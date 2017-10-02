
--------------------------------------
-----        GENERAL CONFIG 	 -----
--------------------------------------

-- 
target_location ="Route 12"


-- Do you want to use the PathFinder?
autoFindPath = true

-- If the map can not find, you must config manual
-- The first is Pokecenter -> the last is target location
-- You dont need to edit its (IF autoFindPath = TRUE)
mapList = {
	"Pokecenter Vulcanic Town",
	"Vulcanic Town",
	"Vulcan Forest",
	"Vulcan Path"
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
--{20, 26, 24, 27} -- Route 15
--{26, 13, 31, 15} -- Mt. Silver Exterior
--{41, 61, 50, 62} -- Mt. Silver 1F

-- Do you want to swap pokemon during training or leveling?
autoSwap=true
-- Do you want to catch pokemon during training or leveling?
caughtPoke=true

-- Index of Pokemon that you want to switch in to every battle
attacker=2

useHeadbutt = false
useDigSpot = false
buyPokeball = 50



-------------------------------------------------
--------          HUNT CONFIG        ------------
-- Dont edit it if you dont want to catch poke --
-------------------------------------------------

-- Do you have a sync at 1st?
useSync= true

-- False swipe or Dragon Rage? Use weakMove = "" if you dont want to use it
weakMove = "False swipe"

-- If you want to sleep or paralysis wild poke, tell me what move?
-- Use statusMove = "" if you dont want to use it
statusMove = ""

-- Do you want to check Abilities of Pokemon before catch its?
-- WARNING : It's just work with Hunter.lua Module only
checkAbi=false

-- Percent of Health start throwing ball
lowestHealthPercent = 30
-- Max Pokemon want to catch
maxCounter=20

-- Config list of pokemon you want to catch
wishList = {"Snorlax"}
-- Config list of abilities of pokemon you want to catch
abiList = {"Lightning Rod", "Vital Spirit", "No Guard", "Hustle"}

-- Do you want to catch uncaught pokemon?
collectPoke=true

-- Attach every pokemon you dont want to catch?
farmMoney=false

-------------------------------------------------
--------         LEVEL CONFIG        ------------
--- Dont edit it if you dont want to level up ---
-------------------------------------------------

-- Pokemon will attack by itself at what Lv?
atkLv = 50

-- Max Level you want to reach
maxLv = 99


-------------------------------------------------
--------         TRAIN CONFIG        ------------
--- Dont edit it if you dont want to TRAIN pk ---
-------------------------------------------------

-- Config list of Evs set you want to train
-- Attack, Defense, Speed, SpAttack, SpDefense, HP
EvList = {"Attack", "Speed"}
EvValue = {252, 252}

------------------------------------------------------

-- Which module you will apply? Hunter, Trainer or Leveler? 
dofile "Trainer.lua"
