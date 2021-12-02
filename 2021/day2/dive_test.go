package main

import "testing"

func TestPart1Example(t *testing.T) {
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

func TestPart2Example(t *testing.T) {
	got := DiveAndAim("example.input")
	want := 900
	if got != want {
		t.Errorf("got %d want %d", got, want)
	}
}

func TestPart2(t *testing.T) {
	got := DiveAndAim("directions.input")
	want := 2086357770
	if got != want {
		t.Errorf("got %d want %d", got, want)
	}
}
