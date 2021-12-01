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

func ReadIntegersFromFile(filename string) []int {
	lines, err := ReadLines(filename)

	if err != nil {
		return make([]int, 0)
	}

	return ConvertArrayOfStringToArrayOfIntegers(lines)
}

func CalculateDepthCombined(filename string) int {
	return 0
}

func CalculateDepthPart1(filename string) int {
	var previousDepth int = 0
	var increasedCount int = 0

	for _, currentDepth := range ReadIntegersFromFile(filename) {
		if previousDepth > 0 && currentDepth > previousDepth {
			increasedCount++
		}
		previousDepth = currentDepth
	}

	return increasedCount
}
