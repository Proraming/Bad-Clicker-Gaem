require "UI"

function love.load()
    
    clickerpower = 1
    cps = 1
    timer = 0
    money = 0
    Cclock = 0
    isup = false
    basic_cost = 50
    swarm_cost = 10

    Shop = UIElements.Frame:new()
    Shop:SetActiveState(true)

    Game = UIElements.Frame:new()
    Game:SetActiveState(true)
    Cash_icon = UIElements.Image:new(love.graphics.newImage("clicker.png"), {10, 10}, {0.125, 0.125})
    Cash_display = UIElements.Label:new(": " .. money, {90, 10}, {0, 50}, {0, 0, 1})

    Game:AddElement(Cash_display)
    Game:AddElement(Cash_icon)

    Cpsicon = UIElements.Image:new(love.graphics.newImage("swarm.png"), {0, 60}, {0.18/4.8,0.18/4.8})

    Game:AddElement(Cpsicon)
    Game:AddElement(UIElements.Label:new(": " .. cps, {90, 65}, {0, 50}, {0, 0, 1}))

    Shop:AddElement(UIElements.Label:new("Frans shop", {400, 20}, {0, 0}, {0.3, 1, 0.3}))
    Shop:AddElement(UIElements.Label:new("Clicks: " .. money, {400, 60}, {0, 0}, {0.3, 1, 0.3}))

    Shop:AddElement(UIElements.Label:new("Cost:" .. basic_cost, {75, 195}, {0, 0}, {0.3, 1, 0.3}))
    Shop:AddElement(UIElements.Label:new("Cost:" .. swarm_cost, {75, 350}, {0, 0}, {0.3, 1, 0.3}))
    
    ClickerPowerImage = UIElements.Image:new(love.graphics.newImage("clicker.png"), {20, 75}, {0.25, 0.25})
    Buyclickerpower = UIElements.Imagebutton:new(ClickerPowerImage)
    Shop:AddElement(Buyclickerpower)

    Shop:AddElement(UIElements.Label:new("    An upgrade that\nboost clicking power", {300, 100}, {0, 0}, {0.3, 1, 0.3}))

    SwarmImage = UIElements.Image:new(love.graphics.newImage("swarm.png"), {-5, 200}, {1/12.5, 1/12.5})
    BuySwarm = UIElements.Imagebutton:new(SwarmImage)
    
    Shop:AddElement(UIElements.Label:new("A good upgrade that boosts\nclicks per second", {350, 250}, {0, 0}, {0.3, 1, 0.3}))
    Shop:AddElement(BuySwarm)

    
    CalcImage = UIElements.Image:new(love.graphics.newImage("calc.png"), {200, 50}, {0.4,0.4})
    Calc = UIElements.Imagebutton:new(CalcImage)
    Game:AddElement(Calc)

    ShopIcon = UIElements.Image:new(love.graphics.newImage("Shopicon.png"), {720, 0}, {0.2,0.2})
    ExitIcon = UIElements.Image:new(love.graphics.newImage("Exiticon.png"), {720, 0}, {0.2,0.2})
    Shopbutton = UIElements.Imagebutton:new(ShopIcon)

    font = love.graphics.newFont("Sigmar-Regular.ttf",28)
    love.graphics.setFont(font)

    Shop:SetActiveState(false)
end

function love.update()
    Game.ElementContents[1].Text = ": " .. money
    Shop.ElementContents[2].Text = "Clicks: " .. money
    Shop.ElementContents[3].Text = "Cost:" .. basic_cost
    Shop.ElementContents[4].Text = "Cost:" .. swarm_cost
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
    Shop.ElementContents[7].Text = ""
    Shop.ElementContents[6].Text = ""


    timer = timer + 0.5
    if timer == 60 then
        money = money + cps
        timer = 0
    end

    Buyclickerpower:IsTriggered(function ()
        buyitem("clickerpower")
    end, {Pos2D = {-10, 0}, Scale2D = {100, 95}})

    Buyclickerpower:Hover(function ()
        Shop.ElementContents[6].Text = "    An upgrade that\nboost clicking power"
        print("Hovering")
    end, {Pos2D = {20, 0}, Scale2D = {125, 125}})

    BuySwarm:IsTriggered(function ()
        buyitem("cps")
    end, {Pos2D = {20, 0}, Scale2D = {125, 125}})

    BuySwarm:Hover(function ()
        Shop.ElementContents[7].Text = "A good upgrade that boosts\nclicks per second"
        print("Hovering")
    end, {Pos2D = {20, 0}, Scale2D = {125, 125}})

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
    end, {Pos2D = {0, 0}, Scale2D = {100, 95}})

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

function buyitem(ItemType)
    print("Buying item")
    if ItemType == "clickerpower" then
        if money >= basic_cost then
            money = money - basic_cost
            clickerpower = clickerpower + 1
            basic_cost = basic_cost * 2 - 30
        else
            print("Not enough money")
        end
    end
    if ItemType == "cps" then
        if money >= swarm_cost then
            money = money - swarm_cost
            swarm_cost = cps * 3 + 9
            cps = cps + 1
        else
            print("Not enough money")
        end
    end
end

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