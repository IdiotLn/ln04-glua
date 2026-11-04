hook.Add("HUDShouldDraw", "ln04_removehud", function(name)
    if name == "CHudHealth" then
        return false
    end

    if name == "CHudBattery" then
        return false
    end
end)

surface.CreateFont("nameFont", {
    font = "Roboto-Black",
    size = 26,
    weight = 800,
    antialias = true,
    shadow = true
})

surface.CreateFont("idFont", {
    font = "Roboto",
    size = 20,
    weight = 600,
    antialias = true
})

surface.CreateFont("barFont", {
    font = "Roboto",
    size = 18,
    weight = 1000,
    antialias = true
})

local avatar

hook.Add("HUDPaint", "ln04_newhud", function()
    if not IsValid(avatar) then -- if avatar has not been assigned any data, then run the following. This is to avoid LocalPlayer() running too early.
        avatar = vgui.Create("AvatarImage")
        avatar:SetSize(62, 62)
        avatar:SetPlayer(LocalPlayer(), 64)
    end
    
    local scrw,scrh = ScrW(),ScrH()
    local boxw,boxh = 500,240
    local boxx,boxy = 10,scrh - boxh - 10
    local health = math.Clamp(LocalPlayer():Health(), 0, LocalPlayer():GetMaxHealth())
    local healthw = (boxw - 30) * (health / LocalPlayer():GetMaxHealth())
    local armor = math.Clamp(LocalPlayer():Armor(), 0, LocalPlayer():GetMaxArmor())
    local armorw = (boxw - 30) * (armor / LocalPlayer():GetMaxArmor())

    draw.RoundedBox(10,boxx,boxy,boxw,boxh,Color(25,25,30, 200)) -- background

    surface.SetDrawColor(210, 210, 210)
    surface.DrawRect(boxx + 19, boxy + 19, 64, 64) -- avatar outline
    avatar:SetPos(boxx + 20, boxy + 20)

    draw.SimpleText(LocalPlayer():Nick(), "nameFont", boxx + 100, boxy + 47, Color(210, 210, 210), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) -- steam name
    draw.SimpleText(LocalPlayer():SteamID(), "idFont", boxx + 100, boxy + 75, Color(140, 140, 140), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) -- steam id

    surface.SetDrawColor(255, 255, 255, 5)
    surface.DrawRect(boxx + 15, boxy + 105, boxw - 30, 2) -- divider

    draw.SimpleText("HEALTH", "barFont", boxx + 15, boxy + 135, Color(140,140,140), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    draw.SimpleText(LocalPlayer():Health(), "barFont", boxw - 5, boxy + 135, Color( 210, 210, 210), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    surface.SetDrawColor(255, 255, 255, 5)
    surface.DrawRect(boxx + 15, boxy + 150, boxw - 30, 10)
    surface.SetDrawColor(50,220,170)
    surface.DrawRect(boxx + 15, boxy + 150, healthw, 10)

    draw.SimpleText("ARMOR", "barFont", boxx + 15, boxy + 190, Color(140,140,140), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    draw.SimpleText(LocalPlayer():Armor(), "barFont", boxw - 5, boxy + 190, Color( 210, 210, 210), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    surface.SetDrawColor(255, 255, 255, 5)
    surface.DrawRect(boxx + 15, boxy + 205, boxw - 30, 10)
    surface.SetDrawColor(50,170,220)
    surface.DrawRect(boxx + 15, boxy + 205, armorw, 10)
end)