LUA_PATH := lua/?.lua;lua/?/init.lua;$(LUA_PATH)
export LUA_PATH

.PHONY: lint test test-pip

lint:
	stylua --check .

test: test-pip

test-pip:
	busted --lua nlua test/pip/*_spec.lua
