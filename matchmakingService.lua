local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

local winningLogicsModule = require(game:GetService("ServerScriptService").winningLogic)

local maps = {
    {
        name = "lobby",
        part = workspace.lobby
    },
    {
        name = "map1",
        part = workspace.map1
    }
}

local knit = require(replicatedStorage.modules.packages.Knit)

local matchmakingService = knit.CreateService {
    Name = "matchmakingService",
    Client = {},
    inQueue = {},
    minimumPlayers = 0,
    status = "Waiting for players...",
    timeSettings = {
        betweenRounds = 1,
        roundTime = 1
    }
}

local function _leaveQueue(userId)
    local player = players:GetPlayerByUserId(userId)
    if matchmakingService.status == "Waiting for players..." then return end
    
    local character = player.Character or player.CharacterAdded:Wait()
    character.PrimaryPart.CFrame = maps[1].part.CFrame * CFrame.new(0 , 4 , 0)
end

function _chooseMap()
    return maps[math.random(2 , #maps)]
end

function _endGame()
    local inQueue = matchmakingService.inQueue
    for _ , v in pairs(inQueue) do
        matchmakingService:RemoveFromQueue(v)
    end
    matchmakingService.status = "Waiting for players..."

    task.spawn(function()
        task.wait(matchmakingService.timeSettings.betweenRounds)
        local winners = winningLogicsModule:GetWinners()
        
        for i , v in pairs(winners) do
            local player = players:GetPlayerByUserId(v)
            if not player then continue end
            print(player.Name.." is number : "..i)
        end

        for _ , v in pairs(players:GetPlayers()) do
            matchmakingService:AddToQueue(v)
        end
    end)
end

local function _joinGame()
    local inQueue = matchmakingService.inQueue
    if #inQueue < matchmakingService.minimumPlayers then return end

    for _ , v in pairs(inQueue) do
        local player = players:GetPlayerByUserId(v)
        local map = _chooseMap()
        local character = player.Character or player.CharacterAdded:Wait()
        character.PrimaryPart.CFrame = map.part.CFrame * CFrame.new(0 , 4 , 0)
    end

    matchmakingService.status = "In game."
    winningLogicsModule.createLogic()
    task.spawn(function()
        task.wait(matchmakingService.timeSettings.roundTime)
        _endGame()
    end)
end

function matchmakingService:RemoveFromQueue(userId)
    if typeof(userId) == "Instance" then userId = userId.UserId end
	table.remove(self.inQueue , table.find(self.inQueue , userId))
    _leaveQueue(userId)
end

function matchmakingService:AddToQueue(player: Player)
	self:RemoveFromQueue(player.UserId)
    table.insert(self.inQueue , player.UserId)
    _joinGame()
end

function matchmakingService:GetStatus()
    return self.status
end

function matchmakingService.Client:GetStatus()
    return self.status
end

function matchmakingService.Client:AddToQueue(...)
    print(...)
    self.Server:AddToQueue(...)
    return
end

function matchmakingService.Client:RemoveFromQueue(...)
    print(...)
    self.Server:RemoveFromQueue(...)
end

return matchmakingService