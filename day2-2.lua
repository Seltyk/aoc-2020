#!/bin/lua5.4
local f, pwds = assert(io.open("day2", 'r')), 0
for line in f:lines() do
	local pos1, pos2, letter, pass = line:match "^(%d+)-(%d+) (%a): (%a+)$"
	pos1, pos2 = tonumber(pos1), tonumber(pos2)
	if pass:sub(pos1, pos1) == letter and pass:sub(pos2, pos2) ~= letter or
			pass:sub(pos1, pos1) ~= letter and pass:sub(pos2, pos2) == letter then
		pwds = pwds + 1
	end
end

print(pwds)
