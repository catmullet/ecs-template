package logger

import (
	"os"
	"testing"
)

func TestInfo(t *testing.T) {
	os.Setenv("APP", "kms-ecs-template")
	tmp := struct {
		Person   string
		Username string
		Password string
	}{Person: "Bobby Brown", Username: "bbrown", Password: "Ihhn2348ansdfasdf"}

	Info("I Fail to see how this is helping", tmp)
	Info("I see %s people", "dead")
	Info("Hello World")
}

func TestError(t *testing.T) {
	os.Setenv("APP", "kms-ecs-template")
	tmp := struct {
		Person   string
		Username string
		Password string
	}{Person: "Bobby Brown", Username: "bbrown", Password: "Ihhn2348ansdfasdf"}

	Error("I Fail to see how this is helping", tmp)
	Error("I see %s people", "dead")
}

func TestDebug(t *testing.T) {
	os.Setenv("APP", "kms-ecs-template")
	tmp := struct {
		Person   string
		Username string
		Password string
	}{Person: "Bobby Brown", Username: "bbrown", Password: "Ihhn2348ansdfasdf"}

	Debug("I Fail to see how this is helping", tmp)
	Debug("I see %s people", "dead")
}

func TestWarn(t *testing.T) {
	os.Setenv("APP", "kms-ecs-template")
	tmp := struct {
		Person   string
		Username string
		Password string
	}{Person: "Bobby Brown", Username: "bbrown", Password: "Ihhn2348ansdfasdf"}

	Warn("I Fail to see how this is helping", tmp)
	Warn("I see %s people", "dead")
}
