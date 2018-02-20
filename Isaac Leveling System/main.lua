local Mod = RegisterMod("Leveling System", 1) -- Register mod (duh)

-- Round function (so can round to num. decimal places) --
function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

-------------
-- Imports --
-------------
local LevelingSystem = require("scripts/LevelingSystem.lua") -- Import level system script (experience table and level bonuses table)
local TblToString = require("scripts/TblToString.lua") -- Import TblToString script (with table to string functions)
local BitmapConverter = require("scripts/bitmap_1_converter.lua") -- Import bitmap converter (convert bitmap into number of 1s)

-------------------
-- Import Tables --
-------------------
local Exp = LevelingSystem.Exp -- Gets experience table from level system script
local LevelBonus = LevelingSystem.LevelBonus -- Gets level bonuses table from level system script

---------------
-- Variables --
---------------
local game = Game() -- Creates game variable (to avoid using Game() whenever using a function from Game)
local sfxManager = SFXManager() -- Creates sfx manager (for sounds)
local Variables = {} -- Creates blank variables table (to be filled in on load data)
local Stats = {} -- Creates blank stats table
local Points = {} -- Creates blank points table
local CritChance = {} -- Creates blank crit chance table
local CritDamage = {} -- Creates blank crit damage table

---------------------
--   Script for    --
-- Leveling System --
---------------------
local LevelScript = {}
	function LevelScript:Rebirth(player) -- Rebirth the character
		Stats.Level = 1 -- Resets level to level 1
		Stats.Experience = 0 -- Resets experience to 0
		Stats.MaxExperience = 100 -- Resets max experience to 100
		Stats.Strength = 15 -- Resets strength to 15
		Stats.Dexterity = 15 -- Resets dexterity to 15
		Stats.Vitality = 15 -- Resets vitality to 15
		Stats.Luck = 0 -- Resets luck to 0
		Points.Points_Stat = 0 -- Resets stat points to 0
		Stats.RebirthLevel = Stats.RebirthLevel + 1 -- Increases rebirth level by 1
	end
	
	function LevelScript:onPefUpdate(player)
		if game:GetFrameCount() > 1 then
			if Stats.Experience > Stats.MaxExperience then -- If the experience exceeds the maximum experience
				Stats.Experience = Stats.MaxExperience -- Sets the experience to the maximum experience (used for when max level)
			end
			if Stats.Experience >= Stats.MaxExperience and Stats.Level < 100 then -- Checks to see in the player has leveled up
				--Stats.Experience = Stats.Experience - Stats.MaxExperience -- Sets the experience to the experience it should be
				Stats.MaxExperience = (Stats.MaxExperience*2) + math.floor((math.sqrt(Stats.Level)+Stats.Level) * 5) -- Sets the maximum experience to the next level's maximum experience
				Stats.Level = Stats.Level + 1 -- Level up the player
				Points.Points_Stat = Points.Points_Stat + LevelBonus.LEVEL_STAT + Stats.RebirthLevel -- Increases stat points by stat point per level (plus rebirth level if >= 1)
			end
		end
	end
	
	function LevelScript:onKill(target)
	-- Adding Experience --
		local entity = target:ToNPC()
	-- BoI Enemies --
		if entity.Type == EntityType.ENTITY_GAPER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_GAPER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_GAPER
			end
		end
		if entity.Type == EntityType.ENTITY_GUSHER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_GUSHER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_GUSHER
			end
		end
		if entity.Type == EntityType.ENTITY_HORF then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_HORF * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_HORF
			end
		end
		if entity.Type == EntityType.ENTITY_POOTER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_POOTER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_POOTER
			end
		end
		if entity.Type == EntityType.ENTITY_CLOTTY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_CLOTTY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_CLOTTY
			end
		end
		if entity.Type == EntityType.ENTITY_MULLIGAN then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MULLIGAN * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MULLIGAN
			end
		end
		if entity.Type == EntityType.ENTITY_SHOPKEEPER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_SHOPKEEPER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_SHOPKEEPER
			end
		end
		if entity.Type == EntityType.ENTITY_ATTACKFLY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_ATTACKFLY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_ATTACKFLY
			end
		end
		if entity.Type == EntityType.ENTITY_MAGGOT then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MAGGOT * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MAGGOT
			end
		end
		if entity.Type == EntityType.ENTITY_HIVE then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_HIVE * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_HIVE
			end
		end
		if entity.Type == EntityType.ENTITY_CHARGER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_CHARGER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_CHARGER
			end
		end
		if entity.Type == EntityType.ENTITY_GLOBIN then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_GLOBIN * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_GLOBIN
			end
		end
		if entity.Type == EntityType.ENTITY_BOOMFLY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BOOMFLY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BOOMFLY
			end
		end
		if entity.Type == EntityType.ENTITY_MAW then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MAW * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MAW
			end
		end
		if entity.Type == EntityType.ENTITY_HOST then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_HOST * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_HOST
			end
		end
		if entity.Type == EntityType.ENTITY_HOPPER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_HOPPER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_HOPPER
			end
		end
		if entity.Type == EntityType.ENTITY_SPITY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_SPITY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_SPITY
			end
		end
		if entity.Type == EntityType.ENTITY_BRAIN then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BRAIN * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BRAIN
			end
		end
		if entity.Type == EntityType.ENTITY_LEAPER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_LEAPER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_LEAPER
			end
		end
		if entity.Type == EntityType.ENTITY_MRMAW then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MRMAW * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MRMAW
			end
		end
		if entity.Type == EntityType.ENTITY_BABY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BABY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BABY
			end
		end
		if entity.Type == EntityType.ENTITY_VIS then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_VIS * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_VIS
			end
		end
		if entity.Type == EntityType.ENTITY_GUTS then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_GUTS * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_GUTS
			end
		end
		if entity.Type == EntityType.ENTITY_KNIGHT then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_KNIGHT * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_KNIGHT
			end
		end
		if entity.Type == EntityType.ENTITY_DOPLE then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_DOPLE * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_DOPLE
			end
		end
		if entity.Type == EntityType.ENTITY_FLAMINGHOPPER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_FLAMINGHOPPER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_FLAMINGHOPPER
			end
		end
		if entity.Type == EntityType.ENTITY_LEECH then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_LEECH * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_LEECH
			end
		end
		if entity.Type == EntityType.ENTITY_LUMP then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_LUMP * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_LUMP
			end
		end
		if entity.Type == EntityType.ENTITY_MEMBRAIN then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MEMBRAIN * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MEMBRAIN
			end
		end
		if entity.Type == EntityType.ENTITY_PARA_BITE then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_PARA_BITE * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_PARA_BITE
			end
		end
		if entity.Type == EntityType.ENTITY_FRED then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_FRED * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_FRED
			end
		end
		if entity.Type == EntityType.ENTITY_EYE then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_EYE * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_EYE
			end
		end
		if entity.Type == EntityType.ENTITY_SUCKER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_SUCKER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_SUCKER
			end
		end
		if entity.Type == EntityType.ENTITY_FISTULA_BIG then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_FISTULA_BIG * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_FISTULA_BIG
			end
		end
		if entity.Type == EntityType.ENTITY_FISTULA_MEDIUM then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_FISTULA_MEDIUM * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_FISTULA_MEDIUM
			end
		end
		if entity.Type == EntityType.ENTITY_FISTULA_SMALL then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_FISTULA_SMALL * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_FISTULA_SMALL
			end
		end
		if entity.Type == EntityType.ENTITY_BLASTOCYST_BIG then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BLASTOCYST_BIG * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BLASTOCYST_BIG
			end
		end
		if entity.Type == EntityType.ENTITY_BLASTOCYST_MEDIUM then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BLASTOCYST_MEDIUM * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BLASTOCYST_MEDIUM
			end
		end
		if entity.Type == EntityType.ENTITY_BLASTOCYST_SMALL then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BLASTOCYST_SMALL * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BLASTOCYST_SMALL
			end
		end
		if entity.Type == EntityType.ENTITY_EMBRYO then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_EMBRYO * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_EMBRYO
			end
		end
		if entity.Type == EntityType.ENTITY_MOTER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MOTER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MOTER
			end
		end
		if entity.Type == EntityType.ENTITY_SPIDER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_SPIDER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_SPIDER
			end
		end
		if entity.Type == EntityType.ENTITY_KEEPER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_KEEPER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_KEEPER
			end
		end
		if entity.Type == EntityType.ENTITY_GURGLE then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_GURGLE * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_GURGLE
			end
		end
		if entity.Type == EntityType.ENTITY_WALKINGBOIL then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_WALKINGBOIL * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_WALKINGBOIL
			end
		end
		if entity.Type == EntityType.ENTITY_BUTTLICKER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BUTTLICKER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BUTTLICKER
			end
		end
		if entity.Type == EntityType.ENTITY_HANGER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_HANGER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_HANGER
			end
		end
		if entity.Type == EntityType.ENTITY_SWARMER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_SWARMER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_SWARMER
			end
		end
		if entity.Type == EntityType.ENTITY_HEART then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_HEART * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_HEART
			end
		end
		if entity.Type == EntityType.ENTITY_BIGSPIDER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BIGSPIDER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BIGSPIDER
			end
		end
	-- BoI Mini-bosses --
		if entity.Type == EntityType.ENTITY_SLOTH then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_SLOTH * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_SLOTH
			end
		end
		if entity.Type == EntityType.ENTITY_LUST then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_LUST * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_LUST
			end
		end
		if entity.Type == EntityType.ENTITY_WRATH then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_WRATH * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_WRATH
			end
		end
		if entity.Type == EntityType.ENTITY_GLUTTONY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_GLUTTONY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_GLUTTONY
			end
		end
		if entity.Type == EntityType.ENTITY_GREED then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_GREED * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_GREED
			end
		end
		if entity.Type == EntityType.ENTITY_ENVY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_ENVY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_ENVY
			end
		end
		if entity.Type == EntityType.ENTITY_PRIDE then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_PRIDE * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_PRIDE
			end
		end
	-- BoI Bosses --
		if entity.Type == EntityType.ENTITY_LARRYJR then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_LARRYJR * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_LARRYJR
			end
		end
		if entity.Type == EntityType.ENTITY_MONSTRO then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MONSTRO * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MONSTRO
			end
		end
		if entity.Type == EntityType.ENTITY_CHUB then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_CHUB * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_CHUB
			end
		end
		if entity.Type == EntityType.ENTITY_MONSTRO2 then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MONSTRO2 * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MONSTRO2
			end
		end
		if entity.Type == EntityType.ENTITY_GURDY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_GURDY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_GURDY
			end
		end
		if entity.Type == EntityType.ENTITY_PIN then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_PIN * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_PIN
			end
		end
		if entity.Type == EntityType.ENTITY_DUKE then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_DUKE * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_DUKE
			end
		end
		if entity.Type == EntityType.ENTITY_PEEP then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_PEEP * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_PEEP
			end
		end
		if entity.Type == EntityType.ENTITY_LOKI then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_LOKI * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_LOKI
			end
		end
		if entity.Type == EntityType.ENTITY_GEMINI then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_GEMINI * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_GEMINI
			end
		end
		if entity.Type == EntityType.ENTITY_FALLEN then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_FALLEN * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_FALLEN
			end
		end
		if entity.Type == EntityType.ENTITY_MASK_OF_INFAMY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MASK_OF_INFAMY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MASK_OF_INFAMY
			end
		end
		if entity.Type == EntityType.ENTITY_HEART_OF_INFAMY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_HEART_OF_INFAMY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_HEART_OF_INFAMY
			end
		end
		if entity.Type == EntityType.ENTITY_GURDY_JR then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_GURDY_JR * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_GURDY_JR
			end
		end
		if entity.Type == EntityType.ENTITY_WIDOW then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_WIDOW * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_WIDOW
			end
		end
		if entity.Type == EntityType.ENTITY_DADDYLONGLEGS then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_DADDYLONGLEGS * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_DADDYLONGLEGS
			end
		end
		-- Horsemen --
		if entity.Type == EntityType.ENTITY_FAMINE then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_FAMINE * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_FAMINE
			end
		end
		if entity.Type == EntityType.ENTITY_PESTILENCE then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_PESTILENCE * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_PESTILENCE
			end
		end
		if entity.Type == EntityType.ENTITY_WAR then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_WAR * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_WAR
			end
		end
		if entity.Type == EntityType.ENTITY_DEATH then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_DEATH * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_DEATH
			end
		end
		if entity.Type == EntityType.ENTITY_HEADLESS_HORSEMAN then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_HEADLESS_HORSEMAN * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_HEADLESS_HORSEMAN
			end
		end
		if entity.Type == EntityType.ENTITY_HORSEMAN_HEAD then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_HORSEMAN_HEAD * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_HORSEMAN_HEAD
			end
		end
	-- BoI End Bosses --
		if entity.Type == EntityType.ENTITY_MOM then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MOM * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MOM
			end
		end
		if entity.Type == EntityType.ENTITY_MOMS_HEART then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MOMS_HEART * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MOMS_HEART
			end
		end
		if entity.Type == EntityType.ENTITY_SATAN then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_SATAN * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_SATAN
			end
		end
		if entity.Type == EntityType.ENTITY_ISAAC then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_ISAAC * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_ISAAC
			end
		end
	-- Rebirth Enemies --
		if entity.Type == EntityType.ENTITY_MOBILE_HOST then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MOBILE_HOST * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MOBILE_HOST
			end
		end
		if entity.Type == EntityType.ENTITY_NEST then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_NEST * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_NEST
			end
		end
		if entity.Type == EntityType.ENTITY_BABY_LONG_LEGS then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BABY_LONG_LEGS * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BABY_LONG_LEGS
			end
		end
		if entity.Type == EntityType.ENTITY_CRAZY_LONG_LEGS then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_CRAZY_LONG_LEGS * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_CRAZY_LONG_LEGS
			end
		end
		if entity.Type == EntityType.ENTITY_FATTY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_FATTY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_FATTY
			end
		end
		if entity.Type == EntityType.ENTITY_FAT_SACK then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_FAT_SACK * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_FAT_SACK
			end
		end
		if entity.Type == EntityType.ENTITY_BLUBBER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BLUBBER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BLUBBER
			end
		end
		if entity.Type == EntityType.ENTITY_HALF_SACK then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_HALF_SACK * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_HALF_SACK
			end
		end
		if entity.Type == EntityType.ENTITY_MOMS_HAND then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MOMS_HAND * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MOMS_HAND
			end
		end	
		if entity.Type == EntityType.ENTITY_FLY_L2 then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_FLY_L2 * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_FLY_L2
			end
		end
		if entity.Type == EntityType.ENTITY_SPIDER_L2 then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_SPIDER_L2 * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_SPIDER_L2
			end
		end
		if entity.Type == EntityType.ENTITY_SWINGER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_SWINGER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_SWINGER
			end
		end
		if entity.Type == EntityType.ENTITY_DIP then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_DIP * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_DIP
			end
		end
		if entity.Type == EntityType.ENTITY_WALL_HUGGER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_WALL_HUGGER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_WALL_HUGGER
			end
		end
		if entity.Type == EntityType.ENTITY_WIZOOB then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_WIZOOB * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_WIZOOB
			end
		end
		if entity.Type == EntityType.ENTITY_SQUIRT then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_SQUIRT * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_SQUIRT
			end
		end
		if entity.Type == EntityType.ENTITY_COD_WORM then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_COD_WORM * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_COD_WORM
			end
		end
		if entity.Type == EntityType.ENTITY_RING_OF_FLIES then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_RING_OF_FLIES * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_RING_OF_FLIES
			end
		end
		if entity.Type == EntityType.ENTITY_DINGA then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_DINGA * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_DINGA
			end
		end
		if entity.Type == EntityType.ENTITY_OOB then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_OOB * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_OOB
			end
		end
		if entity.Type == EntityType.ENTITY_BLACK_MAW then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BLACK_MAW * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BLACK_MAW
			end
		end
		if entity.Type == EntityType.ENTITY_SKINNY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_SKINNY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_SKINNY
			end
		end
		if entity.Type == EntityType.ENTITY_BONY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BONY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BONY
			end
		end
		if entity.Type == EntityType.ENTITY_HOMUNCULUS then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_HOMUNCULUS * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_HOMUNCULUS
			end
		end
		if entity.Type == EntityType.ENTITY_TUMOR then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_TUMOR * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_TUMOR
			end
		end
		if entity.Type == EntityType.ENTITY_CAMILLO_JR then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_CAMILLO_JR * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_CAMILLO_JR
			end
		end
		if entity.Type == EntityType.ENTITY_SKINBALL then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_SKINBALL * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_SKINBALL
			end
		end
		if entity.Type == EntityType.ENTITY_MOM_HEAD then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MOM_HEAD * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MOM_HEAD
			end
		end
		if entity.Type == EntityType.ENTITY_ONE_TOOTH then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_ONE_TOOTH * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_ONE_TOOTH
			end
		end
		if entity.Type == EntityType.ENTITY_GURGLING then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_GURGLING * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_GURGLING
			end
		end
		if entity.Type == EntityType.ENTITY_SPLASHER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_SPLASHER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_SPLASHER
			end
		end
		if entity.Type == EntityType.ENTITY_GRUB then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_GRUB * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_GRUB
			end
		end
		if entity.Type == EntityType.ENTITY_WALL_CREEP then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_WALL_CREEP * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_WALL_CREEP
			end
		end
		if entity.Type == EntityType.ENTITY_RAGE_CREEP then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_RAGE_CREEP * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_RAGE_CREEP
			end
		end
		if entity.Type == EntityType.ENTITY_BLIND_CREEP then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BLIND_CREEP * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BLIND_CREEP
			end
		end
		if entity.Type == EntityType.ENTITY_CONJOINED_SPITTY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_CONJOINED_SPITTY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_CONJOINED_SPITTY
			end
		end
		if entity.Type == EntityType.ENTITY_ROUND_WORM then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_ROUND_WORM * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_ROUND_WORM
			end
		end
		if entity.Type == EntityType.ENTITY_RAGLING then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_RAGLING * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_RAGLING
			end
		end
		if entity.Type == EntityType.ENTITY_FLESH_MOBILE_HOST then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_FLESH_MOBILE_HOST * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_FLESH_MOBILE_HOST
			end
		end
		if entity.Type == EntityType.ENTITY_PSY_HORF then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_PSY_HORF * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_PSY_HORF
			end
		end
		if entity.Type == EntityType.ENTITY_FULL_FLY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_FULL_FLY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_FULL_FLY
			end
		end
		if entity.Type == EntityType.ENTITY_TICKING_SPIDER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_TICKING_SPIDER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_TICKING_SPIDER
			end
		end
		if entity.Type == EntityType.ENTITY_BEGOTTEN then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BEGOTTEN * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BEGOTTEN
			end
		end
		if entity.Type == EntityType.ENTITY_NULLS then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_NULLS * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_NULLS
			end
		end
		if entity.Type == EntityType.ENTITY_PSY_TUMOR then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_PSY_TUMOR * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_PSY_TUMOR
			end
		end
		if entity.Type == EntityType.ENTITY_FLOATING_KNIGHT then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_FLOATING_KNIGHT * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_FLOATING_KNIGHT
			end
		end
		if entity.Type == EntityType.ENTITY_NIGHT_CRAWLER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_NIGHT_CRAWLER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_NIGHT_CRAWLER
			end
		end
	-- Rebirth Bosses --
		if entity.Type == EntityType.ENTITY_THE_HAUNT then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_THE_HAUNT * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_THE_HAUNT
			end
		end
		if entity.Type == EntityType.ENTITY_DINGLE then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_DINGLE * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_DINGLE
			end
		end
		if entity.Type == EntityType.ENTITY_MEGA_MAW then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MEGA_MAW * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MEGA_MAW
			end
		end
		if entity.Type == EntityType.ENTITY_GATE then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_GATE * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_GATE
			end
		end
		if entity.Type == EntityType.ENTITY_MEGA_FATTY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MEGA_FATTY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MEGA_FATTY
			end
		end
		if entity.Type == EntityType.ENTITY_CAGE then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_CAGE * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_CAGE
			end
		end
		if entity.Type == EntityType.ENTITY_MAMA_GURDY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MAMA_GURDY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MAMA_GURDY
			end
		end
		if entity.Type == EntityType.ENTITY_DARK_ONE then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_DARK_ONE * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_DARK_ONE
			end
		end
		if entity.Type == EntityType.ENTITY_ADVERSARY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_ADVERSARY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_ADVERSARY
			end
		end
		if entity.Type == EntityType.ENTITY_POLYCEPHALUS then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_POLYCEPHALUS * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_POLYCEPHALUS
			end
		end
		if entity.Type == EntityType.ENTITY_MR_FRED then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MR_FRED * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MR_FRED
			end
		end
		-- Angels --
		if entity.Type == EntityType.ENTITY_URIEL then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_URIEL * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_URIEL
			end
		end
		if entity.Type == EntityType.ENTITY_GABRIEL then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_GABRIEL * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_GABRIEL
			end
		end
	-- Rebirth End Bosses --
		if entity.Type == EntityType.ENTITY_THE_LAMB then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_THE_LAMB * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_THE_LAMB
			end
		end
		if entity.Type == EntityType.ENTITY_MEGA_SATAN then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MEGA_SATAN * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MEGA_SATAN
			end
		end
		if entity.Type == EntityType.ENTITY_MEGA_SATAN_2 then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MEGA_SATAN_2 * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MEGA_SATAN_2
			end
		end
	-- Afterbirth Enemies --
		if entity.Type == EntityType.ENTITY_DART_FLY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_DART_FLY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_DART_FLY
			end
		end
		if entity.Type == EntityType.ENTITY_CONJOINED_FATTY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_CONJOINED_FATTY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_CONJOINED_FATTY
			end
		end
		if entity.Type == EntityType.ENTITY_FAT_BAT then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_FAT_BAT * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_FAT_BAT
			end
		end
		if entity.Type == EntityType.ENTITY_IMP then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_IMP * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_IMP
			end
		end
		if entity.Type == EntityType.ENTITY_ROUNDY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_ROUNDY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_ROUNDY
			end
		end
		if entity.Type == EntityType.ENTITY_BLACK_BONY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BLACK_BONY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BLACK_BONY
			end
		end
		if entity.Type == EntityType.ENTITY_BLACK_GLOBIN then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BLACK_GLOBIN * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BLACK_GLOBIN
			end
		end
		if entity.Type == EntityType.ENTITY_BLACK_GLOBIN_HEAD then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BLACK_GLOBIN_HEAD * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BLACK_GLOBIN_HEAD
			end
		end
		if entity.Type == EntityType.ENTITY_BLACK_GLOBIN_BODY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BLACK_GLOBIN_BODY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BLACK_GLOBIN_BODY
			end
		end
		if entity.Type == EntityType.ENTITY_SWARM then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_SWARM * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_SWARM
			end
		end
		if entity.Type == EntityType.ENTITY_MEGA_CLOTTY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MEGA_CLOTTY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MEGA_CLOTTY
			end
		end
		if entity.Type == EntityType.ENTITY_BONE_KNIGHT then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BONE_KNIGHT * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BONE_KNIGHT
			end
		end
		if entity.Type == EntityType.ENTITY_CYCLOPIA then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_CYCLOPIA * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_CYCLOPIA
			end
		end
		if entity.Type == EntityType.ENTITY_RED_GHOST then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_RED_GHOST * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_RED_GHOST
			end
		end
		if entity.Type == EntityType.ENTITY_FLESH_DEATHS_HEAD then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_FLESH_DEATHS_HEAD * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_FLESH_DEATHS_HEAD
			end
		end
		if entity.Type == EntityType.ENTITY_MOMS_DEAD_HAND then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MOMS_DEAD_HAND * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MOMS_DEAD_HAND
			end
		end
		if entity.Type == EntityType.ENTITY_DUKIE then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_DUKIE * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_DUKIE
			end
		end
		if entity.Type == EntityType.ENTITY_ULCER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_ULCER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_ULCER
			end
		end
		if entity.Type == EntityType.ENTITY_MEATBALL then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MEATBALL * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MEATBALL
			end
		end
		if entity.Type == EntityType.ENTITY_HUSH_FLY then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_HUSH_FLY * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_HUSH_FLY
			end
		end
		if entity.Type == EntityType.ENTITY_HUSH_GAPER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_HUSH_GAPER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_HUSH_GAPER
			end
		end
		if entity.Type == EntityType.ENTITY_HUSH_BOIL then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_HUSH_BOIL * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_HUSH_BOIL
			end
		end
		if entity.Type == EntityType.ENTITY_GREED_GAPER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_GREED_GAPER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_GREED_GAPER
			end
		end
	-- Afterbirth Bosses --
		if entity.Type == EntityType.ENTITY_STAIN then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_STAIN * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_STAIN
			end
		end
		if entity.Type == EntityType.ENTITY_BROWNIE then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BROWNIE * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BROWNIE
			end
		end
		if entity.Type == EntityType.ENTITY_FORSAKEN then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_FORSAKEN * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_FORSAKEN
			end
		end
		if entity.Type == EntityType.ENTITY_LITTLE_HORN then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_LITTLE_HORN * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_LITTLE_HORN
			end
		end
		if entity.Type == EntityType.ENTITY_RAG_MAN then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_RAG_MAN * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_RAG_MAN
			end
		end
	-- Afterbirth End Bosses --
		if entity.Type == EntityType.ENTITY_ULTRA_GREED then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_ULTRA_GREED * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_ULTRA_GREED
			end
		end
		if entity.Type == EntityType.ENTITY_HUSH then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_HUSH * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_HUSH
			end
		end
	-- Afterbirth+ Enemies --
		if entity.Type == EntityType.ENTITY_MUSHROOM then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MUSHROOM * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MUSHROOM
			end
		end
		if entity.Type == EntityType.ENTITY_POISON_MIND then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_POISON_MIND * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_POISON_MIND
			end
		end
		if entity.Type == EntityType.ENTITY_BLISTER then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BLISTER * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BLISTER
			end
		end
		if entity.Type == EntityType.ENTITY_THE_THING then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_THE_THING * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_THE_THING
			end
		end
		if entity.Type == EntityType.ENTITY_MINISTRO then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_MINISTRO * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_MINISTRO
			end
		end
		if entity.Type == EntityType.ENTITY_PORTAL then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_PORTAL * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_PORTAL
			end
		end
	-- Afterbirth+ Bosses --
		if entity.Type == EntityType.ENTITY_RAG_MEGA then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_RAG_MEGA * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_RAG_MEGA
			end
		end
		if entity.Type == EntityType.ENTITY_SISTERS_VIS then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_SISTERS_VIS * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_SISTERS_VIS
			end
		end
		if entity.Type == EntityType.ENTITY_BIG_HORN then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_BIG_HORN * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_BIG_HORN
			end
		end
	-- Afterbirth+ End Bosses --
		if entity.Type == EntityType.ENTITY_DELIRIUM then
			if entity:IsChampion() then
				Stats.Experience = Stats.Experience + (Exp.EXP_DELIRIUM * 2)
			else
				Stats.Experience = Stats.Experience + Exp.EXP_DELIRIUM
			end
		end
	end
Mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, LevelScript.onPefUpdate)
Mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, LevelScript.onKill)

---------------------
--   Script for    --
--   Stat System   --
---------------------
local StatScript = {}	
	------------------------
	-- Save and Load data --
	------------------------
	function saveData(data)
		dataToString = TblToString.tostring(data) -- Uses TblToString script to convert the table given as data into a string
		Isaac.SaveModData(Mod, dataToString) -- Saves the data for the mod using the previously converted string
	end
	
	function StatScript:onGameExit()
		saveData(Variables) -- Saves the data in the Variables table
	end
	
	function StatScript:onRender()
		-- Renders stats to screen --
		Isaac.RenderText("STR: "..Stats.Strength, 400, 160, 1, 1, 1, 1)
		Isaac.RenderText("DEX: "..Stats.Dexterity, 400, 170, 1, 1, 1, 1)
		Isaac.RenderText("VIT: "..Stats.Vitality, 400, 180, 1, 1, 1, 1)
		Isaac.RenderText("LCK: "..Stats.Luck, 400, 190, 1, 1, 1, 1)
		Isaac.RenderText("Stat pt: "..Points.Points_Stat, 400, 200, 1, 1, 1, 1)
		Isaac.RenderText("Exp: "..Stats.Experience.." ("..round((Stats.Experience / Stats.MaxExperience)*100).."%)", 210, 240, 1, 1, 1, 1)
		Isaac.RenderText("Lvl: "..Stats.Level, 270, 250, 1, 1, 1, 1)
		Isaac.RenderText("Rebirth: "..Stats.RebirthLevel, 190, 250, 1, 1, 1, 1)
		if Stats.ExtraHealth > 0 then
			Isaac.RenderText("HP: "..Stats.Health.." + "..Stats.ExtraHealth, 60, 5, 1, 1, 1, 1)
		else
			Isaac.RenderText("HP: "..Stats.Health, 60, 5, 1, 1, 1, 1)
		end
		-- Stat Rendering end --
	end
	
	function StatScript:onCache(player, cacheFlag)
		if cacheFlag == CacheFlag.CACHE_DAMAGE then -- If cache is damage
			player.Damage = player.Damage + round(((Stats.Strength / 5) - 3), 1)
		end
		if cacheFlag == CacheFlag.CACHE_FIREDELAY then -- If cache is fire delay
			if player.MaxFireDelay >= 1 then
				player.MaxFireDelay = player.MaxFireDelay - math.floor(math.log(Stats.Dexterity^3/200) - 2)
			else
				player.MaxFireDelay = 1
			end
		end
		if cacheFlag == CacheFlag.CACHE_LUCK then -- If cache is luck
			player.Luck = player.Luck + math.floor(Stats.Luck / 5)
		end
	end
	
	function StatScript:onPlayerInit(player)
		if Isaac.HasModData(Mod) then
			Variables = load("return "..Isaac.LoadModData(Mod))() -- Loads the data for the mod into the Variables table
		else
			-- Default values for the Variables table
			Variables = {
				Isaac = {
					Stats = {
						Strength = 15, -- Strength stat
						Vitality = 15, -- Vitality stat
						Dexterity = 15, -- Dexterity stat
						Luck = 0, -- Luck stat
						Experience = 0, -- Current experience
						Health = 30, -- Current health
						ExtraHealth = 0, -- Current extra health (goes above cap)
						MaxHealth = 30, -- Maximum health
						HealthDif = 0, -- Health difference due to character, items, etc.
						EternalArmor = false, -- Has eternal heart armour?
						GoldenArmor = false, -- Has golden heart armour?
						Level = 1, -- Current level
						RebirthLevel = 0, -- Current rebirth level
						MaxExperience = 100 -- Experience to next level
					},
					Points = {
						Points_Stat = 0, -- Current stat points
					},
					CritChance = {
						CRIT = 0.1, -- Chance of basic crit
						OVERCRIT = 1, -- Chance of Overcrit
						DOUBLE_OVERCRIT = 1 -- Chance of double Overcrit
					},
					CritDamage = {
						CRIT = 2, -- Basic crit damage multiplier
						OVERCRIT = 3, -- Overcrit damage multiplier
						DOUBLE_OVERCRIT = 4 -- Double Overcrit damage multiplier
					}
				},
				Magdalene = {
					Stats = {
						Strength = 15, -- Strength stat
						Vitality = 15, -- Vitality stat
						Dexterity = 15, -- Dexterity stat
						Luck = 0, -- Luck stat
						Experience = 0, -- Current experience
						Health = 30, -- Current health
						ExtraHealth = 0, -- Current extra health (goes above cap)
						MaxHealth = 30, -- Maximum health
						HealthDif = 0, -- Health difference due to character, items, etc.
						EternalArmor = false, -- Has eternal heart armour?
						GoldenArmor = false, -- Has golden heart armour?
						Level = 1, -- Current level
						RebirthLevel = 0, -- Current rebirth level
						MaxExperience = 100 -- Experience to next level
					},
					Points = {
						Points_Stat = 0, -- Current stat points
					},
					CritChance = {
						Crit = 0.1, -- Chance of basic crit
						OVERCRIT = 1, -- Chance of Overcrit
						DOUBLE_OVERCRIT = 1 -- Chance of double Overcrit
					},
					CritDamage = {
						CRIT = 2, -- Basic crit damage multiplier
						OVERCRIT = 3, -- Overcrit damage multiplier
						DOUBLE_OVERCRIT = 4 -- Double Overcrit damage multiplier
					}
				},
				Cain = {
					Stats = {
						Strength = 15, -- Strength stat
						Vitality = 15, -- Vitality stat
						Dexterity = 15, -- Dexterity stat
						Luck = 0, -- Luck stat
						Experience = 0, -- Current experience
						Health = 30, -- Current health
						ExtraHealth = 0, -- Current extra health (goes above cap)
						MaxHealth = 30, -- Maximum health
						HealthDif = 0, -- Health difference due to character, items, etc.
						EternalArmor = false, -- Has eternal heart armour?
						GoldenArmor = false, -- Has golden heart armour?
						Level = 1, -- Current level
						RebirthLevel = 0, -- Current rebirth level
						MaxExperience = 100 -- Experience to next level
					},
					Points = {
						Points_Stat = 0, -- Current stat points
					},
					CritChance = {
						Crit = 0.1, -- Chance of basic crit
						OVERCRIT = 1, -- Chance of Overcrit
						DOUBLE_OVERCRIT = 1 -- Chance of double Overcrit
					},
					CritDamage = {
						CRIT = 2, -- Basic crit damage multiplier
						OVERCRIT = 3, -- Overcrit damage multiplier
						DOUBLE_OVERCRIT = 4 -- Double Overcrit damage multiplier
					}
				},
				Judas = {
					Stats = {
						Strength = 15, -- Strength stat
						Vitality = 15, -- Vitality stat
						Dexterity = 15, -- Dexterity stat
						Luck = 0, -- Luck stat
						Experience = 0, -- Current experience
						Health = 30, -- Current health
						ExtraHealth = 0, -- Current extra health (goes above cap)
						MaxHealth = 30, -- Maximum health
						HealthDif = 0, -- Health difference due to character, items, etc.
						EternalArmor = false, -- Has eternal heart armour?
						GoldenArmor = false, -- Has golden heart armour?
						Level = 1, -- Current level
						RebirthLevel = 0, -- Current rebirth level
						MaxExperience = 100 -- Experience to next level
					},
					Points = {
						Points_Stat = 0, -- Current stat points
					},
					CritChance = {
						Crit = 0.1, -- Chance of basic crit
						OVERCRIT = 1, -- Chance of Overcrit
						DOUBLE_OVERCRIT = 1 -- Chance of double Overcrit
					},
					CritDamage = {
						CRIT = 2, -- Basic crit damage multiplier
						OVERCRIT = 3, -- Overcrit damage multiplier
						DOUBLE_OVERCRIT = 4 -- Double Overcrit damage multiplier
					}
				},
				Eve = {
					Stats = {
						Strength = 15, -- Strength stat
						Vitality = 15, -- Vitality stat
						Dexterity = 15, -- Dexterity stat
						Luck = 0, -- Luck stat
						Experience = 0, -- Current experience
						Health = 30, -- Current health
						ExtraHealth = 0, -- Current extra health (goes above cap)
						MaxHealth = 30, -- Maximum health
						HealthDif = 0, -- Health difference due to character, items, etc.
						EternalArmor = false, -- Has eternal heart armour?
						GoldenArmor = false, -- Has golden heart armour?
						Level = 1, -- Current level
						RebirthLevel = 0, -- Current rebirth level
						MaxExperience = 100 -- Experience to next level
					},
					Points = {
						Points_Stat = 0, -- Current stat points
					},
					CritChance = {
						Crit = 0.1, -- Chance of basic crit
						OVERCRIT = 1, -- Chance of Overcrit
						DOUBLE_OVERCRIT = 1 -- Chance of double Overcrit
					},
					CritDamage = {
						CRIT = 2, -- Basic crit damage multiplier
						OVERCRIT = 3, -- Overcrit damage multiplier
						DOUBLE_OVERCRIT = 4 -- Double Overcrit damage multiplier
					}
				},
				Samson = {
					Stats = {
						Strength = 15, -- Strength stat
						Vitality = 15, -- Vitality stat
						Dexterity = 15, -- Dexterity stat
						Luck = 0, -- Luck stat
						Experience = 0, -- Current experience
						Health = 30, -- Current health
						ExtraHealth = 0, -- Current extra health (goes above cap)
						MaxHealth = 30, -- Maximum health
						HealthDif = 0, -- Health difference due to character, items, etc.
						EternalArmor = false, -- Has eternal heart armour?
						GoldenArmor = false, -- Has golden heart armour?
						Level = 1, -- Current level
						RebirthLevel = 0, -- Current rebirth level
						MaxExperience = 100 -- Experience to next level
					},
					Points = {
						Points_Stat = 0, -- Current stat points
					},
					CritChance = {
						Crit = 0.1, -- Chance of basic crit
						OVERCRIT = 1, -- Chance of Overcrit
						DOUBLE_OVERCRIT = 1 -- Chance of double Overcrit
					},
					CritDamage = {
						CRIT = 2, -- Basic crit damage multiplier
						OVERCRIT = 3, -- Overcrit damage multiplier
						DOUBLE_OVERCRIT = 4 -- Double Overcrit damage multiplier
					}
				},
				Azazel = {
					Stats = {
						Strength = 15, -- Strength stat
						Vitality = 15, -- Vitality stat
						Dexterity = 15, -- Dexterity stat
						Luck = 0, -- Luck stat
						Experience = 0, -- Current experience
						Health = 30, -- Current health
						ExtraHealth = 0, -- Current extra health (goes above cap)
						MaxHealth = 30, -- Maximum health
						HealthDif = 0, -- Health difference due to character, items, etc.
						EternalArmor = false, -- Has eternal heart armour?
						GoldenArmor = false, -- Has golden heart armour?
						Level = 1, -- Current level
						RebirthLevel = 0, -- Current rebirth level
						MaxExperience = 100 -- Experience to next level
					},
					Points = {
						Points_Stat = 0, -- Current stat points
					},
					CritChance = {
						Crit = 0.1, -- Chance of basic crit
						OVERCRIT = 1, -- Chance of Overcrit
						DOUBLE_OVERCRIT = 1 -- Chance of double Overcrit
					},
					CritDamage = {
						CRIT = 2, -- Basic crit damage multiplier
						OVERCRIT = 3, -- Overcrit damage multiplier
						DOUBLE_OVERCRIT = 4 -- Double Overcrit damage multiplier
					}
				},
				Lazarus = {
					Stats = {
						Strength = 15, -- Strength stat
						Vitality = 15, -- Vitality stat
						Dexterity = 15, -- Dexterity stat
						Luck = 0, -- Luck stat
						Experience = 0, -- Current experience
						Health = 30, -- Current health
						ExtraHealth = 0, -- Current extra health (goes above cap)
						MaxHealth = 30, -- Maximum health
						HealthDif = 0, -- Health difference due to character, items, etc.
						EternalArmor = false, -- Has eternal heart armour?
						GoldenArmor = false, -- Has golden heart armour?
						Level = 1, -- Current level
						RebirthLevel = 0, -- Current rebirth level
						MaxExperience = 100 -- Experience to next level
					},
					Points = {
						Points_Stat = 0, -- Current stat points
					},
					CritChance = {
						Crit = 0.1, -- Chance of basic crit
						OVERCRIT = 1, -- Chance of Overcrit
						DOUBLE_OVERCRIT = 1 -- Chance of double Overcrit
					},
					CritDamage = {
						CRIT = 2, -- Basic crit damage multiplier
						OVERCRIT = 3, -- Overcrit damage multiplier
						DOUBLE_OVERCRIT = 4 -- Double Overcrit damage multiplier
					}
				},
				Eden = {
					Stats = {
						Strength = 15, -- Strength stat
						Vitality = 15, -- Vitality stat
						Dexterity = 15, -- Dexterity stat
						Luck = 0, -- Luck stat
						Experience = 0, -- Current experience
						Health = 30, -- Current health
						ExtraHealth = 0, -- Current extra health (goes above cap)
						MaxHealth = 30, -- Maximum health
						HealthDif = 0, -- Health difference due to character, items, etc.
						EternalArmor = false, -- Has eternal heart armour?
						GoldenArmor = false, -- Has golden heart armour?
						Level = 1, -- Current level
						RebirthLevel = 0, -- Current rebirth level
						MaxExperience = 100 -- Experience to next level
					},
					Points = {
						Points_Stat = 0, -- Current stat points
					},
					CritChance = {
						Crit = 0.1, -- Chance of basic crit
						OVERCRIT = 1, -- Chance of Overcrit
						DOUBLE_OVERCRIT = 1 -- Chance of double Overcrit
					},
					CritDamage = {
						CRIT = 2, -- Basic crit damage multiplier
						OVERCRIT = 3, -- Overcrit damage multiplier
						DOUBLE_OVERCRIT = 4 -- Double Overcrit damage multiplier
					}
				},
				Lilith = {
					Stats = {
						Strength = 15, -- Strength stat
						Vitality = 15, -- Vitality stat
						Dexterity = 15, -- Dexterity stat
						Luck = 0, -- Luck stat
						Experience = 0, -- Current experience
						Health = 30, -- Current health
						ExtraHealth = 0, -- Current extra health (goes above cap)
						MaxHealth = 30, -- Maximum health
						HealthDif = 0, -- Health difference due to character, items, etc.
						EternalArmor = false, -- Has eternal heart armour?
						GoldenArmor = false, -- Has golden heart armour?
						Level = 1, -- Current level
						RebirthLevel = 0, -- Current rebirth level
						MaxExperience = 100 -- Experience to next level
					},
					Points = {
						Points_Stat = 0, -- Current stat points
					},
					CritChance = {
						Crit = 0.1, -- Chance of basic crit
						OVERCRIT = 1, -- Chance of Overcrit
						DOUBLE_OVERCRIT = 1 -- Chance of double Overcrit
					},
					CritDamage = {
						CRIT = 2, -- Basic crit damage multiplier
						OVERCRIT = 3, -- Overcrit damage multiplier
						DOUBLE_OVERCRIT = 4 -- Double Overcrit damage multiplier
					}
				},
				Apollyon = {
					Stats = {
						Strength = 15, -- Strength stat
						Vitality = 15, -- Vitality stat
						Dexterity = 15, -- Dexterity stat
						Luck = 0, -- Luck stat
						Experience = 0, -- Current experience
						Health = 30, -- Current health
						ExtraHealth = 0, -- Current extra health (goes above cap)
						MaxHealth = 30, -- Maximum health
						HealthDif = 0, -- Health difference due to character, items, etc.
						EternalArmor = false, -- Has eternal heart armour?
						GoldenArmor = false, -- Has golden heart armour?
						Level = 1, -- Current level
						RebirthLevel = 0, -- Current rebirth level
						MaxExperience = 100 -- Experience to next level
					},
					Points = {
						Points_Stat = 0, -- Current stat points
					},
					CritChance = {
						Crit = 0.1, -- Chance of basic crit
						OVERCRIT = 1, -- Chance of Overcrit
						DOUBLE_OVERCRIT = 1 -- Chance of double Overcrit
					},
					CritDamage = {
						CRIT = 2, -- Basic crit damage multiplier
						OVERCRIT = 3, -- Overcrit damage multiplier
						DOUBLE_OVERCRIT = 4 -- Double Overcrit damage multiplier
					}
				},
				BB = {
					Stats = {
						Strength = 15, -- Strength stat
						Vitality = 15, -- Vitality stat
						Dexterity = 15, -- Dexterity stat
						Luck = 0, -- Luck stat
						Experience = 0, -- Current experience
						Health = 30, -- Current health
						ExtraHealth = 0, -- Current extra health (goes above cap)
						MaxHealth = 30, -- Maximum health
						HealthDif = 0, -- Health difference due to character, items, etc.
						EternalArmor = false, -- Has eternal heart armour?
						GoldenArmor = false, -- Has golden heart armour?
						Level = 1, -- Current level
						RebirthLevel = 0, -- Current rebirth level
						MaxExperience = 100 -- Experience to next level
					},
					Points = {
						Points_Stat = 0, -- Current stat points
					},
					CritChance = {
						Crit = 0.1, -- Chance of basic crit
						OVERCRIT = 1, -- Chance of Overcrit
						DOUBLE_OVERCRIT = 1 -- Chance of double Overcrit
					},
					CritDamage = {
						CRIT = 2, -- Basic crit damage multiplier
						OVERCRIT = 3, -- Overcrit damage multiplier
						DOUBLE_OVERCRIT = 4 -- Double Overcrit damage multiplier
					}
				},
				TheLost = {
					Stats = {
						Strength = 15, -- Strength stat
						Vitality = 15, -- Vitality stat
						Dexterity = 15, -- Dexterity stat
						Luck = 0, -- Luck stat
						Experience = 0, -- Current experience
						Health = 30, -- Current health
						ExtraHealth = 0, -- Current extra health (goes above cap)
						MaxHealth = 30, -- Maximum health
						HealthDif = 0, -- Health difference due to character, items, etc.
						EternalArmor = false, -- Has eternal heart armour?
						GoldenArmor = false, -- Has golden heart armour?
						Level = 1, -- Current level
						RebirthLevel = 0, -- Current rebirth level
						MaxExperience = 100 -- Experience to next level
					},
					Points = {
						Points_Stat = 0, -- Current stat points
					},
					CritChance = {
						Crit = 0.1, -- Chance of basic crit
						OVERCRIT = 1, -- Chance of Overcrit
						DOUBLE_OVERCRIT = 1 -- Chance of double Overcrit
					},
					CritDamage = {
						CRIT = 2, -- Basic crit damage multiplier
						OVERCRIT = 3, -- Overcrit damage multiplier
						DOUBLE_OVERCRIT = 4 -- Double Overcrit damage multiplier
					}
				},
				TheKeeper = {
					Stats = {
						Strength = 15, -- Strength stat
						Vitality = 15, -- Vitality stat
						Dexterity = 15, -- Dexterity stat
						Luck = 0, -- Luck stat
						Experience = 0, -- Current experience
						Health = 30, -- Current health
						ExtraHealth = 0, -- Current extra health (goes above cap)
						MaxHealth = 30, -- Maximum health
						HealthDif = 0, -- Health difference due to character, items, etc.
						EternalArmor = false, -- Has eternal heart armour?
						GoldenArmor = false, -- Has golden heart armour?
						Level = 1, -- Current level
						RebirthLevel = 0, -- Current rebirth level
						MaxExperience = 100 -- Experience to next level
					},
					Points = {
						Points_Stat = 0, -- Current stat points
					},
					CritChance = {
						Crit = 0.1, -- Chance of basic crit
						OVERCRIT = 1, -- Chance of Overcrit
						DOUBLE_OVERCRIT = 1 -- Chance of double Overcrit
					},
					CritDamage = {
						CRIT = 2, -- Basic crit damage multiplier
						OVERCRIT = 3, -- Overcrit damage multiplier
						DOUBLE_OVERCRIT = 4 -- Double Overcrit damage multiplier
					}
				}
			}
		end
		if player:GetName() == "Isaac" then
			Stats = Variables.Isaac.Stats -- Initialises stats variable
			Points = Variables.Isaac.Points -- Initialises points variable
			CritChance = Variables.Isaac.CritChance -- Initialises crit chance variable
			CritDamage = Variables.Isaac.CritDamage -- Initialises crit damage variable
		elseif player:GetName() == "Magdalene" then
			Stats = Variables.Magdalene.Stats -- Initialises stats variable
			Points = Variables.Magdalene.Points -- Initialises points variable
			CritChance = Variables.Magdalene.CritChance -- Initialises crit chance variable
			CritDamage = Variables.Magdalene.CritDamage -- Initialises crit damage variable
		elseif player:GetName() == "Cain" then
			Stats = Variables.Cain.Stats -- Initialises stats variable
			Points = Variables.Cain.Points -- Initialises points variable
			CritChance = Variables.Cain.CritChance -- Initialises crit chance variable
			CritDamage = Variables.Cain.CritDamage -- Initialises crit damage variable
		elseif player:GetName() == "Judas" then
			Stats = Variables.Judas.Stats -- Initialises stats variable
			Points = Variables.Judas.Points -- Initialises points variable
			CritChance = Variables.Judas.CritChance -- Initialises crit chance variable
			CritDamage = Variables.Judas.CritDamage -- Initialises crit damage variable
		elseif player:GetName() == "Eve" then
			Stats = Variables.Eve.Stats -- Initialises stats variable
			Points = Variables.Eve.Points -- Initialises points variable
			CritChance = Variables.Eve.CritChance -- Initialises crit chance variable
			CritDamage = Variables.Eve.CritDamage -- Initialises crit damage variable
		elseif player:GetName() == "Samson" then
			Stats = Variables.Samson.Stats -- Initialises stats variable
			Points = Variables.Samson.Points -- Initialises points variable
			CritChance = Variables.Samson.CritChance -- Initialises crit chance variable
			CritDamage = Variables.Samson.CritDamage -- Initialises crit damage variable
		elseif player:GetName() == "Azazel" then
			Stats = Variables.Azazel.Stats -- Initialises stats variable
			Points = Variables.Azazel.Points -- Initialises points variable
			CritChance = Variables.Azazel.CritChance -- Initialises crit chance variable
			CritDamage = Variables.Azazel.CritDamage -- Initialises crit damage variable
		elseif player:GetName() == "Lazarus" then
			Stats = Variables.Lazarus.Stats -- Initialises stats variable
			Points = Variables.Lazarus.Points -- Initialises points variable
			CritChance = Variables.Lazarus.CritChance -- Initialises crit chance variable
			CritDamage = Variables.Lazarus.CritDamage -- Initialises crit damage variable
		elseif player:GetName() == "Eden" then
			Stats = Variables.Eden.Stats -- Initialises stats variable
			Points = Variables.Eden.Points -- Initialises points variable
			CritChance = Variables.Eden.CritChance -- Initialises crit chance variable
			CritDamage = Variables.Eden.CritDamage -- Initialises crit damage variable
		elseif player:GetName() == "Lilith" then
			Stats = Variables.Lilith.Stats -- Initialises stats variable
			Points = Variables.Lilith.Points -- Initialises points variable
			CritChance = Variables.Lilith.CritChance -- Initialises crit chance variable
			CritDamage = Variables.Lilith.CritDamage -- Initialises crit damage variable
		elseif player:GetName() == "Apollyon" then
			Stats = Variables.Apollyon.Stats -- Initialises stats variable
			Points = Variables.Apollyon.Points -- Initialises points variable
			CritChance = Variables.Apollyon.CritChance -- Initialises crit chance variable
			CritDamage = Variables.Apollyon.CritDamage -- Initialises crit damage variable
		elseif player:GetName() == "???" then
			Stats = Variables.BB.Stats -- Initialises stats variable
			Points = Variables.BB.Points -- Initialises points variable
			CritChance = Variables.BB.CritChance -- Initialises crit chance variable
			CritDamage = Variables.BB.CritDamage -- Initialises crit damage variable
		elseif player:GetName() == "The Lost" then
			Stats = Variables.TheLost.Stats -- Initialises stats variable
			Points = Variables.TheLost.Points -- Initialises points variable
			CritChance = Variables.TheLost.CritChance -- Initialises crit chance variable
			CritDamage = Variables.TheLost.CritDamage -- Initialises crit damage variable
		elseif player:GetName() == "The Keeper" then
			Stats = Variables.TheKeeper.Stats -- Initialises stats variable
			Points = Variables.TheKeeper.Points -- Initialises points variable
			CritChance = Variables.TheKeeper.CritChance -- Initialises crit chance variable
			CritDamage = Variables.TheKeeper.CritDamage -- Initialises crit damage variable
		end
		-- Set stats according to mod stats --
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE) -- Add damage cache flag for evaluation
		player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY) -- Add fire delay cache flag for evaluation
		player:AddCacheFlags(CacheFlag.CACHE_LUCK) -- Add luck cache flag for evaluation
		player:EvaluateItems() -- Evaluate cache
		-- Stat setting end --
	end
	
	function StatScript:onPefUpdate(player)
		local pData = player:GetData()
		local BlackHearts = BitmapConverter.BitmapConvert(player:GetBlackHearts())
		
		if game:GetFrameCount() == 0 then
			Stats.ExtraHealth = 0 -- Set extra health to 0
		end
		
		if game:GetFrameCount() == 1 then -- If game just started
			-- Ensures player cannot die from heart damage --
			Stats.Health = Stats.MaxHealth -- Set health to max health
			if player:GetName() ~= "???" then
				Stats.ExtraHealth = Stats.ExtraHealth + (player:GetSoulHearts() * 5) -- Set extra health
			else
				Stats.ExtraHealth = (round(Stats.Vitality * 2) + Stats.ExtraHealth) -- Set ??? extra health
			end
			Stats.HealthDif = 0 -- Set health difference to 0
			-- Set stats according to mod stats --
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE) -- Add damage cache flag for evaluation
			player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY) -- Add fire delay flag for evaluation
			player:AddCacheFlags(CacheFlag.CACHE_LUCK) -- Add luck flag for evaluation
			player:EvaluateItems() -- Evaluate cache
			-- Stat setting end --
		end
		
		-- Set stats according to mod stats --
		if player:GetName() ~= "???" and player:GetName() ~= "The Lost" then -- ??? and The Lost never have red heart health
			Stats.MaxHealth = (round(Stats.Vitality * 2) + Stats.HealthDif)
		else
			Stats.MaxHealth = 0
		end
		CritChance.Crit = round((Stats.Dexterity / 150), 2)
		CritChance.OVERCRIT = round((CritChance.Crit / 10), 2)
		CritChance.DOUBLE_OVERCRIT = round((CritChance.Crit / 100), 2)
		-- Stat setting end --
		
		if game:GetFrameCount() > 2 then
				-- Health overhaul --
			if player:GetMaxHearts() ~= 14 then -- If max hearts not equal to 7
				if game:GetFrameCount() == 3 then
					player:AddMaxHearts(14 - player:GetMaxHearts()) -- Set max hearts to 7 hearts
				else
					Stats.HealthDif = Stats.HealthDif - ((14 - player:GetMaxHearts()) * 5) -- Change health by heart difference (via health difference stat)
					Stats.MaxHealth = (round(Stats.Vitality * 2) + Stats.HealthDif) -- Ensures max health is set before health is healed (so health failsafe is not triggered)
					if player:GetMaxHearts() > 14 then -- Only heal health if it went up
						Stats.Health = Stats.Health - ((14 - player:GetMaxHearts()) * 5) -- Heals health by health gained
					end
					player:AddMaxHearts(14 - player:GetMaxHearts()) -- Set max hearts to 7 hearts
				end
			end
			if player:GetSoulHearts() ~= 0 and Stats.ExtraHealth == 0 then -- If player has soul hearts or black hearts and player has no extra health
				player:AddBlackHearts(-BlackHearts) -- Remove black hearts
				player:AddSoulHearts(-(player:GetSoulHearts())) -- Remove soul hearts
			elseif player:GetSoulHearts() ~= 2 and Stats.ExtraHealth ~= 0 then -- If player soul hearts not 1 soul heart and player has extra health
				player:AddBlackHearts(-BlackHearts) -- Remove black hearts
				player:AddSoulHearts(2 - player:GetSoulHearts()) -- Set soul hearts to 1
			end
			if player:GetHearts() ~= 3 and Stats.Health ~= Stats.MaxHealth then -- If player hearts not 1.5 hearts and player health not max health
				if pData.FromFull ~= false then -- If dropping to 1.5 hearts because health dropping from full or because of game restart (don't want health change from that)
					pData.FromFull = false -- Set FromFull data to false
				elseif pData.FromFull == false and player:GetHearts() > 3 then -- If regaining health (not dropping from full health)
					if player:GetHearts() == player:GetMaxHearts() then
						Stats.Health = Stats.MaxHealth
					else
						Stats.Health = Stats.Health - ((3 - player:GetHearts()) * 5) -- Heal the player
					end
				end
				player:AddHearts(3 - player:GetHearts()) -- Set player hearts to 1.5
			elseif player:GetHearts() ~= player:GetMaxHearts() and Stats.Health == Stats.MaxHealth then -- If player health is max health
				if pData.FromFull ~= true then -- If health regained to full
					pData.FromFull = true -- Set FromFull data to true
				end
				player:SetFullHearts() -- Sets player hearts to full hearts
			end
			
			if player:GetName() ~= "The Lost" then -- The Lost always has 0 health, so death handled by on damage
				if Stats.Health <= 0 and Stats.ExtraHealth <= 0 then -- If health is <= 0
					Stats.Health = 0 -- Set health to 0
					player:AddHearts(-24) -- Remove all player hearts
					if player:GetExtraLives() > 0 then -- If player has extra lives
						player:Revive() -- Revive player
						Stats.Health = Stats.MaxHealth -- Set health to maximum health
					else
						player:Die() -- PLayer dies
					end
				end
			end
			if Stats.Health > Stats.MaxHealth then -- If health stat is greater than maximum health (should never happen, but just in case)
				Stats.Health = Stats.MaxHealth -- Set health to maximum health
			end
		
			for _, entity in pairs(Isaac.GetRoomEntities()) do -- Loop over all room entities
				if player:GetName() ~= "The Lost" then -- No picking up hearts for The Lost
					if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_HEART and entity:GetData().Picked == nil and entity:GetSprite():IsPlaying("Collect") then -- If not collected heart pickup and is playing collect animation
						entity:GetData().Picked = true -- Sets entity has been picked up
						if entity.SubType == HeartSubType.HEART_HALF_SOUL then -- If entity is half soul heart
							Stats.ExtraHealth = Stats.ExtraHealth + 5 -- Give player 5 extra health
						elseif entity.SubType == HeartSubType.HEART_SOUL then -- If entity is soul heart
							Stats.ExtraHealth = Stats.ExtraHealth + 10 -- Give player 10 extra health
						elseif entity.SubType == HeartSubType.HEART_BLENDED then -- If entity is blended heart
							if Stats.Health + 5 <= Stats.MaxHealth then -- If player can only heal for 5 health
								Stats.ExtraHealth = Stats.ExtraHealth + 5 -- Give player 5 extra health
							else
								Stats.ExtraHealth = Stats.ExtraHealth + 10 -- Give player 10 extra health
							end
						elseif entity.SubType == HeartSubType.HEART_BLACK then -- If entity is black heart
							Stats.ExtraHealth = Stats.ExtraHealth + 20 -- Give player 20 extra health
						elseif entity.SubType == HeartSubType.HEART_ETERNAL then -- If entity is eternal heart
							if Stats.EternalArmor == false and Stats.GoldenArmor == false then -- If player doesn't have health armour
								Stats.EternalArmor = true -- Give player eternal heart health armour
							end
						elseif entity.SubType == HeartSubType.HEART_GOLDEN then -- If entity is golden heart
							if Stats.EternalArmor == false and Stats.GoldenArmor == false then -- If player doesn't have health armour
								Stats.GoldenArmor = true -- Give player golden heart health armour
							end
						end
					end
				end
			end
		end
		
		if game:GetFrameCount() == 2 then -- If game has been running for 2 frames (so stats can be initialised first)
			if player:GetMaxHearts() ~= 6 then -- If max hearts not equal to 3
				Stats.HealthDif = Stats.HealthDif - ((6 - player:GetMaxHearts()) * 5) -- Change health by heart difference (via health difference stat)
				Stats.MaxHealth = (round(Stats.Vitality * 2) + Stats.HealthDif) -- Ensures max health is set before health is healed (so health failsafe is not triggered)
				if player:GetMaxHearts() > 6 then -- Only heal health if it went up
					Stats.Health = Stats.Health - ((6 - player:GetMaxHearts()) * 5) -- Heals health by health gained
				end
			end
			if player:GetSoulHearts() ~= 0 and Stats.ExtraHealth == 0 then -- If player has soul hearts or black hearts and player has no extra health
				player:AddBlackHearts(-BlackHearts) -- Remove black hearts
				player:AddSoulHearts(-(player:GetSoulHearts())) -- Remove soul hearts
			elseif player:GetSoulHearts() ~= 2 and Stats.ExtraHealth ~= 0 then -- If player soul hearts not 1 soul heart and player has extra health
				player:AddBlackHearts(-BlackHearts) -- Remove black hearts
				player:AddSoulHearts(2 - player:GetSoulHearts()) -- Set soul hearts to 1
			end
			if player:GetHearts() ~= player:GetMaxHearts() and Stats.Health == Stats.MaxHealth then -- If player health is max health
				if pData.FromFull ~= true then -- If health regained to full
					pData.FromFull = true -- Set FromFull data to true
				end
				player:SetFullHearts() -- Sets player hearts to full hearts
			end
			-- Health overhaul end --
		end
	end
	
	function StatScript:onPlayerDamage(_, damage, _, source)
		-- Player health damage --
		local player = Isaac.GetPlayer(0) -- Gets player
		if player:GetName() == "The Lost" then
			if player:GetExtraLives() > 0 then -- If player has extra lives
				player:Revive() -- Revive player
				Stats.Health = Stats.MaxHealth -- Set health to maximum health
			else
				player:Die() -- Player dies
			end
		end
		if source.Entity:IsBoss() then -- If damage source was a boss
			if Stats.GoldenArmor ~= true and Stats.EternalArmor ~= true then -- If player does not have health armour
				if Stats.ExtraHealth > 0 then -- If player has extra health (soul heart equivalent)
					if Stats.ExtraHealth - ((damage + (damage * ((Stats.Level - 1) * 0.2))) * 5) >= 0 then -- If player can take the damage from extra health without losing it all
						Stats.ExtraHealth = Stats.ExtraHealth - ((damage + (damage * ((Stats.Level - 1) * 0.2))) * 5) -- Take the damage from extra health (boss damage increases by 1 per level)
					else
						Stats.ExtraHealth = 0 -- Set extra health to 0
					end
				else
					Stats.Health = Stats.Health - ((damage + (damage * ((Stats.Level - 1) * 0.2))) * 5) -- Take the damage from health (boss damage increases by 1 per level)
				end
			else
				Stats.GoldenArmor = false -- Set golden heart health armour to false
				Stats.EternalArmor = false -- Set eternal heart health armour to false
			end
		else
			if Stats.GoldenArmor ~= true and Stats.EternalArmor ~= true then -- If player does not have health armour
				if Stats.ExtraHealth > 0 then -- If player has extra health (soul heart equivalent)
					if Stats.ExtraHealth - (damage * 5) >= 0 then -- If player can take the damage from extra health without losing it all
						Stats.ExtraHealth = Stats.ExtraHealth - (damage * 5) -- Take the damage from extra health
					else
						Stats.ExtraHealth = 0 -- Set extra health to 0
					end
				else
					Stats.Health = Stats.Health - (damage * 5) -- Take the damage from health
				end
			else
				Stats.GoldenArmor = false -- Set golden heart health armour to false
				Stats.EternalArmor = false -- Set eternal heart health armour to false
			end
		end
	end
	
	function StatScript:onEnemySpawn(entity)
		--Increase boss health based on player level --
		if entity:IsBoss() then
			entity.MaxHitPoints = entity.MaxHitPoints + (entity.MaxHitPoints * ((Stats.Level-1) * 0.05)) -- Increases maximum hit points of spawned entity
			entity.HitPoints = entity.MaxHitPoints -- Heals entity to maximum hit points (so that entity starts on max health)
		end
	end
	
	function StatScript:onEval(CurseFlags)
		return CurseFlags | 1 << 3 -- Gives curse of the unknown on top of other curses (don't need to see num. hearts, numerical health system)
	end
Mod:AddCallback(ModCallbacks.MC_POST_RENDER, StatScript.onRender)
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, StatScript.onCache)
Mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, StatScript.onPlayerInit)
Mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, StatScript.onPefUpdate)
Mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, StatScript.onPlayerDamage, EntityType.ENTITY_PLAYER)
Mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, StatScript.onEnemySpawn)
Mod:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, StatScript.onEval)
Mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, StatScript.onGameExit)

---------------------
--   Script for    --
--    Stat Menu    --
---------------------
local MenuScript = {}
	-- Variables --
	local sfont = nil
	local invUI = nil
	local pageUI = 1
	local buttonpressed = false
	local buttontimer = 15
	local actionbutton = 0
	local phase = 10
	local selectedline = 1
	
	local invPosition = Vector(170,64)
	
	-- Colours --
	local c_gray = Color(0.5,0.5,0.5,1,0,0,0)
	local c_white = Color(1,1,1,1,0,0,0)
	local c_yellow = Color(1,1,0,1,0,0,0)
	local c_paper = Color(0.6,0.52,0.46,1,0,0,0)
	
	function MenuScript:WriteText(text, px, py, align, col)
		local fontw = 6
		local ch

		if sfont == nil then -- If sfont not defined
			sfont = Sprite() -- sfont set to be Sprite()
			sfont:Load("/gfx/ui/Fonts.anm2",true) -- sfont loads fonts animation
			sfont:Play("Idle") -- sfont plays idle animation
		end

		if align == 1 then -- Align 1 = align centre
			px = px - ((string.len(text) * fontw) / 2) + (fontw/2) -- Aligns text central
		elseif align == 2 then -- Align 2 = alight right
			px = px - (string.len(text) * fontw) -- Aligns text right
		end

		sfont.Color = col -- Sets colour of the font

		for i=1, string.len(text) do -- Loop over letters in the text
			ch = string.byte(text,i) - 32 -- Converts each letter in message into a character
			sfont:SetLayerFrame(0,ch) -- Sets the frame of the sfont to that in the position of the character number
			sfont:Render(Vector(px + ((i-1)*fontw), py), Vector(0,0), Vector(0,0)) -- Renders the letter
		end
	end
	
	function MenuScript:DrawMenu(player)
		local drawline = 0 -- Line position
		local rowA = 0 -- First row position
		local rowB = 135 -- Second row position

		if invUI == nil then -- If invUI not defined
			invUI = Sprite() -- invUI set to be Sprite()
			invUI:Load("/gfx/ui/MenuUI.anm2",true) -- invUI loads menu animation
		end
		
		if pageUI == 1 then
			invUI:Play("Swap1") -- invUI plays swap paper animation (static)
			invUI:Render(invPosition, Vector(0,0), Vector(0,0)) -- invUI renders at invPosition
			
			MenuScript:WriteText("STAT MENU", invPosition.X-15, invPosition.Y-15, 0, c_paper) -- Write text "STAT MENU" at top left corner of menu
			MenuScript:WriteText(player:GetName(), invPosition.X+150, invPosition.Y-15, 2, c_paper) -- Write player name at top right corner of menu
			MenuScript:WriteText("STAT POINTS: "..Points.Points_Stat, invPosition.X+130, invPosition.Y+75, 2, c_paper)

			rowA = invPosition.X-5 -- Sets first row position
			rowB = rowA + rowB -- Sets second row position
			drawline = invPosition.Y -- Sets draw position of first line
			
			MenuScript:WriteText("Health", rowA, drawline, 0, c_paper) -- Writes text "Health" in row A
			MenuScript:WriteText(string.format("%.2f",Stats.MaxHealth), rowB, drawline, 2, c_white) -- Writes maximum health in row B
			drawline = drawline + 12 -- Sets draw position of next line
			MenuScript:WriteText("Damage", rowA, drawline, 0, c_paper) -- Writes text "Damage" in row A
			MenuScript:WriteText(string.format("%.2f",player.Damage), rowB, drawline, 2, c_white) -- Writes player damage in row B
			drawline = drawline + 12 -- Sets draw position of next line
			MenuScript:WriteText("Fire rate", rowA, drawline, 0, c_paper) -- Writes text "Fire Rate" in row A
			MenuScript:WriteText(string.format("%.2f",30/player.MaxFireDelay).." /s", rowB, drawline, 2, c_white) -- Writes player tears per second in row B
			drawline = drawline + 12 -- Sets draw position of next line
			MenuScript:WriteText("Crit. Chance", rowA, drawline, 0, c_paper) -- Writes text "Crit. Chance" in row A
			MenuScript:WriteText(string.format("%.2f",(CritChance.Crit*100)).."%", rowB, drawline, 2, c_white) -- Writes player crit chance (in %) in row B
			drawline = drawline + 12 -- Sets draw position of next line
			MenuScript:WriteText("Crit. Damage", rowA, drawline, 0, c_paper) -- Writes text "Crit. Damage" in row A
			MenuScript:WriteText(string.format("%.2f",CritDamage.CRIT).."x", rowB, drawline, 2, c_white) -- Writes player crit damage in row B
			drawline = drawline + 12 -- Sets draw position of next line
			MenuScript:WriteText("Luck", rowA, drawline, 0, c_paper) -- Writes text "Luck" in row A
			MenuScript:WriteText(string.format("%.0f",player.Luck), rowB, drawline, 2, c_white) -- Writes player luck in row B
			
			local cline -- Creates line colour variable (to change in certain circumstances) for row A
			local cline2 -- Creates line colour variable (to change in certain circumstances) for row B
			
			drawline = drawline + 24 -- Sets draw position of next line
			if (selectedline == 1) then cline = c_white cline2 = c_yellow else cline = c_paper cline2 = c_gray end -- Changes colour of line 1 depending on if it is selected
			MenuScript:WriteText("STR", rowA, drawline, 0, cline) -- Write text "STR" in row A
			drawline = drawline + 10 -- Sets draw position of next line
			if Points.Points_Stat > 0 then -- If stat points available to spend
				if Stats.Strength > 15 then -- If Strength stat higher than the default
					MenuScript:WriteText("< "..Stats.Strength.." >", rowB, drawline, 2, cline2) -- Writes strength stat with "< >" around it in row B
				else
					MenuScript:WriteText("> "..Stats.Strength.." >", rowB, drawline, 2, cline2) -- Writes strength stat with "> >" around it in row B
				end
			else
				if Stats.Strength > 15 then -- If Strength stat higher than the default
					MenuScript:WriteText("< "..Stats.Strength.." <", rowB, drawline, 2, cline2) -- Writes strength stat with "< <" around it in row B
				else
					MenuScript:WriteText("> "..Stats.Strength.." <", rowB, drawline, 2, cline2) -- Writes strength stat with "> <" around it in row B
				end
			end
			drawline = drawline + 12 -- Sets draw position of next line
			if (selectedline == 2) then cline = c_white cline2 = c_yellow else cline = c_paper cline2 = c_gray end -- Changes colour of line 2 depending on if it is selected
			MenuScript:WriteText("DEX", rowA, drawline, 0, cline) -- Writes text "DEX" in row A
			drawline = drawline + 10 -- Sets draw position of next line
			if Points.Points_Stat > 0 then -- If stat points available to spend
				if Stats.Dexterity > 15 then -- If Dexterity stat higher than the default
					MenuScript:WriteText("< "..Stats.Dexterity.." >", rowB, drawline, 2, cline2) -- Writes dexterity stat with "< >" around it in row B
				else
					MenuScript:WriteText("> "..Stats.Dexterity.." >", rowB, drawline, 2, cline2) -- Writes dexterity stat with "> >" around it in row B
				end
			else
				if Stats.Dexterity > 15 then -- If Dexterity stat higher than the default
					MenuScript:WriteText("< "..Stats.Dexterity.." <", rowB, drawline, 2, cline2) -- Writes dexterity stat with "< <" around it in row B
				else
					MenuScript:WriteText("> "..Stats.Dexterity.." <", rowB, drawline, 2, cline2) -- Writes dexterity stat with "> <" around it in row B
				end
			end
			drawline = drawline + 12 -- Sets draw position of next line
			if (selectedline == 3) then cline = c_white cline2 = c_yellow else cline = c_paper cline2 = c_gray end -- Changes colour of line 3 depending on if it is selected
			MenuScript:WriteText("VIT", rowA, drawline, 0, cline) -- Write text "VIT" in row A
			drawline = drawline + 10 -- Sets draw position of next line
			if Points.Points_Stat > 0 then -- If stat points available to spend
				if Stats.Vitality > 15 then -- If Vitality stat higher than the default
					MenuScript:WriteText("< "..Stats.Vitality.." >", rowB, drawline, 2, cline2) -- Writes vitality stat with "< >" around it in row B
				else
					MenuScript:WriteText("> "..Stats.Vitality.." >", rowB, drawline, 2, cline2) -- Writes vitality stat with "< >" around it in row B
				end
			else
				if Stats.Vitality > 15 then -- If Vitality stat higher than the default
					MenuScript:WriteText("< "..Stats.Vitality.." <", rowB, drawline, 2, cline2) -- Writes vitality stat with "< <" around it in row B
				else
					MenuScript:WriteText("> "..Stats.Vitality.." <", rowB, drawline, 2, cline2) -- Writes vitality stat with "> <" around it in row B
				end
			end
			drawline = drawline + 12 -- Sets draw position of next line
			if (selectedline == 4) then cline = c_white cline2 = c_yellow else cline = c_paper cline2 = c_gray end -- Changes colour of line 4 depending on if it is selected
			MenuScript:WriteText("LCK", rowA, drawline, 0, cline) -- Write text "LCK" in row A
			drawline = drawline + 10 -- Sets draw position of next line
			if Points.Points_Stat > 0 then -- If stat points available to spend
				if Stats.Luck > 0 then -- If Luck stat higher than the default
					MenuScript:WriteText("< "..Stats.Luck.." >", rowB, drawline, 2, cline2) -- Writes luck stat with "< >" around it in row B
				else
					MenuScript:WriteText("> "..Stats.Luck.." >", rowB, drawline, 2, cline2) -- Writes luck stat with "> >" around it in row B
				end
			else
				if Stats.Luck > 0 then -- If Luck stat higher than the default
					MenuScript:WriteText("< "..Stats.Luck.." <", rowB, drawline, 2, cline2) -- Writes luck stat with "< <" around it in row B
				else
					MenuScript:WriteText("> "..Stats.Luck.." <", rowB, drawline, 2, cline2) -- Writes luck stat with "> <" around it in row B
				end
			end
			drawline = drawline + 12 -- Sets draw position of next line
			if (selectedline == 5) then cline = c_white cline2 = c_yellow else cline = c_paper cline2 = c_gray end -- Changes colour of line 5 depending on if it is selected
			MenuScript:WriteText("REBIRTH?", rowA, drawline, 0, cline) -- Writes text "REBIRTH?" in row A
			drawline = drawline + 10 -- Sets draw position of next line
			if Stats.Level == 100 and Stats.Experience == Stats.MaxExperience then -- If max level and max exp
				MenuScript:WriteText("DO IT", rowB, drawline, 2, cline2) -- Writes text "DO IT" in row B
			else
				MenuScript:WriteText("NEED MORE EXP", rowB, drawline, 2, c_gray) -- Writes text "NEED MORE EXP" in row B (gray colour)
			end
		end
	end
	
	function MenuScript:UIRender()
		local player = Isaac.GetPlayer(0) -- Get player

		if phase == 0 then -- If current phase is 0
			MenuScript:DrawMenu(player) -- Draw the menu
		end
	end
	
	function MenuScript:UPDATEui()
		local player = Isaac.GetPlayer(0) -- Get player

		if player.FrameCount == 3 then -- If player frame count is 3
			pageUI = 1 -- Set current page to 1
			selectedline = 1 -- Set selected line to 1
		elseif Input.IsButtonPressed(Keyboard.KEY_T, 0) then -- If pressed key T
			if buttonpressed == false then -- If button pressed is false
				if phase == 10 then -- If phase is 10
					phase = 0 -- Set phase to 0
					player.ControlsEnabled = false -- Disable player controls
				else
					phase = 10 -- Set phase to 10
					player.ControlsEnabled = true -- Enable player controls
				end
				buttonpressed = true -- Set button pressed to true
			end
		elseif Input.IsActionPressed(ButtonAction.ACTION_DOWN,player.ControllerIndex) and phase ~= 10 then -- If in menu and move down (S key) is pressed
			if buttonpressed == false then -- If button pressed is false
				if pageUI == 1 then -- If current page is 2
					selectedline = math.min(selectedline + 1, 5) -- Set selected line to next line (up to 5)
				end
				buttonpressed = true -- Set button pressed to true
			end
		elseif Input.IsActionPressed(ButtonAction.ACTION_UP,player.ControllerIndex) and (phase ~= 10) then -- If in menu and move up (W key) is pressed
			if buttonpressed == false then -- If button pressed is false
				if pageUI == 1 then -- If current page is 2
					selectedline = math.max(selectedline - 1, 1) -- Set selected line to previous line (up to 0)
				end
				buttonpressed = true -- Set button pressed to true
			end
		elseif Input.IsActionPressed(ButtonAction.ACTION_RIGHT,player.ControllerIndex) and (phase ~= 10) and (phase ~= 6) then -- If in menu and move right (D key) is pressed
			if (buttonpressed == false) then -- If button pressed is false
				if pageUI == 1 then -- If current page is 2
					if selectedline == 1 then -- If selected line is 1
						if Points.Points_Stat > 0 then -- If stat points available to spend
							Stats.Strength = Stats.Strength + 1 -- Increase strength by 1
							Points.Points_Stat = Points.Points_Stat - 1 -- Decrease stat points by 1
							player:AddCacheFlags(CacheFlag.CACHE_DAMAGE) -- Add damage cache flag for evaluation
							player:EvaluateItems() -- Evaluate cache
						end
					elseif selectedline == 2 then -- If selected line is 2
						if Points.Points_Stat > 0 then -- If stat points available to spend
							Stats.Dexterity = Stats.Dexterity + 1 -- Increase dexterity by 1
							Points.Points_Stat = Points.Points_Stat - 1 -- Decrease stat points by 1
							player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY) -- Add fire delay flag for evaluation
							player:EvaluateItems() -- Evaluate cache
						end
					elseif selectedline == 3 then -- If selected line is 3
						if Points.Points_Stat > 0 then -- If stat points available to spend
							Stats.Vitality = Stats.Vitality + 1 -- Increase vitality by 1
							Points.Points_Stat = Points.Points_Stat - 1 -- Decrease stat points by 1
							Stats.Health = Stats.Health + 2 -- Increase Health by amount of health gained
						end
					elseif selectedline == 4 then -- If selected line is 4
						if Points.Points_Stat > 0 then -- If stat points available to spend
							Stats.Luck = Stats.Luck + 1 -- Increase luck by 1
							Points.Points_Stat = Points.Points_Stat - 1 -- Decrease stat points by 1
							player:AddCacheFlags(CacheFlag.CACHE_LUCK) -- Add luck flag for evaluation
							player:EvaluateItems() -- Evaluate cache
						end
					end
				end
				buttonpressed = true -- Set button pressed to true
			end
		elseif Input.IsActionPressed(ButtonAction.ACTION_LEFT,player.ControllerIndex) and (phase ~= 10) and (phase ~= 6) then -- If in menu and move left (A key) is pressed
			if buttonpressed == false then -- If button pressed is false
				if pageUI == 1 then -- If current page is 2
					if selectedline == 1 then -- If selected line is 1
						if Stats.Strength > 15 then -- If strength stat is more than base strength
							Stats.Strength = Stats.Strength - 1 -- Decrease strength by 1
							Points.Points_Stat = Points.Points_Stat + 1 -- Set stat points to stat points + 1
							player:AddCacheFlags(CacheFlag.CACHE_DAMAGE) -- Add damage cache flag for evaluation
							player:EvaluateItems() -- Evaluate cache
						end
					elseif selectedline == 2 then -- If selected line is 2
						if Stats.Dexterity > 15 then -- If dexterity stat is more than base dexterity
							Stats.Dexterity = Stats.Dexterity - 1 -- Decrease dexterity by 1
							Points.Points_Stat = Points.Points_Stat + 1 -- Set stat points to stat points + 1
							player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY) -- Add fire delay flag for evaluation
							player:EvaluateItems() -- Evaluate cache
						end
					elseif selectedline == 3 then -- If selected line is 3
						if Stats.Vitality > 15 then -- If vitality stat is more than base vitality
							Stats.Vitality = Stats.Vitality - 1 -- Decrease vitality by 1
							Points.Points_Stat = Points.Points_Stat + 1 -- Set stat points to stat points + 1
							Stats.Health = Stats.Health - 2 -- Decrease Health by amount of health lost
						end
					elseif selectedline == 4 then -- If selected line is 4
						if Stats.Luck > 0 then -- If luck stat is more than base luck
							Stats.Luck = Stats.Luck - 1 -- Decrease luck by 1
							Points.Points_Stat = Points.Points_Stat + 1 -- Set stat points to stat points + 1
							player:AddCacheFlags(CacheFlag.CACHE_LUCK) -- Add luck flag for evaluation
							player:EvaluateItems() -- Evaluate cache
						end
					end
				end
				buttonpressed = true -- Set button pressed to true
			end
		elseif Input.IsActionPressed(ButtonAction.ACTION_BOMB, player.ControllerIndex) and (phase ~= 10) and (phase ~= 6) then -- If in menu and bomb (E key) is pressed
			if pageUI == 1 then -- If current page is 2
				if selectedline == 5 then -- If selected line is 5
					if Stats.Level == 100 and Stats.Experience == Stats.MaxExperience then -- If max level and max exp
						LevelScript:Rebirth(player) -- Run Rebirth function
					end
				end
			end
		else
			buttonpressed = false -- Set button pressed to false
			buttontimer = 15 -- Set button timer to 15
			actionbutton = 0 -- Set action button to 0
		end
	end
Mod:AddCallback(ModCallbacks.MC_POST_UPDATE, MenuScript.UPDATEui)
Mod:AddCallback(ModCallbacks.MC_POST_RENDER, MenuScript.UIRender)

---------------------
--   Script for    --
-- Critical System --
---------------------
local CriticalScript = {}
	local CritId = Isaac.GetItemIdByName("Crit")
	
	function CriticalScript:onDamage(entity, damage, _, source)
		local player = Isaac.GetPlayer(0) -- Gets the player
		if entity:IsVulnerableEnemy() and (source.Type == EntityType.ENTITY_TEAR or source.Type == EntityType.ENTITY_LASER or source.Type == EntityType.ENTITY_KNIFE or source.Type == EntityType.ENTITY_EFFECT) then -- Only crit with player projectiles or lasers
			local rng = player:GetCollectibleRNG(CritId) -- Creates RNG using the Crit item (never implemented, also does not need to be given to player in order to use
			if rng:RandomFloat() < CritChance.CRIT then -- If RNG value is lower than the crit chance (crit chance is maximum value to roll from 0)
				if rng:RandomFloat() < CritChance.OVERCRIT then -- If RNG value is lower than the overcrit change
					if rng:RandomFloat() < CritChance.DOUBLE_OVERCRIT then -- If RNG value is lower than double overcrit chance
						entity:TakeDamage(damage * (CritDamage.DOUBLE_OVERCRIT - 1), 0, EntityRef(player), 0) -- If get double overcrit, entity takes double overcrit damage
						sfxManager:Play(SoundEffect.SOUND_DIMEPICKUP, 1.0, 0, false, 1.0) -- If get double overcrit, dime pickup sound plays
					else
						entity:TakeDamage(damage * (CritDamage.OVERCRIT - 1), 0, EntityRef(player), 0) -- If get overcrit, entity takes overcrit damage
						sfxManager:Play(SoundEffect.SOUND_NICKELPICKUP, 1.0, 0, false, 1.0) -- If get overcrit, nickel pickup sound plays
					end
				else
					entity:TakeDamage(damage * (CritDamage.CRIT - 1), 0, EntityRef(player), 0) -- If get crit, entity takes crit damage
					sfxManager:Play(SoundEffect.SOUND_PENNYPICKUP, 1.0, 0, false, 1.0) -- If get crit, penny pickup sound plays
				end
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 0, source.Position, Vector(0,0), player) -- Spawn critical visual effect
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 0, source.Position, Vector(0,0), player) -- Spawn critical visual effect
			end
		end
	end
Mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, CriticalScript.onDamage)