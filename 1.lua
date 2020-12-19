#!/bin/lua5.4
local f = assert(io.open("day1", 'r'))
local ns = {}
for l in f:lines() do
	ns[tonumber(l)] = true
end

f:close(); f = nil

for k, _ in pairs(ns) do
	if arg[1] == '3' then
		for j, _ in pairs(ns) do
			if k ~= j and ns[2020 - k - j] then
				print(k * j * (2020 - k - j))
				os.exit()
			end
		end
	elseif arg[1] == '2' then
		if ns[2020 - k] then
			print(k * (2020 - k))
			os.exit()
		end
	end
end

