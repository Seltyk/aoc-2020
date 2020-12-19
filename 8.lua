#!/bin/lua5.4

--Get input
local f, lines = assert(io.open("day8", 'r')), {}
for line in f:lines() do
	table.insert(lines, line)
end

f:close(); f = nil

--Switch a nop to a jmp and vice versa
local function switch(pos)
	if lines[pos]:sub(1, 3) == "jmp" then
		lines[pos] = lines[pos]:gsub("jmp", "nop")
	elseif lines[pos]:sub(1, 3) == "nop" then
		lines[pos] = lines[pos]:gsub("nop", "jmp")
	end
end

--Attempt the current boot
local function try()
	local ran, accum, pos = {}, 0, 1
	while pos <= #lines do

		--Catch loop
		if ran[pos] then
			if arg[1] == '1' then print(accum) end
			return false
		end

		ran[pos] = true

		--Behavior
		if lines[pos]:sub(1, 3) == "acc" then
			accum = accum + tonumber(lines[pos]:sub(5))
			pos = pos + 1
		elseif lines[pos]:sub(1, 3) == "jmp" then
			pos = pos + tonumber(lines[pos]:sub(5))
		else --nop
			pos = pos + 1
		end
	end

	return accum
end

if arg[1] == '1' then
	try()
else
	for i = 1, #lines do
		switch(i)
		attempt = try()
		if attempt then
			print(attempt)
			break
		else
			switch(i)
		end
	end
end
