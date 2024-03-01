package utils

import (
	"bufio"
	"errors"
	"fmt"
	"log"
	"math/rand"
	"os"
	"strings"
	"time"
)

func GetMajorVersion(s string) (string, error) {
	parts := strings.Split(s, ".")

	if len(parts) > 0 {
		return parts[0], nil
	}

	return "", errors.New("unable to parse major version")
}

func ValidateDbVersion(pgDbVersion string, pgDumpVersion string) error {
	pgDbMajorVersion, err := GetMajorVersion(pgDbVersion)

	if err != nil {
		return err
	}

	if !strings.Contains(pgDumpVersion, pgDbMajorVersion) {
		return errors.New("major postgres version does not match pg_dump")
	}

	return nil
}

func AskForConfirmation(s string) bool {
	reader := bufio.NewReader(os.Stdin)

	for {
		fmt.Printf("%s [y/n]: ", s)

		response, err := reader.ReadString('\n')
		if err != nil {
			log.Fatal(err)
		}

		response = strings.ToLower(strings.TrimSpace(response))

		if response == "y" || response == "yes" {
			return true
		} else if response == "n" || response == "no" {
			return false
		}
	}
}

func RandomString(n int) string {
	var letters = []rune("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")

	// Seed the random number generator to get different results each run
	rand.Seed(time.Now().UnixNano())

	// Generate a random string of length n from the letters slice
	s := make([]rune, n)
	for i := range s {
		s[i] = letters[rand.Intn(len(letters))]
	}
	return string(s)
}

func SprintfNoNewlines(format string, a ...interface{}) string {
	result := fmt.Sprintf(format, a...)

	result = strings.ReplaceAll(result, "\n", "")
	result = strings.ReplaceAll(result, "\r", "")

	return result
}

type Pair[T, U any] struct {
	First  T
	Second U
}

func Zip[T, U any](ts []T, us []U) []Pair[T, U] {
	if len(ts) != len(us) {
		panic("slices have different length")
	}
	pairs := make([]Pair[T, U], len(ts))
	for i := 0; i < len(ts); i++ {
		pairs[i] = Pair[T, U]{ts[i], us[i]}
	}
	return pairs
}
