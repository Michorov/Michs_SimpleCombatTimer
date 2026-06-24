local _, addon = ...

local EventHandler = {}
addon.EventHandler = EventHandler

local eventFrame = CreateFrame("Frame")
local initialized = false

function EventHandler:Initialize()
	if initialized then
		error("EventHandler already initialized", 2)
	end

	eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

	eventFrame:SetScript("OnEvent", function(self, event, ...)
		if EventHandler[event] then
			EventHandler[event](EventHandler, event, ...)
		end
	end)

	initialized = true
end

function EventHandler:PLAYER_REGEN_DISABLED()
	addon.CombatTimer:Start()
end

function EventHandler:PLAYER_REGEN_ENABLED()
	addon.CombatTimer:Stop()
end
