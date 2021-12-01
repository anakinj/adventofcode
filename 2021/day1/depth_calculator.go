package main

import (
	"antman.io/utils/array"
	"antman.io/utils/file"
)

func compareDepths(depths []int) int {
	var previousDepth int = 0
	var increasedCount int = 0

	for _, currentDepth := range depths {
		if previousDepth > 0 && currentDepth > previousDepth {
			increasedCount++
		}
		previousDepth = currentDepth
	}

	return increasedCount
}

func combineThrees(depths []int) []int {
	var retVal = []int{}

	for iDepth := 0; iDepth < len(depths)-2; iDepth++ {
		retVal = append(retVal, array.SumValues(depths[iDepth:iDepth+3]))
	}

	return retVal
}

func CalculateDepthPart2(filename string) int {
	return compareDepths(combineThrees(file.ReadIntegers(filename)))
}

func CalculateDepthPart1(filename string) int {
	return compareDepths(file.ReadIntegers(filename))
}
