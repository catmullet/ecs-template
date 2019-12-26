package main

import (
	"fmt"
	"github.com/kyani-inc/kms-ecs-template/boostrap"
	"github.com/kyani-inc/kms-ecs-template/local/helpers/environments"
	log "github.com/kyani-inc/kms-ecs-template/logger"
	"github.com/labstack/echo/v4"
	"os"
)

const logo = `    __ __      _  _        _ 
   / //_/_  __(_)(_)____  (_)
  / ,< / / / / __ / __  \/ /
 / /| / /_/ / /_/ / / / / /
/_/ |_\__, /\__,_/_/ /_/_/
      __/ / Live Kyani
    /____/
`

// Bootstrap the App
func init() {
	// Initialize RDS MySQL Databases.
	// Add databases connections to boostrap/rds.go
	boostrap.InitializeMySqlDatabases()
}

func main() {
	// Echo instance
	e := echo.New()

	port := os.Getenv("PORT")

	if len(port) == 0 {
		environments.LoadEnvironmentVariablesFromYml(environments.Staging)
	}

	// Health Info
	health := map[string]string{
		"app":   os.Getenv("APP"),
		"build": os.Getenv("BUILD"),
	}

	// Health endpoint
	e.GET("/health", func(ctx echo.Context) error {
		return ctx.JSON(200, health)
	})

	// Start server
	e.HideBanner = true
	fmt.Println(logo)
	err := e.Start(fmt.Sprintf(":%s", os.Getenv("PORT")))

	// If we get to this point Log any errors and shut it down
	if err != nil {
		log.Fatal("Failed to start Server", err.Error())
	}
}
