UIElements = {}

--Buttons
UIElements.Buttons = {}
UIElements.Buttons.__index = UIElements.Buttons

--Imagebuttons
UIElements.Image = {}
UIElements.Image.__index = UIElements.Image

--image
UIElements.Imagebutton = {}
UIElements.Imagebutton.__index = UIElements.Imagebutton

UIElements.Frame = {}
UIElements.Frame.__index = UIElements.Frame

UIElements.Label = {}
UIElements.Label.__index = UIElements.Lable

UIElements.rectangle = {}
UIElements.rectangle.__index = UIElements.rectangle

function UIElements.rectangle:new(Scale2D,Color,IsActive)
    local Rectangle = {}
    setmetatable(Rectangle,UIElements.rectangle)
    Rectangle.Pos2D = {0,0}
    Rectangle.Scale2D = Scale2D or {100,100}
    Rectangle.Color = Color or {1,1,1}
    Rectangle.IsActive = IsActive or true

    return Rectangle
end

function UIElements.rectangle:draw()
    if self.IsActive == false then return end

    if self.Color then
        love.graphics.setColor(self.Color[1],self.Color[2],self.Color[3])
    end
    love.graphics.rectangle("fill",self.Pos2D[1],self.Pos2D[2],self.Scale2D[1],self.Scale2D[2])
end

function UIElements.Imagebutton:new(image,IsActive)
    local Imagebutton = {}
    setmetatable(Imagebutton,UIElements.Imagebutton)
    Imagebutton.image = image
    Imagebutton.IsActive = IsActive or true
    return Imagebutton
end

function UIElements.Imagebutton:IsTriggered(func,colider)
    MX = love.mouse.getX()
    MY = love.mouse.getY()
    if love.mouse.isDown(1) and self.IsActive == true and colider and isup == false then
        if (MX > self.image.Pos2D[1] + colider.Pos2D[1] and MX < self.image.Pos2D[1] + colider.Scale2D[1]) and MY > self.image.Pos2D[2] + colider.Pos2D[2]and MY < self.image.Pos2D[2] + colider.Scale2D[2] then
            print("Triggered")
            love.graphics.setColor(1, 0, 0)
            love.graphics.rectangle("fill", self.image.Pos2D[1], self.image.Pos2D[2], colider.Scale2D[1], colider.Scale2D[2])
            isup = true
            load(func)()
        end
    end
end

function UIElements.Imagebutton:Hover(func,colider)
    MX = love.mouse.getX()
    MY = love.mouse.getY()
    if self.IsActive == true and colider and isup == false then
        if (MX > self.image.Pos2D[1] + colider.Pos2D[1] and MX < self.image.Pos2D[1] + colider.Scale2D[1]) and MY > self.image.Pos2D[2] + colider.Pos2D[2]and MY < self.image.Pos2D[2] + colider.Scale2D[2] then
            --print("Triggered")
            love.graphics.setColor(1, 0, 0)
            --love.graphics.rectangle("fill", self.image.Pos2D[1], self.image.Pos2D[2], colider.Scale2D[1], colider.Scale2D[2])
            isup = true
            load(func)()
        end
    end
end

function UIElements.Imagebutton:Draw()
    if self.IsAcive == false then return end
    
    love.graphics.setColor(1,1,1)   
    self.image:Draw()
end

function UIElements.Image:new(image,Pos2D,Scale2D)
    local Image = {}
    setmetatable(Image,UIElements.Image)
    Image.image = image
    Image.Pos2D = Pos2D
    Image.Scale2D = Scale2D

    return Image
end

function UIElements.Image:Draw()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(self.image, self.Pos2D[1], self.Pos2D[2], 0, self.Scale2D[1], self.Scale2D[2])
end

function UIElements.Frame:new(items,Active)
    local Element = {}
    setmetatable(Element,UIElements.Frame)
    Element.ElementContents = items or {}
    Element.IsActive = Active or true

    return Element
end

function UIElements.Frame:AddElement(item)
    self.ElementContents[#self.ElementContents + 1] = item
end

function UIElements.Frame:SetActiveState(Bool)
    for key, value in pairs(self.ElementContents) do
        value.IsActive = Bool
    end
    self.IsActive = Bool
end

function UIElements.Frame:Draw(misc)
    if self.IsActive == false then return end
    if misc then misc() end
    
    for key, value in pairs(self.ElementContents) do
        value:Draw()
    end
end
function UIElements.Label:new(Text,Pos2D,Scale2D,Color)
    local Element = {}
    setmetatable(Element,UIElements.Buttons)
    Element.Text = Text
    Element.Scale2D = Scale2D
    Element.Pos2D = Pos2D
    Element.Color = Color
    Element.IsActive = true

    return Element
end

function UIElements.Label:Draw(Scale)
    if self.IsActive then
        if self.Text then
            textScale = 1
                
            if Scale then
                textScale = Scale
            end

            love.graphics.setColor(self.Color[1],self.Color[2],self.Color[3])
            love.graphics.print(self.Text, self.Pos2D[1] + (self.Scale2D[1] - love.graphics.getFont():getWidth(self.Text) * textScale) / 2, self.Pos2D[2] + (self.Scale2D[2] - love.graphics.getFont():getHeight() * textScale) / 2, 0, textScale, textScale)
        end
    end
end


function UIElements.Buttons:new(Text,Scale2D,Pos2D,Color)
    local Element = {}
    setmetatable(Element,UIElements.Buttons)
    Element.Text = Text
    Element.Scale2D = Scale2D
    Element.Pos2D = Pos2D
    Element.Color = Color
    Element.IsActive = true

    return Element
end

function UIElements.Buttons:IsTriggered(func)
    if not self.IsAcive == false then return end

    MX = love.mouse.getX()
    MY = love.mouse.getY()
    if love.mouse.isDown(1) and self.IsActive then
        if MX > self.Pos2D[1] and MX < self.Pos2D[1] + self.Scale2D[1] and MY > self.Pos2D[2] and MY < self.Pos2D[2] + self.Scale2D[2] then
            load(func)()
        end
    end
end

function UIElements.Buttons:Draw(TextScalearg)
    if self.IsActive then
        if self.Color then
            love.graphics.setColor(self.Color[1],self.Color[2],self.Color[3])
        end
        love.graphics.rectangle("fill",self.Pos2D[1],self.Pos2D[2],self.Scale2D[1],self.Scale2D[2])

        if self.Text then
            textScale = 1
            
            if TextScalearg then
                textScale = TextScalearg
            end

            love.graphics.setColor(0,0,0)
            love.graphics.print(self.Text, self.Pos2D[1] + (self.Scale2D[1] - love.graphics.getFont():getWidth(self.Text) * textScale) / 2, self.Pos2D[2] + (self.Scale2D[2] - love.graphics.getFont():getHeight() * textScale) / 2, 0, textScale, textScale)
        end

        
    end
end

return UIElements