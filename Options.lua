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

local function RegisterPositionXSetting(category)
	local function GetPositionX()
		return addon.Database:GetSettings().positionX
	end

	local function SetPositionX(value)
		addon.Database:GetSettings().positionX = value
		addon.CombatTimer:UpdatePosition()
	end

	local setting = Settings.RegisterProxySetting(
		category,
		"MichsSimpleCombatTimer_PositionX",
		Settings.VarType.Number,
		"Position X",
		addon.Database:GetDefaults().positionX,
		GetPositionX,
		SetPositionX
	)

	local options = Settings.CreateSliderOptions(-2000, 2000, 1)
	options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)

	Settings.CreateSlider(category, setting, options, "Move the combat timer left or right.")
end

local function RegisterPositionYSetting(category)
	local function GetPositionY()
		return addon.Database:GetSettings().positionY
	end

	local function SetPositionY(value)
		addon.Database:GetSettings().positionY = value
		addon.CombatTimer:UpdatePosition()
	end

	local setting = Settings.RegisterProxySetting(
		category,
		"MichsSimpleCombatTimer_PositionY",
		Settings.VarType.Number,
		"Position Y",
		addon.Database:GetDefaults().positionY,
		GetPositionY,
		SetPositionY
	)

	local options = Settings.CreateSliderOptions(-2000, 2000, 1)
	options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)

	Settings.CreateSlider(category, setting, options, "Move the combat timer up or down.")
end

function Options:Initialize()
	local category = Settings.RegisterVerticalLayoutCategory("Mich's Combat Timer")

	RegisterEnabledSetting(category)
	RegisterPositionXSetting(category)
	RegisterPositionYSetting(category)

	Settings.RegisterAddOnCategory(category)
end
