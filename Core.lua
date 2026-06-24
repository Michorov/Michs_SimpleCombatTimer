local addonName, addon = ...

addon.name = addonName

local addonInitializerFrame = CreateFrame("Frame")
addonInitializerFrame:RegisterEvent("ADDON_LOADED")

addonInitializerFrame:SetScript("OnEvent", function(self, event, loadedAddonName)
	if loadedAddonName ~= addonName then
		return
	end

	self:UnregisterEvent("ADDON_LOADED")
end)
