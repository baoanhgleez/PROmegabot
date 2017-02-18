name = "Leveling Module - Edited Version - MEGABOT Pack"
author= "gl3e"
description= "This script is full support for Leveling your 1st pokemon in "..target_location.."."

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

	startLv = getPokemonLevel(1)
end

function onPause()
	earnedLv=getPokemonLevel(1)-startLv;
	log("You have a Lv "..getPokemonLevel(1).." "..getPokemonName(1)..". It increased "..earnedLv.." Lv")
end

function onPathAction()

	if getPokemonLevel(1)>=maxLv then
		playSound("notice.wav")
		if getPokemonHeldItem(1)=="Leftovers" then
			return takeItemFromPokemon(1)
		end

		if autoSwap then
			location = 0
			for i=2, getTeamSize() do
				if getPokemonLevel(i)<maxLv then
					location = i
					break
				end
			end
			if location~=0 then
				startLv=getPokemonLevel(location)
				return swapPokemon(1, location)
			end
		end
		fatal("Training Completed")
	end

	-- Change facer when reached atkLv	
	if getPokemonLevel(1)>=atkLv then
		facer=1
	else
		facer=attacker 
	end
	
	-- Give Item to Pokemon
	if getPokemonHeldItem(facer)~="Leftovers" and hasItem("Leftovers") then
		return giveItemToPokemon("Leftovers",facer)
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
	if stringContains(message, "has grown to level") then
		playSound("notice.wav")
	end
end

function onBattleAction()
	-- Magikarp has very low base exp, so dont attack them :v
	if getOpponentName()=="Magikarp"  then
		return run()
	end

	-- Enable Hunter Module if caughtPoke = true
	if isWildBattle() and caughtPoke and(isOpponentShiny() or (collectPoke and not isAlreadyCaught()) or listContains(wishList, getOpponentName())) then
		return tryToCatchOpponent()
	end

	-- Send facer to battle if possible
	if getActivePokemonNumber()~=facer then
		if runable then
			return sendPokemon(facer) or run() or sendUsablePokemon() or sendAnyPokemon()
		else
			return attack() or sendUsablePokemon() or sendAnyPokemon
		end
	end

	if isPokemonCanAttack(getActivePokemonNumber()) then
		return attack() or  run() or sendUsablePokemon() or sendAnyPokemon()	
	else
		return run() or sendUsablePokemon() or sendAnyPokemon
	end

end


