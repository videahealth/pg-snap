package db

import (
	"bufio"
	"errors"
	"fmt"
	"io"
	"os"
	"path/filepath"
	"strings"

	pg_query "github.com/pganalyze/pg_query_go/v5"
	"github.com/videahealth/pg-snap/internal/pgcommand"
	"github.com/videahealth/pg-snap/internal/utils"
)

type NotFkRelationError struct{}

func (m *NotFkRelationError) Error() string {
	return "not fk relation, skipping"
}

type DumpParser struct {
	dumpFolder   string
	Tables       []*Table
	FkAttributes []ForeignKeyInfo
}

func NewPsql(fPath string) *DumpParser {
	return &DumpParser{
		dumpFolder: fPath,
	}
}

func (dp *DumpParser) Dump(params *utils.DbParams) error {
	if err := dp.GeneratePgDump(params); err != nil {
		return err
	}
	if err := dp.AnalyzeSQLStatements(); err != nil {
		return err
	}

	return nil
}

func (dp *DumpParser) Restore(params *utils.DbParams) error {
	dp.SplitDDLWithFks()
	return nil
}

func (dp *DumpParser) GeneratePgDump(params *utils.DbParams) error {
	if err := os.MkdirAll(dp.dumpFolder, os.ModePerm); err != nil {
		return fmt.Errorf("error making directory %s: %s", dp.dumpFolder, err)
	}
	ddlPath, err := filepath.Abs(filepath.Join(dp.dumpFolder, "ddl.sql"))
	if err != nil {
		return err
	}
	ddlFile, err := os.OpenFile(ddlPath, os.O_CREATE|os.O_RDWR, 0666)
	if err != nil {
		return err
	}

	dumpOutput, err := pgcommand.DumpDb(params)

	if err != nil {
		return err
	}

	_, err = ddlFile.WriteString(dumpOutput)
	if err != nil {
		return err
	}

	return nil
}

func ParseCreateTableStatement(st *pg_query.RawStmt) (*Table, error) {
	createStmt := st.GetStmt().GetCreateStmt()

	if createStmt == nil {
		return nil, nil
	}

	schema := createStmt.GetRelation().GetSchemaname()
	table := createStmt.GetRelation().GetRelname()
	cols := createStmt.GetTableElts()

	var tblCols []Col
	for _, col := range cols {
		colName := col.GetColumnDef().GetColname()
		types := col.GetColumnDef().GetTypeName()
		var colType string
		for _, tp := range types.GetNames() {
			if tp.GetString_().GetSval() != "pg_catalog" {
				colType = tp.GetString_().GetSval()
				break
			}
		}
		tblCols = append(tblCols, Col{
			Name: colName,
			Type: colType,
		})
	}

	return NewTable(table, schema, tblCols), nil

}

func ParseAlterTableStatement(st *pg_query.RawStmt, tables []*Table) ([]ForeignKeyInfo, error) {
	// Alter table
	var fks []ForeignKeyInfo
	altTblSt := st.GetStmt().GetAlterTableStmt()

	pkTable := altTblSt.GetRelation().GetRelname()
	pkSchema := altTblSt.GetRelation().GetSchemaname()

	for _, al := range altTblSt.GetCmds() {
		if al == nil {
			// continue
			return []ForeignKeyInfo{}, fmt.Errorf("no alter table statement found")
		}
		constr := al.GetAlterTableCmd().GetDef().GetConstraint()

		if constr == nil || constr.Contype.String() != "CONSTR_FOREIGN" {
			continue
		}
		pkTableVal := constr.GetPktable()
		if pkTableVal == nil {
			// continue
			return []ForeignKeyInfo{}, fmt.Errorf("no pk table found")
		}
		fkTable := pkTableVal.Relname
		fkSchema := pkTableVal.Schemaname

		for _, v := range utils.Zip(constr.GetFkAttrs(), constr.GetPkAttrs()) {
			foreignColName := v.Second.GetString_().Sval
			colName := v.First.GetString_().Sval
			fColType := GetTableType(fmt.Sprintf("%s.%s", fkSchema, fkTable), tables, foreignColName)
			colType := GetTableType(fmt.Sprintf("%s.%s", pkSchema, pkTable), tables, colName)

			fks = append(fks, ForeignKeyInfo{
				Schema:            pkSchema,
				Name:              pkTable,
				ColumnName:        colName,
				ForeignColumnName: foreignColName,
				ForeignSchema:     fkSchema,
				ForeignName:       fkTable,
				ForeignColType:    fColType,
				ColType:           colType,
			})
		}

	}

	return fks, nil
}

func GetTableType(id string, tables []*Table, lookupCol string) string {
	for _, tbl := range tables {
		if tbl.Details.Display == id {
			for _, col := range tbl.Cols {
				if col.Name == lookupCol {
					return col.Type
				}
			}
		}
	}
	return ""
}

func (dp *DumpParser) ParseStatements() ([]*pg_query.RawStmt, error) {
	ddlFilePath := filepath.Join(dp.dumpFolder, "ddl.sql")

	file, err := os.Open(ddlFilePath)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	content, err := io.ReadAll(file)
	if err != nil {
		return nil, err
	}

	text := string(content)

	result, err := pg_query.Parse(text)
	if err != nil {
		return nil, err
	}

	statements := result.GetStmts()
	return statements, nil
}

func (dp *DumpParser) AnalyzeSQLStatements() error {
	var fks []ForeignKeyInfo
	var tables []*Table

	statements, err := dp.ParseStatements()
	if err != nil {
		return err
	}

	for _, st := range statements {
		if st == nil {
			continue
		}
		table, err := ParseCreateTableStatement(st)
		if err != nil {
			return err
		}
		if table != nil {
			tables = append(tables, table)
		}
	}
	for _, st := range statements {
		if st == nil {
			continue
		}
		fk, err := ParseAlterTableStatement(st, tables)
		if err != nil {
			return err
		}
		fks = append(fks, fk...)
	}

	dp.FkAttributes = fks
	dp.Tables = tables
	return nil
}

func (dp *DumpParser) SplitDDLWithFks() error {
	origDdlFile := filepath.Join(dp.dumpFolder, "ddl.sql")
	fks, rem, err := ExtractAndRemoveFKConstraints(origDdlFile)
	if err != nil {
		return err
	}
	err = os.Remove(origDdlFile)
	if err != nil {
		return err
	}
	ddlPath, err := filepath.Abs(filepath.Join(dp.dumpFolder, "rem.sql"))
	if err != nil {
		return err
	}
	ddlFile, err := os.OpenFile(ddlPath, os.O_CREATE|os.O_RDWR, 0666)
	if err != nil {
		return err
	}
	defer ddlFile.Close()
	fkPath, err := filepath.Abs(filepath.Join(dp.dumpFolder, "fk.sql"))
	if err != nil {
		return err
	}
	fkFile, err := os.OpenFile(fkPath, os.O_CREATE|os.O_RDWR, 0666)
	if err != nil {
		return err
	}
	defer fkFile.Close()

	ddlFileWriter := bufio.NewWriter(ddlFile)
	ddlFileWriter.WriteString(rem)
	fkFileWriter := bufio.NewWriter(fkFile)
	fkFileWriter.WriteString(fks)

	return nil
}

func ExtractAndRemoveFKConstraints(filePath string) (string, string, error) {
	file, err := os.Open(filePath)
	if err != nil {
		return "", "", err
	}
	defer file.Close()

	var lines []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}

	if err := scanner.Err(); err != nil {
		return "", "", err
	}

	var remainingContent string
	var extractedContent string
	capture := false

	for _, line := range lines {
		if strings.HasPrefix(line, "-- Name:") {
			if strings.Contains(line, "Type: FK CONSTRAINT") {
				capture = true
			} else {
				capture = false
				remainingContent += line + "\n"
			}
		}

		if capture {
			extractedContent += line + "\n"
		} else if !strings.HasPrefix(line, "-- Name:") {
			remainingContent += line + "\n"
		}
	}

	if extractedContent == "" && remainingContent == "" {
		return "", "", errors.New("no content processed")
	}

	return extractedContent, remainingContent, nil
}
