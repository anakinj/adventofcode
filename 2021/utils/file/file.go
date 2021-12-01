package file

import (
	"antman.io/utils/array"
	"io/ioutil"
	"strings"
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
