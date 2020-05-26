# ARSENIC API

## How to use
***First, include this at the top of your script.***
```lua
local as = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Upbolt/Arsenic-API/master/as.lua"))()
```

***After you do this, all tables and functions will be under the `as` table.***
Example:
```lua
as.destroy(game.Players.Gusmanak) 
as.setPartColor(game.Players.LocalPlayer.Character:FindFirstChild("Left Arm"), as.colors.brightRed)
```

# Tables
```lua
color {
    hotPink
    dustyRose
    cyan
    dirtBrown
    pastelViolet
    limeGreen
    brightRed
    darkStoneGrey
    newYeller
    lillyWhite
    maroon
    pastelYellow
    brightBluishGreen
    fog
    camo
    brightOrange
    salmon
    teal
    reallyBlack
    brightGreen
    brightBlue
    pastelBlueGreen
    black
    brightViolet
    persimmon
    neonOrange
    sandRed
    white
    reallyBlue
    reallyRed
    terraCotta
    pearl
    navyBlue
    toothpaste
    khaki
    laurelGreen
    electricBlue
    slimeGreen
    brickYellow
    gold
    royalPurple
    cashmere
    quillGrey
    pink
    seaGreen
    reddishBrown
    lightReddishViolet
    babyBlue
    deepOrange
    grime
    institutionalWhite
    cgaBrown
    alder
    pastelLightBlue
    coolYellow
    crimson
    brYellowishOrange
    nougat
    brightYellow
    earthGreen
}
```

# Functions 
***Functions marked with \<YIELD> pause the script until they are finished running.***
```lua

<YIELD> setParent ( instance, newParent )
    ~ Sets the parent of "instance" to "newParent"

<YIELD> destroy ( instance )
    ~ Sets the parent of "instance" to nil

<YIELD> setValueObject ( valueObject, newValue )
    ~ If "valueObject" is a valid ValueObject (StringValue, NumberValue, Color3Value, etc.), its value will be set to "newValue"

setCFrame ( part, cframe )
    ~ Sets the CFrame of "part" to cframe

<YIELD> setPartColor ( part, colorId )
    ~ Sets the color of "part" to "colorId" (Use as.colors to select a color!)

setModelColor ( model, colorId )
    ~ Sets the color of parts inside "model" to "colorId" (Use as.colors to select a color!)

<YIELD> clone ( instance, newParent, count = 1 )
    ~ Clones "instance", with "count" amount (defaults to 1), and sets the parent to "newParent"
```
