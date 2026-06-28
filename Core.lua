local addonName, addon = ...

addon.name = addonName

local addonInitializerFrame = CreateFrame("Frame")
addonInitializerFrame:RegisterEvent("ADDON_LOADED")

addonInitializerFrame:SetScript("OnEvent", function(self, event, loadedAddonName)
	if loadedAddonName ~= addonName then
		return
	end

	addon.PixelPerfect = LibStub("MichsPixelPerfectLib-1.0"):CreateScaler()

	addon.Database:Initialize()
	addon.CombatTimer:Initialize()
	addon.EventHandler:Initialize()
	addon.Options:Initialize()

	self:UnregisterEvent("ADDON_LOADED")
end)
