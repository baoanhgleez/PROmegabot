name = "Training Module - Edited Version - MEGABOT Pack"
author= "gl3e"
description= "This script is full support for pokemon EV training in "..target_location.."."

dofile "Utilities.lua"

function onStart()
	if caughtPoke then
		if weakMove ~= "" then
			swiper = getPokeIDHasMove(weakMove)
			if swiper!=0 then
				log("Pokemon with "..weakMove.." : "..getPokemonName(swiper))
			else
				fatal("Cannot find pokemon has learnt "..weakMove)
			end
		end

		if statusMove ~= "" then
			anoyer = getPokeIDHasMove(statusMove)
			if anoyer!=0 then
				log("Pokemon with "..statusMove.." : "..getPokemonName(anoyer))
			else
				fatal("Cannot find pokemon has learnt "..statusMove)
			end
		end
	end
end

function onPause()
	for i = 1, getLength(EvList), 1 do
		log("Your "..getPokemonName(1).." gains "..getPokemonEffortValue(1, EvList[i]).." "..EvList[i].." EVs")
	end
end


function isFullEvsTrain(_index)
	local result = true
	
	for i = 1, getLength(EvList), 1 do
		if getPokemonEffortValue(_index, EvList[i])<EvValue[i] then
			result=false
			break
		end
	end

	return result
end

-- Get Total EVs of Pokemon
function getPokemonTotalEVs(_index)
	local Evs= getPokemonEffortValue(_index, "Attack")
			+ getPokemonEffortValue(_index, "Defense")
			+ getPokemonEffortValue(_index, "SpAttack")
			+ getPokemonEffortValue(_index, "SpDefense")
			+ getPokemonEffortValue(_index, "Speed")
			+ getPokemonEffortValue(_index, "HP")
	return Evs
end

function onPathAction()
	if isFullEvsTrain(1) or getPokemonTotalEVs(1)>=510 then
		playSound("notice.wav")
		if getPokemonHeldItem(1)=="Macho Brace" then
			return takeItemFromPokemon(1)
		end

		if autoSwap then
			local location = 0
			for i=2, getTeamSize() do
				if not isFullEvsTrain(i) and getPokemonTotalEVs(i)<510 then
					location = i
					break
				end
			end
			if location~=0 then
				return swapPokemon(1, location)
			end
		end

		return fatal("Training Completed")
	end

	-- Give Item to pokemon
	if getPokemonHeldItem(1)~="Macho Brace" and hasItem("Macho Brace") then
		return giveItemToPokemon("Macho Brace",1)
	end

	if getPokemonHeldItem(attacker)~="Leftovers" and hasItem("Leftovers") and attacker~=1 then
		return giveItemToPokemon("Leftovers",attacker)
	end

	-- If Hunter module is enable
	if caughtPoke then
		if weakMove~="" and getPokemonHeldItem(swiper)~="Leftovers" and hasItem("Leftovers") then
			return giveItemToPokemon("Leftovers",swiper)
		end

		if statusMove~="" and getPokemonHeldItem(anoyer)~="Leftovers" and hasItem("Leftovers") then
			return giveItemToPokemon("Leftovers",anoyer)
		end	
	end

	-- Traveling control
	return controlOnPathAction() 
end

function onBattleMessage(message)
	if stringContains(message, "won") then
		for i = 1, getLength(EvList), 1 do
			log("Your "..getPokemonName(1).." gains "..getPokemonEffortValue(1, EvList[i]).." "..EvList[i].." EVs")
		end
	end
end

function onSystemMessage(message)
	if stringContains(message, "now AFK") then
		return logout()
	end
end

function getEvsID()
	local result=0
	for i = 1, getLength(EvList), 1 do
		if isOpponentEffortValue(EvList[i]) then
			result=i
			break
		end
	end
	return result
end

function onBattleAction()
	
	if isWildBattle() and caughtPoke and(isOpponentShiny() or (collectPoke and not isAlreadyCaught()) or listContains(wishList, getOpponentName())) then
		return tryToCatchOpponent(swiper)
	end

	if not isPokemonCanAttack(attacker) then
		return run() or useAnyMove() or sendUsablePokemon() or sendAnyPokemon()
	end

	-- Clear bad status condition
	if hasHealingItem(getPokemonStatus(attacker)) then
		return clearPokemonStatus(attacker)
	end

	if caughtPoke and hasHealingItem(getPokemonStatus(swiper)) then
		return clearPokemonStatus(swiper)
	end

	--Battle Action
	if getActivePokemonNumber()~=attacker then
		if runable then
			return sendPokemon(attacker) or run() or sendUsablePokemon() or sendAnyPokemon()
		else
			return attack() or sendUsablePokemon() or sendAnyPokemon
		end
	end

	if not runable or (getEvsID()~=0 and getPokemonEffortValue(1,EvList[getEvsID()])<EvValue[getEvsID()]) then
		return attack() or useAnyMove() or  run() or sendUsablePokemon() or sendAnyPokemon()
	else
		return run() or sendUsablePokemon() or sendAnyPokemon()
	end
end

