name = "Hunting Module - Edited Version - MEGABOT Pack"
author= "gl3e"
description= "This script is full support for pokemon hunting in "..target_location.."."

dofile "Common.lua"

function onStart()
	playSound("Assets/score.wav")
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

	if checkAbi then
		rolePlayer = getPokeIDHasMove("Role Play")
		if swiper!=0 then
			log("Your Role Player : "..getPokemonName(rolePlayer))
		else
			fatal("Cannot find pokemon has learnt Role Play ")
		end
	end


	pokecounter=0
	wildCounter=0
	if farmMoney then
		startMoney=getMoney()
	end
end

function onPause()
	log("You have caught "..pokecounter.." Pokemon(s)")
	log("You have seen "..wildCounter.." Pokemon(s)")

	if pokecounter>0 then
		cRate = 100.0*pokecounter/wildCounter
		log("Caught rate: "..cRate)
	end

	if farmMoney then
		log("You earned "..getMoney()-startMoney.."$")
	end
end

function onPathAction()
	if getPokeballQuantity()<=0  then
		return fatal("You dont have any pokeball.")
	end

	if pokecounter>=maxCounter then
		return fatal("You caught "..maxCounter.." pokemon.")
	end

	if weakMove~="" and getPokemonHeldItem(swiper)~="Leftovers" and hasItem("Leftovers") then
		return giveItemToPokemon("Leftovers",swiper)
	end

	if statusMove~="" and getPokemonHeldItem(anoyer)~="Leftovers" and hasItem("Leftovers") then
		return giveItemToPokemon("Leftovers",anoyer)
	end

	if checkAbi and getPokemonHeldItem(rolePlayer)~="Leftovers" and hasItem("Leftovers") then
		return giveItemToPokemon("Leftovers",rolePlayer)
	end

	if farmMoney~="" and getPokemonHeldItem(attacker)~="Leftovers" and hasItem("Leftovers") then
		return giveItemToPokemon("Leftovers",attacker)
	end
	
	-- Traveling control
	return controlOnPathAction() 
end

function onBattleMessage(message)
	if stringContains(message, "A Wild") and stringContains(message, "Attacks!") then
		wildCounter=wildCounter+1
	end
end

function onBattleAction()
	if isWildBattle() and (isOpponentShiny() or (not isAlreadyCaught() and collectPoke) or mustCaught ) then --or getOpponentName()=="Abra") then
		return tryToCatchOpponent() or sendAnyPokemon()
	end

	if isWildBattle() and listContains(wishList, getOpponentName()) then
		-- Checking pokemon's ability
		if checkAbi and not usedRolePlay then
			if getActivePokemonNumber()~=rolePlayer then
				return sendPokemon(rolePlayer) or run() or sendUsablePokemon() or sendAnyPokemon()
			else
				if not usedRolePlay then
					return useMove("Role Play") or run() or sendUsablePokemon() or sendAnyPokemon()
				end
			end
		end

		if (not checkAbi or rightAbi) then
			if not runable then
				return tryToCatchOpponent() or run() or sendAnyPokemon()
			else
				return tryToCatchOpponent() or run() or sendAnyPokemon()
			end
		else
			if farmMoney then
				return attack() or sendPokemon(attacker) or run() or sendUsablePokemon() or sendAnyPokemon()
			else
				if runable then
					return run() or sendPokemon(attacker) or sendUsablePokemon() or sendAnyPokemon()
				else
					return attack() or useAnyMove() or  run() or sendUsablePokemon() or sendAnyPokemon()
				end
			end
		end
	end

	if not isWildBattle() then
		return attack() or sendAnyPokemon() or run()
	end

	if getActivePokemonNumber()~=attacker then
		if runable then
			return sendPokemon(attacker) or run() or sendUsablePokemon() or sendAnyPokemon() or sendAnyPokemon()
		else
			return attack() or sendUsablePokemon() or sendAnyPokemon()
		end
	end
		
	if farmMoney then
		return attack() or useAnyMove() or run() or sendUsablePokemon() or sendAnyPokemon()
	else
		if runable then
			return run() or sendUsablePokemon() or sendAnyPokemon()
		else
			return attack() or useAnyMove() or  run() or sendUsablePokemon() or sendAnyPokemon()
		end
	end
end





