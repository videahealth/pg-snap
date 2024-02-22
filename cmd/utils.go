package cmd

import (
	"errors"
	"strings"
)

func GetMajorVersion(s string) (string, error) {
	parts := strings.Split(s, ".")

	if len(parts) > 0 {
		return parts[0], nil
	}

	return "", errors.New("unable to parse major version")
}
