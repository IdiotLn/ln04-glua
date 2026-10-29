local endTime = 0

net.Receive("spawnProtCount", function()
    endTime = CurTime() + 10
end)

hook.Add("HUDPaint", "spawnProtHud", function()
    if CurTime() < endTime then
        local scrw,scrh = ScrW(),ScrH()
        local boxw,boxh = scrw * .1,scrh * .04
        local timeLeft = math.ceil(endTime - CurTime())
        local textAlpha = math.abs(math.sin(CurTime() * 2)) * 255 

        surface.SetDrawColor(0,0,0,180)
        surface.DrawRect(scrw * .5 - (boxw * .5), scrh * .95 - (boxh * .5), boxw, boxh)
        draw.SimpleText("SPAWN PROTECTION: " .. timeLeft .. "s", "DermaLarge", scrw * .5, scrh * .95, Color(200,200,0, textAlpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

end)