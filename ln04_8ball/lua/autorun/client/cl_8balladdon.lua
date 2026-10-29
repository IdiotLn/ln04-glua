net.Receive("8ballSend", function()
    local plyName = net.ReadString()
    local plyQuestion = net.ReadString()
    local ballAnswer = net.ReadString()

    chat.AddText(plyName, " asked: ", Color(100,255,100), plyQuestion)
    chat.AddText(Color(255,200,100), "[8Ball] ", Color(100,255,100), ballAnswer)
end)