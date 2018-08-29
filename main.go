package main

import (
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
	ps "github.com/mitchellh/go-ps"
)

func main() {
	lambda.Start(HandleRequest)
}

func HandleRequest() {
	processes, _ := ps.Processes()
	for _, proc := range processes {
		fmt.Println(proc.Executable())
	}
}
