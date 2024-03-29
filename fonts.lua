
DEFAULTFONT = "opensans"
DIALOGFONT = "opensans"
TITLEFONT = "bp100"
UIFONT = "bp50"
BUTTONFONT = "buttonfont"
NEWFONT = "spirequal"
NEWFONT_SMALL = "spirequal_small"
NEWFONT_OUTLINE = "spirequal_outline"
NEWFONT_OUTLINE_SMALL = "spirequal_outline_small"
NUMBERFONT = "stint-ucr"
TALKINGFONT = "talkingfont"
CHATFONT = "bellefair"
HEADERFONT = "hammerhead"
CHATFONT_OUTLINE = "bellefair_outline"
SMALLNUMBERFONT = "stint-small"
BODYTEXTFONT = "stint-ucr"
CODEFONT = "ptmono"

-- These extra glyph fonts are only used as fallbacks.
local CONTROLLERS = "controllers"
local EMOJIFONT = "emoji"

FALLBACK_FONT = "fallback_font"
FALLBACK_FONT_OUTLINE = "fallback_font_outline"


require "translator"

local font_posfix = ""

if LanguageTranslator then	-- This gets called from the build pipeline too
    local lang = LanguageTranslator.defaultlang 

    -- Some languages need their own font
    local specialFontLangs = {"jp"}

    for i,v in pairs(specialFontLangs) do
        if v == lang then
            font_posfix = "__"..lang
        end
    end
end

DEFAULT_FALLBACK_TABLE = {
	EMOJIFONT,
	CONTROLLERS,
	FALLBACK_FONT,
}

DEFAULT_FALLBACK_TABLE_OUTLINE = {
	EMOJIFONT,
	CONTROLLERS,
	FALLBACK_FONT_OUTLINE,
}

FONTS = {
	{ filename = "fonts/talkingfont"..font_posfix..".zip", alias = TALKINGFONT, fallback = DEFAULT_FALLBACK_TABLE_OUTLINE },
	{ filename = "fonts/hammerhead50"..font_posfix..".zip", alias = HEADERFONT, fallback = DEFAULT_FALLBACK_TABLE },
	{ filename = "fonts/bellefair50"..font_posfix..".zip", alias = CHATFONT, fallback = DEFAULT_FALLBACK_TABLE },
	{ filename = "fonts/bellefair50_outline"..font_posfix..".zip", alias = CHATFONT_OUTLINE, fallback = DEFAULT_FALLBACK_TABLE_OUTLINE },
	{ filename = "fonts/stint-ucr50"..font_posfix..".zip", alias = BODYTEXTFONT, fallback = DEFAULT_FALLBACK_TABLE_OUTLINE },
	{ filename = "fonts/stint-ucr20"..font_posfix..".zip", alias = SMALLNUMBERFONT, fallback = DEFAULT_FALLBACK_TABLE_OUTLINE },
	{ filename = "fonts/opensans50"..font_posfix..".zip", alias = DEFAULTFONT, fallback = DEFAULT_FALLBACK_TABLE_OUTLINE },							-- aka DIALOGFONT
	{ filename = "fonts/belisaplumilla50"..font_posfix..".zip", alias = UIFONT, fallback = DEFAULT_FALLBACK_TABLE_OUTLINE, adjustadvance=-2 },
	{ filename = "fonts/belisaplumilla100"..font_posfix..".zip", alias = TITLEFONT, fallback = DEFAULT_FALLBACK_TABLE_OUTLINE},	-- old header font
	{ filename = "fonts/buttonfont"..font_posfix..".zip", alias = BUTTONFONT, fallback = DEFAULT_FALLBACK_TABLE },	
	{ filename = "fonts/spirequal"..font_posfix..".zip", alias = NEWFONT, fallback = DEFAULT_FALLBACK_TABLE },	
	{ filename = "fonts/spirequal_small"..font_posfix..".zip", alias = NEWFONT_SMALL, fallback = DEFAULT_FALLBACK_TABLE },							-- hardly used, could be replaced with NEWFONT, size difference is not noticable 
	{ filename = "fonts/spirequal_outline"..font_posfix..".zip", alias = NEWFONT_OUTLINE, fallback = DEFAULT_FALLBACK_TABLE_OUTLINE },
	{ filename = "fonts/spirequal_outline_small"..font_posfix..".zip", alias = NEWFONT_OUTLINE_SMALL, fallback = DEFAULT_FALLBACK_TABLE_OUTLINE },	-- not in use
	{ filename = "fonts/ptmono32"..font_posfix..".zip", alias = CODEFONT, fallback = DEFAULT_FALLBACK_TABLE },										-- not in use yet, will be used for promo-code verification text box

	{ filename = "fonts/controllers"..font_posfix..".zip", alias = CONTROLLERS, disable_color = true},
	{ filename = "fonts/emoji"..font_posfix..".zip", alias = EMOJIFONT, disable_color = true},

	{ filename = "fonts/fallback_full_packed"..font_posfix..".zip", alias = FALLBACK_FONT},
	{ filename = "fonts/fallback_full_outline_packed"..font_posfix..".zip", alias = FALLBACK_FONT_OUTLINE},
}
