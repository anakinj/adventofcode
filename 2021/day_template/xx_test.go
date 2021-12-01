package main

import "testing"

func TestXX(t *testing.T) {
	got := XX()
	want := 0
	if got != want {
		t.Errorf("got %d want %d", got, want)
	}
}