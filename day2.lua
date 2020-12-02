#!/bin/lua5.4
local f, pwds = assert(io.open("day2", 'r')), 0
for line in f:lines() do
	local low, high, letter, pass = line:match "^(%d+)-(%d+) (%a): (%a+)$"
	low, high = tonumber(low), tonumber(high)

	if arg[1] == '1' then
		local count = select(2, pass:gsub(letter, letter))
		if low <= count and count <= high then pwds = pwds + 1 end
	elseif arg[1] == '2' then
		if (pass:sub(low, low) == letter) ~= (pass:sub(high, high) == letter) then pwds = pwds + 1 end
	end
end

print(pwds)
