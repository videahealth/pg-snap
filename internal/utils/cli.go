package utils

import (
	"fmt"
	"sync/atomic"

	"github.com/charmbracelet/log"
)

func DisplayProgress(ops *atomic.Uint64, rows int64, total int, tableName string) {
	ops.Add(1)
	progress := ops.Load()

	log.Info(SprintfNoNewlines("COPIED %s rows from %s",
		Colored(Green, fmt.Sprint(rows)),
		Colored(Yellow, tableName)),
		"progress",
		SprintfNoNewlines("%d / %d", progress, total))
}
