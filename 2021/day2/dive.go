package main

import (
	"regexp"
	"strconv"

	"antman.io/utils/file"
)

type Instruction struct {
	direction string
	count     int
}

func extractInstructions(rawList []string) []Instruction {
	re := regexp.MustCompile(`(?P<direction>\w+) (?P<count>\d+)`)

	var instructions = []Instruction{}

	for _, line := range rawList {
		results := re.FindAllStringSubmatch(line, -1)
		count, err := strconv.Atoi(results[0][2])
		if err == nil {
			instructions = append(instructions, Instruction{direction: results[0][1], count: count})
		}
	}
	return instructions
}

func Dive(filename string) int {
	instruction := extractInstructions(file.ReadLines(filename))
	depth := 0
	distance := 0
	for _, instruction := range instruction {
		switch instruction.direction {
		case "forward":
			distance += instruction.count
		case "up":
			depth -= instruction.count
		case "down":
			depth += instruction.count
		}
	}
	return depth * distance
}

func DiveAndAim(filename string) int {
	instruction := extractInstructions(file.ReadLines(filename))
	aim := 0
	depth := 0
	distance := 0
	for _, instruction := range instruction {
		switch instruction.direction {
		case "forward":
			distance += instruction.count
			depth += aim * instruction.count
		case "up":
			aim -= instruction.count
		case "down":
			aim += instruction.count
		}
	}
	return depth * distance
}

func main() {

}
