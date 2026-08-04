local _, addon = ...

addon.OptionsPanel = addon.OptionsPanel or {}
addon.OptionsPanel.Pages = addon.OptionsPanel.Pages or {}
addon.OptionsPanel.Pages.General = addon.OptionsPanel.Pages.General or {}

local General = addon.OptionsPanel.Pages.General

function General:Create(panel)
	local page = panel:RegisterPage("general", {
		titleKey = "General",
		showHeader = true,
	})
	local subpage = page:RegisterSubPage("general", { titleKey = "General" })

	local firstRow = subpage:CreateRow(2)
	firstRow:SetLayoutPoint("TOPLEFT", subpage.frame, "TOPLEFT", 0, 0)

	local showTimerSlot = firstRow:CreateCheckboxSlot("top")
	local showTimerCheckbox = showTimerSlot:CreateControl("Checkbox", { labelKey = "Show Timer" })
	showTimerCheckbox:BindValue({
		get = function(settings)
			return settings.showTimer
		end,
		set = function(settings, _, value)
			settings.showTimer = value
		end,
		onChange = function()
			addon.CombatTimer:UpdateSettings()
		end,
	})

	local positionRow = subpage:CreateRow(4)
	positionRow:SetLayoutPoint("TOPLEFT", firstRow.frame, "BOTTOMLEFT", 0, -16)

	local positionXSlider = positionRow:CreateControl("Slider", { labelKey = "Position X" })
	positionXSlider:SetMinMaxValues(-2000, 2000)
	positionXSlider:SetStep(1)
	positionXSlider:BindValue({
		get = function(settings)
			return settings.positionX
		end,
		set = function(settings, _, value)
			settings.positionX = value
		end,
		onChange = function()
			addon.CombatTimer:UpdatePosition()
		end,
	})

	local positionYSlider = positionRow:CreateControl("Slider", { labelKey = "Position Y" })
	positionYSlider:SetMinMaxValues(-2000, 2000)
	positionYSlider:SetStep(1)
	positionYSlider:BindValue({
		get = function(settings)
			return settings.positionY
		end,
		set = function(settings, _, value)
			settings.positionY = value
		end,
		onChange = function()
			addon.CombatTimer:UpdatePosition()
		end,
	})

	local panelRow = subpage:CreateRow(4)
	panelRow:SetLayoutPoint("TOPLEFT", positionRow.frame, "BOTTOMLEFT", 0, -16)

	local widthSlider = panelRow:CreateControl("Slider", { labelKey = "Panel Width" })
	widthSlider:SetMinMaxValues(64, 300)
	widthSlider:SetStep(1)
	widthSlider:BindValue({
		get = function(settings)
			return settings.width
		end,
		set = function(settings, _, value)
			settings.width = value
		end,
		onChange = function()
			addon.CombatTimer:UpdateSize()
			addon.CombatTimer:UpdatePosition()
		end,
	})

	local heightSlider = panelRow:CreateControl("Slider", { labelKey = "Panel Height" })
	heightSlider:SetMinMaxValues(22, 120)
	heightSlider:SetStep(1)
	heightSlider:BindValue({
		get = function(settings)
			return settings.height
		end,
		set = function(settings, _, value)
			settings.height = value
		end,
		onChange = function()
			addon.CombatTimer:UpdateSize()
			addon.CombatTimer:UpdatePosition()
		end,
	})

	local backgroundOpacitySlider = panelRow:CreateControl("Slider", { labelKey = "Panel Opacity" })
	backgroundOpacitySlider:SetMinMaxValues(0, 1)
	backgroundOpacitySlider:SetStep(0.05)
	backgroundOpacitySlider:SetValueFormatter(function(value)
		return string.format("%.0f%%", value * 100)
	end)
	backgroundOpacitySlider:SetValueParser("percent")
	backgroundOpacitySlider:BindValue({
		get = function(settings)
			return settings.backgroundOpacity
		end,
		set = function(settings, _, value)
			settings.backgroundOpacity = value
		end,
		onChange = function()
			addon.CombatTimer:UpdateBackground()
		end,
	})

	local textRow = subpage:CreateRow(4)
	textRow:SetLayoutPoint("TOPLEFT", panelRow.frame, "BOTTOMLEFT", 0, -16)

	local fontSizeSlider = textRow:CreateControl("Slider", { labelKey = "Font Size" })
	fontSizeSlider:SetMinMaxValues(8, 64)
	fontSizeSlider:SetStep(1)
	fontSizeSlider:BindValue({
		get = function(settings)
			return settings.fontSize
		end,
		set = function(settings, _, value)
			settings.fontSize = value
		end,
		onChange = function()
			addon.CombatTimer:UpdateTextStyle()
		end,
	})

	local textColorPicker = textRow:CreateControl("ColorPicker", { labelKey = "Font Color" })
	textColorPicker:SetHasOpacity(true)
	textColorPicker:BindValue({
		get = function(settings)
			local color = CreateColorFromHexString(settings.textColor)
			local r, g, b, a = color:GetRGBA()

			return {
				r = r,
				g = g,
				b = b,
				a = a,
			}
		end,
		set = function(settings, _, value)
			settings.textColor = string.format(
				"%02X%02X%02X%02X",
				math.floor((value.a or 1) * 255 + 0.5),
				math.floor((value.r or 1) * 255 + 0.5),
				math.floor((value.g or 1) * 255 + 0.5),
				math.floor((value.b or 1) * 255 + 0.5)
			)
		end,
		onChange = function()
			addon.CombatTimer:UpdateTextStyle()
		end,
	})

	return page
end
