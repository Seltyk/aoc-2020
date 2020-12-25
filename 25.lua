#!/bin/lua5.4

--[[
--	DO NOT EVER,
--	EVER,
--		EVER,
--			EVER
--	USE THIS FOR INSPIRATION.
--	FOR ANYTHING,
--		EVER.
--	this code SUCKS.
--	it is BAD.
--	there should be functions separating dupicate code.
--	but i don't really give a shit
--]]

--Get the puzzle input
local f = assert(io.open("day25", 'r'))
local cardpub = tonumber(f:read'l')
local doorpub = tonumber(f:read'l')
f:close(); f = nil

--Brute force the loop counts
local cardloop, doorloop = 0, 0

local subject, temp = 7, 1
while temp ~= cardpub do
	temp = (temp * subject) % 20201227
	cardloop = cardloop + 1
end

temp = 1
while temp ~= doorpub do
	temp = (temp * subject) % 20201227
	doorloop = doorloop + 1
end

--Brute force the card's encryption key
temp, subject = 1, doorpub
for i = 1, cardloop do
	temp = (temp * subject) % 20201227
end

local cardenc = temp

--Brute force the door's encryption key
temp, subject = 1, cardpub
for i = 1, doorloop do
	temp = (temp * subject) % 20201227
end

local doorenc = temp

temp = nil --Don't need this anymore
assert(cardenc == doorenc) --Encryption keys are identical

print(cardenc) --now gimme
