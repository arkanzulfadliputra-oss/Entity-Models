function setPinkLighting()
    local lighting = game.Lighting.MainColorCorrection
    lighting.TintColor = Color3.fromRGB(255, 255, 255)
    lighting.Contrast = 0.4
    game:GetService("TweenService"):Create(lighting, TweenInfo.new(2.5), {Contrast = 0}):Play()
    -- Đổi sang đỏ
    game:GetService("TweenService"):Create(lighting, TweenInfo.new(5), {TintColor = Color3.fromRGB(255, 0, 0)}):Play()
end

function resetLighting()
    local lighting = game.Lighting.MainColorCorrection
    lighting.TintColor = Color3.fromRGB(255, 0, 0)
    lighting.Contrast = 10
    game:GetService("TweenService"):Create(lighting, TweenInfo.new(2.5), {Contrast = 0}):Play()
    game:GetService("TweenService"):Create(lighting, TweenInfo.new(5), {TintColor = Color3.fromRGB(255, 255, 255)}):Play()
end
wait(1)
local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

---====== Create entity ======---

local entity = spawner.Create({
	Entity = {
		Name = "Strunggle",
		Asset = "https://github.com/arkanzulfadliputra-oss/Entity-Models/raw/main/DoorsMod/Strunggle.rbxm",
		HeightOffset = 0
	},
	Lights = {
		Flicker = {
			Enabled = false,
			Duration = 1
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Range = 100,
		Values = {1.5, 20, 0.1, 1} -- Magnitude, Roughness, FadeIn, FadeOut
	},
	Movement = {
		Speed = 150,
		Delay = 2,
		Reversed = false
	},
	Rebounding = {
		Enabled = false,
		Type = "Ambush", -- "Blitz"
		Min = 1,
		Max = 1,
		Delay = 2
	},
	Damage = {
		Enabled = true,
		Range = 40,
		Amount = 125
	},
	Crucifixion = {
		Enabled = true,
		Range = 40,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding", -- "Curious"
		Hints = {"Death", "Hints", "Go", "Here"},
		Cause = ""
	}
})

---====== Debug entity ======---

entity:SetCallback("OnSpawned", function()
    print("Entity has spawned")
end)

entity:SetCallback("OnStartMoving", function()
    print("Entity has started moving")
end)

entity:SetCallback("OnEnterRoom", function(room, firstTime)
    if firstTime == true then
        print("Entity has entered room: ".. room.Name.. " for the first time")
    else
        print("Entity has entered room: ".. room.Name.. " again")
    end
end)

entity:SetCallback("OnLookAt", function(lineOfSight)
	if lineOfSight == true then
		print("Player is looking at entity")
	else
		print("Player view is obstructed by something")
	end
end)

entity:SetCallback("OnRebounding", function(startOfRebound)
    if startOfRebound == true then
        print("Entity has started rebounding")
	else
        print("Entity has finished rebounding")
	end
end)

entity:SetCallback("OnDespawning", function()
    print("Entity is despawning")
end)

entity:SetCallback("OnDespawned", function()
    print("Entity has despawned")
    resetLighting()
    local s = Instance.new("Sound", workspace)
    s.SoundId = "rbxassetid://1837829565"
    s.Volume = 9999
    s.PlaybackSpeed = 0.5
    s:Play()
end)

entity:SetCallback("OnDamagePlayer", function(newHealth)
	if newHealth == 0 then
		print("Entity has killed the player")
	else
		print("Entity has damaged the player")
	end
end)

--[[

DEVELOPER NOTE:
By overwriting 'CrucifixionOverwrite' the default crucifixion callback will be replaced with your custom callback.

entity:SetCallback("CrucifixionOverwrite", function()
    print("Custom crucifixion callback")
end)

]]--

---====== Run entity ======---

entity:Run()
