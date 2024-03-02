package config

import (
	"encoding/json"
	"fmt"
	"io"
	"os"
)

type Config struct {
	Subset struct {
		Table           string `json:"table"`
		Schema          string `json:"schema"`
		Where           string `json:"where"`
		MaxRowsPerTable int32  `json:"maxRowsPerTable"`
	} `json:"subset"`
	SkipTables []string `json:"skipTables"`
}

func LoadConfig(path string) (*Config, error) {
	configFile, err := os.Open(path)
	if err != nil {
		return nil, fmt.Errorf("unable to open config file: %w", err)
	}
	defer configFile.Close()

	bytes, err := io.ReadAll(configFile)
	if err != nil {
		return nil, fmt.Errorf("unable to read config file: %w", err)
	}

	var config Config
	if err := json.Unmarshal(bytes, &config); err != nil {
		return nil, fmt.Errorf("unable to unmarshal config JSON: %w", err)
	}

	if config.Subset.MaxRowsPerTable == 0 {
		config.Subset.MaxRowsPerTable = -1
	}

	return &config, nil
}
