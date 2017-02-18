name = "Show every index and information of your pokemon"
author = "gl3e"

index = 1

-- Index of pokemon to calculate HP type and strength

statTable={"HP", "Attack", "Defense", "Speed", "SpAttack", "SpDefense"}

function showStats()
    log("   Stat Value:")
    for i=1, getLength(statTable) do
        log("      "..statTable[i]..": "..getPokemonIndividualValue(index, statTable[i]).."/"..getPokemonEffortValue(index, statTable[i]))
    end
end

function showMoveSet()
    log("   Current Move Set:")
    for i=1,4 do
        moveName = assert(getPokemonMoveName(index, i))
        if moveName~= nil then
            
            log("      "..i.."."..moveName)
        end
    end
end

function showLog()
    log("Your pokemon name : "..getPokemonName(index))
    log("Nature: "..getPokemonNature(index).." || Abilities: "..getPokemonAbility(index))
    showStats()
    --showMoveSet()

    log(" Hidden Power Type: " .. determineHPType(index))
    log(" Hidden Power Strength: " .. determineHPStrength(index))
end

function onStart()
    showLog()
    fatal("Logging done !")
    
end

function determineHPType(index)

    hp = getPokemonIndividualValue(index, "HP") % 2
    atk = (getPokemonIndividualValue(index, "ATK") % 2) * 2
    def = (getPokemonIndividualValue(index, "DEF") % 2) * 4
    spd = (getPokemonIndividualValue(index, "SPD") % 2) * 8
    spatk = (getPokemonIndividualValue(index, "SPATK") % 2) * 16
    spdef = (getPokemonIndividualValue(index, "SPDEF") % 2) * 32
    
    hpType = math.floor(((hp + atk + def + spd + spatk + spdef) * 15) / 63)
    
    if hpType == 0 then 
        return "Fighting"
    elseif hpType == 1 then
        return "Flying"
    elseif hpType == 2 then
        return "Poison"
    elseif hpType == 3 then
        return "Ground"
    elseif hpType == 4 then
        return "Rock"
    elseif hpType == 5 then
        return "Bug"
    elseif hpType == 6 then
        return "Ghost"
    elseif hpType == 7 then
        return "Steel"
    elseif hpType == 8 then
        return "Fire"
    elseif hpType == 9 then
        return "Water"
    elseif hpType == 10 then
        return "Grass"
    elseif hpType == 11 then
        return "Electric"
    elseif hpType == 12 then
        return "Psychic"
    elseif hpType == 13 then
        return "Ice"
    elseif hpType == 14 then
        return "Dragon"
    elseif hpType == 15 then
        return "Dark"
    end
    
end

function determineHPStrength(index)
    for i=1,getLength(statTable) do
        print(i)
    end

    hp = getPokemonIndividualValue(index, "HP") % 4
    atk = getPokemonIndividualValue(index, "ATK") % 4
    def = getPokemonIndividualValue(index, "DEF") % 4
    spd = getPokemonIndividualValue(index, "SPD") % 4
    spatk = getPokemonIndividualValue(index, "SPATK") % 4
    spdef = getPokemonIndividualValue(index, "SPDEF") % 4
    
    
    -- Yes, I know this part looks weird and clunky. I couldn't think of a better way to do it.
    
    if hp == 2 or hp == 3 then
        hp = 1
    else
        hp = 0
    end
    
    if atk == 2 or atk == 3 then
        atk = 2
    else
        atk = 0
    end
    
    if def == 2 or def == 3 then
        def = 4
    else
        def = 0
    end
    
    if spd == 2 or spd == 3 then
        spd = 8
    else
        spd = 0
    end
    
    if spatk == 2 or spatk == 3 then
        spatk = 16
    else
        spatk = 0
    end
    
    if spdef == 2 or spdef == 3 then
        spdef = 32
    else
        spdef = 0
    end
    
    return math.floor((((hp + atk + def + spd + spatk + spdef) * 40) / 63) + 30)
    
end

------------ Utitilities ---------------

-- Return amount of elements on list
function getLength(_list)
    local count = 0
    for _ in pairs(_list) do count = count + 1 end
    return count
end