package api

import (
	"github.com/kyani-inc/kms-ecs-template/api/example"
	"github.com/labstack/echo/v4"
)

// All routes will be grouped and defined here in one file for ease of searching.
func Routes(e *echo.Echo) {

	// Example Group
	exampleGroup := e.Group("/example")

	// Example route
	exampleGroup.GET("/hello", example.Hello)

}
