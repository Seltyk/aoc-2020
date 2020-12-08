#!/bin/lua5.4

--Get input
local f = assert(io.open("day5", 'r'))

--Loop over lines and track either highest ID or existing seats
local out = arg[1] == '2' and {} or 0
for seat in f:lines() do
	seat = tonumber(seat:gsub('F', '0'):gsub('B', '1'):gsub('L', '0'):gsub('R', '1'), 2)

	if arg[1] == '2' then
		out[seat] = true
	else
		if seat > out then out = seat end
	end
end

if arg[1] == '2' then
	for id = 2, 2046 do
		if not out[id] and out[id - 1] then
			out = id
			break
		end
	end
end

print(out)
