#!/bin/lua

--Shift every item in `t` back one, dropping the 1st item. Adds `x` as the 25th
function shift(t, x)
	for i = 1, 24 do
		t[i] = t[i + 1]
	end

	t[25] = x
end

--Attempts to find two values in `t` whose sum is `s`, returning `false` on failure
function findsum(t, s)
	for i = 1, 24 do
		for j = i + 1, 25 do
			if t[i] + t[j] == s then return true end
		end
	end

	return false
end

local f <close> = assert(io.open("day9", 'r'))
local list = setmetatable({}, {__index = table})

for line in f:lines() do

	--Fill the preamble
	if #list < 25 then
		list:insert(tonumber(line))
		goto cont
	end

	local candidate = tonumber(line)
	if findsum(list, candidate) then
		shift(list, candidate)
	else
		print(candidate)
		break
	end

	::cont::
end
