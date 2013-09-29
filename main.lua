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

   arduino.pinMode(ledPin, ArduinoConstants.OUTPUT)

   arduino.pinMode(3, ArduinoConstants.INPUT);
   arduino.digitalWrite(3, ArduinoConstants.HIGH); --turns on pull-up resistor after input

   while arduino ~= nil do
      print(arduino.digitalRead(3))
  --    arduino.digitalWrite(ledPin, not arduino.digitalRead(buttonPin))
      --arduino.digitalWrite(13, ArduinoConstants.LOW)
   end
end

--Global defs
local wasActivated = false
ledPin = 13

--Entry point
start()