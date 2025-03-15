require "UI"
require "shop"

mode = "shop"
Game = nil
function love.load()
    font = love.graphics.newFont("assets/Sigmar-Regular.ttf",28)
    love.graphics.setFont(font)

    Game = UIElements.Frame:new()
    Shop = UIElements.Frame:new()
    
    clickerpower = 0.7
    cps = 0.5
    timer = 0
    money = 150
    Cclock = 0
    isup = false
    basic_cost = 50
    swarm_cost = 10
    
    if mode == "shop" then
        FransShop.Load()
        Shop:SetActiveState(true)
    elseif mode == "game" then
        UIElements.Frame:new()
        Run()
    end
end

-- local UIFrame = require("UI").Frame

---@param Frame UiElements.Frame
function GrabElement(Frame)
    if love.mouse.isDown(1) then
        for _, value in pairs(Frame.ElementContents or {}) do
            if value.image then
                if value.IsTriggered then
                    value:IsTriggered(
                        function ()
                            print("fried")
                            value.image.Pos2D[1] = love.mouse.getX()
                            value.image.Pos2D[2] = love.mouse.getY()
                        end,{Pos2D = {0,0},Scale2D = {value.image.Scale2D[1],value.image.Scale2D[2]}}
                    )
                end
            end
        end
    end
end

function love.update()
    if not love.mouse.isDown(1) then
        isup = false
    end
    if mode == "shop" then
        FransShop.Update(shop)
        GrabElement(Shop)
    elseif mode == "game" then
        Game.ElementContents[1].Text = ": " .. math.floor(money)
        Game.ElementContents[2].Text = ": " .. cps
    end
end
function Run()
    Game:SetActiveState(true)
    Cash_icon = UIElements.Image:new(love.graphics.newImage("assets/icons/clicker.png"), {10, 10}, {0.125, 0.125})
    Cash_display = UIElements.Label:new(": " .. money, {90, 10}, {0, 50}, {0, 0, 1})

    Game:AddElement(Cash_display)
    Game:AddElement(Cash_icon)

    Cpsicon = UIElements.Image:new(love.graphics.newImage("assets/icons/swarm.png"), {0, 60}, {0.18/4.8,0.18/4.8})

    Game:AddElement(Cpsicon)
    Game:AddElement(UIElements.Label:new(": " .. cps, {90, 65}, {0, 50}, {0, 0, 1}))

    

    
    CalcImage = UIElements.Image:new(love.graphics.newImage("assets/clickers/calc.png"), {200, 50}, {0.4,0.4})
    Calc = UIElements.Imagebutton:new(CalcImage)
    Game:AddElement(Calc)

    ShopIcon = UIElements.Image:new(love.graphics.newImage("assets/icons/Shopicon.png"), {720, 0}, {0.2,0.2})
    ExitIcon = UIElements.Image:new(love.graphics.newImage("assets/icons/Exiticon.png"), {720, 0}, {0.2,0.2})
    Shopbutton = UIElements.Imagebutton:new(ShopIcon)

    SaveIcon = UIElements.Image:new(love.graphics.newImage('assets/icons/SaveIcon.png'),{710,500},{.25,.25})
    SaveButton = UIElements.Imagebutton:new(SaveIcon)
    Game:AddElement(SaveButton)

    font = love.graphics.newFont("assets/Sigmar-Regular.ttf",28)
    love.graphics.setFont(font)
end

function love.draw()
    love.graphics.setBackgroundColor(.8, 1, 1)
    
    if mode == "shop" then
        Shop:Draw(function ()
            love.graphics.setColor(.3, 0.3, 0.3)
            love.graphics.rectangle("fill", 0, 0, 800, 800)
        end)
    elseif mode == "game" then
        Cash_display:Draw()
        Shopbutton:Draw()
        Game:Draw()
    end
end