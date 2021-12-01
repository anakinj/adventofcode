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

func TestPart2ExampleInput(t *testing.T) {
	got := CalculateDepthPart2("example.input")
	want := 5
	if got != want {
		t.Errorf("got %d want %d", got, want)
	}
}

func TestPart2(t *testing.T) {
	got := CalculateDepthPart2("depths.input")
	want := 1362
	if got != want {
		t.Errorf("got %d want %d", got, want)
	}
}
