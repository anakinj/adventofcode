package main

import "testing"

func TestExampleInput(t *testing.T) {
	got := CalculateDepth("example.input")
	want := 7
	if got != want {
		t.Errorf("got %d want %d", got, want)
	}
}

func TestPart1Input(t *testing.T) {
	got := CalculateDepth("part1.input")
	want := 1387
	if got != want {
		t.Errorf("got %d want %d", got, want)
	}
}
