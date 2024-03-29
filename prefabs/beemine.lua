require "prefabutil"

local function SpawnBees(inst, target)
    inst.SoundEmitter:PlaySound("dontstarve/bee/beemine_explo")
    if target == nil or not target:IsValid() then
        target = FindEntity(inst, 25, nil, nil, { "insect", "playerghost" }, { "character", "animal", "monster" })
    end
    if target ~= nil then
        for i = 1, TUNING.BEEMINE_BEES do
            local bee = SpawnPrefab(inst.beeprefab)
            if bee ~= nil then
                local x, y, z = inst.Transform:GetWorldPosition()
                local dist = math.random()
                local angle = math.random() * 2 * PI
                bee.Physics:Teleport(x + dist * math.cos(angle), y, z + dist * math.sin(angle))
                if bee.components.combat ~= nil then
                    bee.components.combat:SetTarget(target)
                end
            end
        end
        target:PushEvent("coveredinbees")
    end
end

local function OnExplode(inst)
    if inst.rattletask ~= nil then
        inst.rattletask:Cancel()
        inst.rattletask = nil
    end
    if inst.spawntask ~= nil then -- We've already been told to explode
        return
    end
    inst.components.workable:SetWorkable(false)
    inst.AnimState:PlayAnimation("explode")
    inst.SoundEmitter:PlaySound("dontstarve/bee/beemine_launch")
    inst.spawntask = inst:DoTaskInTime(9 * FRAMES, SpawnBees, inst.components.mine:GetTarget())
    inst:ListenForEvent("animover", inst.Remove)
    inst:RemoveComponent("inventoryitem")
    inst:RemoveComponent("mine")
    inst.persists = false
    inst.Physics:SetActive(false)
    --V2C: mine is lost if save happens during these 9 frames
    --     but better than loading back into an invalid state
end

local function onhammered(inst, worker)
    if inst.components.mine ~= nil then
        inst.components.mine:Explode(worker)
    end
end

local function MineRattle(inst)
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle", false)
    inst.SoundEmitter:PlaySound("dontstarve/bee/beemine_rattle")
    inst.rattletask = inst:DoTaskInTime(4 + math.random(), MineRattle)
end

local function StartRattling(inst)
    if inst.rattletask ~= nil then
        inst.rattletask:Cancel()
    end
    inst.rattletask = inst:DoTaskInTime(1, MineRattle)
end

local function StopRattling(inst)
    if inst.rattletask ~= nil then
        inst.rattletask:Cancel()
        inst.rattletask = nil
    end
end

local function ondeploy(inst, pt, deployer)
    inst.components.mine:Reset()
    inst.Physics:Stop()
    inst.Physics:Teleport(pt:Get())
end

local function SetActive(inst)
    if inst.components.inventoryitem ~= nil then
        inst.components.inventoryitem.nobounce = true
    end
    StartRattling(inst)
end

local function SetInactive(inst)
    if inst.components.inventoryitem ~= nil then
        inst.components.inventoryitem.nobounce = false
    end
    inst.AnimState:PlayAnimation("inactive")
    StopRattling(inst)
end

local function OnDropped(inst)
    inst.components.mine:Deactivate()
end

local function OnHaunt(inst, haunter)
    if inst.components.mine == nil or inst.components.mine.inactive then
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_TINY
        Launch(inst, haunter, TUNING.LAUNCH_SPEED_SMALL)
        return true
    elseif inst.components.mine.issprung then
        return false
    elseif math.random() <= TUNING.HAUNT_CHANCE_RARE then
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_MEDIUM
        inst.components.mine:Explode(nil)
        return true
    elseif inst.rattletask ~= nil then
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_TINY
        inst.rattletask:Cancel()
        MineRattle(inst)
        return true
    end
    return false
end

local function BeeMine(name, alignment, skin, spawnprefab, isinventory)
    local assets =
    {
        Asset("ANIM", "anim/"..skin..".zip"),
        Asset("SOUND", "sound/bee.fsb"),
    }
    if name ~= "beemine" then
        table.insert(assets, Asset("MINIMAP_IMAGE", "beemine"))
    end

    local prefabs =
    {
        spawnprefab,
    }

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddMiniMapEntity()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        inst.MiniMapEntity:SetIcon("beemine.png")

        inst.AnimState:SetBank(skin)
        inst.AnimState:SetBuild(skin)
        inst.AnimState:PlayAnimation("inactive")

        inst:AddTag("mine")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("mine")
        inst.components.mine:SetOnExplodeFn(OnExplode)
        inst.components.mine:SetAlignment(alignment)
        inst.components.mine:SetRadius(TUNING.BEEMINE_RADIUS)
        inst.components.mine:SetOnResetFn(SetActive)
        inst.components.mine:SetOnSprungFn(SetActive)
        inst.components.mine:SetOnDeactivateFn(SetInactive)

        inst.beeprefab = spawnprefab

        inst:AddComponent("inspectable")
        inst:AddComponent("lootdropper")
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(1)
        inst.components.workable:SetOnFinishCallback(onhammered)

        if isinventory then
            inst:AddComponent("inventoryitem")
            inst.components.inventoryitem:SetOnPutInInventoryFn(StopRattling)
            inst.components.inventoryitem:SetOnDroppedFn(OnDropped)

            inst:AddComponent("deployable")
            inst.components.deployable.ondeploy = ondeploy
            inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.LESS)
        end

        inst:AddComponent("hauntable")
        inst.components.hauntable:SetOnHauntFn(OnHaunt)

        inst.components.mine:Reset()

        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

return BeeMine("beemine", "player", "bee_mine", "bee", true),
    MakePlacer("beemine_placer", "bee_mine", "bee_mine", "idle"),
    BeeMine("beemine_maxwell", "nobody", "bee_mine_maxwell", "mosquito", false)
