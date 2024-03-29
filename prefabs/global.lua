local assets =
{
    Asset("PKGREF", "sound/dontstarve.fev"),
    Asset("SOUNDPACKAGE", "sound/dontstarve_DLC001.fev"),
    Asset("FILE", "sound/DLC_music.fsb"),

    Asset("FILE", "sound/wilton.fsb"),         -- Legacy sound that can be used in mods
    Asset("FILE", "sound/winnie.fsb"),         -- Legacy sound that can be used in mods
    Asset("FILE", "sound/wallace.fsb"),        -- Legacy sound that can be used in mods
    Asset("FILE", "sound/woodrow.fsb"),        -- Legacy sound that can be used in mods
    Asset("FILE", "sound/stuff.fsb"),          -- Legacy sound that can be used in mods

    Asset("ATLAS", "images/global.xml"),
    Asset("IMAGE", "images/global.tex"),
    Asset("IMAGE", "images/visited.tex"),
    Asset("ANIM", "anim/scroll_arrow.zip"),

    Asset("ANIM", "anim/corner_dude.zip"),

    Asset("SHADER", "shaders/anim_bloom.ksh"),
    Asset("SHADER", "shaders/anim_bloom_ghost.ksh"),
    Asset("SHADER", "shaders/road.ksh"),

    Asset("IMAGE", "images/shadow.tex"),
    Asset("IMAGE", "images/erosion.tex"),
    Asset("IMAGE", "images/circle.tex"),
    Asset("IMAGE", "images/square.tex"),
    Asset("IMAGE", "images/trans.tex"),

    Asset("DYNAMIC_ATLAS", "images/fepanels.xml"),
    Asset("PKGREF", "images/fepanels.tex"),
    
    --item explorer stuff in and out of game
    Asset("ANIM", "anim/spool.zip"), -- doodads
    Asset("ANIM", "anim/frame_bg.zip"),
    Asset("ANIM", "anim/accountitem_frame.zip"),
    Asset("ANIM", "anim/frames_comp.zip"), -- If we replace frames_comp with accountitem_frame, we can remove.

    --IAP shop is accessible in FE and in in-game lobby
    Asset("DYNAMIC_ATLAS", "images/fepanels_redux_shop_panel.xml"),
    Asset("PKGREF", "images/fepanels_redux_shop_panel.tex"),
    Asset("DYNAMIC_ATLAS", "images/fepanels_redux_shop_panel_wide.xml"),
    Asset("PKGREF", "images/fepanels_redux_shop_panel_wide.tex"),

    Asset("DYNAMIC_ANIM", "anim/dynamic/box_shared_spiral.zip"),
    Asset("PKGREF", "anim/dynamic/box_shared_spiral.dyn"),
    Asset("DYNAMIC_ANIM", "anim/dynamic/box_shared.zip"), --needed for the mystery and purchase box opening animation (happens to contain the forge box build too)
    Asset("PKGREF", "anim/dynamic/box_shared.dyn"),

    -- Used in event join flow and in-game victory.
    Asset("ATLAS", "images/dialogcurly_9slice.xml"),
    Asset("IMAGE", "images/dialogcurly_9slice.tex"),

    -- Used for motd and options
    Asset("ATLAS", "images/dialogrect_9slice.xml"),
    Asset("IMAGE", "images/dialogrect_9slice.tex"),

    Asset("DYNAMIC_ATLAS", "images/lavaarena_achievements.xml"),
    Asset("PKGREF", "images/lavaarena_achievements.tex"),

	Asset("ATLAS", "images/lavaarena_unlocks.xml"),
	Asset("IMAGE", "images/lavaarena_unlocks.tex"),

	Asset("ATLAS", "images/lavaarena_unlocks2.xml"),
	Asset("IMAGE", "images/lavaarena_unlocks2.tex"),

	Asset("ATLAS", "images/lavaarena_quests.xml"),
	Asset("IMAGE", "images/lavaarena_quests.tex"),

    Asset("DYNAMIC_ATLAS", "images/quagmire_food_common_inv_images_hires.xml"),
    Asset("PKGREF", "images/quagmire_food_common_inv_images_hires.tex"),

    Asset("ATLAS", "images/quagmire_achievements.xml"),
    Asset("IMAGE", "images/quagmire_achievements.tex"),

    Asset("ATLAS", "images/quagmire_recipebook.xml"),
    Asset("IMAGE", "images/quagmire_recipebook.tex"),

    Asset("DYNAMIC_ATLAS", "images/options.xml"),
    Asset("PKGREF", "images/options.tex"),
    Asset("DYNAMIC_ATLAS", "images/options_bg.xml"),
    Asset("PKGREF", "images/options_bg.tex"),

    Asset("ATLAS", "images/frontend.xml"),
    Asset("IMAGE", "images/frontend.tex"),
    Asset("ATLAS", "images/frontend_redux.xml"),
    Asset("IMAGE", "images/frontend_redux.tex"),

    Asset("ATLAS", "images/bg_spiral.xml"),
    Asset("IMAGE", "images/bg_spiral.tex"),
    Asset("ATLAS", "images/bg_vignette.xml"),
    Asset("IMAGE", "images/bg_vignette.tex"),

    Asset("DYNAMIC_ATLAS", "images/fepanel_fills.xml"),
    Asset("PKGREF", "images/fepanel_fills.tex"),

    Asset("ATLAS", "images/bg_redux_dark_right.xml"),
    Asset("IMAGE", "images/bg_redux_dark_right.tex"),
    Asset("ATLAS", "images/bg_redux_dark_sidebar.xml"),
    Asset("IMAGE", "images/bg_redux_dark_sidebar.tex"),

    -- Old portal frontend background from before The Forge UI update. Still
    -- used on tradescreen.
    --Note(Peter):try moving this to the frontend prefab
    Asset("DYNAMIC_ATLAS", "images/bg_animated_portal.xml"),
    Asset("PKGREF", "images/bg_animated_portal.tex"),
    Asset("DYNAMIC_ATLAS", "images/fg_animated_portal.xml"),
    Asset("PKGREF", "images/fg_animated_portal.tex"),
    Asset("DYNAMIC_ATLAS", "images/fg_trees.xml"),
    Asset("PKGREF", "images/fg_trees.tex"),
    --

    Asset("ANIM", "anim/portal_scene2.zip"),
    Asset("ANIM", "anim/portal_scene_steamfxbg.zip"),
    Asset("ANIM", "anim/portal_scene2_inside.zip"),
    Asset("ANIM", "anim/portal_scene_steamfxeast.zip"),
    Asset("ANIM", "anim/portal_scene_steamfxwest.zip"),
    Asset("ANIM", "anim/portal_scene_steamfxsouth.zip"),
    Asset("ANIM", "anim/cloud_build.zip"),

    --Asset("IMAGE", "images/river_bed.tex"),
    --Asset("IMAGE", "images/water_river.tex"),
    Asset("IMAGE", "images/pathnoise.tex"),
    Asset("IMAGE", "images/mini_pathnoise.tex"),
    Asset("IMAGE", "images/roadnoise.tex"),
    Asset("IMAGE", "images/roadedge.tex"),
    Asset("IMAGE", "images/roadcorner.tex"),
    Asset("IMAGE", "images/roadendcap.tex"),

    Asset("IMAGE", "images/colour_cubes/identity_colourcube.tex"),

    Asset("SHADER", "shaders/anim.ksh"),
    Asset("SHADER", "shaders/anim_fade.ksh"),
    Asset("SHADER", "shaders/anim_bloom.ksh"),
    Asset("SHADER", "shaders/blurh.ksh"),
    Asset("SHADER", "shaders/blurv.ksh"),
    Asset("SHADER", "shaders/creep.ksh"),
    Asset("SHADER", "shaders/debug_line.ksh"),
    Asset("SHADER", "shaders/debug_tri.ksh"),
    Asset("SHADER", "shaders/render_depth.ksh"),
    Asset("SHADER", "shaders/font.ksh"),
    Asset("SHADER", "shaders/font_packed.ksh"),
    Asset("SHADER", "shaders/font_packed_outline.ksh"),
    Asset("SHADER", "shaders/ground.ksh"),
    Asset("SHADER", "shaders/ground_overlay.ksh"),
    Asset("SHADER", "shaders/ground_lights.ksh"),
    Asset("SHADER", "shaders/ceiling.ksh"),
    -- Asset("SHADER", "shaders/triplanar.ksh"),
    Asset("SHADER", "shaders/triplanar_bg.ksh"),
    Asset("SHADER", "shaders/triplanar_alpha_wall.ksh"),
    Asset("SHADER", "shaders/triplanar_alpha_ceiling.ksh"),
    Asset("SHADER", "shaders/lighting.ksh"),
    Asset("SHADER", "shaders/minimap.ksh"),
    Asset("SHADER", "shaders/minimapfs.ksh"),
    Asset("SHADER", "shaders/particle.ksh"),
    Asset("SHADER", "shaders/vfx_particle.ksh"),
    Asset("SHADER", "shaders/vfx_particle_add.ksh"),
    Asset("SHADER", "shaders/vfx_particle_reveal.ksh"),
    Asset("SHADER", "shaders/road.ksh"),
    Asset("SHADER", "shaders/river.ksh"),
    Asset("SHADER", "shaders/splat.ksh"),
    Asset("SHADER", "shaders/texture.ksh"),
    Asset("SHADER", "shaders/ui.ksh"),
    Asset("SHADER", "shaders/ui_cc.ksh"),
    Asset("SHADER", "shaders/ui_yuv.ksh"),
    Asset("SHADER", "shaders/swipe_fade.ksh"),
    Asset("SHADER", "shaders/ui_anim.ksh"),
    Asset("SHADER", "shaders/combine_colour_cubes.ksh"),
    Asset("SHADER", "shaders/postprocess.ksh"),
    Asset("SHADER", "shaders/postprocessbloom.ksh"),
    Asset("SHADER", "shaders/postprocessdistort.ksh"),
    Asset("SHADER", "shaders/postprocessbloomdistort.ksh"),

    Asset("SHADER", "shaders/waves.ksh"),
    Asset("SHADER", "shaders/overheat.ksh"),

    Asset("SHADER", "shaders/anim.ksh"),
    Asset("SHADER", "shaders/anim_bloom.ksh"),
    Asset("SHADER", "shaders/anim_fade.ksh"),
    Asset("SHADER", "shaders/anim_haunted.ksh"),
    Asset("SHADER", "shaders/anim_fade_haunted.ksh"),
    Asset("SHADER", "shaders/anim_bloom_haunted.ksh"),
    Asset("SHADER", "shaders/minimapblend.ksh"),
    
    --common UI elements that we will always need
    Asset("ATLAS", "images/ui.xml"),
    Asset("IMAGE", "images/ui.tex"),
    Asset("ATLAS", "images/global_redux.xml"),
    Asset("IMAGE", "images/global_redux.tex"),
    Asset("ATLAS", "images/textboxes.xml"),
    Asset("IMAGE", "images/textboxes.tex"),
    Asset("ATLAS", "images/scoreboard.xml"),
    Asset("IMAGE", "images/scoreboard.tex"),
    Asset("ANIM", "anim/generating_world.zip"),
    Asset("ANIM", "anim/generating_cave.zip"),
    Asset("ANIM", "anim/creepy_hands.zip"),    
    Asset("ANIM", "anim/saving_indicator.zip"),

    Asset("ANIM", "anim/skingift_popup.zip"),
    Asset("ATLAS", "images/giftpopup.xml"),
    Asset("IMAGE", "images/giftpopup.tex"),

    --oft-used panel bgs
    Asset("DYNAMIC_ATLAS", "images/globalpanels2.xml"),
    Asset("PKGREF", "images/globalpanels2.tex"),

    Asset("ATLAS", "images/button_icons.xml"),
    Asset("IMAGE", "images/button_icons.tex"),

    Asset("ATLAS", "images/avatars.xml"),
    Asset("IMAGE", "images/avatars.tex"),

    Asset("ATLAS", "images/profileflair.xml"),
    Asset("IMAGE", "images/profileflair.tex"),

    Asset("DYNAMIC_ANIM", "anim/dynamic/body_default1.zip"),
    Asset("DYNAMIC_ANIM", "anim/dynamic/hand_default1.zip"),
    Asset("DYNAMIC_ANIM", "anim/dynamic/legs_default1.zip"),
    Asset("DYNAMIC_ANIM", "anim/dynamic/feet_default1.zip"),
    Asset("PKGREF", "anim/dynamic/body_default1.dyn"),
    Asset("PKGREF", "anim/dynamic/hand_default1.dyn"),
    Asset("PKGREF", "anim/dynamic/legs_default1.dyn"),
    Asset("PKGREF", "anim/dynamic/feet_default1.dyn"),

    Asset("DYNAMIC_ANIM", "anim/dynamic/previous_skin.zip"),
    Asset("PKGREF", "anim/dynamic/previous_skin.dyn"),
    Asset("DYNAMIC_ANIM", "anim/dynamic/random_skin.zip"),
    Asset("PKGREF", "anim/dynamic/random_skin.dyn"),
}

require "fonts"
for i, font in ipairs( FONTS ) do
    table.insert( assets, Asset( "FONT", font.filename ) )
end

-- Add all the characters by name
-- GetOfficialCharacterList doesn't exist in the pipeline.
local official_characters = GetOfficialCharacterList and GetOfficialCharacterList() or DST_CHARACTERLIST
for _,char in ipairs(official_characters) do
    table.insert(assets, Asset("DYNAMIC_ATLAS", "bigportraits/"..char..".xml"))
    table.insert(assets, Asset("PKGREF", "bigportraits/"..char..".tex"))

    table.insert(assets, Asset("DYNAMIC_ATLAS", "images/names_"..char..".xml"))
    table.insert(assets, Asset("PKGREF", "images/names_"..char..".tex"))

    table.insert(assets, Asset("DYNAMIC_ATLAS", "images/names_gold_"..char..".xml"))
    table.insert(assets, Asset("PKGREF", "images/names_gold_"..char..".tex"))

    --table.insert(assets, Asset("IMAGE", "images/selectscreen_portraits/"..char..".tex")) -- Not currently used, but likely to come back
    --table.insert(assets, Asset("IMAGE", "images/selectscreen_portraits/"..char.."_silho.tex")) -- Not currently used, but likely to come back
end

--Skin assets
for _, skin_asset in pairs(require("skin_assets")) do
    table.insert(assets, skin_asset)
end

if QUAGMIRE_USE_KLUMP then
    --Add the custom quagmire recipe images
    for _,file in pairs(require("klump_files")) do
        local klump_file = string.gsub(file, "klump/", "")
        if klump_file:find(".tex") and klump_file:find("_hires") then --crappy assumption for now that _hires .tex klump files have a matching atlas that we need to load
            local xml_file = string.gsub(klump_file, ".tex", ".xml")
            table.insert(assets, Asset("DYNAMIC_ATLAS", xml_file)) --global because the recipe book is used in the frontend and backend
        end
    end
end

return Prefab("global", function() end, assets)
