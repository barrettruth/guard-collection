LUA_PATH := lua/?.lua;lua/?/init.lua;$(LUA_PATH)
export LUA_PATH

.PHONY: lint test test-pip test-npm test-go test-rust test-lua test-binary test-apt

lint:
	stylua --check .

test: test-pip test-npm test-go test-rust test-lua test-binary test-apt

test-pip:
	busted --lua nlua test/pip/*_spec.lua

test-npm:
	busted --lua nlua test/npm/*_spec.lua

test-go:
	busted --lua nlua test/go/*_spec.lua

test-rust:
	busted --lua nlua test/rust/*_spec.lua

test-lua:
	busted --lua nlua test/lua/*_spec.lua

test-binary:
	busted --lua nlua test/binary/*_spec.lua

test-apt:
	@for f in test/apt/*_spec.lua; do busted --lua nlua "$$f"; done

