require "src.lib.UI"
require "src.game.Shop"
require "src.lib.Save"

function love.load()
    clickerpower = 0.7
    cps = 0.5
    timer = 0
    money = 150
    Cclock = 0
    isup = false
    basic_cost = 50
    swarm_cost = 10

    Game = UIElements.Frame:new()
    Game:SetActiveState(true)
    Cash_icon = UIElements.Image:new(love.graphics.newImage("src/assets/icons/clicker.png"), {10, 10}, {0.125, 0.125})
    Cash_display = UIElements.Label:new(": " .. money, {90, 10}, {0, 50}, {0, 0, 1})

    Game:AddElement(Cash_display)
    Game:AddElement(Cash_icon)

    Cpsicon = UIElements.Image:new(love.graphics.newImage("src/assets/icons/swarm.png"), {0, 60}, {0.18/4.8,0.18/4.8})

    Game:AddElement(Cpsicon)
    Game:AddElement(UIElements.Label:new(": " .. cps, {90, 65}, {0, 50}, {0, 0, 1}))

    

    
    CalcImage = UIElements.Image:new(love.graphics.newImage("src/assets/clickers/calc.png"), {200, 50}, {0.4,0.4})
    Calc = UIElements.Imagebutton:new(CalcImage)
    Game:AddElement(Calc)

    ShopIcon = UIElements.Image:new(love.graphics.newImage("src/assets/icons/ShopIcon.png"), {720, 0}, {0.2,0.2})
    ExitIcon = UIElements.Image:new(love.graphics.newImage("src/assets/icons/Exiticon.png"), {720, 0}, {0.2,0.2})
    Shopbutton = UIElements.Imagebutton:new(ShopIcon)

    SaveIcon = UIElements.Image:new(love.graphics.newImage('src/assets/icons/SaveIcon.png'),{710,500},{.25,.25})
    SaveButton = UIElements.Imagebutton:new(SaveIcon)
    Game:AddElement(SaveButton)

    font = love.graphics.newFont("src/assets/Sigmar-Regular.ttf",28)
    love.graphics.setFont(font)
    FransShop.Load()
    
    Savefile = Save.LoadSave()
    cps = Savefile.cps
    MacWheelCost = Savefile.MacWheelCost
    swarm_cost = Savefile.swarm_cost
    money = Savefile.money
    MacPointerCost = Savefile.MacPointerCost
    clickerpower = Savefile.clickerpower
    basic_cost = Savefile.basic_cost
end

function love.update()
    FransShop.Update()

    Game.ElementContents[1].Text = ": " .. math.floor(money)
    Game.ElementContents[4].Text = ": " .. cps
    funges()
    --[[if Collision(700, 22, 100, 95) and love.mouse.isDown(1) and isup == false then
        buyitem("clickerpower")
        isup = true
    end
    if Collision(700, 150, 100, 95) and love.mouse.isDown(1) and isup == false then
        buyitem("cps")
        isup = true
    end]]--
end

function funges()
    timer = timer + 0.5
    if timer == 60 then
        money = money + cps
        timer = 0
    end

    Calc:IsTriggered(function ()
        money = money + clickerpower
        print(money)
    end, {Pos2D = {75, 0}, Scale2D = {345,470}})

    Shopbutton:IsTriggered(function ()
        Shop:SetActiveState(not Shop.IsActive)
        Game:SetActiveState(not Game.IsActive)

        if Game.IsActive == true then
            Shopbutton.image = ShopIcon
        else
            Shopbutton.image = ExitIcon
        end
    end, {Pos2D = {0, 0}, Scale2D = {100, 85}})

    SaveButton:IsTriggered(function () --TODO make it dictonary
        Save.SaveGame({
            cps = cps,
            MacWheelCost = MacWheelCost,
            swarm_cost = swarm_cost,
            money = money,
            MacPointerCost = MacPointerCost,
            clickerpower = clickerpower,
            basic_cost = basic_cost,
        })
        
    end, {Pos2D = {0,0}, Scale2D = {100, 95}})

    if not love.mouse.isDown(1) then
        isup = false
    end
end

--[[function Collision(x, y, ScaleX, ScaleY)
    if love.mouse.getX() > x and love.mouse.getX() < x + ScaleX then
        if love.mouse.getY() > y and love.mouse.getY() < y + ScaleY then
            return true
        end
    end
    return false
end--]]

function love.draw()
    love.graphics.setBackgroundColor(.8, 1, 1)

    Shop:Draw(function ()
        love.graphics.setColor(.3, 0.3, 0.3)
        love.graphics.rectangle("fill", 0, 0, 800, 800)
    end)
    Game:Draw()

    Cash_display:Draw()
    Shopbutton:Draw()
end