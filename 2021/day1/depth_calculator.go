package main

import (
	"io/ioutil"
	"strconv"
	"strings"
)

func ReadLines(filename string) ([]string, error) {
	content, err := ioutil.ReadFile(filename)
	if err != nil {
		return make([]string, 0), err
	}
	return strings.Split(string(content), "\n"), nil
}

func ConvertArrayOfStringToArrayOfIntegers(arrayOfStrings []string) []int {
	var retVal = []int{}
	for _, i := range arrayOfStrings {
		j, err := strconv.Atoi(i)
		if err == nil {
			retVal = append(retVal, j)
		}
	}
	return retVal
}

func CalculateDepth(filename string) int {
	lines, err := ReadLines(filename)
	if err != nil {
		return -1
	}

	numbers := ConvertArrayOfStringToArrayOfIntegers(lines)

	var previousDepth int = 0
	var increasedCount int = 0

	for _, currentDepth := range numbers {
		if previousDepth > 0 {
			if currentDepth > previousDepth {
				increasedCount++
			}
		}
		previousDepth = currentDepth
	}

	return increasedCount
}
