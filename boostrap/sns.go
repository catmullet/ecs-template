package boostrap

import (
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/sns"
)

// SnsService will be initialized for use automatically.
var SnsService *sns.SNS

func init() {
	cfg := &aws.Config{
		Region: aws.String("us-east-1"),
	}
	SnsService = sns.New(session.Must(session.NewSession(cfg)))
}
