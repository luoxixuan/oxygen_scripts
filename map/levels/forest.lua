require("map/level")


----------------------------------
-- Survival levels
----------------------------------

local survival_together = {
		id = "SURVIVAL_TOGETHER",
		name = STRINGS.UI.CUSTOMIZATIONSCREEN.PRESETLEVELS.SURVIVAL_TOGETHER,
		desc = STRINGS.UI.CUSTOMIZATIONSCREEN.PRESETLEVELDESC.SURVIVAL_TOGETHER,
        location = "forest",
        version = 3,
		overrides = {
		},		
		ordered_story_setpieces = {
			"Sculptures_1",
			"Maxwell5",
		},
		numrandom_set_pieces = 4,
		random_set_pieces = 
		{
			"Sculptures_2",
			"Sculptures_3",
			"Sculptures_4",
			"Sculptures_5",
			"Chessy_1",
			"Chessy_2",
			"Chessy_3",
			"Chessy_4",
			"Chessy_5",
			"Chessy_6",
			--"ChessSpot1",
			--"ChessSpot2",
			--"ChessSpot3",
			"Maxwell1",
			"Maxwell2",
			"Maxwell3",
			"Maxwell4",
			"Maxwell6",
			"Maxwell7",
			"Warzone_1",
			"Warzone_2",
			"Warzone_3",
		},
	}
if IsConsole() then
	survival_together.name = STRINGS.UI.CUSTOMIZATIONSCREEN.PRESETLEVELS.SURVIVAL_TOGETHER_PS4
end
AddLevel(LEVELTYPE.SURVIVAL, survival_together)

-- if a mod preset vanishes (i.e. the mod isn't running), just use the default preset instead.
local mod_missing = deepcopy(survival_together)
mod_missing.id = "MOD_MISSING"
mod_missing.name = STRINGS.UI.CUSTOMIZATIONSCREEN.PRESETLEVELS.MOD_MISSING
mod_missing.desc = STRINGS.UI.CUSTOMIZATIONSCREEN.PRESETLEVELDESC.MOD_MISSING
mod_missing.hideinfrontend = true
AddLevel(LEVELTYPE.SURVIVAL, mod_missing)

AddLevel(LEVELTYPE.SURVIVAL, { 
		id = "SURVIVAL_TOGETHER_CLASSIC",
		name = STRINGS.UI.CUSTOMIZATIONSCREEN.PRESETLEVELS.SURVIVAL_TOGETHER_CLASSIC,
		desc = STRINGS.UI.CUSTOMIZATIONSCREEN.PRESETLEVELDESC.SURVIVAL_TOGETHER_CLASSIC,
        location = "forest",
        version = 3,
        overrides = {
            task_set = "classic",
            spring = "noseason",
            summer = "noseason",
            frograin = "never",
            wildfires = "never",

            bearger = "never",
            goosemoose = "never",
            dragonfly = "never",
            deciduousmonster = "never",
            houndmound = "never",

            buzzard = "never",
            catcoon = "never",
            moles = "never",
            lightninggoat = "never",

            rock_ice = "never",

            cactus = "never",
        },
		ordered_story_setpieces = {
			"Sculptures_1",
			"Maxwell5",
		},
		numrandom_set_pieces = 4,
		random_set_pieces = 
		{
			"Sculptures_2",
			"Sculptures_3",
			"Sculptures_4",
			"Sculptures_5",
			"Chessy_1",
			"Chessy_2",
			"Chessy_3",
			"Chessy_4",
			"Chessy_5",
			"Chessy_6",
			--"ChessSpot1",
			--"ChessSpot2",
			--"ChessSpot3",
			"Maxwell1",
			"Maxwell2",
			"Maxwell3",
			"Maxwell4",
			"Maxwell6",
			"Maxwell7",
			"Warzone_1",
			"Warzone_2",
			"Warzone_3",
		},
	})


if IsConsole() then   -- boons and spiders at default values rather than "often"
AddLevel(LEVELTYPE.SURVIVAL, {
		id="SURVIVAL_DEFAULT_PLUS",
		name=STRINGS.UI.CUSTOMIZATIONSCREEN.PRESETLEVELS.SURVIVAL_DEFAULT_PLUS,
		desc= STRINGS.UI.CUSTOMIZATIONSCREEN.PRESETLEVELDESC.SURVIVAL_DEFAULT_PLUS,
        location = "forest",
        version = 3,
        overrides={
            start_location = "plus",

            berrybush = "rare",
            carrot = "rare",

            rabbits = "rare",
        },
		ordered_story_setpieces = {
			"Sculptures_1",
			"Maxwell5",
		},
		numrandom_set_pieces = 4,
		random_set_pieces = 
		{
			"Sculptures_2",
			"Sculptures_3",
			"Sculptures_3",
			"Sculptures_3",
			"Sculptures_4",
			"Chessy_1",
			"Chessy_2",
			"Chessy_3",
			"Chessy_4",
			"Chessy_5",
			"Chessy_6",
			--"ChessSpot1",
			--"ChessSpot2",
			--"ChessSpot3",
			"Maxwell1",
			"Maxwell2",
			"Maxwell3",
			"Maxwell4",
			"Maxwell6",
			"Maxwell7",
			"Warzone_1",
			"Warzone_2",
			"Warzone_3",
		},
	})
else
AddLevel(LEVELTYPE.SURVIVAL, {
		id="SURVIVAL_DEFAULT_PLUS",
		name=STRINGS.UI.CUSTOMIZATIONSCREEN.PRESETLEVELS.SURVIVAL_DEFAULT_PLUS,
		desc= STRINGS.UI.CUSTOMIZATIONSCREEN.PRESETLEVELDESC.SURVIVAL_DEFAULT_PLUS,
        location = "forest",
        version = 3,
        overrides={
            start_location = "plus",
            boons = "often",

            spiders = "often",

            berrybush = "rare",
            carrot = "rare",

            rabbits = "rare",
        },
		ordered_story_setpieces = {
			"Sculptures_1",
			"Maxwell5",
		},
		numrandom_set_pieces = 4,
		random_set_pieces = 
		{
			"Sculptures_2",
			"Sculptures_3",
			"Sculptures_4",
			"Sculptures_5",
			"Chessy_1",
			"Chessy_2",
			"Chessy_3",
			"Chessy_4",
			"Chessy_5",
			"Chessy_6",
			--"ChessSpot1",
			--"ChessSpot2",
			--"ChessSpot3",
			"Maxwell1",
			"Maxwell2",
			"Maxwell3",
			"Maxwell4",
			"Maxwell6",
			"Maxwell7",
			"Warzone_1",
			"Warzone_2",
			"Warzone_3",
		},
	})
end

AddLevel(LEVELTYPE.SURVIVAL, {
		id="COMPLETE_DARKNESS",
		name=STRINGS.UI.CUSTOMIZATIONSCREEN.PRESETLEVELS.COMPLETE_DARKNESS,
		desc= STRINGS.UI.CUSTOMIZATIONSCREEN.PRESETLEVELDESC.COMPLETE_DARKNESS,
        location = "forest",
        version = 3,
        overrides={
            start_location = "darkness",
            day = "onlynight",
        },
		ordered_story_setpieces = {
			"Sculptures_1",
			"Maxwell5",
		},
		numrandom_set_pieces = 4,
		random_set_pieces = 
		{
			"Sculptures_2",
			"Sculptures_3",
			"Sculptures_4",
			"Sculptures_5",
			"Chessy_1",
			"Chessy_2",
			"Chessy_3",
			"Chessy_4",
			"Chessy_5",
			"Chessy_6",
			--"ChessSpot1",
			--"ChessSpot2",
			--"ChessSpot3",
			"Maxwell1",
			"Maxwell2",
			"Maxwell3",
			"Maxwell4",
			"Maxwell6",
			"Maxwell7",
			"Warzone_1",
			"Warzone_2",
			"Warzone_3",
		},
	})

	
