Objects = {
   t = {
   },
   New = function(name, type, port)
	    res = {}
	    res.name = name
	    res.type = type
	    res.pin = pin
	    res.value = 0
	    Objects.t[name] = res
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
		       Objects.New(textinput:GetText(), typechoice:GetChoice(), numberbox:GetValue())
		    end
   
end

function updateObjectList()
   if objList == nil then return end
   objList:Clear()
   for i,j in pairs(Objects.t) do
      objList:AddRow(j.name, tostring(j.type), tostring(j.port))
   end
end