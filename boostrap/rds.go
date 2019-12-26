package boostrap

import (
	"github.com/catmullet/AwsRds"
	log "github.com/kyani-inc/kms-ecs-template/logger"
)

var Clusters = []struct {
	Cluster  string
	Database string
	Username string
	Password string
}{
	//{Cluster: "au-bi", Database: "Kyani", Username: "root", Password: "groot"},
}

func InitializeMySqlDatabases() {
	for _, c := range Clusters {
		log.Info("Registering Database...", c)
		err := AwsRds.RegisterCluster(c.Cluster, c.Database, c.Username, c.Password)

		if err != nil {
			log.Fatal(err.Error())
		}
	}
}
