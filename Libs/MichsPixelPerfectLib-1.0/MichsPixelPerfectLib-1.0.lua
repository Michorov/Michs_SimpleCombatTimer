local MAJOR, MINOR = "MichsPixelPerfectLib-1.0", 1

assert(LibStub, MAJOR .. " requires LibStub")

local MichsPixelPerfect = LibStub:NewLibrary(MAJOR, MINOR)
if not MichsPixelPerfect then
	return
end

local cachedPixelStep

local Scaler = MichsPixelPerfect.Scaler or {}
MichsPixelPerfect.Scaler = Scaler
Scaler.__index = Scaler

local function GetPixelStep()
	if not cachedPixelStep then
		MichsPixelPerfect:RefreshPixelGrid()
	end
	return cachedPixelStep
end

local function RoundToNearestInt(value)
	value = value or 0

	if value >= 0 then
		return math.floor(value + 0.5)
	end

	return math.ceil(value - 0.5)
end

local function Scale(scaler, value)
	return (value or 0) * scaler.globalScale
end

local function ScaleToResolution(value)
	local step = GetPixelStep()
	return (value or 0) / step
end

function MichsPixelPerfect:RefreshPixelGrid()
	local _, physicalHeight = GetPhysicalScreenSize()
	local uiScale = UIParent and UIParent:GetEffectiveScale()

	if type(physicalHeight) ~= "number" or physicalHeight <= 0 then
		physicalHeight = 1080
	end

	if type(uiScale) ~= "number" or uiScale <= 0 then
		uiScale = 1
	end

	local pixelScale = 768 / physicalHeight
	cachedPixelStep = pixelScale / uiScale
end

function MichsPixelPerfect:CreateScaler()
	local scaler = {
		globalScale = 1,
	}

	return setmetatable(scaler, Scaler)
end

function Scaler:RefreshPixelGrid()
	MichsPixelPerfect:RefreshPixelGrid()
end

function Scaler:SetGlobalScale(value)
	if type(value) ~= "number" then
		return
	end

	self.globalScale = math.min(2, math.max(0.5, value))
end

function Scaler:ToUI(pixelCount)
	local scaledPixels = Scale(self, pixelCount)
	local roundedPixels = RoundToNearestInt(scaledPixels)

	return roundedPixels * GetPixelStep()
end

function Scaler:ScaleFont(size)
	local scaledFontSize = Scale(self, size)
	local roundedFontSize = RoundToNearestInt(scaledFontSize)

	return math.max(1, roundedFontSize)
end

function Scaler:ToUIScaled(value)
	local scaledToResolutionPixels = ScaleToResolution(value)

	return self:ToUI(scaledToResolutionPixels)
end
