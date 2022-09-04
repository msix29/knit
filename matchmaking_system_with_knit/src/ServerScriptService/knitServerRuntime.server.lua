local replicatedStorage = game:GetService("ReplicatedStorage")

local knit = require(replicatedStorage.modules.packages.Knit)

for _ , v in pairs(game:GetService("ServerStorage").services:GetChildren()) do
	if v:IsA("ModuleScript") then
		require(v)
	end
end

knit.Start()