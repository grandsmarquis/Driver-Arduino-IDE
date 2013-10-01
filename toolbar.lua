function updateConnetionStatus()
   if connectionStatus == "good" or true then
      infoConnection:SetText({{0, 255, 0, 255}, "Connection status : \"Connected\""})
      devInfoButton:SetClickable(true)
      objectsButton:SetClickable(true)
      addObjectButton:SetClickable(true)
   else
      infoConnection:SetText({{255, 0, 0, 255}, "Connection status : \"Not connected\""})
      devInfoButton:SetClickable(false)
      objectsButton:SetClickable(false)
      addObjectButton:SetClickable(false)
   end
end


function makeToolbar()
   local width = love.graphics.getWidth()

   local toolbar = loveframes.Create("panel")
   toolbar:SetSize(width, 35)
   toolbar:SetPos(0, 0)

   info = loveframes.Create("text", toolbar)
   info:SetPos(5, 3)
   info:SetText({{0, 0, 0, 255}, "Device selected : \"" .. DEFAULT.device .. "\""})

   infoConnection = loveframes.Create("text", toolbar)
   infoConnection:SetPos(5, 18)
   infoConnection:SetText({{0, 0, 0, 255}, "Connection status : \"\""})

   local devButton = loveframes.Create("button", toolbar)
   devButton:SetPos(toolbar:GetWidth() - 420, 5)
   devButton:SetSize(100, 25)
   devButton:SetText("Choose device")
   devButton.OnClick = function()
                          makeChooseDevice()
                       end

   devInfoButton = loveframes.Create("button", toolbar)
   devInfoButton:SetPos(toolbar:GetWidth() - 315, 5)
   devInfoButton:SetSize(100, 25)
   devInfoButton:SetText("Device infos")
   devInfoButton.OnClick = function()
                              makeDeviceInfo()
                           end

   objectsButton = loveframes.Create("button", toolbar)
   objectsButton:SetPos(toolbar:GetWidth() - 210, 5)
   objectsButton:SetSize(100, 25)
   objectsButton:SetText("See elements")
   objectsButton.OnClick = function()
                              makeObjects()
                           end

   addObjectButton = loveframes.Create("button", toolbar)
   addObjectButton:SetPos(toolbar:GetWidth() - 105, 5)
   addObjectButton:SetSize(100, 25)
   addObjectButton:SetText("Add element")
   addObjectButton.OnClick = function()
                              makeNewObject()
                           end
end

function makeNewObject()

end

function makeDeviceInfo()

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
