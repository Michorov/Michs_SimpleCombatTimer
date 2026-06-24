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

local function RegisterWidthSetting(category)
	local function GetWidth()
		return addon.Database:GetSettings().width
	end

	local function SetWidth(value)
		addon.Database:GetSettings().width = value
		addon.CombatTimer:UpdateSize()
	end

	local setting = Settings.RegisterProxySetting(
		category,
		"MichsSimpleCombatTimer_Width",
		Settings.VarType.Number,
		"Width",
		addon.Database:GetDefaults().width,
		GetWidth,
		SetWidth
	)

	local options = Settings.CreateSliderOptions(64, 300, 1)
	options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)

	Settings.CreateSlider(category, setting, options, "Set the combat timer width.")
end

local function RegisterHeightSetting(category)
	local function GetHeight()
		return addon.Database:GetSettings().height
	end

	local function SetHeight(value)
		addon.Database:GetSettings().height = value
		addon.CombatTimer:UpdateSize()
	end

	local setting = Settings.RegisterProxySetting(
		category,
		"MichsSimpleCombatTimer_Height",
		Settings.VarType.Number,
		"Height",
		addon.Database:GetDefaults().height,
		GetHeight,
		SetHeight
	)

	local options = Settings.CreateSliderOptions(22, 120, 1)
	options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)

	Settings.CreateSlider(category, setting, options, "Set the combat timer height.")
end

function Options:Initialize()
	local category = Settings.RegisterVerticalLayoutCategory("Mich's Combat Timer")

	RegisterEnabledSetting(category)
	RegisterPositionXSetting(category)
	RegisterPositionYSetting(category)
	RegisterWidthSetting(category)
	RegisterHeightSetting(category)

	Settings.RegisterAddOnCategory(category)
end
