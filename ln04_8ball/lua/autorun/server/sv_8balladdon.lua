util.AddNetworkString("8ballSend")
local ballAnswers = {"Yes!", "Maybe so.", "Probably!", "Now is not the time to ask that...", "Absolutely not!", "No."}
local cmdCd = {}

hook.Add("PlayerSay", "8ballCmd", function(ply, text)
    local stringSplit = string.Split(text, " ")
    local plyCmd = stringSplit[1]
    local stringCon = table.concat(stringSplit, " ", 2)

    if string.lower(plyCmd) == "!8ball" then

        if stringCon ~= "" then
            if cmdCd[ply] and CurTime() - cmdCd[ply] < 30 then
                ply:ChatPrint("You must wait " .. math.ceil(30 - (CurTime() - cmdCd[ply])) .. "s, before using this command again.")
                return ""
            end

            cmdCd[ply] = CurTime()
            net.Start("8ballSend")
            net.WriteString(ply:Name())
            net.WriteString(stringCon)
            net.WriteString(ballAnswers[math.random(#ballAnswers)])
            net.Broadcast()
        else
            ply:ChatPrint("You must ask a question.")
        end

        return ""
    end
end)

hook.Add("PlayerDisconnected", "cmdRm", function(ply)
    cmdCd[ply] = nil
end)