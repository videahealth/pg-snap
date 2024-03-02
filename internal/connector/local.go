package connector

import (
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"
	"strconv"
	"strings"

	"github.com/videahealth/pg-snap/internal/utils"
)

func getLatestDir(root string) (int, string, error) {
	files, err := ioutil.ReadDir(root)
	if err != nil {
		return 0, "", err
	}

	maxNum := 0
	maxName := ""
	for _, f := range files {
		if f.IsDir() {
			parts := strings.SplitN(f.Name(), "-", 2)
			if len(parts) > 0 {
				num, err := strconv.Atoi(parts[0])
				if err == nil && num > maxNum {
					maxNum = num
					maxName = f.Name()
				}
			}
		}
	}

	return maxNum, maxName, err
}

func createNextDirectory(root, namePart string) (string, error) {
	if _, err := os.Stat(root); os.IsNotExist(err) {
		if err := os.MkdirAll(root, 0755); err != nil {
			return "", err
		}
	}

	maxNum, _, err := getLatestDir(root)
	if err != nil {
		return "", err
	}

	nextNum := maxNum + 1
	newDirName := fmt.Sprintf("%06d-%s", nextNum, namePart)
	newDirPath := filepath.Join(root, newDirName)
	if err := os.Mkdir(newDirPath, 0755); err != nil {
		return "", err
	}

	return newDirPath, nil
}

const LOCAL_DIR string = "./pg-snap"

type Local struct {
	RootPath           string
	LatestSnapshotName string
}

func NewLocal() (*Local, error) {
	return &Local{
		RootPath: LOCAL_DIR,
	}, nil
}

func (l *Local) NewDump() error {
	randName := utils.GenerateStupidName()
	formattedName := strings.Replace(strings.ToLower(randName), " ", "-", 1)
	_, err := createNextDirectory(LOCAL_DIR, formattedName)
	if err != nil {
		return err
	}
	return nil
}

func (l *Local) GetLatestDir() (string, error) {
	_, name, err := getLatestDir(LOCAL_DIR)
	if err != nil {
		return "", err
	}
	return filepath.Join(LOCAL_DIR, name), nil
}

func (l *Local) Compress(dbName string) error {
	latest, err := l.GetLatestDir()
	if err != nil {
		return err
	}
	return CompressDir(latest, fmt.Sprintf("./%s.tar.gz", dbName))
}

func (l *Local) Decompress(file string) error {
	if !strings.HasSuffix(file, ".tar.gz") {
		return nil
	}
	return DecompressDir(file, LOCAL_DIR)
}
