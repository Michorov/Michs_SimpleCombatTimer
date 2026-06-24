local _, addon = ...

local EventHandler = {}
addon.EventHandler = EventHandler

local eventFrame = CreateFrame("Frame")
local initialized = false
local encounterActive = false

function EventHandler:Initialize()
	if initialized then
		error("EventHandler already initialized", 2)
	end

	eventFrame:RegisterEvent("ENCOUNTER_START")
	eventFrame:RegisterEvent("ENCOUNTER_END")
	eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

	eventFrame:SetScript("OnEvent", function(self, event, ...)
		if EventHandler[event] then
			EventHandler[event](EventHandler, event, ...)
		end
	end)

	initialized = true
end

function EventHandler:ENCOUNTER_START()
	encounterActive = true
	addon.CombatTimer:Start()
end

function EventHandler:ENCOUNTER_END()
	encounterActive = false
	addon.CombatTimer:Stop()
end

function EventHandler:PLAYER_REGEN_DISABLED()
	if encounterActive then
		return
	end

	addon.CombatTimer:Start()
end

function EventHandler:PLAYER_REGEN_ENABLED()
	if encounterActive then
		return
	end

	addon.CombatTimer:Stop()
end
