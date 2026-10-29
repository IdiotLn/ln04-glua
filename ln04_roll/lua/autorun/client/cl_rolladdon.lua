local diceRollName
local diceRollNum
local diceRollString = " rolled the dice and got a "
local scrw, scrh = ScrW(), ScrH()

surface.CreateFont("nameAndNumber", {
    font = "Roboto",
    size = 32,
    weight = 1000,
    antialias = true,
    underline = true,
})

surface.CreateFont("stringText", {
    font = "Roboto",
    size = 32,
    weight = 700,
    antialias = true
})

surface.CreateFont("nameAndNumberBlur", {
    font = "Roboto",
    size = 32,
    weight = 1000,
    antialias = true,
    blursize = 7
})

surface.CreateFont("stringTextBlur", {
    font = "Roboto",
    size = 32,
    weight = 700,
    antialias = true,
    blursize = 5
})

net.Receive("diceRoll", function()
    diceRollName = net.ReadString()
    diceRollNum = net.ReadString()
    timer.Create("rollTimer", 5, 1, function()
        diceRollName = nil
        diceRollNum = nil
    end)
end)

hook.Add("HUDPaint", "diceRollBroadcast", function()
    if diceRollNum ~= nil then

        surface.SetFont("nameAndNumber")
        local nameW = surface.GetTextSize(diceRollName)
        local numW = surface.GetTextSize(diceRollNum)

        surface.SetFont("stringText")
        local stringW = surface.GetTextSize(diceRollString)

        local lineW = stringW + numW + nameW
        local lineStart =  scrw * .5 - (lineW / 2)
        local boxW = lineW + lineW * .3

        surface.SetDrawColor(0,0,0,220)
        surface.DrawRect(scrw * .5 - boxW * .5, scrh * .06, boxW, scrh * .05)

        // blur background
        draw.SimpleText(diceRollName, "nameAndNumberBlur", lineStart, scrh * .085, Color(255,174,0,160), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(diceRollString, "stringTextBlur", lineStart + nameW, scrh * .085, Color(255,255,255,100), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(diceRollNum, "nameAndNumberBlur", lineStart + nameW + stringW, scrh * .085, Color(0,248,132,160), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        // base text
        draw.SimpleText(diceRollName, "nameAndNumber", lineStart, scrh * .085, Color(255,174,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(diceRollString, "stringText", lineStart + nameW, scrh * .085, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(diceRollNum, "nameAndNumber", lineStart + nameW + stringW, scrh * .085, Color(0,248,132), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
end)

