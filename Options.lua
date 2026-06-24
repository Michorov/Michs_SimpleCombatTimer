local _, addon = ...

local Options = {}
addon.Options = Options

local function RegisterEnabledSetting(category)
	local function GetEnabled()
		return addon.Database:GetSettings().enabled
	end

	local function SetEnabled(value)
		addon.Database:GetSettings().enabled = value
		addon.CombatTimer:UpdateSettings()
	end

	local setting = Settings.RegisterProxySetting(
		category,
		"MichsSimpleCombatTimer_Enabled",
		Settings.VarType.Boolean,
		"Enabled",
		addon.Database:GetDefaults().enabled,
		GetEnabled,
		SetEnabled
	)

	Settings.CreateCheckbox(category, setting, "Show the combat timer.")
end

function Options:Initialize()
	local category = Settings.RegisterVerticalLayoutCategory("Mich's Combat Timer")

	RegisterEnabledSetting(category)

	Settings.RegisterAddOnCategory(category)
end
