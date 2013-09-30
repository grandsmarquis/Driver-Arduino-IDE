--
-- Lua Rainy Day: Jules Dourlens (jdourlens)
--

DEFAULT = {
   device = "/dev/ATM0"
}

device = DEFAULT.device

function loadLibs()

   local simple_dispatcher = require "lua-firmata.simple_dispatcher"
   local arduino_module = require "lua-firmata.arduino"
   local socket = require "socket"
   require "posix"
   require "LoveFrames"
end

function loadArduino(path)
   arduino = Arduino(path)
   info:SetText({{0, 0, 0, 255}, "Device selected : \"" .. path .. "\""})
   if arduino == nil then
   end
end

function makeTaskBar()
   local width = love.graphics.getWidth()
   
   local toolbar = loveframes.Create("panel")
   toolbar:SetSize(width, 35)
   toolbar:SetPos(0, 0)

   info = loveframes.Create("text", toolbar)
   info:SetPos(5, 3)
   info:SetText({{0, 0, 0, 255}, "Device selected : \"" .. DEFAULT.device .. "\""})

   local devButton = loveframes.Create("button", toolbar)
   devButton:SetPos(toolbar:GetWidth() - 105, 5)
   devButton:SetSize(100, 25)
   devButton:SetText("Choose device")
   devButton.OnClick = function()
			  makeChooseDevice()
		       end
end

function makeChooseDevice()
      local frame = loveframes.Create("frame")
      frame:SetName("Path to device")
      frame:SetSize(500, 90)
      frame:SetModal(true)
      local textinput = loveframes.Create("textinput", frame)
      textinput:SetPos(5, 30)
      textinput:SetWidth(490)
      textinput.OnEnter = function(object)
			     loadArduino(textinput:GetText())
			     frame:Remove()
			  end
      textinput:SetFont(love.graphics.newFont(12))      
      local togglebutton = loveframes.Create("button", frame)
      togglebutton:SetPos(5, 60)
      togglebutton:SetWidth(490)
      togglebutton:SetText("OK")
      togglebutton.OnClick = function(object)
				loadArduino(textinput:GetText())
				frame:Remove()
			     end
end

function love.load()
   loadLibs()
   makeTaskBar()
end

function love.update(dt)
   loveframes.update(dt)
end
                 
function love.draw()
   loveframes.draw()
end
 
function love.mousepressed(x, y, button)
   loveframes.mousepressed(x, y, button)
end
 
function love.mousereleased(x, y, button)
   loveframes.mousereleased(x, y, button)
end
 
function love.keypressed(key, unicode)
   loveframes.keypressed(key, unicode)
end
 
function love.keyreleased(key)
   loveframes.keyreleased(key)
end
