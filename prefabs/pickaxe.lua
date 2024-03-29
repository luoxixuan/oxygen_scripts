local assets =
{
    Asset("ANIM", "anim/pickaxe.zip"),
    Asset("ANIM", "anim/goldenpickaxe.zip"),
    Asset("ANIM", "anim/swap_pickaxe.zip"),
    Asset("ANIM", "anim/swap_goldenpickaxe.zip"),
}

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_pickaxe", "swap_pickaxe")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function common_fn(bank, build)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank(bank)
    inst.AnimState:SetBuild(build)
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("sharp")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -----
    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.MINE)

    -------
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.PICKAXE_USES)
    inst.components.finiteuses:SetUses(TUNING.PICKAXE_USES)
    inst.components.finiteuses:SetOnFinished(inst.Remove) 
    inst.components.finiteuses:SetConsumption(ACTIONS.MINE, 1)

    -------
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.PICK_DAMAGE)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

    inst:AddComponent("equippable")

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)

    return inst
end

local function onequipgold(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_goldenpickaxe", "swap_goldenpickaxe")
    owner.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function normal()
    return common_fn("pickaxe", "pickaxe")
end

local function golden()
    local inst = common_fn("goldenpickaxe", "goldenpickaxe")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.finiteuses:SetConsumption(ACTIONS.MINE, 1 / TUNING.GOLDENTOOLFACTOR)
    inst.components.weapon.attackwear = 1 / TUNING.GOLDENTOOLFACTOR

    inst.components.equippable:SetOnEquip(onequipgold)

    return inst
end

return Prefab("pickaxe", normal, assets),
    Prefab("goldenpickaxe", golden, assets)