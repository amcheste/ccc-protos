<div align="center">

# ccc-protos

**Shared protobuf contracts for the Command and Control Center microservices.**

[![Validate](https://github.com/amcheste/ccc-protos/actions/workflows/validate.yml/badge.svg)](https://github.com/amcheste/ccc-protos/actions/workflows/validate.yml)
[![Version](https://img.shields.io/github/v/tag/amcheste/ccc-protos?label=version&sort=semver&color=0B0B0C)](https://github.com/amcheste/ccc-protos/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-1F4D3A.svg)](LICENSE)
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/amcheste/ccc-protos/badge)](https://scorecard.dev/viewer/?uri=github.com/amcheste/ccc-protos)

</div>

---

This repo is the single source of truth for gRPC contracts between CCC
services. Proto definitions live under `proto/`, managed with
[buf](https://buf.build). Generated Go code is committed under `gen/go/`
as its own Go module, so consumers never need protoc or buf installed.

## Layout

```
proto/ccc/<service>/v1/   proto definitions, one package per service per major version
gen/go/                   committed Go codegen, module github.com/amcheste/ccc-protos/gen/go
buf.yaml                  module config: STANDARD lint, FILE-level breaking checks
buf.gen.yaml              codegen config: local protoc-gen-go + protoc-gen-go-grpc
```

## Consuming from Go

```sh
go get github.com/amcheste/ccc-protos/gen/go@latest
```

```go
import accountv1 "github.com/amcheste/ccc-protos/gen/go/ccc/account/v1"
```

Pin to a tagged release in service go.mod files rather than tracking
`develop`.

## Making changes

1. Branch from `develop`, edit protos under `proto/`.
2. `make tools` once, then `make generate` to refresh `gen/go/`.
3. `make lint` and `make breaking` must pass locally.
4. Open a PR. CI re-runs lint, checks for breaking changes against the
   base branch, and fails if committed codegen is stale.

Breaking changes to a published package require a new version directory
(`v2/`) rather than editing `v1/` in place. The `buf breaking` gate in CI
enforces this.

## Versioning

Releases are semver tags (`v0.x.y`) cut from `main` via the standard
release flow. A minor bump means added messages, fields, or RPCs. Package
version directories (`v1`, `v2`) track wire compatibility; repo tags track
the Go module.
