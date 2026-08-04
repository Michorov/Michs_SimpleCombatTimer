local addonName, addon = ...

addon.name = addonName
addon.OptionsUI = LibStub("MichsOptionsUILib-1.0"):CreateInstance({
	addonName = addonName,
	title = "Mich's Simple Combat Timer",
})

local addonInitializerFrame = CreateFrame("Frame")
addonInitializerFrame:RegisterEvent("ADDON_LOADED")

addonInitializerFrame:SetScript("OnEvent", function(self, event, loadedAddonName)
	if loadedAddonName ~= addonName then
		return
	end

	addon.Database:Initialize()
	addon.CombatTimer:Initialize()
	addon.EventHandler:Initialize()
	addon.Options:Initialize()
	addon.OptionsPanel:Initialize()

	self:UnregisterEvent("ADDON_LOADED")
end)
