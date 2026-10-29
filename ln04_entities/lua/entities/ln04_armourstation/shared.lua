ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Armour Station"
ENT.Author = "Ln04"
ENT.Category = "Ln04's Entities"
ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "Charges")
end