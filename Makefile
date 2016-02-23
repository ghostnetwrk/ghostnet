# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: ghostnet ghostnet-cross evm all test travis-test-with-coverage xgo clean
.PHONY: ghostnet-linux ghostnet-linux-arm ghostnet-linux-386 ghostnet-linux-amd64
.PHONY: ghostnet-darwin ghostnet-darwin-386 ghostnet-darwin-amd64
.PHONY: ghostnet-windows ghostnet-windows-386 ghostnet-windows-amd64
.PHONY: ghostnet-android ghostnet-android-16 ghostnet-android-21

GOBIN = build/bin

CROSSDEPS = https://gmplib.org/download/gmp/gmp-6.0.0a.tar.bz2
GO ?= latest

ghostnet:
	build/env.sh go install -v $(shell build/flags.sh) ./cmd/ghostnet
	@echo "Done building."
	@echo "Run \"$(GOBIN)/ghostnet\" to launch ghostnet."

ghostnet-cross: ghostnet-linux ghostnet-darwin ghostnet-windows ghostnet-android
	@echo "Full cross compilation done:"
	@ls -l $(GOBIN)/ghostnet-*

ghostnet-linux: xgo ghostnet-linux-arm ghostnet-linux-386 ghostnet-linux-amd64
	@echo "Linux cross compilation done:"
	@ls -l $(GOBIN)/ghostnet-linux-*

ghostnet-linux-arm: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --dest=$(GOBIN) --deps=$(CROSSDEPS) --targets=linux/arm -v $(shell build/flags.sh) ./cmd/ghostnet
	@echo "Linux ARM cross compilation done:"
	@ls -l $(GOBIN)/ghostnet-linux-* | grep arm

ghostnet-linux-386: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --dest=$(GOBIN) --deps=$(CROSSDEPS) --targets=linux/386 -v $(shell build/flags.sh) ./cmd/ghostnet
	@echo "Linux 386 cross compilation done:"
	@ls -l $(GOBIN)/ghostnet-linux-* | grep 386

ghostnet-linux-amd64: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --dest=$(GOBIN) --deps=$(CROSSDEPS) --targets=linux/amd64 -v $(shell build/flags.sh) ./cmd/ghostnet
	@echo "Linux amd64 cross compilation done:"
	@ls -l $(GOBIN)/ghostnet-linux-* | grep amd64

ghostnet-darwin: xgo ghostnet-darwin-386 ghostnet-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -l $(GOBIN)/ghostnet-darwin-*

ghostnet-darwin-386: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --dest=$(GOBIN) --deps=$(CROSSDEPS) --targets=darwin/386 -v $(shell build/flags.sh) ./cmd/ghostnet
	@echo "Darwin 386 cross compilation done:"
	@ls -l $(GOBIN)/ghostnet-darwin-* | grep 386

ghostnet-darwin-amd64: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --dest=$(GOBIN) --deps=$(CROSSDEPS) --targets=darwin/amd64 -v $(shell build/flags.sh) ./cmd/ghostnet
	@echo "Darwin amd64 cross compilation done:"
	@ls -l $(GOBIN)/ghostnet-darwin-* | grep amd64

ghostnet-windows: xgo ghostnet-windows-386 ghostnet-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -l $(GOBIN)/ghostnet-windows-*

ghostnet-windows-386: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --dest=$(GOBIN) --deps=$(CROSSDEPS) --targets=windows/386 -v $(shell build/flags.sh) ./cmd/ghostnet
	@echo "Windows 386 cross compilation done:"
	@ls -l $(GOBIN)/ghostnet-windows-* | grep 386

ghostnet-windows-amd64: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --dest=$(GOBIN) --deps=$(CROSSDEPS) --targets=windows/amd64 -v $(shell build/flags.sh) ./cmd/ghostnet
	@echo "Windows amd64 cross compilation done:"
	@ls -l $(GOBIN)/ghostnet-windows-* | grep amd64

ghostnet-android: xgo ghostnet-android-16 ghostnet-android-21
	@echo "Android cross compilation done:"
	@ls -l $(GOBIN)/ghostnet-android-*

ghostnet-android-16: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --dest=$(GOBIN) --deps=$(CROSSDEPS) --targets=android-16/* -v $(shell build/flags.sh) ./cmd/ghostnet
	@echo "Android 16 cross compilation done:"
	@ls -l $(GOBIN)/ghostnet-android-16-*

ghostnet-android-21: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --dest=$(GOBIN) --deps=$(CROSSDEPS) --targets=android-21/* -v $(shell build/flags.sh) ./cmd/ghostnet
	@echo "Android 21 cross compilation done:"
	@ls -l $(GOBIN)/ghostnet-android-21-*

evm:
	build/env.sh $(GOROOT)/bin/go install -v $(shell build/flags.sh) ./cmd/evm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/evm to start the evm."

all:
	build/env.sh go install -v $(shell build/flags.sh) ./...

test: all
	build/env.sh go test ./...

travis-test-with-coverage: all
	build/env.sh build/test-global-coverage.sh

xgo:
	build/env.sh go get github.com/karalabe/xgo

clean:
	rm -fr build/_workspace/pkg/ Godeps/_workspace/pkg $(GOBIN)/*
