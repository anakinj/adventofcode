package main

import (
	"strconv"

	"antman.io/utils/file"
)

func BinaryDiagnostic(filename string) int64 {
	lines := file.ReadLines(filename)
	var gammaString string
	var epsilonString string
	for i := 0; i < len(lines[0]); i++ {
		nCount := 0
		for _, line := range lines {
			if line[i] == '1' {
				nCount++
			} else {
				nCount--
			}
		}
		if nCount > 0 {
			gammaString += "1"
			epsilonString += "0"
		} else {
			gammaString += "0"
			epsilonString += "1"
		}
	}

	gammaRate, _ := strconv.ParseInt(gammaString, 2, 16)
	epsilonRate, _ := strconv.ParseInt(epsilonString, 2, 16)
	return gammaRate * epsilonRate
}

func main() {

}
