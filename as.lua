local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local as = {}

local remote = workspace.Remote
local globals = getrenv()._G
local fireServer = debug.getupvalue(getmetatable(getrenv().shared).__index, 3)
debug.setupvalue(fireServer, 2, function() return error end)
debug.setupvalue(fireServer, 3, function() return true end)

local visualData = require(ReplicatedStorage:FindFirstChild("Skin Visuals"))
local internalColors = visualData.Colors
local internalMaterials = visualData.MaterialEnums

local colors = {
    brightRed = 1,
    brightBlue = 2,
    brightGreen = 3,
    brightOrange = 4,
    brightYellow = 5,
    brightBluishGreen = 6,
    brightViolet = 7,
    grime = 8,
    earthGreen = 9,
    navyBlue = 10,
    dustyRose = 11,
    black = 12,
    reddishBrown = 13,
    nougat = 14,
    brickYellow = 15,
    reallyBlue = 16,
    reallyRed = 17,
    newYeller = 18,
    limeGreen = 19,
    hotPink = 20,
    white = 21,
    reallyBlack = 22,
    deepOrange = 23,
    cyan = 24,
    slimeGreen = 25,
    alder = 26,
    royalPurple = 27,
    cgaBrown = 28,
    maroon = 29,
    gold = 30,
    coolYellow = 31,
    cashmere = 32,
    dirtBrown = 33,
    crimson = 34,
    institutionalWhite = 35,
    pearl = 36,
    babyBlue = 37,
    seaGreen = 38,
    salmon = 39,
    lightReddishViolet = 40,
    pink = 41,
    pastelViolet = 42,
    alder = 43,
    pastelBlueGreen = 44,
    persimmon = 45,
    quillGrey = 46,
    coolYellow = 47,
    pastelLightBlue = 48,
    brYellowishOrange = 49,
    laurelGreen = 50,
    pastelBlueGreen = 51,
    khaki = 52,
    cashmere = 53,
    grime = 54,
    toothpaste = 55,
    neonOrange = 56,
    teal = 57,
    camo = 58,
    terraCotta = 59,
    electricBlue = 60,
    fog = 61,
    pastelYellow = 62,
    lillyWhite = 63,
    darkStoneGrey = 64,
    sandRed = 65
}
local function getMaterialId(material)
    return (material == Enum.Material.Plastic and 1) or table.find(internalMaterials, material)
end

local function fireEvent(event, ...)
    remote:FindFirstChild(event):FireServer(...)
end

local function setParent(instance, parent)
    fireServer("ChangeParent", instance, parent)
    repeat wait() until instance.Parent == parent
end

local function setValueObject(object, newValue) 
    fireServer("ChangeValue", object, newValue)
    repeat wait() until object.Value == newValue
end

local function destroy(instance)
    fireServer("ChangeParent", instance)
end

local function addFlag(instance, name)
    local methods = {}
    local flagCheck = instance:FindFirstChild(name)
    
    if not flagCheck then
        local flagAdd
        local flagYield = true

        flagAdd = instance.ChildAdded:Connect(function(child)
            if child.Name == name then
                function methods.remove()
                    destroy(child)
                end

                flagAdd:Disconnect()
                flagYield = false
            end
        end)

        fireEvent("AddClothing", name, instance, "", "", "")

        repeat wait() until not flagYield
    else
        function methods.remove()
            destroy(flagCheck)
        end
    end

    return methods
end

local cloneBait = {
    "G18Ammo",
    "VehicleJack"
}
local function clone(instance, parent, amount)
    amount = amount or 1
    
    local bait
    local ogParent = instance.Parent
    local cloneEvent
    local cloneYield = true
    local objects = {}
    local objectIterator = 0
    local data = {}
    
    for i, item in pairs(cloneBait) do
        local found = Lighting.LootDrops:FindFirstChild(item)
        if found then
            setParent(found, Lighting.Materials)
            setParent(instance, found)
            
            bait = found
            break
        end
    end
    
    cloneEvent = workspace.ChildAdded:Connect(function(child)
        if child.Name == bait.Name then
            repeat wait() until child:FindFirstChildOfClass("Model")
            local clone = child:FindFirstChild(instance.Name)
            
            if clone then
                setParent(clone, parent)
                destroy(child)
                
                objectIterator = objectIterator + 1
                objects[objectIterator] = clone
                
                if objectIterator >= amount then
                    setParent(instance, ogParent)
                    setParent(bait, Lighting.LootDrops)
                    
                    cloneEvent:Disconnect()
                    cloneYield = false
                end
            end
        end
    end)
    
    for i = 1, amount do
        fireEvent("PlaceMaterial", bait.Name, Vector3.new(9e9, 9e9, 9e9), false, false)
    end 

    repeat wait() until not cloneYield
    
    data.objects = objects
    function data.forEach(callback)
        for i,v in pairs(objects) do
            callback(v)
        end
    end
    
    return data
end

local function setPartColor(part, colorCode)
    if part.BrickColor.Number == internalColors[colorCode] then
        return
    end

    local oldParent = part.Parent
    local transfer = clone(as.transfer, oldParent).objects[1]
    local colorFlag = addFlag(transfer, "SecondaryColor")
    local material = getMaterialId(part.Material)

    setParent(part, transfer)
    fireEvent("ColorGun", transfer, colorCode, material, colorCode, material)
    setParent(part, oldParent)
    destroy(transfer)

    colorFlag.remove()

    repeat wait() until part.BrickColor.Number == internalColors[colorCode]
end

local function setPartColor(part, material)
    if part.Material == material then
        return
    end

    local oldParent = part.Parent
    local transfer = clone(as.transfer, oldParent).objects[1]
    local colorFlag = addFlag(transfer, "SecondaryColor")
    material = getMaterialId(material)

    setParent(part, transfer)
    fireEvent("ColorGun", transfer, 0, material, 0, material)
    setParent(part, oldParent)
    destroy(transfer)

    colorFlag.remove()

    repeat wait() until part.BrickColor.Number == internalColors[colorCode]
end

local function setModelColor(model, colorCode)
    spawn(function()
        local firstPart
        local modelChildren = model:GetChildren()

        for i, v in pairs(model:GetChildren()) do
            if v:IsA("BasePart") then
                if not firstPart then
                    firstPart = v
                    break
                end
            end
        end

        if not firstPart then
            return
        end

        local colorCheck = model:FindFirstChild("SecondaryColor")
        local material = getMaterialId(firstPart.Material)
        local colorFlag

        if not colorCheck then
            colorFlag = addFlag(model, "SecondaryColor")
        end

        fireEvent("ColorGun", model, colorCode, material, colorCode, material)

        if colorFlag then
            colorFlag.remove()
        end
    end)
end

local function setModelMaterial(model, material)
    spawn(function()
        local firstPart
        local modelChildren = model:GetChildren()

        for i, v in pairs(model:GetChildren()) do
            if v:IsA("BasePart") then
                if not firstPart then
                    firstPart = v
                    break
                end
            end
        end

        if not firstPart then
            return
        end

        local colorCheck = model:FindFirstChild("SecondaryColor")
        local material = getMaterialId(material)
        local colorFlag

        if not colorCheck then
            colorFlag = addFlag(model, "SecondaryColor")
        end

        fireEvent("ColorGun", model, 0, material, 0, material)

        if colorFlag then
            colorFlag.remove()
        end
    end)
end

local function setCFrame(instance, cframe)
    spawn(function()
        local flag 

        if not part:FindFirstChild("") then
            flag = addFlag(instance, "IsBuildingMaterial")
        end
        
        if instance:IsA("BasePart") then
            fireEvent("ReplicatePart", instance, cframe)
        elseif instance:IsA("Model") then
            fireEvent("ReplicateModel", instance, cframe)
        end
        
        if flag then
            flag.remove()
        end
    end)
end

local function setEnabled(object, flag)
    fireEvent("SwitchEnabled", flag, object)
    repeat wait() until object.Enabled == flag
end

as.colors = colors
as.setParent = setParent
as.setValueObject = setValueObject
as.setEnabled = setEnabled
as.setCFrame = setCFrame
as.setPartColor = setPartColor
as.setPartMaterial = setPartColor
as.setModelColor = setModelColor
as.setModelMaterial = setModelColor
as.clone = clone
as.destroy = destroy
as.transfer = clone(ReplicatedStorage.Transfer, Players.LocalPlayer).objects[1]

as.fireServer = fireServer
as.fireEvent = fireEvent

return as
