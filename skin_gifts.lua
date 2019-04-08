-- AUTOGENERATED CODE BY export_accountitems.lua

local SKIN_GIFT_TYPES =
{
	arrowsign_post_circus = "TWITCH_DROP",
	beefalohat_pigking = "YOTP",
	birdcage_circus = "TWITCH_DROP",
	cane_ancient = "ANRARG",
	emote_swoon = "CUPID",
	featherhat_circus = "TWITCH_DROP",
	firesuppressor_circus = "TWITCH_DROP",
	lantern_winter = "WINTER",
	playerportrait_bg_arrowsignpostcircus = "TWITCH_DROP",
	playerportrait_bg_birdcagecircus = "TWITCH_DROP",
	playerportrait_bg_featherhatcircus = "TWITCH_DROP",
	playerportrait_bg_firesuppressorcircus = "TWITCH_DROP",
	playerportrait_bg_foods = "GORGE",
	playerportrait_bg_rainometercircus = "TWITCH_DROP",
	playerportrait_bg_tentcircus = "TWITCH_DROP",
	playerportrait_bg_tophatcircus = "TWITCH_DROP",
	playerportrait_bg_umbrellacircus = "TWITCH_DROP",
	playerportrait_bg_winterometercircus = "TWITCH_DROP",
	profileflair_arrowsignpost_circus = "TWITCH_DROP",
	profileflair_birdcage_circus = "TWITCH_DROP",
	profileflair_featherhat_circus = "TWITCH_DROP",
	profileflair_firesuppressor_circus = "TWITCH_DROP",
	profileflair_rainometer_circus = "TWITCH_DROP",
	profileflair_tent_circus = "TWITCH_DROP",
	profileflair_tophat_circus = "TWITCH_DROP",
	profileflair_umbrella_circus = "TWITCH_DROP",
	profileflair_winterometer_circus = "TWITCH_DROP",
	rainometer_circus = "TWITCH_DROP",
	reviver_cupid = "CUPID",
	reviver_cupid_2 = "CUPID",
	reviver_cupid_3 = "CUPID",
	tent_circus = "TWITCH_DROP",
	tophat_circus = "TWITCH_DROP",
	torch_shadow_alt = "ARG",
	treasurechest_sacred = "ANRARG",
	umbrella_circus = "TWITCH_DROP",
	winterhat_fancy_puppy = "VARG",
	winterhat_rooster = "LUNAR",
	winterometer_circus = "TWITCH_DROP",
}

local SKIN_GIFT_POPUPDATA =
{
	ANRARG =
	{
		atlas = "images/thankyou_item_event.xml",
		image = {"thankyou_anrarg.tex"},
		title = STRINGS.THANKS_POPUP.ANRARG,
		titleoffset = {0, -20, 0},
	},
	ARG =
	{
		atlas = "images/thankyou_item_popup.xml",
		image = {"thankyou_gift.tex"},
		title = STRINGS.THANKS_POPUP.ARG,
		titleoffset = {0, -20, 0},
	},
	CUPID =
	{
		atlas = "images/thankyou_item_popup.xml",
		image = {"thankyou_gift.tex"},
		title = STRINGS.THANKS_POPUP.CUPID,
		titleoffset = {0, -30, 0},
	},
	GORGE =
	{
		atlas = "images/thankyou_item_event2.xml",
		image = {"thankyou_gorge.tex"},
		title = STRINGS.THANKS_POPUP.GORGE,
		titleoffset = {0, -20, 0},
	},
	LUNAR =
	{
		atlas = "images/thankyou_item_event.xml",
		image = {"thankyou_lunar.tex"},
		title = STRINGS.THANKS_POPUP.LUNAR,
		titleoffset = {0, -30, 0},
	},
	TWITCH_DROP =
	{
		atlas = "images/thankyou_item_popup.xml",
		image = {"thankyou_twitch.tex"},
		title = STRINGS.THANKS_POPUP.TWITCH_DROP,
		titleoffset = {0, -20, 0},
	},
	VARG =
	{
		atlas = "images/thankyou_item_event.xml",
		image = {"thankyou_varg.tex"},
		title = STRINGS.THANKS_POPUP.VARG,
		titleoffset = {0, -20, 0},
	},
	WINTER =
	{
		atlas = "images/thankyou_item_event.xml",
		image = {"thankyou_winter.tex"},
		title = STRINGS.THANKS_POPUP.WINTER,
		titleoffset = {0, -30, 0},
	},
	YOTP =
	{
		atlas = "images/thankyou_item_event2.xml",
		image = {"thankyou_yotp.tex"},
		title = STRINGS.THANKS_POPUP.YOTP,
		titleoffset = {0, -20, 0},
	},
}

return { types = SKIN_GIFT_TYPES, popupdata = SKIN_GIFT_POPUPDATA }
