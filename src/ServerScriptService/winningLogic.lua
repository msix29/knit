local winningLogics = {
    winners = {}
}

local players = game:GetService("Players")

function winningLogics.createLogic()
    winningLogics.winners = {}
    for _ , v in pairs(players:GetPlayers()) do
        table.insert(winningLogics.winners , v.UserId)
    end
end

function winningLogics:GetWinners()
    return self.winners
end

return winningLogics