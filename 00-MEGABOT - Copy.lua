
--------------------------------------
-----        GENERAL CONFIG 	 -----
--------------------------------------

-- 
target_location =  "Route 117"


-- Do you want to use the PathFinder?
autoFindPath = true

-- If the map can not find, you must config manual
-- The first is Pokecenter -> the last is target location
-- You dont need to edit its (IF autoFindPath = TRUE)
mapList = {
	"Pokemon Tower 5F"
}


-- If you dont have any mount, use ""
mount = "S Charizard Mount"

--[[	
	area = Grass / Water    : Execute moveToGrass() or moveToWater()
    area = <name of Map>    : Execute moveNearExit(<name of Map>)
    area = {x, y}           : Go fishing at (x,y)
    area = {x1, y1, x2, y2} : Execute moveToRectangle(x1, y1, x2, y2)
--]]
area = "grass"
--{37, 57, 40, 62} -- Mt. Moon 1F
--{79, 36, 85, 38} -- Route 3 grass
--{10, 11, 16, 12}	-- Route 1 grass
--{37, 11, 42, 15} -- Route 8 grass
--{36, 11, 48, 12} -- Route 22 grass
--{30, 42, 34, 50} -- Celadon City Water
--{21, 16, 25, 18} -- Granite Cave B1F
--{20, 35, 30, 40} -- Route 6 water
--{20, 26, 24, 27} -- Route 15
--{10, 13, 16, 15} -- Route 101

-- Do you want to swap pokemon during training or leveling?
autoSwap=true
-- Do you want to catch pokemon during training or leveling?
caughtPoke=true

-- Index of Pokemon that you want to switch in to every battle
attacker=1

useHeadbutt = false
useDigSpot = false

-------------------------------------------------
--------          HUNT CONFIG        ------------
-- Dont edit it if you dont want to catch poke --
-------------------------------------------------

-- Do you have a sync at 1st?
useSync= false

-- False swipe or Dragon Rage? Use weakMove = "" if you dont want to use it
weakMove = "Water Gun"

-- If you want to sleep or paralysis wild poke, tell me what move?
-- Use statusMove = "" if you dont want to use it
statusMove = ""

-- Do you want to check Abilities of Pokemon before catch its?
-- WARNING : It's just work with Hunter.lua Module only
checkAbi=false

-- Percent of Health start throwing ball
lowestHealthPercent = 80
-- Max Pokemon want to catch
maxCounter=20

-- Config list of pokemon you want to catch
wishList = {}

-- Config list of abilities of pokemon you want to catch
abiList = {"Rattled", "Swift Swim", "Drought", "Hustle"}

-- Do you want to catch uncaught pokemon?
collectPoke=true

-- Attach every pokemon you dont want to catch?
farmMoney=false

-------------------------------------------------
--------         LEVEL CONFIG        ------------
--- Dont edit it if you dont want to level up ---
-------------------------------------------------

-- Pokemon will attack by itself at what Lv?
atkLv = 1

-- Max Level you want to reach
maxLv = 50


-------------------------------------------------
--------         TRAIN CONFIG        ------------
--- Dont edit it if you dont want to TRAIN pk ---
-------------------------------------------------

-- Config list of Evs set you want to train
-- Attack, Defense, Speed, SpAttack, SpDefense, HP
EvList = {"Attack"}
EvValue = {252, 252}

------------------------------------------------------


-- Which module you will apply? Hunter, Trainer or Leveler? 
dofile "Leveler.lua"