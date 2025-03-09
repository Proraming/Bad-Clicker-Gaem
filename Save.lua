require "SaveFile"

Save = {}

function Save.LoadSave()
    return Player
end

function Save.SaveGame(Player)
    file = io.open("SaveFile.lua",'w')
    file:write(
    "Save = {}\n"..
    "--REMINDER DO NOT OFFSET PLAYER AT ALL\n"..
    " \n"..
    "Player = {\n"..
    "    cps = " .. Player.cps..",".."\n"..
    "    MacWheelCost = " .. Player.MacWheelCost..",".."\n"..
    "    swarm_cost = " .. Player.swarm_cost..",".."\n"..
    "    money = " .. Player.money..",".."\n"..
    "    MacPointerCost = " .. Player.MacPointerCost..",".."\n"..
    "    clickerpower = " .. Player.clickerpower..",".."\n"..
    "    basic_cost = " .. Player.basic_cost..",".."\n"..
    "}\n"..
    "return Player")
end

return Save