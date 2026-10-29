surface.CreateFont("idTitles", { // creates custom font.
    font = "Arial",
    size = 28,
    weight = 1000,
    antialias = true,
})

local idPanel // creates empty variable.

hook.Add("OnPlayerChat", "idCommand", function(ply, text, bTeam, bDead)
    local scrw, scrh = ScrW(), ScrH()
    local sizeW = scrw * .27
    local sizeH = scrh * .27

    if ply ~= LocalPlayer() and string.lower(text) == "!showid" then 
        return true // stops message from showing in chat.
    end

    if bDead == true and string.lower(text) == "!showid" then
        return true // stops message from showing in chat.
    end

    if string.lower(text) == "!showid" then
        if IsValid(idPanel) then return true end // if idPanel is already showing on screen, then stop here.
        idPanel = vgui.Create("DFrame")
        idPanel:SetSize(sizeW, sizeH)
        idPanel:Center()
        idPanel:MakePopup()
        idPanel:SetTitle("")
        idPanel:ShowCloseButton(true)

        function idPanel:Paint(w, h)
            surface.SetDrawColor(0,0,0,150)
            surface.DrawRect(0, 0, w, h)
        end

        local modelPanel = vgui.Create("DPanel", idPanel)
        modelPanel:SetSize(sizeW * .38, sizeH * .8)
        modelPanel:SetPos(sizeW * .03, sizeH * .09)

        function modelPanel:Paint(w,h)
            surface.SetDrawColor(0,0,0,100)
            surface.DrawRect(0,0,w,h)
        end

        local showModel = vgui.Create("DModelPanel", modelPanel)
        showModel:SetSize(sizeW * .38, sizeH * .8)
        showModel:SetPos(0,0)
        showModel:SetModel(LocalPlayer():GetModel())
        local headBone = showModel:GetEntity():LookupBone("ValveBiped.Bip01_Head1") // gets the entity attached to showModel and finds the head bone.
        local headBonePos = showModel:GetEntity():GetBonePosition(headBone) // gets the position (the vector) of the head bone.
        function showModel:LayoutEntity(entity) return end // overrides the model spin.
        showModel:SetLookAt(headBonePos) // faces the camera towards the headbone position.
        showModel:SetCamPos(Vector(15,0,0) + headBonePos) // sets the position of the camera.
        showModel:GetEntity():SetEyeTarget(showModel:GetCamPos()) // makes the model look at the camera.

        local textPanel = vgui.Create("DPanel", idPanel)
        textPanel:SetSize(sizeW * .5, sizeH * .8)
        textPanel:SetPos(sizeW * .47, sizeH * .09)

        function textPanel:Paint(w,h)
        local plyData = { // a table of values allowing for a loop.
            {label = "NAME", value = ply:Nick()},
            {label = "STEAM ID", value = ply:SteamID()},
            {label = "USER GROUP", value = string.upper(ply:GetUserGroup())}
            }

        local ypos = 5
        for _, item in ipairs(plyData) do // loops through the table until done.
            draw.DrawText(item.label, "idTitles", 10, ypos, Color(190,190,190), TEXT_ALIGN_LEFT)
            draw.DrawText(item.value, "idTitles", 10, ypos + 30, Color(255,255,255), TEXT_ALIGN_LEFT)
            ypos = ypos + 80
        end

        draw.DrawText("HEALTH", "idTitles", 10, ypos, Color(190,190,190), TEXT_ALIGN_LEFT)
        surface.SetDrawColor(30,0,0,100)
        surface.DrawRect(10, ypos + 30, 300, 50)
        surface.SetDrawColor(255,50,50,255)
        surface.DrawRect(10, ypos + 30, 300 * math.Clamp(ply:Health() / ply:GetMaxHealth(), 0, 1), 50) // draws player health in a rectangle, math.Clamp keeps the number within 0 - 1.
        end

        return true
    end
end)