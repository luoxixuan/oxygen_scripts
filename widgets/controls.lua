local Screen = require "widgets/screen"
local Button = require "widgets/button"
local AnimButton = require "widgets/animbutton"
local ImageButton = require "widgets/imagebutton"
local Text = require "widgets/text"
local Image = require "widgets/image"
local UIAnim = require "widgets/uianim"
local Inv = require "widgets/inventorybar"
local Widget = require "widgets/widget"
local CraftTabs = require "widgets/crafttabs"
local HoverText = require "widgets/hoverer"
local MapControls = require "widgets/mapcontrols"
local ContainerWidget = require("widgets/containerwidget")
local DemoTimer = require "widgets/demotimer"
local SavingIndicator = require "widgets/savingindicator"
local UIClock = require "widgets/uiclock"
local MapScreen = require "screens/mapscreen"
local FollowText = require "widgets/followtext"
local StatusDisplays = require "widgets/statusdisplays"
local Lavaarena_StatusDisplays = require "widgets/statusdisplays_lavaarena"
local Quagmire_StatusDisplays = require "widgets/statusdisplays_quagmire"
local Quagmire_StatusCravingDisplay = require "widgets/statusdisplays_quagmire_cravings"
local Quagmire_NotificationWidget = require "widgets/quagmire_notificationwidget"
local QuagmireRecipeBookScreen = require "screens/quagmire_recipebookscreen"
local ChatQueue = require "widgets/chatqueue"
local Desync = require "widgets/desync"
local WorldResetTimer = require "widgets/worldresettimer"
local GiftItemToast = require "widgets/giftitemtoast"
local VoteDialog = require "widgets/votedialog"
local TEMPLATES = require "widgets/templates"
local easing = require("easing")
local TeamStatusBars = require("widgets/teamstatusbars")

local Controls = Class(Widget, function(self, owner)
    Widget._ctor(self, "Controls")
    self.owner = owner

    self._scrnw, self._scrnh = TheSim:GetScreenSize()

    self.playeractionhint = self:AddChild(FollowText(TALKINGFONT, 28))
    self.playeractionhint:SetHUD(owner.HUD.inst)
    self.playeractionhint:SetOffset(Vector3(0, 100, 0))
    self.playeractionhint:Hide()

    self.playeractionhint_itemhighlight = self:AddChild(FollowText(TALKINGFONT, 28))
    self.playeractionhint_itemhighlight:SetHUD(owner.HUD.inst)
    self.playeractionhint_itemhighlight:SetOffset(Vector3(0, 100, 0))
    self.playeractionhint_itemhighlight:Hide()

    self.attackhint = self:AddChild(FollowText(TALKINGFONT, 28))
    self.attackhint:SetHUD(owner.HUD.inst)
    self.attackhint:SetOffset(Vector3(0, 100, 0))
    self.attackhint:Hide()

    self.groundactionhint = self:AddChild(FollowText(TALKINGFONT, 28))
    self.groundactionhint:SetHUD(owner.HUD.inst)
    self.groundactionhint:SetOffset(Vector3(0, 100, 0))
    self.groundactionhint:Hide()

    self.blackoverlay = self:AddChild(Image("images/global.xml", "square.tex"))
    self.blackoverlay:SetVRegPoint(ANCHOR_MIDDLE)
    self.blackoverlay:SetHRegPoint(ANCHOR_MIDDLE)
    self.blackoverlay:SetVAnchor(ANCHOR_MIDDLE)
    self.blackoverlay:SetHAnchor(ANCHOR_MIDDLE)
    self.blackoverlay:SetScaleMode(SCALEMODE_FILLSCREEN)
    self.blackoverlay:SetClickable(false)
    self.blackoverlay:SetTint(0,0,0,.5)
    self.blackoverlay:Hide()

    self.containerroot = self:AddChild(Widget(""))
    self:MakeScalingNodes()

    self.saving = self.topright_over_root:AddChild(SavingIndicator(self.owner))
    self.saving:SetPosition(-440, 0, 0)

    self.item_notification = self.topleft_root:AddChild(GiftItemToast(self.owner))
    self.item_notification:SetPosition(115, 150, 0)

    self.worldresettimer = self.bottom_root:AddChild(WorldResetTimer(self.owner))
    self.inv = self.bottom_root:AddChild(Inv(self.owner))
    self.inv.autoanchor = self.worldresettimer
    self.inv:Hide()

    self.sidepanel = self.topright_root:AddChild(Widget("sidepanel"))
    self.sidepanel:SetScale(1,1,1)
    self.sidepanel:SetPosition(-80, -60, 0)

    self.votedialog = self.topright_root:AddChild(VoteDialog(self.owner))
    self.votedialog:SetPosition(-330, 0, 0)

    if TheNet:GetServerGameMode() == "lavaarena" then
        self.status = self.bottom_root:AddChild(Lavaarena_StatusDisplays(self.owner))
        self.teamstatus = self.topleft_root:AddChild(TeamStatusBars(self.owner))
    elseif TheNet:GetServerGameMode() == "quagmire" then
        self.status = self.bottom_root:AddChild(Quagmire_StatusDisplays(self.owner))
		self.quagmire_hangriness = self.top_root:AddChild(Quagmire_StatusCravingDisplay(self.owner))
		self.quagmire_notifications = self.right_root:AddChild(Quagmire_NotificationWidget(self.owner))
		self.quagmire_notifications:SetPosition(0, 200)
		self.containerroot:MoveToFront() -- so safes ui opens on top of hangriness meter
    else
        self.status = self.sidepanel:AddChild(StatusDisplays(self.owner))
        self.status:SetPosition(0,-110,0)

		self.clock = self.sidepanel:AddChild(UIClock(self.owner))
		if self.clock:IsCaveClock() then
			self.clock.inst:DoPeriodicTask(.5, function() self.clock:UpdateCaveClock(self.owner) end, 0)
		end
    end

    local twitch_options = TheFrontEnd:GetTwitchOptions()
    if twitch_options ~= nil and twitch_options:SupportedByPlatform() then
        if twitch_options:IsInitialized() and twitch_options:GetBroadcastingEnabled() and twitch_options:GetVisibleChatEnabled() then
            self.chatqueue = self.sidepanel:AddChild(ChatQueue(self.owner))
        end
    end

    -- Network global chat queue
    self.chat_queue_root = self:AddChild(Widget("chat_queue_root"))
    self.chat_queue_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.chat_queue_root:SetHAnchor(ANCHOR_MIDDLE)
    self.chat_queue_root:SetVAnchor(ANCHOR_BOTTOM)
    self.chat_queue_root = self.chat_queue_root:AddChild(Widget(""))
    self.chat_queue_root:SetPosition(-90,765,0)
    self.networkchatqueue = self.chat_queue_root:AddChild(ChatQueue(self.owner))

    self.containers = {}

    self.mapcontrols = self.bottomright_root:AddChild(MapControls())
    self.mapcontrols:SetPosition(-60,70,0)
    if TheNet:GetServerGameMode() == "quagmire" then
		self.mapcontrols.minimapBtn:SetTextures("images/quagmire_hud.xml", "map_button.tex")
		self.mapcontrols.map_tooltip = STRINGS.UI.RECIPE_BOOK.TITLE.."\n"
		self.mapcontrols:RefreshTooltips()
	end

    --set this to true, to enable the PAX demo timer
    if false and not IsGamePurchased() then
        self.demotimer = self.top_root:AddChild(DemoTimer(self.owner))
        self.demotimer:SetPosition(0, 0, 0)
    end

    self.containerroot:SetHAnchor(ANCHOR_MIDDLE)
    self.containerroot:SetVAnchor(ANCHOR_MIDDLE)
    self.containerroot:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.containerroot:SetMaxPropUpscale(MAX_HUD_SCALE)
    self.containerroot = self.containerroot:AddChild(Widget(""))

    self.containerroot_side = self:AddChild(Widget(""))
    self.containerroot_side:SetHAnchor(ANCHOR_RIGHT)
    self.containerroot_side:SetVAnchor(ANCHOR_MIDDLE)
    self.containerroot_side:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.containerroot_side:SetMaxPropUpscale(MAX_HUD_SCALE)
    self.containerroot_side = self.containerroot_side:AddChild(Widget("contaierroot_side"))
    self.containerroot_side:Hide()

    self.mousefollow = self:AddChild(Widget("follower"))
    self.mousefollow:FollowMouse(true)
    self.mousefollow:SetScaleMode(SCALEMODE_PROPORTIONAL)

    self.hover = self:AddChild(HoverText(self.owner))
    self.hover:SetScaleMode(SCALEMODE_PROPORTIONAL)

    self.crafttabs = self.left_root:AddChild(CraftTabs(self.owner, self.top_root))

    if TheNet:GetIsClient() then
        --Not using topleft_root because we need to be on top of containerroot
        self.desync = self:AddChild(Widget("desyncroot"))
        self.desync:SetScaleMode(SCALEMODE_PROPORTIONAL)
        self.desync:SetHAnchor(ANCHOR_LEFT)
        self.desync:SetVAnchor(ANCHOR_TOP)
        self.desync:SetMaxPropUpscale(MAX_HUD_SCALE)
        self.desync = self.desync:AddChild(Desync(owner))
        if PLATFORM == "WIN32_RAIL" then
            self.desync:ShowHostPerf()
        end
    end

    self.dismounthintdelay = 0
    self.craftingandinventoryshown = false

    self:SetHUDSize()

    self:StartUpdating()
end)

function Controls:ShowStatusNumbers()
    self.status:ShowStatusNumbers()
    if self.teamstatus ~= nil then
        self.teamstatus:ShowStatusNumbers()
    end
end

function Controls:HideStatusNumbers()
    self.status:HideStatusNumbers()
    if self.teamstatus ~= nil then
        self.teamstatus:HideStatusNumbers()
    end
end

function Controls:SetDark(val)
    if val then
        self.blackoverlay:Show()
    else
        self.blackoverlay:Hide()
    end
end

function Controls:MakeScalingNodes()

    --these are auto-scaling root nodes
    self.top_root = self:AddChild(Widget("top"))
    self.top_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.top_root:SetHAnchor(ANCHOR_MIDDLE)
    self.top_root:SetVAnchor(ANCHOR_TOP)
    self.top_root:SetMaxPropUpscale(MAX_HUD_SCALE)

    self.topleft_root = self:AddChild(Widget("topleft"))
    self.topleft_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.topleft_root:SetHAnchor(ANCHOR_LEFT)
    self.topleft_root:SetVAnchor(ANCHOR_TOP)
    self.topleft_root:SetMaxPropUpscale(MAX_HUD_SCALE)

    self.bottom_root = self:AddChild(Widget("bottom"))
    self.bottom_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.bottom_root:SetHAnchor(ANCHOR_MIDDLE)
    self.bottom_root:SetVAnchor(ANCHOR_BOTTOM)
    self.bottom_root:SetMaxPropUpscale(MAX_HUD_SCALE)

    self.topright_root = self:AddChild(Widget("side"))
    self.topright_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.topright_root:SetHAnchor(ANCHOR_RIGHT)
    self.topright_root:SetVAnchor(ANCHOR_TOP)
    self.topright_root:SetMaxPropUpscale(MAX_HUD_SCALE)

    self.right_root = self:AddChild(Widget("right_root"))
    self.right_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.right_root:SetHAnchor(ANCHOR_RIGHT)
    self.right_root:SetVAnchor(ANCHOR_MIDDLE)
    self.right_root:SetMaxPropUpscale(MAX_HUD_SCALE)   

    self.bottomright_root = self:AddChild(Widget("bottomright"))
    self.bottomright_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.bottomright_root:SetHAnchor(ANCHOR_RIGHT)
    self.bottomright_root:SetVAnchor(ANCHOR_BOTTOM)
    self.bottomright_root:SetMaxPropUpscale(MAX_HUD_SCALE)

    self.left_root = self:AddChild(Widget("left_root"))
    self.left_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.left_root:SetHAnchor(ANCHOR_LEFT)
    self.left_root:SetVAnchor(ANCHOR_MIDDLE)
    self.left_root:SetMaxPropUpscale(MAX_HUD_SCALE)    

    self.topright_over_root = self:AddChild(Widget("topright_over"))
    self.topright_over_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.topright_over_root:SetHAnchor(ANCHOR_RIGHT)
    self.topright_over_root:SetVAnchor(ANCHOR_TOP)
    self.topright_over_root:SetMaxPropUpscale(MAX_HUD_SCALE)

    --these are for introducing user-configurable hud scale
    self.topleft_root = self.topleft_root:AddChild(Widget("tl_scale_root"))
    self.topright_root = self.topright_root:AddChild(Widget("tr_scale_root"))
    self.bottom_root = self.bottom_root:AddChild(Widget("bottom_scale_root"))
    self.top_root = self.top_root:AddChild(Widget("top_scale_root"))
    self.left_root = self.left_root:AddChild(Widget("left_scale_root"))
    self.right_root = self.right_root:AddChild(Widget("right_scale_root"))
    self.bottomright_root = self.bottomright_root:AddChild(Widget("br_scale_root"))
    self.topright_over_root = self.topright_over_root:AddChild(Widget("tr_over_scale_root"))
    --
end

function Controls:SetHUDSize()
    local scale = TheFrontEnd:GetHUDScale()

    self.topleft_root:SetScale(scale, scale, scale)
    self.topright_root:SetScale(scale, scale, scale)
    self.bottom_root:SetScale(scale, scale, scale)
    self.top_root:SetScale(scale, scale, scale)
    self.right_root:SetScale(scale, scale, scale)
    self.bottomright_root:SetScale(scale, scale, scale)
    self.left_root:SetScale(scale, scale, scale)
    self.containerroot:SetScale(scale, scale, scale)
    self.containerroot_side:SetScale(scale, scale, scale)
    self.hover:SetScale(scale, scale, scale)
    self.topright_over_root:SetScale(scale, scale, scale)

    self.mousefollow:SetScale(scale, scale, scale)

    if self.desync ~= nil then
        self.desync:SetScale(scale, scale, scale)
    end

    self.owner.HUD.inst:PushEvent("refreshhudsize", scale)
end

function Controls:OnUpdate(dt)
    if PerformingRestart then
        self.playeractionhint:SetTarget(nil)
        self.playeractionhint_itemhighlight:SetTarget(nil)
        self.attackhint:SetTarget(nil)
        self.groundactionhint:SetTarget(nil)
        return
    end

    local scrnw, scrnh = TheSim:GetScreenSize()
    if scrnw ~= self._scrnw or scrnh ~= self._scrnh then
        self._scrnw, self._scrnh = scrnw, scrnh
        self:SetHUDSize()
    end

    local controller_mode = TheInput:ControllerAttached()
    local controller_id = TheInput:GetControllerID()

    if controller_mode then
        self.mapcontrols:Hide()
    else
        self.mapcontrols:Show()
    end

    for k,v in pairs(self.containers) do
        if v.should_close_widget then
            self.containers[k] = nil
            v:Kill()
        end
    end

    --[[if false and self.demotimer then
        if IsGamePurchased() then
            self.demotimer:Kill()
            self.demotimer = nil
        end
    end]]

    local shownItemIndex = nil
    local itemInActions = false     -- the item is either shown through the actionhint or the groundaction

    if controller_mode and not (self.inv.open or self.crafttabs.controllercraftingopen) and self.owner:IsActionsVisible() then
        local ground_l, ground_r = self.owner.components.playercontroller:GetGroundUseAction()
        local ground_cmds = {}
        if self.owner.components.playercontroller.deployplacer ~= nil or self.owner.components.playercontroller.placer ~= nil then
            local placer = self.terraformplacer

            if self.owner.components.playercontroller.deployplacer ~= nil then
                self.groundactionhint:Show()
                self.groundactionhint:SetTarget(self.owner.components.playercontroller.deployplacer)

                if self.owner.components.playercontroller.deployplacer.components.placer.can_build then
                    self.groundactionhint.text:SetString(TheInput:GetLocalizedControl(controller_id, CONTROL_CONTROLLER_ACTION) .. " " .. self.owner.components.playercontroller.deployplacer.components.placer:GetDeployAction():GetActionString().."\n"..TheInput:GetLocalizedControl(controller_id, CONTROL_CONTROLLER_ALTACTION).." "..STRINGS.UI.HUD.CANCEL)
                else
                    self.groundactionhint.text:SetString(TheInput:GetLocalizedControl(controller_id, CONTROL_CONTROLLER_ALTACTION).." "..STRINGS.UI.HUD.CANCEL)
                end

            elseif self.owner.components.playercontroller.placer ~= nil then
                self.groundactionhint:Show()
                self.groundactionhint:SetTarget(self.owner)
                self.groundactionhint.text:SetString(TheInput:GetLocalizedControl(controller_id, CONTROL_CONTROLLER_ACTION) .. " " .. STRINGS.UI.HUD.BUILD.."\n" .. TheInput:GetLocalizedControl(controller_id, CONTROL_CONTROLLER_ALTACTION) .. " " .. STRINGS.UI.HUD.CANCEL.."\n")    
            end
        else
            local aoetargeting = self.owner.components.playercontroller:IsAOETargeting()
            if ground_r ~= nil then
                if ground_r.action ~= ACTIONS.CASTAOE then
                    table.insert(ground_cmds, TheInput:GetLocalizedControl(controller_id, CONTROL_CONTROLLER_ALTACTION).." "..ground_r:GetActionString())
                elseif aoetargeting then
                    table.insert(ground_cmds, TheInput:GetLocalizedControl(controller_id, CONTROL_CONTROLLER_ACTION).." "..ground_r:GetActionString())
                end
            end
            if aoetargeting then
                table.insert(ground_cmds, TheInput:GetLocalizedControl(controller_id, CONTROL_CONTROLLER_ALTACTION).." "..STRINGS.UI.HUD.CANCEL)
            end
            if #ground_cmds > 0 then
                self.groundactionhint:Show()
                self.groundactionhint:SetTarget(self.owner)
                self.groundactionhint.text:SetString(table.concat(ground_cmds, "\n"))
            else
                self.groundactionhint:Hide()
            end
        end

        local attack_shown = false
        local controller_target = self.owner.components.playercontroller:GetControllerTarget()
        local controller_attack_target = self.owner.components.playercontroller:GetControllerAttackTarget()
        if controller_target ~= nil then
            local cmds, cmdsoffset
            local textblock = self.playeractionhint.text
            if self.groundactionhint.shown and distsq(self.owner:GetPosition(), controller_target:GetPosition()) < 1.33 then
                --You're close to your target so we should combine the two text blocks.
                cmds = ground_cmds
                cmdsoffset = #cmds
                textblock = self.groundactionhint.text
                self.playeractionhint:Hide()
                itemInActions = false
            else
                cmds = {}
                cmdsoffset = 0
                self.playeractionhint:Show()
                self.playeractionhint:SetTarget(controller_target)
                itemInActions = true
            end

            local l, r = self.owner.components.playercontroller:GetSceneItemControllerAction(controller_target)
            local adjective = controller_target:GetAdjective()
            table.insert(cmds, adjective ~= nil and (adjective.." "..controller_target:GetDisplayName()) or controller_target:GetDisplayName())
            shownItemIndex = #cmds

            if controller_target == controller_attack_target then
                table.insert(cmds, TheInput:GetLocalizedControl(controller_id, CONTROL_CONTROLLER_ATTACK) .. " " .. STRINGS.UI.HUD.ATTACK)
                attack_shown = true
            end
            if (self.owner.CanExamine == nil or self.owner:CanExamine()) and
                --V2C: Closing the avatar popup takes priority
                not self.owner.HUD:IsPlayerAvatarPopUpOpen() and
                controller_target:HasTag("inspectable") then
                table.insert(cmds, TheInput:GetLocalizedControl(controller_id, CONTROL_INSPECT) .. " " .. STRINGS.UI.HUD.INSPECT)
            end
            if l ~= nil then
                table.insert(cmds, TheInput:GetLocalizedControl(controller_id, CONTROL_CONTROLLER_ACTION) .. " " .. l:GetActionString())
            end
            if r ~= nil and ground_r == nil then
                table.insert(cmds, TheInput:GetLocalizedControl(controller_id, CONTROL_CONTROLLER_ALTACTION) .. " " .. r:GetActionString())
            end
			if self.owner.components.playercontroller:IsControllerTargetLocked() then
                table.insert(cmds, TheInput:GetLocalizedControl(controller_id, CONTROL_CANCEL) .. " " .. STRINGS.UI.HUD.UNLOCK_TARGET)
			end
            if controller_target.quagmire_shoptab ~= nil then
                for k, v in pairs(self.crafttabs.tabs.shown) do
                    if k.filter == controller_target.quagmire_shoptab then
                        if v then
                            table.insert(cmds, TheInput:GetLocalizedControl(TheInput:GetControllerID(), CONTROL_OPEN_CRAFTING).." "..STRINGS.UI.CRAFTING.TABACTION[controller_target.quagmire_shoptab.str])
                        end
                        break
                    end
                end
            end

            if #cmds - cmdsoffset <= 1 then
                --New special case that we support:
                -- target is highlighted but with no actions
                -- -> suppress any ground action hints
                -- -> use target's custom display name to show special action hint
                if cmds ~= ground_cmds then
                    self.groundactionhint:Hide()
                    self.groundactionhint:SetTarget(nil)
                end
                textblock:SetString(cmds[#cmds])
            else
                textblock:SetString(table.concat(cmds, "\n"))
            end
        elseif not self.groundactionhint.shown
            and self.dismounthintdelay <= 0
            and self.owner.replica.rider ~= nil
            and self.owner.replica.rider:IsRiding() then
            self.playeractionhint.text:SetString(TheInput:GetLocalizedControl(controller_id, CONTROL_CONTROLLER_ALTACTION).." "..STRINGS.ACTIONS.DISMOUNT)
            self.playeractionhint:Show()
            self.playeractionhint:SetTarget(self.owner)
        else
            self.playeractionhint:Hide()
            self.playeractionhint:SetTarget(nil)
        end

        if controller_attack_target ~= nil and not attack_shown then
            self.attackhint:Show()
            self.attackhint:SetTarget(controller_attack_target)
            self.attackhint.text:SetString(TheInput:GetLocalizedControl(controller_id, CONTROL_CONTROLLER_ATTACK) .. " " .. STRINGS.UI.HUD.ATTACK)
        else
            self.attackhint:Hide()
            self.attackhint:SetTarget(nil)
        end
    else
        self.attackhint:Hide()
        self.attackhint:SetTarget(nil)

        self.playeractionhint:Hide()
        self.playeractionhint:SetTarget(nil)

        self.groundactionhint:Hide()
        self.groundactionhint:SetTarget(nil)
    end

    if not self.owner:HasTag("idle") then
        self.dismounthintdelay = .5
    elseif self.dismounthintdelay > 0 then
        self.dismounthintdelay = self.dismounthintdelay - dt
    end

    --default offsets   
    self.playeractionhint:SetScreenOffset(0,0)
    self.attackhint:SetScreenOffset(0,0)

    --if we are showing both hints, make sure they don't overlap
    if self.attackhint.shown and self.playeractionhint.shown then

        local w1, h1 = self.attackhint.text:GetRegionSize()
        local x1, y1 = self.attackhint:GetPosition():Get()
        --print (w1, h1, x1, y1)

        local w2, h2 = self.playeractionhint.text:GetRegionSize()
        local x2, y2 = self.playeractionhint:GetPosition():Get()
        --print (w2, h2, x2, y2)

        local sep = (x1 + w1/2) < (x2 - w2/2) or
                    (x1 - w1/2) > (x2 + w2/2) or
                    (y1 + h1/2) < (y2 - h2/2) or
                    (y1 - h1/2) > (y2 + h2/2)

        if not sep then
            local a_l = x1 - w1/2
            local a_r = x1 + w1/2

            local p_l = x2 - w2/2
            local p_r = x2 + w2/2

            if math.abs(p_r - a_l) < math.abs(p_l - a_r) then
                local d = (p_r - a_l) + 20
                self.attackhint:SetScreenOffset(d/2,0)
                self.playeractionhint:SetScreenOffset(-d/2,0)
            else
                local d = (a_r - p_l) + 20
                self.attackhint:SetScreenOffset( -d/2,0)
                self.playeractionhint:SetScreenOffset(d/2,0)
            end
        end
    end

    self:HighlightActionItem(shownItemIndex, itemInActions)
end

function Controls:HighlightActionItem(itemIndex, itemInActions)
    if itemIndex then
        local followerWidget
        if itemInActions then
            followerWidget = self.playeractionhint
        else
            followerWidget = self.groundactionhint
        end
        self.playeractionhint_itemhighlight:Show()
        local offsetx, offsety = followerWidget:GetScreenOffset()
        self.playeractionhint_itemhighlight:SetScreenOffset(offsetx, offsety)
        self.playeractionhint_itemhighlight:SetTarget(followerWidget.target)

        local str = followerWidget.text.string
        local itemlines = {}
        local commandlines = {}
        local target = self.owner.components.playercontroller.controller_target
        for idx,line in ipairs(string.split(str, "\n")) do
            if idx==itemIndex then
                itemlines[#itemlines+1] = line
                commandlines[#commandlines+1]= " "
            else
                itemlines[#itemlines+1] = " "
                commandlines[#commandlines+1] = line
            end
        end
        followerWidget.text:SetString(table.concat(commandlines,"\n"))

        self.playeractionhint_itemhighlight.text:SetString(table.concat(itemlines,"\n"))
        if target:GetIsWet() then
            self.playeractionhint_itemhighlight.text:SetColour(unpack(WET_TEXT_COLOUR))
        else
            self.playeractionhint_itemhighlight.text:SetColour(unpack(NORMAL_TEXT_COLOUR))
        end
    else
        self.playeractionhint_itemhighlight:Hide()
    end
end

function Controls:ShowMap()
    if self.owner ~= nil and self.owner.HUD ~= nil and (not self.owner.HUD:IsMapScreenOpen()) then
		if TheNet:GetServerGameMode() == "quagmire" then
			if self.owner.HUD:IsStatusScreenOpen() then
				TheFrontEnd:PopScreen()
			end
			TheFrontEnd:PushScreen(QuagmireRecipeBookScreen(self.owner))
		elseif not GetGameModeProperty("no_minimap") then
			if self.owner.HUD:IsStatusScreenOpen() then
				TheFrontEnd:PopScreen()
			end
			TheFrontEnd:PushScreen(MapScreen(self.owner))
		end
    end
end

function Controls:HideMap()
    if self.owner ~= nil and self.owner.HUD ~= nil and self.owner.HUD:IsMapScreenOpen() then
        TheFrontEnd:PopScreen()
    end
end

function Controls:ToggleMap()
    if self.owner ~= nil and self.owner.HUD ~= nil then
		if TheNet:GetServerGameMode() == "quagmire" then
			if self.owner.HUD:IsMapScreenOpen() then
				TheFrontEnd:PopScreen()
			elseif self.owner.components.playercontroller ~= nil and self.owner.components.playercontroller:IsMapControlsEnabled() then
				if self.owner.HUD:IsStatusScreenOpen() then
					TheFrontEnd:PopScreen()
				end
				TheFrontEnd:PushScreen(QuagmireRecipeBookScreen(self.owner))
			end
		elseif not GetGameModeProperty("no_minimap") then
			if self.owner.HUD:IsMapScreenOpen() then
				TheFrontEnd:PopScreen()
			elseif self.owner.components.playercontroller ~= nil and self.owner.components.playercontroller:IsMapControlsEnabled() then
				if self.owner.HUD:IsStatusScreenOpen() then
					TheFrontEnd:PopScreen()
				end
				TheFrontEnd:PushScreen(MapScreen(self.owner))
			end
		end
    end
end

function Controls:ShowCraftingAndInventory()
    if not self.craftingandinventoryshown then
        self.craftingandinventoryshown = true
        if not GetGameModeProperty("no_crafting") then
            self.crafttabs:Show()
        end
        self.inv:Show()
        self.containerroot_side:Show()
        self.item_notification:ToggleCrafting(false)
        if self.status.ToggleCrafting ~= nil then
            self.status:ToggleCrafting(false)
        end
    end
end

function Controls:HideCraftingAndInventory()
    if self.craftingandinventoryshown then
        self.craftingandinventoryshown = false
        if self.owner ~= nil and self.owner.HUD ~= nil then
            if self.owner.HUD:IsControllerCraftingOpen() then
                self.owner.HUD:CloseControllerCrafting()
            end
            if self.owner.HUD:IsControllerInventoryOpen() then
                self.owner.HUD:CloseControllerInventory()
            end
        end
        self.crafttabs:Hide()
        self.inv:Hide()
        self.containerroot_side:Hide()
        self.item_notification:ToggleCrafting(true)
        if self.status.ToggleCrafting ~= nil then
            self.status:ToggleCrafting(true)
        end
    end
end

return Controls
