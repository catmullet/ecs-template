package example

import (
	"github.com/kyani-inc/kms-ecs-template/app/example"
	"github.com/labstack/echo/v4"
)

// All controller logic should be within the api/<package> directory
func Hello(ctx echo.Context) error {

	hello := example.GetMessage()

	return ctx.JSON(200, hello)
}
