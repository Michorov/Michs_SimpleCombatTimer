local _, addon = ...

local CombatTimer = {}
addon.CombatTimer = CombatTimer

local timerFrame

function CombatTimer:Initialize()
	timerFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
	timerFrame.text = timerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")

	self:UpdateSettings()
end

function CombatTimer:UpdateSettings()
	timerFrame:SetSize(120, 40)
	timerFrame:ClearAllPoints()
	timerFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 120)

	timerFrame:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8X8",
		edgeFile = "Interface\\Buttons\\WHITE8X8",
		edgeSize = 1,
	})

	timerFrame:SetBackdropColor(0, 0, 0, 0.6)
	timerFrame:SetBackdropBorderColor(0, 0, 0, 1)

	timerFrame.text:ClearAllPoints()
	timerFrame.text:SetPoint("CENTER", timerFrame, "CENTER")
	timerFrame.text:SetTextColor(1, 1, 1, 1)
	timerFrame.text:SetText("0.0")
end
