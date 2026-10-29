// Creates a new font with the following properties.
surface.CreateFont("waypointFont", {
    font = "Arial",
    size = 18,
    antialias = true,
    weight = 700
})


hook.Add("HUDPaint", "plyWaypoints", function() // Draws whats defined inside the hook every single frame.
    local scrw, scrh = ScrW(), ScrH() // Storing the client's  screen width and height in these easy to call variables.
    local myPos = LocalPlayer():GetPos() // Gets the local players position coords - the players x, y and z.
    for i, ply in pairs(player.GetAll()) do // Creates a loop that runs through the table of players currently ingame.
        if ply == LocalPlayer() then continue end // If the player is the local player then skip them. This is so the waypoint doesn't get drawn on themself.
        local plyPos = ply:GetPos() // Gets the player position.
        local headPos = plyPos + Vector(0, 0, 80) // Creates a new variable, with the plyPos Z coord upwards by 80.
        local distance = myPos:Distance(plyPos) // Creates a variable that stores the local players distance from the current players position we are targetting.
        local screenPos = headPos:ToScreen() // Converts the headPos vector to a 2D screen object.

        if distance <= 2950 then // If the distance between the Local Player and player we are targetting on the table is less than or equal to 2950, then...
            surface.SetDrawColor(0,0,0,200) // Sets the colour of what we draw to a slightly opaque black.
            surface.DrawRect(screenPos.x - scrw * .015, screenPos.y - scrh * .01, scrw * .03, scrh * .02) // Draws a rectangle on the properties defined.
            draw.SimpleText(ply:Nick(), "waypointFont", screenPos.x, screenPos.y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER) // Draws text on the properties defined.
        end
    end
end)

hook.Add("HUDPaint", "spawnWaypoint", function()
    local spawnPos = Vector(708, 367, -79)
    local spawnToScreen = spawnPos:ToScreen()
    local plyPos = LocalPlayer():GetPos()
    local distanceFromSpawn = plyPos:Distance(spawnPos)
    local metres = math.Round(distanceFromSpawn / 40)

    if distanceFromSpawn <= 2950 then
        surface.SetDrawColor(0,0,0,200)
        surface.DrawRect(spawnToScreen.x - 50, spawnToScreen.y - 15, 100, 30)
        draw.SimpleText("Spawn: " .. metres .. "m", "waypointFont", spawnToScreen.x, spawnToScreen.y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end)