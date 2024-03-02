package connector

import (
	"bytes"
	"io"
	"os"

	"github.com/videahealth/pg-snap/internal/utils"
)

func CompressDir(dir string, outFile string) error {
	var buf bytes.Buffer
	err := utils.Compress(dir, &buf)
	if err != nil {
		return err
	}

	fileToWrite, err := os.OpenFile(outFile, os.O_CREATE|os.O_RDWR, os.FileMode(0600))
	if err != nil {
		return err
	}
	if _, err := io.Copy(fileToWrite, &buf); err != nil {
		return err
	}

	return nil
}

func DecompressDir(filePath string, out string) error {
	file, err := os.Open(filePath)

	if err != nil {
		return err
	}

	err = utils.Decompress(file, out)

	if err != nil {
		return err
	}

	return nil
}
