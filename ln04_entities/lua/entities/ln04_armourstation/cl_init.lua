include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

hook.Add("HUDPaint", "armour_hud", function()
    local ent = LocalPlayer():GetEyeTrace().Entity

    if IsValid(ent) and ent:GetClass() == "ln04_armourstation" and LocalPlayer():GetPos():Distance(ent:GetPos()) < 150 then
        draw.SimpleText("Charges: " .. ent:GetCharges() .. "/3", "DermaLarge", ScrW() * .5, ScrH() * .55, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

end)