#!/bin/lua5.4

--List required passport entries
local entries = {"byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"}

--Get input data
local f = assert(io.open("day4", 'r'))
local input = f:read('a')
f:close(); f = nil

--Standardize format: separate passports with LF, separate key:value pairs with single whitespace
input = input:gsub("\n\n", '\0'):gsub('\n', ' '):gsub("%s%s+", ' '):gsub('\0+', '\n')

--Loop over the lines and count valid passports
local valid = 0
for line in input:gmatch(".-\n") do

	--Fill in the current passport
	local passport = {}
	for key, value in line:gmatch("(%a%a%a):([^%s]+)") do
		passport[key] = true
	end

	for _, entry in ipairs(entries) do
		if not passport[entry] then goto invalid end
	end

	valid = valid + 1
	::invalid:: --Jumps here both break the loop to save time and skip the count
end

print(valid)
