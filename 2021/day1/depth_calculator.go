package main

import (
	"io/ioutil"
	"strconv"
	"strings"
)

func ReadLines(filename string) []string {
	content, err := ioutil.ReadFile(filename)
	if err != nil {
		panic(err)
	}
	return strings.Split(string(content), "\n")
}

func ConvertArrayOfStringToArrayOfIntegers(arrayOfStrings []string) []int {
	var retVal = []int{}
	for _, i := range arrayOfStrings {
		integer, err := strconv.Atoi(i)
		if err == nil {
			retVal = append(retVal, integer)
		}
	}
	return retVal
}

func ReadIntegersFromFile(filename string) []int {
	return ConvertArrayOfStringToArrayOfIntegers(ReadLines(filename))
}

func CompareDepths(depths []int) int {
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

func SumArrayValues(values []int) int {
	retVal := 0
	for _, v := range values {
		retVal += v
	}
	return retVal
}

func CombineThrees(depths []int) []int {
	var retVal = []int{}

	for iDepth := 0; iDepth < len(depths)-2; iDepth++ {
		retVal = append(retVal, SumArrayValues(depths[iDepth:iDepth+3]))
	}

	return retVal
}

func CalculateDepthPart2(filename string) int {
	return CompareDepths(CombineThrees(ReadIntegersFromFile(filename)))
}

func CalculateDepthPart1(filename string) int {
	return CompareDepths(ReadIntegersFromFile(filename))
}
