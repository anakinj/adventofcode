package main

import "testing"

func TestExample(t *testing.T) {
	got := Dive("example.input")
	want := 150
	if got != want {
		t.Errorf("got %d want %d", got, want)
	}
}

func TestPart1(t *testing.T) {
	got := Dive("directions.input")
	want := 2187380
	if got != want {
		t.Errorf("got %d want %d", got, want)
	}
}
