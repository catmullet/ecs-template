package boostrap

import (
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/sqs"
)

// SqsService will be initialized for use automatically.
var SqsService *sqs.SQS

func init() {
	cfg := &aws.Config{
		Region: aws.String("us-east-1"),
	}
	SqsService = sqs.New(session.Must(session.NewSession(cfg)))
}
