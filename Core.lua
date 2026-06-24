local addonName, addon = ...

addon.name = addonName

local addonInitializerFrame = CreateFrame("Frame")
addonInitializerFrame:RegisterEvent("ADDON_LOADED")

addonInitializerFrame:SetScript("OnEvent", function(self, event, loadedAddonName)
	if loadedAddonName ~= addonName then
		return
	end

	addon.Database:Initialize()
	addon.CombatTimer:Initialize()
	addon.EventHandler:Initialize()

	self:UnregisterEvent("ADDON_LOADED")
end)
