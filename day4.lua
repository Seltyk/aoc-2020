#!/bin/lua5.4

--List required passport entries and their legality checks
local entries = {
	byr = function(v)
		local n = tonumber(v)
		return #v == 4 and n and 1920 <= n and n <= 2002
	end,

	iyr = function(v)
		local n = tonumber(v)
		return #v == 4 and n and 2010 <= n and n <= 2020
	end,

	eyr = function(v)
		local n = tonumber(v)
		return #v == 4 and n and 2020 <= n and n <= 2030
	end,

	hgt = function(v)
		local n = tonumber(v:sub(1, -3))
		if not n then return false end
		if v:sub(-2) == "cm" then return 150 <= n and n <= 193
		elseif v:sub(-2) == "in" then return 59 <= n and n <= 76
		else return false end
	end,

	hcl = function(v)
		if v:sub(1, 1) ~= '#' or #v:sub(2) ~= 6 then return false end
		return tonumber(v:sub(2), 16)
	end,

	ecl = function(v)
		local colors = {amb = true, blu = true, brn = true, gry = true, grn = true, hzl = true, oth = true}
		return colors[v]
	end,

	pid = function(v)
		if #v ~= 9 then return false end
		return tonumber(v)
	end
}

--Get input data
local f = assert(io.open("day4", 'r'))
local input = f:read('a')
f:close(); f = nil

--Standardize format: separate passports with LF, separate key:value pairs with single whitespace. Ensure final LF
input = input:gsub("\n\n", '\0'):gsub('\n', ' '):gsub("%s%s+", ' '):gsub('\0+', '\n') .. '\n'

--Loop over the lines and count valid passports
local valid = 0
for line in input:gmatch(".-\n") do

	--Fill in the current passport
	local passport = {}
	for key, value in line:gmatch("(%a%a%a):([^%s]+)") do
		passport[key] = value
	end

	--Ensure every required entry is there
	for entry, check in pairs(entries) do

		--Part 1 solution: is there or isn't there data
		if not passport[entry] then goto invalid end

		--Part 2 solution: is this data legal
		if arg[1] == '2' then
			if not check(passport[entry]) then goto invalid end
		end
	end

	valid = valid + 1
	::invalid:: --Jumps here both break the loop to save time and skip the count
end

print(valid)
