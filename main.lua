--
-- Lua Rainy Day: Jules Dourlens (jdourlens)
--

DEFAULT = {
   device = "/dev/ttyACM0"
}

device = DEFAULT.device
connectionStatus = "not"

ELEMS = {}



function loadElements()
   require "arduino"
   require "toolbar"
   require "objects"
end

function loadLibs()
   local simple_dispatcher = require "lua-firmata.simple_dispatcher"
   local arduino_module = require "lua-firmata.arduino"
   local socket = require "socket"
   require "posix"
   require "LoveFrames"
end

function loadArduino(path)
   if path == nil or path == "" then
      return
   end
   arduino = Arduino(path)
   info:SetText({{0, 0, 0, 255}, "Device selected : \"" .. path .. "\""})
   if arduino == nil then
      connectionStatus = "not"
   else
      connectionStatus = "good"
   end
   updateConnetionStatus()
end

function love.load()
   love.graphics.setBackgroundColor( 50, 40, 150)
   loadLibs()
   loadElements()
   makeToolbar()
   loadArduino(DEFAULT.device)
   imageBG = love.graphics.newImage("images/bg.jpg")
end

function love.update(dt)
   loveframes.update(dt)
   updateArduino(dt)
end
                 
function love.draw()

   local width = love.graphics.getWidth()
   local height = love.graphics.getHeight()
   local scalex = width/imageBG:getWidth()
   local scaley = height/imageBG:getHeight()
   
   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.draw(imageBG, 0, 0, 0, scalex, scaley)

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
