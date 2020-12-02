#!/bin/lua5.4
local f = assert(io.open("day1", 'r'))
local ns = setmetatable({}, {__index = table})
local l = f:read('l')
while l and l ~= "" do
	ns:insert(tonumber(l))
	l = f:read('l')
end

f:close(); f = nil

for i = 1, #ns - 2 do
	for j = i + 1, #ns - 1 do
		for k = j + 1, #ns do
			if ns[i] + ns[j] + ns[k] == 2020 then
				print(ns[i] * ns[j] * ns[k])
				os.exit(0)
			end
		end
	end
end

os.exit(1)
