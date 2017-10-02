
--------------------------------------
-----        GENERAL CONFIG 	 -----
--------------------------------------

-- 
target_location =  "Pokemon Tower 2F"


-- Do you want to use the PathFinder?
autoFindPath = true

-- If the map can not find, you must config manual
-- The first is Pokecenter -> the last is target location
-- You dont need to edit its (IF autoFindPath = TRUE)
mapList = {
	"Pokecenter Viridian",
	"Viridian City",
	"Route 22",
	"Pokemon League Reception Gate",
	"Victory Road Kanto 1F"
}


-- If you dont have any mount, use ""
mount = "Bicycle"

--[[	
	area = Grass / Water    : Execute moveToGrass() or moveToWater()
    area = <name of Map>    : Execute moveNearExit(<name of Map>)
    area = {x, y}           : Go fishing at (x,y)
    area = {x1, y1, x2, y2} : Execute moveToRectangle(x1, y1, x2, y2)
--]]
area = "Pokemon Tower 1F"
--{10, 11, 16, 12}	-- Route 1 grass
--{37, 11, 42, 15} -- Route 8 grass
--{36, 11, 48, 12} -- Route 22 grass
--{30, 42, 34, 50} -- Celadon City Water
--{21, 16, 25, 18} -- Granite Cave B1F
--{20, 35, 30, 40} -- Route 6 water
--{20, 26, 24, 27} -- Route 15
--{16,36,24,41} -- Kalijodo Lake
--{31,19,37,21} -- Vulcan Path
--{23,33,28,35} -- Kalijodo Path
--{30, 42, 34, 50} -- Celadon City Water
--{21, 16, 25, 18} -- Granite Cave B1F
--{20, 35, 30, 40} -- Route 6 water
--{20, 26, 24, 27} -- Route 15
--{26, 13, 31, 15} -- Mt. Silver Exterior
--{41, 61, 50, 62} -- Mt. Silver 1F

-- Do you want to swap pokemon during training or leveling?
autoSwap=false
-- Do you want to catch pokemon during training or leveling?
caughtPoke=true

-- Index of Pokemon that you want to switch in to every battle
attacker=1

useHeadbutt = false
useDigSpot = false
buyPokeball = 10

-------------------------------------------------
--------          HUNT CONFIG        ------------
-- Dont edit it if you dont want to catch poke --
-------------------------------------------------

-- Do you have a sync at 1st?
useSync= false

-- False swipe or Dragon Rage? Use weakMove = "" if you dont want to use it
weakMove = "Dragon Rage"

-- If you want to sleep or paralysis wild poke, tell me what move?
-- Use statusMove = "" if you dont want to use it
statusMove = ""

-- Do you want to check Abilities of Pokemon before catch its?
-- WARNING : It's just work with Hunter.lua Module only
checkAbi=true

-- Percent of Health start throwing ball
lowestHealthPercent = 50

-- Max Pokemon want to catch
maxCounter=10

-- Config list of pokemon you want to catch
wishList = {"Cubone"}

-- Config list of abilities of pokemon you want to catch
abiList = {"Magic Guard", "Synchronize", "Drought", "Rock Head"}

-- Do you want to catch uncaught pokemon?
collectPoke=true

-- Attach every pokemon you dont want to catch?
farmMoney=false

-------------------------------------------------
--------         LEVEL CONFIG        ------------
--- Dont edit it if you dont want to level up ---
-------------------------------------------------

-- Pokemon will attack by itself at what Lv?
atkLv = 46

-- Max Level you want to reach
maxLv = 99


-------------------------------------------------
--------         TRAIN CONFIG        ------------
--- Dont edit it if you dont want to TRAIN pk ---
-------------------------------------------------

-- Config list of Evs set you want to train
-- Attack, Defense, Speed, SpAttack, SpDefense, HP
EvList = {"Speed", "SpAttack"}
EvValue = {252, 252,  6}

------------------------------------------------------


-- Which module you will apply? Hunter, Trainer or Leveler? 
dofile "Hunter.lua"