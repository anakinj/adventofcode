package main

import "testing"

func TestPart1ExampleInput(t *testing.T) {
	got := CalculateDepthPart1("example.input")
	want := 7
	if got != want {
		t.Errorf("got %d want %d", got, want)
	}
}

func TestPart1(t *testing.T) {
	got := CalculateDepthPart1("depths.input")
	want := 1387
	if got != want {
		t.Errorf("got %d want %d", got, want)
	}
}


