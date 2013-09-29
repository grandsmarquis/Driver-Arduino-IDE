--
-- Lua Rainy Day: Jules Dourlens (jdourlens)
--

function loadLibs()
   local simple_dispatcher = require "lua-firmata.simple_dispatcher"
   local arduino_module = require "lua-firmata.arduino"
   local socket = require "socket"
   require "posix"
end

function start()
   loadLibs()
   arduino = Arduino("/dev/ttyACM0")
   arduino.analogWrite(10, 40)
end

start()