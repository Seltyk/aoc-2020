#!/bin/lua5.4

---Creates something vaguely defined as a set. Counts additions and handles the #, &, and | operators
---Keys can be whatever, but values always become true
---Calling this a set in a math class would get me hanged, but it will suffice here
local function set()
	local mt = {n = 0}
	mt.__len = function() return mt.n end

	mt.__newindex = function(t, k, v)
		mt.n = mt.n + 1
		rawset(t, k, true)
	end

	mt.__bor = function(l, r)
		local out = set()
		for k, _ in pairs(l) do
			out[k] = true
		end

		for k, _ in pairs(r) do
			out[k] = true
		end

		return out
	end

	mt.__band = function(l, r)
		local out = set()
		for k, _ in pairs(l) do
			if r[k] then out[k] = true end
		end

		return out
	end

	return setmetatable({}, mt)
end

--Get input
local f = assert(io.open("day6", 'r'))
local input = f:read('a') .. '\n' --Extra LF critical for the bullshit I'll do to read groups
f:close(); f = nil

--Read group-by-group
local yes = 0
for group in input:gmatch("(.-\n)\n") do
	local list = setmetatable({}, {__index = table})

	--Read answer-by-answer
	for answer in group:gmatch("(.-)\n") do
		local curr = set()

		--Read letter-by-letter
		for i = 1, #answer do
			curr[answer:sub(i, i)] = true
		end

		list:insert(curr)
	end

	--Merge the group depending on part 1 or 2
	local merge = list[1]
	for i = 2, #list do
		if arg[1] == '2' then merge = merge & list[i]
		else merge = merge | list[i] end
	end

	yes = yes + #merge
end

print(yes)

