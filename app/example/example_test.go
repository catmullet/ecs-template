package example

import "testing"

// Always write unit tests for your work.
func TestGetMessage(t *testing.T) {
	message := GetMessage()

	if message.Message != "Hello World" {
		t.Fail()
	}
}
