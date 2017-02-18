
--------------------------------------
-----        GENERAL CONFIG 	 -----
--------------------------------------

-- 
target_location = "Pokecenter Lavender"


-- Do you want to use the PathFinder?
autoFindPath = true

-- If the map can not find, you must config manual
-- The first is Pokecenter -> the last is target location
-- You dont need to edit its (IF autoFindPath = TRUE)
mapList = {
	"Pokecenter Cinnabar",
	"Cinnabar Island",
	"Route 20"
}


-- If you dont have any mount, use ""
mount = "Zapdos Mount"

--[[	
	area = Grass / Water    : Execute moveToGrass() or moveToWater()
    area = <name of Map>    : Execute moveNearExit(<name of Map>)
    area = {x, y}           : Go fishing at (x,y)
    area = {x1, y1, x2, y2} : Execute moveToRectangle(x1, y1, x2, y2)
--]]
area = "water"

-- Do you want to swap pokemon during training or leveling?
autoSwap=true
-- Do you want to catch pokemon during training or leveling?
caughtPoke=false

-- Index of Pokemon that you want to switch in to every battle
attacker=1


-------------------------------------------------
--------          HUNT CONFIG        ------------
-- Dont edit it if you dont want to catch poke --
-------------------------------------------------

-- Do you have a sync at 1st?
useSync= false

-- False swipe or Dragon Rage? Use weakMove = "" if you dont want to use it
weakMove = "False swipe"

-- If you want to sleep or paralysis wild poke, tell me what move?
-- Use statusMove = "" if you dont want to use it
statusMove = ""

-- Do you want to check Abilities of Pokemon before catch its?
-- WARNING : It's just work with Hunter.lua Module only
checkAbi=false

-- Percent of Health start throwing ball
lowestHealthPercent = 20
-- Max Pokemon want to catch
maxCounter=50

-- Config list of pokemon you want to catch
wishList = {"Starly", "Fletchling", "Chimchar", "Hippopotas", "Scyther", "Murkrow", "Staravia", "Turtwig", "Slakoth", " Vigoroth", "Nosepass",
	"Pansage", "Panpour", "Pansear", "Bibarel", "Venipede", "Fletchinder", "Rufflet", "Golett", "Gligar", "Noibat", "Aron",
	"Beldum", "Mawile", "Heracross", "Joltik", "Talonflame", "Absol", "Pawniard", "Litleo", "Vanillite", "Skorupi", "Trapinch", 
	"Ferroseed", "Sawk", "Throh", "Timburr","Shroomish","Breloom", "Gible", "Larvitar","Roggenrola", "Shinx", "Electabuzz", "Cacnea"}
-- Config list of abilities of pokemon you want to catch
abiList = {"Shield Dust", "Natural Cure", "Levitate"}

-- Do you want to catch uncaught pokemon?
collectPoke=true

-- Attach every pokemon you dont want to catch?
farmMoney=false

-------------------------------------------------
--------         LEVEL CONFIG        ------------
--- Dont edit it if you dont want to level up ---
-------------------------------------------------

-- Pokemon will attack by itself at what Lv?
atkLv = 55

-- Max Level you want to reach
maxLv = 95


-------------------------------------------------
--------         TRAIN CONFIG        ------------
--- Dont edit it if you dont want to TRAIN pk ---
-------------------------------------------------

-- Config list of Evs set you want to train
-- Attack, Defense, Speed, SpAttack, SpDefense, HP
EvList = { "SpAttack"}
EvValue = {252}

------------------------------------------------------

-- Which module you will apply? Hunter, Trainer or Leveler? 
dofile "Explo.lua"