package file

import (
	"io/ioutil"
	"strings"

	"antman.io/utils/array"
)

func ReadLines(filename string) []string {
	content, err := ioutil.ReadFile(filename)
	if err != nil {
		panic(err)
	}
	return strings.Split(string(content), "\n")
}

func ReadIntegers(filename string) []int {
	return array.ConvertArrayOfStringsToArrayOfIntegers(ReadLines(filename))
}
