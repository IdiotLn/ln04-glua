util.AddNetworkString("diceRoll")
local rollCommand = "!roll"
local lastRoll = {}

hook.Add("PlayerSay", "rollCommand", function(ply, text)
    if string.lower(text) == rollCommand then
        if lastRoll[ply] ~= nil and CurTime() - lastRoll[ply] < 60 then
            ply:ChatPrint("Please wait before rolling again.")
            return
        end

        lastRoll[ply] = CurTime()
        local diceNum = math.random(1, 100)
        local plyName = ply:Nick()
        ply:ChatPrint("You rolled a " .. diceNum)
        net.Start("diceRoll")
        net.WriteString(plyName)
        net.WriteString(tostring(diceNum))
        net.Broadcast()
    end
end)
