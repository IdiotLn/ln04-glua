AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_combine/suit_charger001.mdl")

    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    self:SetUseType(SIMPLE_USE)
    self:PhysWake()

    self:SetCharges(3)
    self.lastUse = {}
end

function ENT:Use(act)

    if act:IsPlayer() then
        if self:GetCharges() == 0 then
            act:ChatPrint("This station is empty!")
            return
        end

        if self.lastUse[act] and CurTime() - self.lastUse[act] < 10 then
            local timeLeft = math.ceil(10 - (CurTime() - self.lastUse[act]))
            act:ChatPrint("Please wait " .. timeLeft .. " seconds.")
            return
        end
        
        if act:Armor() < act:GetMaxArmor() then
            act:SetArmor(math.Clamp(act:Armor() + 25, 0, act:GetMaxArmor()))
            act:ChatPrint("You have equipped +25 armor!")
            self:SetCharges(self:GetCharges() - 1)
            self.lastUse[act] = CurTime()  
        else
            act:ChatPrint("You are already at max armor!")        
        end
    end

end

hook.Add("PlayerSay", "refillCmd", function(ply, text)
    
    if string.lower(text) == "!refill" then
        if ply:IsAdmin() then
            local stations = ents.FindByClass("ln04_armourstation")

            for i, station in ipairs(stations) do
                station:SetCharges(3)
            end

            PrintMessage(HUD_PRINTTALK, #stations .. " stations have been refilled!")
            return ""
        else
            ply:ChatPrint("You may not use this command.")
            return ""
        end
    end

end)