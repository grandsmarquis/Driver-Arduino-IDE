Objects = {
   t = {
   },
   New = function(name, type, pin)
	    res = {}
	    res.name = name
	    res.type = type
	    res.pin = pin
	    res.value = 0
	    res.output = 0
	    res.input = 0
	    res.linkedTo = ""
	    res.linkedOn = 0
	    res.linkedOff = 0
	    Objects.t[name] = res
	    initObjectArduino(res)
	    return res
	 end,
   getID = function()
	      i = 1
	      def = "elem "
	      while true do
		 if Objects.t[def..i] == nil then
		    return def ..i
		 end
		 i = i + 1
	      end
	   end
}

function makeObjects()
   local frame = loveframes.Create("frame")
   frame:SetName("Elements")
   frame:SetSize(500, 500)

   objList = loveframes.Create("columnlist", frame)
   objList:SetPos(5, 30)
   objList:SetSize(490, 465)
   objList:AddColumn("Name")
   objList:AddColumn("Type")
   objList:AddColumn("Pin")
   objList.OnRowClicked = function(parent, row, rowdata)
			     for k, v in ipairs(rowdata) do
				makeObject(Objects.t[v])
				return
			     end
			  end
   updateObjectList()
end

function makeNewObject()
   local frame = loveframes.Create("frame")
   frame:SetName("Add new element")
   frame:SetSize(210, 220)
   frame:SetPos(300, 150)
   frame:SetModal(true)
   local label1 = loveframes.Create("text", frame)
   label1:SetText("Choose element type:")
   label1:SetPos(5, 30)
   label1:SetShadowColor(200, 200, 200, 255)

   local typechoice = loveframes.Create("multichoice", frame)
   typechoice:SetPos(5, 50)
   typechoice:SetChoice("Input")
   typechoice:AddChoice("Input")
   typechoice:AddChoice("Output")
   typechoice:AddChoice("Analog")
   typechoice:AddChoice("PWM")
   typechoice:AddChoice("Servo")

   local label2 = loveframes.Create("text", frame)
   label2:SetText("Choose element name:")
   label2:SetPos(5, 80)
   label2:SetShadowColor(200, 200, 200, 255)

   local textinput = loveframes.Create("textinput", frame)
   textinput:SetPos(5, 100)
   textinput:SetText(Objects.getID())
   textinput:SetWidth(200)
   textinput.OnEnter = function(object)
		       end
   textinput:SetFont(love.graphics.newFont(12))

   local label3 = loveframes.Create("text", frame)
   label3:SetText("Choose element pin:")
   label3:SetPos(5, 130)
   label3:SetShadowColor(200, 200, 200, 255)

   local numberbox = loveframes.Create("numberbox", frame)
   numberbox:SetPos(5, 150)
   numberbox:SetSize(200, 25)
   numberbox:SetMin(0)

   local button = loveframes.Create("button", frame)
   button:SetWidth(200)
   button:SetPos(5, 190)
   button:SetText("Ok")
   button.OnClick = function(object, x, y)
		       frame:Remove()
		       Objects.New(textinput:GetText(), typechoice:GetChoice(), numberbox:GetValue())
		    end
   
end

function updateObjectList()
   if objList == nil then return end
   objList:Clear()
   for i,j in pairs(Objects.t) do
      objList:AddRow(j.name, tostring(j.type), tostring(j.pin))
   end
end

function makeObject(obj)
   if obj.type == "Servo" then
      makeServo(obj)
   elseif obj.type == "Input" then
      makeInput(obj)
   end
end

function makeInput(obj)
   local frame = loveframes.Create("frame")
   frame:SetName(obj.name .. " | pin : " .. obj.pin)
   frame:SetSize(300, 220)
   frame:SetPos(300, 150)

   local label1 = loveframes.Create("text", frame)
   label1:SetText("Linked to")
   label1:SetPos(5, 30)
   label1:SetShadowColor(200, 200, 200, 255)

   local textinput = loveframes.Create("textinput", frame)
   textinput:SetPos(5, 50)
   textinput:SetText(obj.linkedTo)
   textinput:SetWidth(200)
   textinput:SetFont(love.graphics.newFont(12))

   local label2 = loveframes.Create("text", frame)
   label2:SetText("On value")
   label2:SetPos(5, 80)
   label2:SetShadowColor(200, 200, 200, 255)

   local numberbox = loveframes.Create("numberbox", frame)
   numberbox:SetPos(5, 100)
   numberbox:SetSize(200, 25)
   numberbox:SetMin(0)
   numberbox:SetMax(255)

   local label2 = loveframes.Create("text", frame)
   label2:SetText("Off value")
   label2:SetPos(5, 130)
   label2:SetShadowColor(200, 200, 200, 255)

   local numberbox2 = loveframes.Create("numberbox", frame)
   numberbox2:SetPos(5, 150)
   numberbox2:SetSize(200, 25)
   numberbox2:SetMin(0)
   numberbox2:SetMax(255)

end

function makeServo(obj)
   local frame = loveframes.Create("frame")
   frame:SetName(obj.name .. " | pin : " .. obj.pin)
   frame:SetSize(300, 220)
   frame:SetPos(300, 150)

   local label1 = loveframes.Create("text", frame)
   label1:SetText("Output value: " .. obj.output)
   label1:SetPos(5, 30)
   label1:SetShadowColor(200, 200, 200, 255)


   local slider1 = loveframes.Create("slider", frame)
   slider1:SetPos(5, 60)
   slider1:SetWidth(290)
   slider1:SetMinMax(0, 255)
   slider1.OnValueChanged = function(object)
 			       obj.output = math.floor(object:GetValue())
			       label1:SetText("Output value: " .. obj.output)
			    end

end