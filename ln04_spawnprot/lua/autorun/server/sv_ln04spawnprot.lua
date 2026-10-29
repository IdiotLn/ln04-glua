util.AddNetworkString("spawnProtCount")

hook.Add("PlayerSpawn", "ln04_playerSpawn", function(ply)
    net.Start("spawnProtCount")
    net.Send(ply)
    ply:GodEnable()

    timer.Create("ln04_" .. ply:SteamID64(), 10, 1, function()
        if IsValid(ply) then
            ply:GodDisable()
        end
    end)
end)