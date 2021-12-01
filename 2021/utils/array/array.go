package array

import (
	"strconv"
)

func SumValues(values []int) int {
	retVal := 0
	for _, v := range values {
		retVal += v
	}
	return retVal
}

func ConvertArrayOfStringsToArrayOfIntegers(arrayOfStrings []string) []int {
	var retVal = []int{}
	for _, i := range arrayOfStrings {
		integer, err := strconv.Atoi(i)
		if err == nil {
			retVal = append(retVal, integer)
		}
	}
	return retVal
}
