local _, addon = ...

local Database = {}
addon.Database = Database

local defaults = {
	enabled = true,
	positionX = 0,
	positionY = 0,
	width = 96,
	height = 32,
	backgroundOpacity = 0.6,
}

function Database:Initialize()
	MichsSimpleCombatTimerDB = MichsSimpleCombatTimerDB or {}

	for key, value in pairs(defaults) do
		if MichsSimpleCombatTimerDB[key] == nil then
			MichsSimpleCombatTimerDB[key] = value
		end
	end

	self.settings = MichsSimpleCombatTimerDB
end

function Database:GetSettings()
	return self.settings
end

function Database:GetDefaults()
	return defaults
end
