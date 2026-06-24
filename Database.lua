local _, addon = ...

local Database = {}
addon.Database = Database

local defaults = {
	enabled = true,
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
