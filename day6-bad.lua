#!/bin/lua5.4

--- Creates a (weak) set. Keeps track of added key count
--- This is not AT ALL enough to qualify as a set in math, but it will suffice here
local function set()
	local mt = {n = 0}
	mt.__len = function() return mt.n end
	mt.__newindex = function(t, key, value)
		mt.n = mt.n + 1
		rawset(t, key, value)
	end

	return setmetatable({}, mt)
end

--Get input
local f = assert(io.open("day6", 'r'))
local input = f:read('a'):gsub("\n\n", '\0'):gsub('\n', ""):gsub('\0', '\n') .. '\n'
f:close(); f = nil

--Loop over lines and count YESes
local yes = 0
local curr = set()
for line in input:gmatch("(%a+)\n") do
	for i = 1, #line do
		curr[line:sub(i, i)] = true
	end

	yes = yes + #curr
	curr = set() --Reset the current set
end

print(yes)
