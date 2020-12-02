#!/bin/lua5.4
local f, pwds = assert(io.open("day2", 'r')), 0
for line in f:lines() do
	local low, high, letter, pass = line:match "^(%d+)-(%d+) (%a): (%a+)$"
	low, high = tonumber(low), tonumber(high)
	local count = select(2, line:gsub(letter, letter)) - 1
	if low <= count and count <= high then pwds = pwds + 1 end
end

print(pwds)
