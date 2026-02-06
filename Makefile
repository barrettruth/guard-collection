LUA_PATH := lua/?.lua;lua/?/init.lua;$(LUA_PATH)
export LUA_PATH

.PHONY: lint test test-pip test-npm test-go test-rust test-lua test-binary test-clang test-haskell test-dotnet test-ruby test-clojure test-elixir test-nix test-swift

lint:
	stylua --check .

test: test-pip test-npm test-go test-rust test-lua test-binary test-clang test-haskell test-dotnet test-ruby test-clojure test-elixir test-nix test-swift

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

test-clang:
	@for f in test/clang/*_spec.lua; do busted --lua nlua "$$f"; done

test-haskell:
	busted --lua nlua test/haskell/*_spec.lua

test-dotnet:
	busted --lua nlua test/dotnet/*_spec.lua

test-ruby:
	busted --lua nlua test/ruby/*_spec.lua

test-clojure:
	busted --lua nlua test/clojure/*_spec.lua

test-elixir:
	busted --lua nlua test/elixir/*_spec.lua

test-nix:
	busted --lua nlua test/nix/*_spec.lua

test-swift:
	busted --lua nlua test/swift/*_spec.lua
