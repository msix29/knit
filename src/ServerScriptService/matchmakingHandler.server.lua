local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")

local knit = require(replicatedStorage.modules.packages.Knit)

local commands = {
    "joinqueue",
    "leavequeue",
}

local prefix = "/"

for _ , v in pairs(game:GetService("ServerStorage").services:GetChildren()) do
    if v:IsA("ModuleScript") then
        require(v)
    end
end

knit.Start()

local matchmakingService = knit.GetService("matchmakingService")

players.PlayerAdded:Connect(function(player)
    matchmakingService:AddToQueue(player)
end)

-- players.PlayerAdded:Connect(function(player)
--     player.Chatted:Connect(function(message)
--         local splits = message:split(" ")
--         splits[1] = splits[1]:lower()

--         local index = table.find(commands , splits[1]:sub(2 , #message))
--         if not index then return end

--         local command = prefix..commands[index]
--         if command ~= splits[1] then return end

--         local functionToCall = index == 1 and matchmakingService.AddToQueue or matchmakingService.RemoveFromQueue
--         functionToCall(matchmakingService , player)
--     end)
-- end)