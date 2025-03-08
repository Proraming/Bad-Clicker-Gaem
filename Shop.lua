require "UI"

FransShop = {}


function FransShop.Load()
    Shop = UIElements.Frame:new()
    Shop:SetActiveState(false)

    FransShopLable = (UIElements.Label:new("Frans shop", {400, 20}, {0, 0}, {0.3, 1, 0.3}))
    Shop:AddElement(FransShopLable)

    Balance = (UIElements.Label:new("Clicks: " .. money, {400, 60}, {0, 0}, {0.3, 1, 0.3}))
    Shop:AddElement(Balance)

    Basic_Cost_Lable = (UIElements.Label:new("Cost:" .. basic_cost, {75, 195}, {0, 0}, {0.3, 1, 0.3}))
    Shop:AddElement(Basic_Cost_Lable)

    Swarm_Cost_Lable = (UIElements.Label:new("Cost:" .. swarm_cost, {75, 350}, {0, 0}, {0.3, 1, 0.3}))
    Shop:AddElement(Swarm_Cost_Lable)
    
    ClickerPowerImage = UIElements.Image:new(love.graphics.newImage("clicker.png"), {20, 75}, {0.25, 0.25})
    Buyclickerpower = UIElements.Imagebutton:new(ClickerPowerImage)
    Shop:AddElement(Buyclickerpower)

    BasicTooltip = UIElements.Label:new("    An upgrade that\n '   '", {280, 100}, {0, 0}, {0.3, 1, 0.3})
    Shop:AddElement(BasicTooltip)
    
    SwarmImage = UIElements.Image:new(love.graphics.newImage("swarm.png"), {-5, 200}, {1/12.5, 1/12.5})
    BuySwarm = UIElements.Imagebutton:new(SwarmImage)
    Shop:AddElement(BuySwarm)
    
    SwarmTooltip = UIElements.Label:new("A good upgrade that boosts\nclicks per second", {280, 250}, {0, 0}, {0.3, 1, 0.3})
    Shop:AddElement(SwarmTooltip)

    MacPointerCost = 500

    MacPointerIcon = UIElements.Image:new(love.graphics.newImage("MacClicker.png"), {25, 380}, {0.3, 0.3})
    MacPointer = UIElements.Imagebutton:new(MacPointerIcon)
    Shop:AddElement(MacPointer)
    
    MacPointerTooltip = UIElements.Label:new("A overrated\nupgrade", {250, 400}, {0, 0}, {0.3, 1, 0.3})
    MacPointerLable = (UIElements.Label:new("Cost:" .. MacPointerCost, {75, 510}, {0, 0}, {0.3, 1, 0.3}))

    Shop:AddElement(MacPointerTooltip)
    Shop:AddElement(MacPointerLable)

    MacWheelCost = 100

    MacPointerIcon = UIElements.Image:new(love.graphics.newImage("Wheel.png"), {25, 380}, {0.3, 0.3})
    MacPointer = UIElements.Imagebutton:new(MacPointerIcon)
    Shop:AddElement(MacPointer)
    
    MacPointerTooltip = UIElements.Label:new("A overrated\nupgrade", {250, 400}, {0, 0}, {0.3, 1, 0.3})
    MacPointerLable = (UIElements.Label:new("Cost:" .. MacPointerCost, {75, 510}, {0, 0}, {0.3, 1, 0.3}))

    Shop:AddElement(MacPointerTooltip)
    Shop:AddElement(MacPointerLable)
end

function FransShop.Update()
    Balance.Text = "Clicks: " .. math.floor(money)
    Basic_Cost_Lable.Text = "Cost:" .. basic_cost
    Swarm_Cost_Lable.Text = "Cost:" .. swarm_cost
    MacPointerLable.Text = "Cost:" .. MacPointerCost

    BasicTooltip.Text = ""
    SwarmTooltip.Text = ""
    MacPointerTooltip.Text = ""

    Buyclickerpower:IsTriggered(function ()
        buyitem("clickerpower")
    end, {Pos2D = {-10, 0}, Scale2D = {100, 95}})

    Buyclickerpower:Hover(function ()
        BasicTooltip.Text = " An upgrade that\n '  '"
        print("Hovering")
    end, {Pos2D = {20, 0}, Scale2D = {125, 125}})

    BuySwarm:IsTriggered(function ()
        buyitem("cps")
    end, {Pos2D = {20, 0}, Scale2D = {125, 125}})

    BuySwarm:Hover(function ()
        SwarmTooltip.Text = "A MID upgrade"
        print("Hovering")
    end, {Pos2D = {20, 0}, Scale2D = {125, 125}})

    MacPointer:Hover(function ()
        MacPointerTooltip.Text = "A overrated\nupgrade"
        print("Hovering")
    end, {Pos2D = {20, 0}, Scale2D = {125, 125}})

    MacPointer:IsTriggered(function ()
        buyitem("MP")
    end, {Pos2D = {20, 0}, Scale2D = {125, 125}})
end

function buyitem(ItemType)
    print("Buying item")
    if ItemType == "MP" then
        if money >= MacPointerCost then
            money = money - MacPointerCost
            clickerpower = clickerpower + 2
            basic_cost = MacPointerCost * 3 - 2
        else
            print("Not enough money")
        end
    end
    if ItemType == "clickerpower" then
        if money >= basic_cost then
            money = money - basic_cost
            clickerpower = clickerpower + 1
            basic_cost = basic_cost * 3 - 2
        else
            print("Not enough money")
        end
    end
    if ItemType == "cps" then
        if money >= swarm_cost then
            money = money - swarm_cost
            swarm_cost = math.floor(swarm_cost * 1.5)
            cps = cps + 0.5
        else
            print("Not enough money")
        end
    end
end

return FransShop