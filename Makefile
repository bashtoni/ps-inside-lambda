# http://clarkgrubb.com/makefile-style-guide

MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

all:
	go build
	chcon -Rt svirt_sandbox_file_t ps
	sam package --template-file template.yaml --output-template-file cfn.yaml --s3-bucket foo-customcfntesting
	aws cloudformation deploy --template-file cfn.yaml --stack-name ps --capabilities CAPABILITY_IAM
	aws lambda invoke --function-name ps --payload '{}' --invocation-type RequestResponse /dev/null
	sam logs -n ps
