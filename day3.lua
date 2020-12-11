#!/bin/lua5.4
--- Compute `x mod y`, but with an offset so the output range becomes [d, y+d).
--- This is functionally equivalent to (but maybe faster than?) `(x-d)%y+d`.
--- Thanks to Wikipedia for having this and OutdatedPine906 for finding it!
---
--- @param x	number	left side of the modulo
--- @param y	number	right side of the modulo
--- @param d	number	delta to shift the output range
function modoff(x, y, d)
	return x - y * math.floor((x - d)/y)
end

--{cols, lines; cols, lines; ...}
local jumps = arg[1] == '1' and {3, 1} or {1, 1, 3, 1, 5, 1, 7, 1, 1, 2}

local f <close> = assert(io.open("day3", 'r'))
local fmti = getmetatable(f).__index --this will be abused later
f:read('l') --to start top-left, the first line must be read in advance

--- toboggan, noun: sled-like object used for tobogging.
---
--- Jumps down `m` lines and `n` characters to the right. Overstepping the line
--- resets to the beginning of said line, as if by modulo.
--- Use this as `f:tobog(start, n)` for the specific file variable `f` above
---
--- @param file		file	file to read from (if used correctly, sets to `f`)
--- @param start	integer	which column to begin at
--- @param n		integer	how much to rotate per call
--- @param m		integer	how many lines to jump
--- @return true if there is a tree in the resultant position, false otherwise
function fmti.tobog(file, start, n, m)
	local pos = start --make a closure for the current column in the line
	return function()
		local line = ""
		for i = 1, m do line = file:read('l') end --get the next line
		if line and line ~= "" then

			--[[
				QUESTION OF THE DAY: which of these is faster?
				Either way, this moves right by n columns and wraps if needed
			]]

			--[[
			pos = (pos + n - 1) % #line + 1
			--[=[
			--]]
			pos = modoff(pos + n, #line, 1)
			--]=]
			return line:sub(pos, pos) == '#' and 1 or 0
		end
	end
end

local accum = 1
for i = 1, #jumps, 2 do
	local trees = 0
	for tree in f:tobog(1, jumps[i], jumps[i + 1]) do
		trees = trees + tree
	end

	--reset to the first line
	f:seek("set")
	f:read('l')

	accum = accum * trees
end

print(accum)

