# Tool versions are pinned so local and CI codegen output stay identical.
BUF_VERSION := v1.71.0
PROTOC_GEN_GO_VERSION := v1.36.11
PROTOC_GEN_GO_GRPC_VERSION := v1.6.2

.PHONY: tools lint breaking generate verify

tools:
	go install github.com/bufbuild/buf/cmd/buf@$(BUF_VERSION)
	go install google.golang.org/protobuf/cmd/protoc-gen-go@$(PROTOC_GEN_GO_VERSION)
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@$(PROTOC_GEN_GO_GRPC_VERSION)

lint:
	buf lint

breaking:
	buf breaking --against '.git#branch=origin/develop'

generate:
	buf generate
	cd gen/go && go mod tidy

verify: generate
	cd gen/go && go build ./...
	git diff --exit-code
