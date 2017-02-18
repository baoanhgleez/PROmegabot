
--------------------------------------
-----        GENERAL CONFIG 	 -----
--------------------------------------

-- 
target_location = "Route 16"


-- Do you want to use the PathFinder?
autoFindPath = true

-- If the map can not find, you must config manual
-- The first is Pokecenter -> the last is target location
-- You dont need to edit its (IF autoFindPath = TRUE)
mapList = {}

-- If you dont have any mount, use ""
mount = "Bicycle"

--[[	
	area = Grass / Water    : Execute moveToGrass() or moveToWater()
    area = <name of Map>    : Execute moveNearExit(<name of Map>)
    area = {x, y}           : Go fishing at (x,y)
    area = {x1, y1, x2, y2} : Execute moveToRectangle(x1, y1, x2, y2)
--]]
area = "grass"

-- Use Covet or Thief?
stealMove = "Thief"



dofile "Utilities.lua"



name="Item Farm on "..target_location.." - MEGABOT PACKAGE."
author="gl3e"
description="This script is configed for item farming in "..target_location.."."

function onStart()
 	thief = getPokeIDHasMove(stealMove)
 	frisker = getPokeIDHasAbi("Frisk")

 	-- Check if the team has a pokemon with ability is frisk
	if frisker~=0 then
		if getPokemonAbility(1)~= "Frisk" then
			frisker=1
			return swapPokemon(1, frisker)	
		end
	else
		-- If dont have frisk, thief will be lead of party
		if not hasMove(1, stealMove) then
			thief=1
			return swapPokemon(1, thief)
		end
	end

end

function onPathAction()
	wildHoldingItem = false
	usedStealMove = false

	if getPokemonHeldItem(thief) ~= nil then
		return takeItemFromPokemon(thief)
	end
	
	return controlOnPathAction()
end

function onBattleMessage(message)
	if stringContains(message, "is Holding") then
		wildHoldingItem=true
	end

	if stringContains(message, " stole ") then
		playSound("notice.wav")
	end

	if stringContains(message, stealMove) then
		usedStealMove = true
	end

end

function onBattleAction()
	if frisker==0 then
		if not usedStealMove then
			return useMove(stealMove) or run() or sendAnyPokemon()
		end
	else
		if wildHoldingItem then
			return useMove(stealMove) or run() or sendAnyPokemon()
		end
	end

	return run() or sendAnyPokemon()
end



