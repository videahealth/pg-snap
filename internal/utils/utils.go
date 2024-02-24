package utils

import (
	"bufio"
	"errors"
	"fmt"
	"log"
	"math/rand"
	"os"
	"strconv"
	"strings"
	"time"

	"github.com/urfave/cli/v3"
)

func GetMajorVersion(s string) (string, error) {
	parts := strings.Split(s, ".")

	if len(parts) > 0 {
		return parts[0], nil
	}

	return "", errors.New("unable to parse major version")
}

type DbParams struct {
	Username string
	Password string
	Host     string
	Db       string
	Port     int32
}

func ParseFromCli(cmd *cli.Command) *DbParams {
	port, err := strconv.ParseInt(cmd.String("port"), 10, 32)
	if err != nil {
		panic(err)
	}

	return &DbParams{
		Username: cmd.String("username"),
		Password: cmd.String("password"),
		Host:     cmd.String("host"),
		Db:       cmd.String("db"),
		Port:     int32(port),
	}
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
