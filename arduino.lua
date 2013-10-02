
function initObjectArduino(obj)
   if arduino == nil then return false end
   arduino.pinMode(obj.pin, ArduinoConstants.SERVO)
   return true
end

function updateArduino(dt)
   if arduino == nil then return end
   arduino.processInput()
   for name, obj in pairs(Objects.t) do
      if obj.type == "Servo" then
	 arduino.analogWrite(obj.pin, obj.output)
      end
   end
end