package main

import "testing"

func TestPart1Example(t *testing.T) {
	got := BinaryDiagnostic("example.input")
	want := int64(198)
	if got != want {
		t.Errorf("got %d want %d", got, want)
	}
}

func TestPart1(t *testing.T) {
	got := BinaryDiagnostic("input")
	want := int64(3320834)
	if got != want {
		t.Errorf("got %d want %d", got, want)
	}
}
