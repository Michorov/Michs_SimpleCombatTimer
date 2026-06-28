local _, addon = ...

local CombatTimer = {}
addon.CombatTimer = CombatTimer

addon.PixelPerfect = LibStub("MichsPixelPerfectLib-1.0"):CreateScaler()
local PP = addon.PixelPerfect

local timerFrame

local combatStartTime
local ticker

function CombatTimer:Initialize()
	timerFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
	timerFrame.text = timerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")

	timerFrame.text:SetText("00:00")
	timerFrame.text:SetPoint("CENTER", timerFrame, "CENTER")

	PP:RegisterForUpdate(function()
		self:UpdateSettings()
	end)
end

function CombatTimer:UpdatePosition()
	local settings = addon.Database:GetSettings()
	PP:CenterElement(timerFrame, UIParent, PP:ToUIScaled(settings.positionX), PP:ToUIScaled(settings.positionY))
end

function CombatTimer:UpdateSize()
	local settings = addon.Database:GetSettings()

	timerFrame:SetSize(PP:ToUIScaled(settings.width), PP:ToUIScaled(settings.height))
	timerFrame:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8X8",
		edgeFile = "Interface\\Buttons\\WHITE8X8",
		edgeSize = PP:ToUIScaled(1),
	})
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
	local color = CreateColorFromHexString(settings.textColor)

	timerFrame.text:SetFont(STANDARD_TEXT_FONT, PP:ScaleFont(settings.fontSize), "OUTLINE")
	timerFrame.text:SetTextColor(color:GetRGBA())
end

function CombatTimer:UpdateSettings()
	local settings = addon.Database:GetSettings()

	self:UpdateSize()
	self:UpdatePosition()
	self:UpdateBackground()
	self:UpdateTextStyle()

	if settings.showTimer then
		timerFrame:Show()
	else
		timerFrame:Hide()
	end
end

function CombatTimer:Start()
	local settings = addon.Database:GetSettings()
	if not settings.showTimer then
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
