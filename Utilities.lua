
-- All small use full script
-- Dont edit these folowing code

-- Call Path Find Module
Pathfinder = require "Pathfinder/MoveToApp"






--################################################################################
--####                                                                        ####
--####                       HOOK REGISTER  SCRIPT                            ####
--####                                                                        ####
--################################################################################

-- Prepare for start
function onPrepare()

	mustCaught=false

	pokecounter=0
	if farmMoney then
		startMoney=getMoney()
	end
end
registerHook("onStart", onPrepare)

-- Generic process for System Message
function onSystemMessageHook(message)
	if stringContains(message, "You can't use item on this map") then
		mountUsable=false
	end
end
registerHook("onSystemMessage", onSystemMessageHook)


-- Generic Path action
function onPathActionHook()
	mustCaught=false
	runable = true
	rightAbi = false
	usedRolePlay = false

	if stringContains(getMapName(), "Class") or stringContains(getMapName(), "Antiban") then
		fatal("You have detected by GM !")
	end

	if not stringContains(name, "Level") then
		facer = attacker	
	end


	if not stringContains(name, "Item Farm") then
		-- get index of importance pokemon
		if weakMove ~= "" then
			swiper = getPokeIDHasMove(weakMove)
		end

		if statusMove ~= "" then
			anoyer = getPokeIDHasMove(statusMove)
		end

		if checkAbi then
			rolePlayer = getPokeIDHasMove("Role Play")
		end
	end
end
registerHook("onPathAction", onPathActionHook)


-- Generic Battle Message process
function onPrepareBattleMessage(message)
	-- Must catch Vulpix has hidden ability
	mustCaught=stringContains(message, "The sunlight got bright!") or getOpponentName()=="Buizel"

	if stringContains(message, "A Wild") and stringContains(message, "Attacks!") then
		log("Level "..getOpponentLevel().." - Total Health: "..getOpponentHealth())                               
	end

	if stringContains(message, "caught") then
		playSound("Assets/score.wav")
		pokecounter = pokecounter +1
	end

	if stringContains(message, "Abillity is now") then
		usedRolePlay = true
	end

	if stringContains(message, "You can not run away!") or stringContains(message,"can not switch") then
		runable = false
	end

	if checkAbi==true then
		if stringContainsElement(message, abiList) then
			rightAbi = true
		end
	end
end
registerHook("onBattleMessage", onPrepareBattleMessage)

-- Play sound when healing pokemon
function onDialogMessageHK(message)
	if stringContains(message, "Okay, let me take a look at those Pokemon.") then
		playSound("pokecenter.wav")
	end
end
registerHook("onDialogMessage", onDialogMessageHK)

-- Notice sound when bot was stopped
function onStopHK()
	playSound("Asset/message.wav")
end
registerHook("onStop", onStopHK)






--################################################################################
--####                                                                        ####
--####                       USEFUL FUNCTION SCRIPT                           ####
--####                                                                        ####
--################################################################################

-- Return TRUE if and only if str is contains in sList
function listContains(_sList, _str)
	local result = false
	if _sList[1] ~= "" then
		for i = 1, getLength(_sList), 1 do
			if _str == _sList[i] then
				result = true
				break
			end
		end
	end
	return result
end

-- Return TRUE if and only if str contains one of these elements of sList
function stringContainsElement(_str, _sList)
	local result = false

	if _sList[1] ~= "" then
		for i = 1, getLength(_sList), 1 do
			if stringContains(_str, _sList[i]) then
				result = true
				break
			end
		end
	end

	return result
end


-- Return amount of elements on list
function getLength(_list)
	local count = 0
	for _ in pairs(_list) do count = count + 1 end
	return count
end






--################################################################################
--####                                                                        ####
--####                    POKE CHECKING AND ACTION                            ####
--####                                                                        ####
--################################################################################

-- Check requirement for access the playing zone: attacker, swiper, rolePlayer, sync.
function isTeamUsable()
	local result = true

	if stringContains(name, "Train") or stringContains(name, "Level") then
		result= getPokemonHealth(1)>0 and isPokemonCanAttack(facer)
		if caughtPoke then
			result = result 
				and (not (weakMove~="") or  (getRemainingPowerPoints(swiper,weakMove) and getPokemonHealth(swiper)>0))
				and (not (statusMove~="") or  (getRemainingPowerPoints(anoyer,statusMove) and getPokemonHealth(anoyer)>0))
		end
	end

	if stringContains(name, "Hunt") or stringContains(name, "Explore") then
		result = getPokemonHealth(1)>0 
			and (not (weakMove!="") or (getRemainingPowerPoints(swiper,weakMove)>0 and getPokemonHealth(swiper)>0))
			and (not checkAbi or (getRemainingPowerPoints(rolePlayer, "Role Play")>0 and getPokemonHealth(rolePlayer)>0))
			and (not (statusMove!="") or (getRemainingPowerPoints(anoyer, statusMove)>0 and getPokemonHealth(anoyer)>0))
		if farmMoney then
			result = result and (isPokemonCanAttack(attacker))
		end
	end

	if stringContains(name, "Item") then
		result = (getRemainingPowerPoints(thief, stealMove)>0 and getPokemonHealth(thief)>0)
			and ((not frisker~=0) or getPokemonHealth(1)>0)
	end
	return result
end

-- Get Number of Pokeball
function getPokeballQuantity()
	return (getItemQuantity("Pokeball") + getItemQuantity("Great ball") + getItemQuantity("Ultra ball"))
end

-- Get Id of pokemon which has _moveName
function getPokeIDHasMove(_moveName)
    local id = 0
    for i=1,getTeamSize() do
        if hasMove(i, _moveName) then
            id=i
            break
        end
    end
    return id
end

-- Get Id of pokemon which has _moveName
function getPokeIDHasAbi(_ability)
    local id = 0
    for i=1,getTeamSize() do
        if getPokemonAbility(i)==_ability then
            id=i
            break
        end
    end
    return id
end

-- Return TRUE if having an 
function hasHealingItem(badContion)
	local result=false

	if badContion=="BURN" then
		result = hasItem("Burn Heal") or hasItem("Rawst Berry")

	elseif badContion=="PARALIZE"  then
		result = hasItem("Paralyze Heal") or hasItem("Cheri Berry")

	elseif badContion=="FREEZE" then
		result = hasItem("Ice Heal") or hasItem("Aspear Berry")

	elseif badContion=="POISON" or badContion=="BPOISON" then
		result = hasItem("Antidote") or hasItem("Pecha Berry")

	elseif badContion=="SLEEP" then
		result = hasItem("Awakening") or hasItem("Chesto Berry") 
	end

	return result
end

-- Remove any Bad Status condition
function clearPokemonStatus(_index)
	if getPokemonStatus(_index)=="BURN" and (hasItem("Burn Heal") or hasItem("Rawst Berry")) then
		return useItemOnPokemon("Burn Heal", _index) or useItemOnPokemon("Rawst Berry", _index) or false

	elseif getPokemonStatus(_index)=="PARALIZE" and (hasItem("Paralyze Heal") or hasItem("Cheri Berry")) then
		return useItemOnPokemon("Paralyze Heal", _index) or useItemOnPokemon("Cheri Berry", _index) or false

	elseif getPokemonStatus(_index)=="FREEZE" and (hasItem("Ice Heal") or hasItem("Aspear Berry")) then
		return useItemOnPokemon("Ice Heal", _index) or useItemOnPokemon("Aspear Berry", _index) or false

	elseif (getPokemonStatus(_index)=="POISON" or getPokemonStatus(_index)=="BPOISON") and (hasItem("Antidote") or hasItem("Pecha Berry")) then
		return useItemOnPokemon("Antidote", _index) or useItemOnPokemon("Pecha Berry", _index) or false

	elseif getPokemonStatus(_index)=="SLEEP" and (hasItem("Awakening") or hasItem("Chesto Berry")) then
		return useItemOnPokemon("Awakening", _index) or useItemOnPokemon("Chesto Berry", _index) or false
	end
end

-- Return True if pokemon actually can attack
function isPokemonCanAttack(_index)
	local result=true
	local totalPP=0
	if not isPokemonUsable(_index) then
		result=false
	else
		if hasMove(_index, "False swipe") then
			totalPP=0
			for i=1,4 do
				local moveName = getPokemonMoveName(_index, i)
				totalPP=totalPP + getRemainingPowerPoints(_index, moveName)
			end

			if totalPP<=40 then 
				result=false
			end
		end
	end
	return result
end







--################################################################################
--####                                                                        ####
--####                        ACTION ON BATTLE                                ####
--####                                                                        ####
--################################################################################

-- This is due to his only move(s) with PP being not damaging type move(s).
function useAnyMove()
    local pokemonId = getActivePokemonNumber()
    for i=1,4 do
        local moveName = getPokemonMoveName(pokemonId, i)
        if moveName and getRemainingPowerPoints(pokemonId, moveName) > 0 then
            return useMove(moveName)
        elseif not moveName then
            log("useAnyMove : moveName nil")
        end
    end
    return false
end

-- Throw pokeball with piority is _ballType
function throwPokeball(_ballType)
    return useItem(_ballType) or useItem("Pokeball") or useItem("Great Ball") or useItem("Ultra Ball")
end

-- Try to catch Opponent with weakMove and STATUS Support
function tryToCatchOpponent()
    if directCaught or getOpponentName()=="Wynaut" or getOpponentName()=="Ralts" or getOpponentName()=="Abra" then
        return throwPokeball("Great Ball") or false
    end

    local minHealthPercent = lowestHealthPercent or 30;

    if weakMove~="" and (getOpponentHealthPercent() > minHealthPercent) then
        if getActivePokemonNumber()~=swiper then
            if not runable then
                return throwPokeball("Great Ball") or attack() or sendAnyPokemon() or false
            end
            return sendPokemon(swiper) or throwPokeball("Great Ball") or sendAnyPokemon() or false
        else
            return useMove(weakMove) or throwPokeball("Great Ball") or sendAnyPokemon() or false
        end
    end

    if statusMove~="" 
    	and (getOpponentStatus() ~= "SLEEP" and getOpponentStatus() ~= "PARALIZE" 
    		and getOpponentStatus() ~= "FREEZE" and getOpponentStatus() ~= "BURN"
    		and getOpponentStatus() ~= "POISON" and getOpponentStatus() ~= "BPOISON") then
        if getActivePokemonNumber()~=anoyer then
            if not runable then
                return throwPokeball("Great Ball") or attack() or sendAnyPokemon() or false
            end
            return sendPokemon(anoyer) or throwPokeball("Great Ball") or sendAnyPokemon() or false
        else
            return useMove(statusMove) or throwPokeball("Great Ball") or sendAnyPokemon() or false
        end
    end

    return throwPokeball("Pokeball") or false
end









--################################################################################
--####                                                                        ####
--####                       ON PATH ACTION SCRIPT                            ####
--####                                                                        ####
--################################################################################

--[[
    Goto Function - Use in PathAction to move in area at tagged map
        _area = Grass or Water   : Execute moveToGrass() or moveToWater()
        _area = <name of Map>    : Execute moveNearExit(_area)
        _area = {x, y}           : Go fishing at (x,y)
        _area = {x1, y1, x2, y2} : Execute moveToRectangle(x1, y1, x2, y2)
--]]
function goToArea(_area)
	local bkArea = _area;

    if type(_area) == "string" then
        _area = _area:upper()
    else
        if #_area == 2 then
            if getPlayerX() == _area[1] and getPlayerY() == _area[2] then
                return useItem("Super Rod") or useItem("Good Rod") or useItem("Old Rod")
            else
                return moveToCell(_area[1], _area[2])
            end
        else
            return moveToRectangle(_area[1], _area[2], _area[3], _area[4])
        end
    end
    
    if _area == "GRASS" then
        return moveToGrass()
    elseif _area == "WATER" then
        return moveToWater()
    else
        return moveNearExit(bkArea)
    end
end

--[[
    Ride to Mount Function - Use in PathAction to Riding to your land mount
    use that script to do:
    if useMount(<mountName>) then end
--]]
function useMount(_mount)
    if hasItem(_mount) and not isMounted() then
        if not isSurfing() and isOutside() then
        	log("Getting on ".._mount)
            return useItem(_mount)
        else
            return false
        end
    else
        return false
    end
end

-- Traveling controller 

function getCurrentMapID()
	local result = 0
	for i=1,#mapList do
		if mapList[i]==getMapName() then
			result=i
			break
		end
	end
	return result
end

function controlOnPathAction()

	-- Get on mount if possible
	if useMount(mount) then
		return true
	end


	map = getMapName()
	if autoFindPath then
		
		if isTeamUsable() then
			if getMapName()~=target_location then
				return Pathfinder.moveTo(map,target_location)
			else
				return goToArea(area)
			end
		else
			return Pathfinder.useNearestPokecenter(map)
		end
	else
		if isTeamUsable() then
			if map~=target_location then
				return moveToMap(mapList[getCurrentMapID() +1 ])
			else
				return goToArea(area)
			end
		else
			if map~=mapList[1] then
				return moveToMap(mapList[getCurrentMapID() -1 ])
			else
				return usePokecenter() 
			end
		end
	end
end
