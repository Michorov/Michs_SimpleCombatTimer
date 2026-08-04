local addonName, addon = ...

addon.OptionsPanel = addon.OptionsPanel or {}
local OptionsPanel = addon.OptionsPanel

local panel
local addonVersion = C_AddOns.GetAddOnMetadata(addonName, "Version") or ""

function OptionsPanel:Initialize()
	if panel then
		return
	end

	panel = addon.OptionsUI:CreatePanel({
		name = "MichsSimpleCombatTimerOptions",
		titleKey = "Mich's Simple Combat Timer",
		localize = function(key)
			return key
		end,
		profileGetter = function()
			return addon.Database:GetSettings()
		end,
	})

	panel:SetFooterUpdater(function()
		return ("Version %s"):format(addonVersion)
	end)

	OptionsPanel.Pages.General:Create(panel)
	panel:SetDefaultPage("general")

	SLASH_MICHSSIMPLECOMBATTIMER1 = "/msct"
	SlashCmdList["MICHSSIMPLECOMBATTIMER"] = function(msg)
		local normalizedMessage = (msg or ""):match("^%s*(.-)%s*$")

		if normalizedMessage ~= "" then
			print("|cffff9900Mich's Simple Combat Timer:|r Unknown command. Use /msct")
			return
		end

		if OptionsPanel:IsOpen() then
			OptionsPanel:Close()
			return
		end

		OptionsPanel:Open()
	end
end

function OptionsPanel:GetPanel()
	return panel
end

function OptionsPanel:Open()
	if not panel then
		self:Initialize()
	end

	panel:Show()
end

function OptionsPanel:Close()
	if panel then
		panel:Hide()
	end
end

function OptionsPanel:IsOpen()
	return panel and panel:IsShown()
end
