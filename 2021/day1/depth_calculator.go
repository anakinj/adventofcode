package main

import (
	"bufio"
	"os"
	"strconv"
)

func CalculateDepth(fileInput string) int {
	file, err := os.Open(fileInput)
	if err != nil {
			return -1
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	var previousDepth int = 0
	var increasedCount int = 0
 
	for scanner.Scan() {
		currentDepth, _ := strconv.Atoi(scanner.Text())
		if previousDepth > 0 {
			if currentDepth > previousDepth {
				increasedCount++
			}
		}
		previousDepth = currentDepth
	}

	return increasedCount
}
