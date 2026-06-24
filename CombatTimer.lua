local _, addon = ...

local CombatTimer = {}
addon.CombatTimer = CombatTimer

local timerFrame

local combatStartTime
local ticker

function CombatTimer:Initialize()
	timerFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
	timerFrame.text = timerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")

	timerFrame:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8X8",
		edgeFile = "Interface\\Buttons\\WHITE8X8",
		edgeSize = 1,
	})

	timerFrame.text:SetPoint("CENTER", timerFrame, "CENTER")

	self:UpdateSettings()
end

function CombatTimer:UpdatePosition()
	local settings = addon.Database:GetSettings()

	timerFrame:ClearAllPoints()
	timerFrame:SetPoint("CENTER", UIParent, "CENTER", settings.positionX, settings.positionY)
end

function CombatTimer:UpdateSize()
	local settings = addon.Database:GetSettings()

	timerFrame:SetSize(settings.width, settings.height)
end

function CombatTimer:UpdateBackground()
	local settings = addon.Database:GetSettings()
	local backgroundOpacity = settings.backgroundOpacity

	if backgroundOpacity <= 0 then
		timerFrame:SetBackdropColor(0, 0, 0, 0)
		timerFrame:SetBackdropBorderColor(0, 0, 0, 0)
		return
	end

	local borderOpacity = math.min(backgroundOpacity + 0.25, 1)

	timerFrame:SetBackdropColor(0, 0, 0, backgroundOpacity)
	timerFrame:SetBackdropBorderColor(0, 0, 0, borderOpacity)
end

function CombatTimer:UpdateTextStyle()
	local settings = addon.Database:GetSettings()

	timerFrame.text:SetFont(STANDARD_TEXT_FONT, settings.fontSize, "OUTLINE")
	timerFrame.text:SetTextColor(1, 1, 1, 1)
end

function CombatTimer:UpdateSettings()
	local settings = addon.Database:GetSettings()

	self:UpdateSize()
	self:UpdatePosition()
	self:UpdateBackground()
	self:UpdateTextStyle()

	timerFrame.text:SetText("00:00")

	if settings.enabled then
		timerFrame:Show()
	else
		timerFrame:Hide()
	end
end

function CombatTimer:Start()
	local settings = addon.Database:GetSettings()
	if not settings.enabled then
		return
	end

	if ticker then
		ticker:Cancel()
		ticker = nil
	end

	combatStartTime = GetTime()
	timerFrame.text:SetText("00:00")

	ticker = C_Timer.NewTicker(1, function()
		self:UpdateTimerText()
	end)
end

function CombatTimer:Stop()
	if not ticker then
		return
	end

	self:UpdateTimerText()

	ticker:Cancel()
	ticker = nil
end

function CombatTimer:UpdateTimerText()
	if not ticker or not combatStartTime then
		return
	end

	local elapsed = GetTime() - combatStartTime
	local minutes = math.floor(elapsed / 60)
	local seconds = math.floor(elapsed % 60)

	timerFrame.text:SetText(string.format("%02d:%02d", minutes, seconds))
end
