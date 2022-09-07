### Matchmaking system fully made with knit.
Feel free to use it and edit it to your likings but please note that this system wasn't designed for a full game, it's just a demo.
## Using the system for testing.
# With Rojo
Just download the file "matchmaking_system_with_knit" and put it as your project file, after it, either build a project file with it or just run rojo to add these files
# With roblox studio
Open matchmaking_system_with_knit.src and copy the files inside each folder to it's name in roblox studio, ex: matchmaking_system_with_knit.src.ReplicatedStorage will go in game.ReplicatedStorage, same with other files.
## Editing the system
To edit the settings, change the starting settings, go to matchmaking_system_with_knit.src.ServerStorage.services.matchmakingService.lua and change line 24, 27 and 28 to match your liking.
To add gamemodes (Winning logics), open matchmaking_system_with_knit.src.ServerStorage.modules.winningLogic.lua change the function "winningLogics.createLogic" to match your likings, remeber to insert the winners in "winningLogics.winners", that table will be reset every round.