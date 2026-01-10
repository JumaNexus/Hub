local placeId = game.PlaceId

local games = {
    [101953168527257] = "https://raw.githubusercontent.com/JumaNexus/Spear-Fishing/refs/heads/main/main.lua",
    [92122513197996] = "https://raw.githubusercontent.com/JumaNexus/Hub/refs/heads/main/dte.lua",
    [96645548064314] = "https://raw.githubusercontent.com/JumaNexus/Catch-And-Tame/refs/heads/main/main.lua",
    [109008444518106] = "https://raw.githubusercontent.com/JumaNexus/Hub/refs/heads/main/bap.lua",
}

if games[placeId] then
    loadstring(game:HttpGet(games[placeId]))()
end
