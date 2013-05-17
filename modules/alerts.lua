local GladiusEx = _G.GladiusEx
local L = LibStub("AceLocale-3.0"):GetLocale("GladiusEx")

-- globals
local pairs = pairs
local max = math.max
local tinsert, tremove = table.insert, table.remove
local UnitBuff, UnitDebuff, UnitHealth, UnitHealthMax, UnitIsDeadOrGhost = UnitBuff, UnitDebuff, UnitHealth, UnitHealthMax, UnitIsDeadOrGhost
local GetTime = GetTime

local function GetDefaultCastsSpells()
	local v = { priority = 5, color = { r = 0, g = 1, b = 0, a = 1 } }
	return {
		[GetSpellInfo(2060)] = v,       -- Greater Heal
		[GetSpellInfo(82326)] = v,      -- Divine Light
		[GetSpellInfo(50464)] = v,      -- Nourish
		[GetSpellInfo(77472)] = v,      -- Greater Healing Wave
		[GetSpellInfo(115175)] = v,     -- Soothing Mist
	}
end

local function GetDefaultAuraSpells()
	local v = { priority = 15, color = { r = 1, g = 1, b = 1, a = 1 } }
	return {
		-- Crowd control
		[GetSpellInfo(108194)] 	= v,    -- Asphyxiate
		[GetSpellInfo(115001)] 	= v,    -- Remorseless Winter
		[GetSpellInfo(91800)] 	= v,    -- Gnaw
		[GetSpellInfo(91797)] 	= v,    -- Monstrous Blow (Dark Transformation)
		[GetSpellInfo(113801)] 	= v,    -- Bash (Force of Nature - Feral Treants)
		[GetSpellInfo(102795)] 	= v,    -- Bear Hug
		[GetSpellInfo(33786)] 	= v,    -- Cyclone
		[GetSpellInfo(99)] 		= v,    -- Disorienting Roar
		[GetSpellInfo(2637)] 	= v,    -- Hibernate
		[GetSpellInfo(22570)] 	= v,    -- Maim
		[GetSpellInfo(5211)] 	= v,    -- Mighty Bash
		[GetSpellInfo(9005)] 	= v,    -- Pounce
		[GetSpellInfo(102546)] 	= v,    -- Pounce (Incarnation)
		[GetSpellInfo(110698)] 	= v,    -- Hammer of Justice (Paladin)
		[GetSpellInfo(113004)] 	= v,    -- Intimidating Roar [Fleeing in fear] (Warrior)
		[GetSpellInfo(113056)] 	= v,    -- Intimidating Roar [Cowering in fear] (Warrior)
		[GetSpellInfo(117526)] 	= v,    -- Binding Shot
		[GetSpellInfo(3355)] 	= v,    -- Freezing Trap
		[GetSpellInfo(1513)] 	= v,    -- Scare Beast
		[GetSpellInfo(19503)] 	= v,    -- Scatter Shot
		[GetSpellInfo(19386)] 	= v,    -- Wyvern Sting
		[GetSpellInfo(90337)] 	= v,    -- Bad Manner (Monkey)
		[GetSpellInfo(24394)] 	= v,    -- Intimidation
		[GetSpellInfo(126246)] 	= v,    -- Lullaby (Crane)
		[GetSpellInfo(126355)] 	= v,    -- Paralyzing Quill (Porcupine)
		[GetSpellInfo(126423)] 	= v,    -- Petrifying Gaze (Basilisk)
		[GetSpellInfo(50519)] 	= v,    -- Sonic Blast (Bat)
		[GetSpellInfo(56626)] 	= v,    -- Sting (Wasp)
		[GetSpellInfo(96201)] 	= v,    -- Web Wrap (Shale Spider)
		[GetSpellInfo(118271)] 	= v,    -- Combustion Impact
		[GetSpellInfo(44572)] 	= v,    -- Deep Freeze
		[GetSpellInfo(31661)] 	= v,    -- Dragon's Breath
		[GetSpellInfo(118)] 	= v,    -- Polymorph
		[GetSpellInfo(61305)] 	= v,    -- Polymorph: Black Cat
		[GetSpellInfo(28272)] 	= v,    -- Polymorph: Pig
		[GetSpellInfo(61721)] 	= v,    -- Polymorph: Rabbit
		[GetSpellInfo(61780)] 	= v,    -- Polymorph: Turkey
		[GetSpellInfo(28271)] 	= v,    -- Polymorph: Turtle
		[GetSpellInfo(82691)] 	= v,    -- Ring of Frost
		[GetSpellInfo(123393)] 	= v,    -- Breath of Fire (Glyph of Breath of Fire)
		[GetSpellInfo(126451)] 	= v,    -- Clash
		[GetSpellInfo(122242)] 	= v,    -- Clash (not sure which one is right)
		[GetSpellInfo(119392)] 	= v,    -- Charging Ox Wave
		[GetSpellInfo(120086)] 	= v,    -- Fists of Fury
		[GetSpellInfo(119381)] 	= v,    -- Leg Sweep
		[GetSpellInfo(115078)] 	= v,    -- Paralysis
		[GetSpellInfo(105421)] 	= v,    -- Blinding Light
		[GetSpellInfo(115752)] 	= v,    -- Blinding Light (Glyph of Blinding Light)
		[GetSpellInfo(105593)] 	= v,    -- Fist of Justice
		[GetSpellInfo(853)] 	= v,    -- Hammer of Justice
		[GetSpellInfo(119072)] 	= v,    -- Holy Wrath
		[GetSpellInfo(20066)] 	= v,    -- Repentance
		[GetSpellInfo(10326)] 	= v,    -- Turn Evil
		[GetSpellInfo(113506)] 	= v,    -- Cyclone (Symbiosis)
		[GetSpellInfo(605)] 	= v,    -- Dominate Mind
		[GetSpellInfo(88625)] 	= v,    -- Holy Word: Chastise
		[GetSpellInfo(64044)] 	= v,    -- Psychic Horror
		[GetSpellInfo(8122)] 	= v,    -- Psychic Scream
		[GetSpellInfo(113792)] 	= v,    -- Psychic Terror (Psyfiend)
		[GetSpellInfo(9484)] 	= v,    -- Shackle Undead
		[GetSpellInfo(87204)] 	= v,    -- Sin and Punishment
		[GetSpellInfo(2094)] 	= v,    -- Blind
		[GetSpellInfo(1833)] 	= v,    -- Cheap Shot
		[GetSpellInfo(1776)] 	= v,    -- Gouge
		[GetSpellInfo(408)] 	= v,    -- Kidney Shot
		[GetSpellInfo(113953)] 	= v,    -- Paralysis (Paralytic Poison)
		[GetSpellInfo(6770)] 	= v,    -- Sap
		[GetSpellInfo(76780)] 	= v,    -- Bind Elemental
		[GetSpellInfo(77505)] 	= v,    -- Earthquake
		[GetSpellInfo(51514)] 	= v,    -- Hex
		[GetSpellInfo(118905)] 	= v,    -- Static Charge (Capacitor Totem)
		[GetSpellInfo(710)] 	= v,    -- Banish
		[GetSpellInfo(137143)] 	= v,    -- Blood Horror
		[GetSpellInfo(54786)] 	= v,    -- Demonic Leap (Metamorphosis)
		[GetSpellInfo(5782)] 	= v,    -- Fear
		[GetSpellInfo(118699)] 	= v,    -- Fear
		[GetSpellInfo(130616)] 	= v,    -- Fear (Glyph of Fear)
		[GetSpellInfo(5484)] 	= v,    -- Howl of Terror
		[GetSpellInfo(22703)] 	= v,    -- Infernal Awakening
		[GetSpellInfo(6789)] 	= v,    -- Mortal Coil
		[GetSpellInfo(132412)] 	= v,    -- Seduction (Grimoire of Sacrifice)
		[GetSpellInfo(30283)] 	= v,    -- Shadowfury
		[GetSpellInfo(104045)] 	= v,    -- Sleep (Metamorphosis)
		[GetSpellInfo(7922)] 	= v,    -- Charge Stun
		[GetSpellInfo(118895)] 	= v,    -- Dragon Roar
		[GetSpellInfo(5246)] 	= v,    -- Intimidating Shout (aoe)
		[GetSpellInfo(20511)] 	= v,    -- Intimidating Shout (targeted)
		[GetSpellInfo(132168)] 	= v,    -- Shockwave
		[GetSpellInfo(107570)] 	= v,    -- Storm Bolt
		[GetSpellInfo(105771)] 	= v,    -- Warbringer
		[GetSpellInfo(107079)] 	= v,    -- Quaking Palm
		[GetSpellInfo(20549)] 	= v,    -- War Stomp
		[GetSpellInfo(118345)] 	= v,    -- Pulverize
		[GetSpellInfo(89766)] 	= v,    -- Axe Toss (Felguard/Wrathguard)
		[GetSpellInfo(115268)] 	= v,    -- Mesmerize (Shivarra)
		[GetSpellInfo(6358)] 	= v,    -- Seduction (Succubus)

		-- Roots
		-- [GetSpellInfo(96294)] 	= v,    -- Chains of Ice (Chilblains)
		-- [GetSpellInfo(91807)] 	= v,    -- Shambling Rush (Dark Transformation)
		-- [GetSpellInfo(339)] 	= v,    -- Entangling Roots
		-- [GetSpellInfo(113770)] 	= v,    -- Entangling Roots (Force of Nature - Balance Treants)
		-- [GetSpellInfo(19975)] 	= v,    -- Entangling Roots (Nature's Grasp)
		-- [GetSpellInfo(45334)] 	= v,    -- Immobilized (Wild Charge - Bear)
		-- [GetSpellInfo(102359)] 	= v,    -- Mass Entanglement
		-- [GetSpellInfo(110693)] 	= v,    -- Frost Nova (Mage)
		-- [GetSpellInfo(19185)] 	= v,    -- Entrapment
		-- [GetSpellInfo(128405)] 	= v,    -- Narrow Escape
		-- [GetSpellInfo(90327)] 	= v,    -- Lock Jaw (Dog)
		-- [GetSpellInfo(50245)] 	= v,    -- Pin (Crab)
		-- [GetSpellInfo(54706)] 	= v,    -- Venom Web Spray (Silithid)
		-- [GetSpellInfo(4167)] 	= v,    -- Web (Spider)
		-- [GetSpellInfo(122)] 	= v,    -- Frost Nova
		-- [GetSpellInfo(111340)] 	= v,    -- Ice Ward
		-- [GetSpellInfo(33395)] 	= v,    -- Freeze
		-- [GetSpellInfo(116706)] 	= v,    -- Disable
		-- [GetSpellInfo(113275)] 	= v,    -- Entangling Roots (Symbiosis)
		-- [GetSpellInfo(123407)] 	= v,    -- Spinning Fire Blossom
		-- [GetSpellInfo(113275)] 	= v,    -- Entangling Roots (Symbiosis)
		-- [GetSpellInfo(87194)] 	= v,    -- Glyph of Mind Blast
		-- [GetSpellInfo(114404)] 	= v,    -- Void Tendril's Grasp
		-- [GetSpellInfo(115197)] 	= v,    -- Partial Paralysis
		-- [GetSpellInfo(64695)] 	= v,    -- Earthgrab (Earthgrab Totem)
		-- [GetSpellInfo(63685)] 	= v,    -- Freeze (Frozen Power)
		-- [GetSpellInfo(107566)] 	= v,    -- Staggering Shout

		-- Silences
		[GetSpellInfo(47476)] 	= v,    -- Strangulate
		[GetSpellInfo(114238)] 	= v,    -- Fae Silence (Glyph of Fae Silence)
		[GetSpellInfo(81261)] 	= v,    -- Solar Beam
		[GetSpellInfo(34490)] 	= v,    -- Silencing Shot
		[GetSpellInfo(102051)] 	= v,    -- Frostjaw (also a root)
		[GetSpellInfo(55021)] 	= v,    -- Silenced - Improved Counterspell
		[GetSpellInfo(116709)] 	= v,    -- Spear Hand Strike
		[GetSpellInfo(31935)] 	= v,    -- Avenger's Shield
		[GetSpellInfo(15487)] 	= v,    -- Silence
		[GetSpellInfo(1330)] 	= v,    -- Garrote - Silence
		[GetSpellInfo(113287)] 	= v,    -- Solar Beam (Symbiosis)
		[GetSpellInfo(132409)] 	= v,    -- Spell Lock (Grimoire of Sacrifice)
		[GetSpellInfo(31117)] 	= v,    -- Unstable Affliction
		[GetSpellInfo(115782)] 	= v,    -- Optical Blast (Observer)
		[GetSpellInfo(24259)] 	= v,    -- Spell Lock (Felhunter
		[GetSpellInfo(25046)] 	= v,    -- Arcane Torrent (Energy)
		[GetSpellInfo(28730)] 	= v,    -- Arcane Torrent (Mana)
		[GetSpellInfo(50613)] 	= v,    -- Arcane Torrent (Runic Power)
		[GetSpellInfo(69179)] 	= v,    -- Arcane Torrent (Rage)
		[GetSpellInfo(80483)] 	= v,    -- Arcane Torrent (Focus)
		[GetSpellInfo(129597)] 	= v,    -- Arcane Torrent (Chi)

		-- Disarms
		-- [GetSpellInfo(126458)] 	= v,    -- Grapple Weapon (Monk)
		-- [GetSpellInfo(50541)] 	= v,    -- Clench (Scorpid)
		-- [GetSpellInfo(91644)] 	= v,    -- Snatch (Bird of Prey)
		-- [GetSpellInfo(117368)] 	= v,    -- Grapple Weapon
		-- [GetSpellInfo(64058)] 	= v,    -- Psychic Horror
		-- [GetSpellInfo(51722)] 	= v,    -- Dismantle
		-- [GetSpellInfo(118093)] 	= v,    -- Disarm (Voidwalker/Voidlord)
		-- [GetSpellInfo(676)] 	= v,    -- Disarm

		-- Buffs
		-- [GetSpellInfo(48792)] 	= v,    -- Icebound Fortitude
		-- [GetSpellInfo(49039)] 	= v,    -- Lichborne
		-- [GetSpellInfo(110575)] 	= v,    -- Icebound Fortitude (Death Knight)
		-- [GetSpellInfo(122291)] 	= v,    -- Unending Resolve (Warlock)
		-- [GetSpellInfo(31821)] 	= v,    -- Aura Mastery
		-- [GetSpellInfo(113002)] 	= v,    -- Spell Reflection (Warrior)
		-- [GetSpellInfo(8178)] 	= v,    -- Grounding Totem Effect (Grounding Totem)
		-- [GetSpellInfo(104773)] 	= v,    -- Unending Resolve
		-- [GetSpellInfo(23920)] 	= v,    -- Spell Reflection
		-- [GetSpellInfo(114028)] 	= v,    -- Mass Spell Reflection
		-- [GetSpellInfo(131557)] 	= v,    -- Spiritwalker's Aegis
		-- [GetSpellInfo(89485)] 	= v,    -- Inner Focus
		-- [GetSpellInfo(6940)] 	= v,    -- Hand of Sacrifice
		-- [GetSpellInfo(110913)] 	= v,    -- Dark Bargain

		-- Immunities
		[GetSpellInfo(115018)] 	= v,    -- Desecrated Ground
		[GetSpellInfo(48707)] 	= v,    -- Anti-Magic Shell
		[GetSpellInfo(110617)] 	= v,    -- Deterrence (Hunter)
		[GetSpellInfo(110715)] 	= v,    -- Dispersion (Priest)
		[GetSpellInfo(110700)] 	= v,    -- Divine Shield (Paladin)
		[GetSpellInfo(110696)] 	= v,    -- Ice Block (Mage)
		[GetSpellInfo(110570)] 	= v,    -- Anti-Magic Shell (Death Knight)
		[GetSpellInfo(110788)] 	= v,    -- Cloak of Shadows (Rogue)
		[GetSpellInfo(19263)] 	= v,    -- Deterrence
		[GetSpellInfo(45438)] 	= v,    -- Ice Block
		[GetSpellInfo(115760)] 	= v,    -- Glyph of Ice Block
		[GetSpellInfo(131523)] 	= v,    -- Zen Meditation
		[GetSpellInfo(642)] 	= v,    -- Divine Shield
		[GetSpellInfo(47585)] 	= v,    -- Dispersion
		[GetSpellInfo(31224)] 	= v,    -- Cloak of Shadows
		[GetSpellInfo(46924)] 	= v,    -- Bladestorm
	}
end

local Alerts = GladiusEx:NewGladiusExModule("Alerts", false, {
		minAlpha = 0.2,
		maxAlpha = 0.6,
		duration = 0.35,
		ease = "OUT",
		blendMode = "BLEND",

		health = true,
		healthThreshold = 0.25,
		healthPriority = 10,
		healthColor = { r = 1, g = 0, b = 0, a = 1 },

		casts = true,
		castsSpells = GetDefaultCastsSpells(),
		
		auras = true,
		aurasSpells = GetDefaultAuraSpells(),
	})

function Alerts:OnEnable()
	self:RegisterEvent("UNIT_AURA")
	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("UNIT_NAME_UPDATE", "UNIT_HEALTH")
	self:RegisterEvent("UNIT_SPELLCAST_START")
	self:RegisterEvent("UNIT_SPELLCAST_STOP")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("UNIT_SPELLCAST_FAILED", "UNIT_SPELLCAST_STOP")
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "UNIT_SPELLCAST_STOP")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", "UNIT_SPELLCAST_START")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "UNIT_SPELLCAST_STOP")

	if not self.frame then
		self.frame = {}
	end
end

function Alerts:OnDisable()
	self:UnregisterAllEvents()

	for unit in pairs(self.frame) do
		self.frame[unit]:SetAlpha(0)
	end
end

function Alerts:CreateFrame(unit)
	local button = GladiusEx.buttons[unit]
	if not button then return end

	-- create frame
	self.frame[unit] = CreateFrame("Frame", "GladiusEx" .. self:GetName() .. unit, button)
	self.frame[unit].texture = self.frame[unit]:CreateTexture("GladiusEx" .. self:GetName() .. "Texture" .. unit, "OVERLAY")
	self.frame[unit].texture:SetAllPoints()
	self.frame[unit].ag = self.frame[unit]:CreateAnimationGroup()
	self.frame[unit].ag.aa = self.frame[unit].ag:CreateAnimation("Alpha")
end

function Alerts:Update(unit)
	local testing = GladiusEx:IsTesting(unit)

	-- create frame
	if not self.frame[unit] then
		self:CreateFrame(unit)
	end

	-- frame
	local parent = GladiusEx:GetAttachFrame(unit, "Frame")
	local left, right, top, bottom = parent:GetHitRectInsets()
	self.frame[unit]:ClearAllPoints()
	self.frame[unit]:SetPoint("TOPLEFT", parent, "TOPLEFT", left, -top)
	self.frame[unit]:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -right, bottom)
	self.frame[unit]:SetFrameLevel(100)

	-- texture
	self.frame[unit].texture:SetTexture(1, 1, 1)
	self.frame[unit].texture:SetBlendMode(self.db[unit].blendMode)

	-- animation group
	self.frame[unit]:SetAlpha(self.db[unit].maxAlpha)
	self.frame[unit].ag:SetLooping("BOUNCE")
	self.frame[unit].ag.aa:SetChange(-(self.db[unit].maxAlpha - self.db[unit].minAlpha))
	self.frame[unit].ag.aa:SetDuration(self.db[unit].duration)
	self.frame[unit].ag.aa:SetSmoothing(self.db[unit].ease)
	self.frame[unit].ag:Stop()

	self.frame[unit]:Hide()
end

function Alerts:Show(unit)
end

function Alerts:Reset(unit)
	if not self.frame[unit] then return end

	self:StopFlash(unit)
	self:ClearAllAlerts(unit)
end

function Alerts:Test(unit)
	self:ClearAllAlerts(unit)
	self:SetAlert(unit, "test", 1, { r = 1, g = 0, b = 0, a = 1 })
end

function Alerts:Refresh(unit)
end

function Alerts:SetFlashColor(unit, color)
	self.frame[unit].texture:SetVertexColor(color.r, color.g, color.b, color.a)
end

function Alerts:StartFlash(unit, color)
	local f = self.frame[unit]
	f.texture:SetVertexColor(color.r, color.g, color.b, color.a)
	
	f:SetAlpha(self.db[unit].maxAlpha)
	f:Show()
	f.ag:Play()
end

function Alerts:StopFlash(unit)
	self.frame[unit].ag:Stop()
	self.frame[unit].ag:SetScript("OnLoop", nil)
	self.frame[unit]:SetAlpha(0)
	self.frame[unit]:Hide()
end

local loop_queue = {}
function Alerts:QueueLoopEvent(unit, count, func)
	if not loop_queue[unit] then loop_queue[unit] = {} end

	tinsert(loop_queue[unit], { ["start"] = GetTime(), ["count"] = count, ["func"] = func })

	if #loop_queue[unit] == 1 then
		self.frame[unit].ag:SetScript("OnLoop",	function(ag, loopState)
			if loopState == "REVERSE" then
				local start_threshold = GetTime() - 0.3
				for i = #loop_queue[unit], 1, -1 do
					local q = loop_queue[unit][i]
					if start_threshold >= q.start then
						q.count = q.count - 1
						if q.count <= 0 then
							self[q.func](self, unit)
							tremove(loop_queue[unit], i)
						end
					end
				end
				if #loop_queue[unit] == 0 then
					ag:SetScript("OnLoop", nil)
				end
			end
		end)
	end
end

local alerts = {}
local alerts_color = {}
function Alerts:SetAlert(unit, alert, priority, color)
	assert(type(unit) == "string")
	assert(type(alert) == "string")
	assert(type(priority) == "number")
	assert(type(color) == "table")
	if not alerts[unit] then alerts[unit] = { count = 0, priority = 0, current = false, alerts = {} } end
	if not alerts_color[unit] then alerts_color[unit] = {} end

	if not alerts[unit].alerts[alert] then
		alerts[unit].alerts[alert] = priority
		alerts_color[unit][alert] = color
		alerts[unit].count = alerts[unit].count + 1
		
		if alerts[unit].count == 1 or alerts[unit].priority < priority then
			alerts[unit].priority = priority
			alerts[unit].current = alert
			self:StartFlash(unit, color)
			GladiusEx:Log("start", unit, alert)
		end
	end
end

function Alerts:UpdateAlertColor(unit)
	-- find new alert
	local new_alert
	local new_priority = 0
	for alert, priority in pairs(alerts[unit].alerts) do
		if priority and priority > new_priority then
			new_alert = alert
			new_priority = priority
		end
	end
	GladiusEx:Log(unit, new_alert, new_priority, alerts[unit].priority)
	if new_alert then
		local cur_alert = alerts[unit].current
		if not alerts[unit][cur_alert] or new_priority > alerts[unit].priority then
			alerts[unit].priority = new_priority
			alerts[unit].current = new_alert
			self:SetFlashColor(unit, alerts_color[unit][new_alert])
		end
	else
		alerts[unit].priority = 0
		alerts[unit].current = false
		self:StopFlash(unit)
	end
end

function Alerts:ClearAlert(unit, alert, count)
	if alerts[unit] and alerts[unit].alerts[alert] then
		alerts[unit].alerts[alert] = false
		alerts[unit].count = alerts[unit].count - 1

		if count and count > 0 then
			self:QueueLoopEvent(unit, count or 1, "UpdateAlertColor")
		else
			self:UpdateAlertColor(unit)
		end
	end
end

function Alerts:IsAlertActive(unit, alert)
	return alerts[unit] and alerts[unit].alerts[alert]
end

function Alerts:ClearAllAlerts(unit)
	alerts[unit] = nil
end

function Alerts:UNIT_AURA(event, unit)
	if not self.frame[unit] then return end
	if not self.db[unit].auras then return end

	for name, aura in pairs(self.db[unit].aurasSpells) do
		if UnitBuff(unit, name) or UnitDebuff(unit, name) then
			self:SetAlert(unit, "aura_" .. name, aura.priority, aura.color)
		else
			self:ClearAlert(unit, "aura_" .. name)
		end
	end
end

function Alerts:UNIT_HEALTH(event, unit)
	if not self.frame[unit] then return end
	if not self.db[unit].health then return end

	local health = UnitHealth(unit)
	local healthMax = UnitHealthMax(unit)

	if not UnitIsDeadOrGhost(unit) and (health / healthMax) <= self.db[unit].healthThreshold then
		self:SetAlert(unit, "health", self.db[unit].healthPriority, self.db[unit].healthColor)
	else
		self:ClearAlert(unit, "health")
	end
end

function Alerts:UNIT_SPELLCAST_START(event, unit, spell)
	if not self.frame[unit] then return end
	if not self.db[unit].casts then return end

	local cast = self.db[unit].castsSpells[spell]
	if cast then
		self:SetAlert(unit, "cast_" .. spell, cast.priority, cast.color)
	end
end

function Alerts:UNIT_SPELLCAST_SUCCEEDED(event, unit, spell)
	if not self.frame[unit] then return end
	if not self.db[unit].casts then return end

	local cast = self.db[unit].castsSpells[spell]
	if cast and not self:IsAlertActive(unit, "cast_" .. spell) then
		self:SetAlert(unit, "cast_" .. spell, cast.priority, cast.color)
		self:ClearAlert(unit, "cast_" .. spell, 1)
	end
end

function Alerts:UNIT_SPELLCAST_STOP(event, unit, spell)
	if not self.frame[unit] then return end
	if not self.db[unit].casts then return end

	self:ClearAlert(unit, "cast_" .. spell)
end

local function HasAuraEditBox()
	return not not LibStub("AceGUI-3.0").WidgetVersions["Aura_EditBox"]
end

local function HasSpellEditBox()
	return not not LibStub("AceGUI-3.0").WidgetVersions["Spell_EditBox"]
end

function Alerts:GetOptions(unit)
	local options
	options = {
		general = {
			type = "group",
			name = L["General"],
			order = 1,
			args = {
				bar = {
					type = "group",
					name = L["Alert animation"],
					desc = L["Alert animation settings"],
					inline = true,
					order = 1,
					args = {
						minAlpha = {
							type = "range",
							name = L["Alpha low"],
							desc = L["Low transparency alpha value of the animation"],
							set = function(info, value)
								self.db[unit].minAlpha = value
								self.db[unit].maxAlpha = max(value + 0.1, self.db[unit].maxAlpha)
								GladiusEx:UpdateFrames()
							end,
							min = 0, max = 0.9, bigStep = 0.1,
							disabled = function() return not self:IsUnitEnabled(unit) end,
							order = 1,
						},
						maxAlpha = {
							type = "range",
							name = L["Alpha high"],
							desc = L["High transparency alpha value of the animation"],
							set = function(info, value)
								self.db[unit].minAlpha = min(value - 0.1, self.db[unit].minAlpha)
								self.db[unit].maxAlpha = value
								GladiusEx:UpdateFrames()
							end,
							min = 0.1, max = 1, bigStep = 0.1,
							disabled = function() return not self:IsUnitEnabled(unit) end,
							order = 2,
						},
						duration = {
							type = "range",
							name = L["Duration"],
							desc = L["Duration of each animation cycle, in seconds"],
							min = 0.1, softMax = 1, bigStep = 0.05,
							disabled = function() return not self:IsUnitEnabled(unit) end,
							order = 3,
						},
						ease = {
							type = "select",
							name = L["Ease"],
							desc = L["Animation ease method"],
							values = {
								["IN"] = L["In"],
								["IN_OUT"] = L["In-Out"],
								["OUT"] = L["Out"],
								["NONE"] = L["None"],
							},
							disabled = function() return not self:IsUnitEnabled(unit) end,
							order = 4,
						},
						blendMode = {
							type = "select",
							name = L["Blend mode"],
							desc = L["Overlay blend mode"],
							values = {
								["ADD"] = L["Add"],
								-- ["ALPHAKEY"] = L["Alpha key"],
								["BLEND"] = L["Blend"],
								-- ["DISABLE"] = L["Disable"],
								-- ["MOD"] = L["Mod"],
							},
							disabled = function() return not self:IsUnitEnabled(unit) end,
							order = 5,
						},
					},
				},
			},
		},
		health = {
			type = "group",
			name = L["Low health"],
			desc = L["Low health settings"],
			order = 2,
			args = {
				health = {
					type = "toggle",
					name = L["Low health alert"],
					desc = L["Toggle low health alerts"],
					disabled = function() return not self:IsUnitEnabled(unit) end,
					order = 1,
				},
				sep = {
					type = "description",
					name = "",
					width = "full",
					order = 11,
				},
				healthThreshold = {
					type = "range",
					name = L["Low health threshold"],
					desc = L["Minimum health percent to fire the alert"],
					min = 0, max = 1, bigStep = 0.05, isPercent = true,
					disabled = function() return not self.db[unit].health or not self:IsUnitEnabled(unit) end,
					order = 20,
				},
				sep2 = {
					type = "description",
					name = "",
					width = "full",
					order = 21,
				},
				healthPriority = {
					type = "range",
					name = L["Alert priority"],
					desc = L["Select what priority the alert should have - higher equals more priority"],
					min = 0, max = 100, step = 1,
					disabled = function() return not self.db[unit].health or not self:IsUnitEnabled(unit) end,
					order = 30,
				},
				healthColor = {
					type = "color",
					name = L["Alert color"],
					name = L["Alert overlay color"],
					get = function(info) return GladiusEx:GetColorOption(self.db[unit], info) end,
					set = function(info, r, g, b, a) return GladiusEx:SetColorOption(self.db[unit], info, r, g, b, a) end,
					hasAlpha = true,
					disabled = function() return not self.db[unit].health or not self:IsUnitEnabled(unit) end,
					order = 40,
				},
			},
		},
		casts = {
			type = "group",
			name = L["Casts"],
			childGroups = "tree",
			order = 3,
			args = {
				casts = {
					type = "toggle",
					name = L["Casts alerts"],
					desc = L["Toggle alerts when some spells are being cast"],
					disabled = function() return not self:IsUnitEnabled(unit) end,
					order = 1,
				},
				newCast = {
					type = "group",
					name = L["New cast"],
					desc = L["New cast"],
					inline = true,
					order = 1,
					args = {
						name = {
							type = "input",
							dialogControl = HasSpellEditBox() and "Spell_EditBox" or nil,
							name = L["Spell name"],
							desc = L["Name of the cast spell"],
							get = function() return self.newCastName or "" end,
							set = function(info, value) self.newCastName = GetSpellInfo(value) or value end,
							disabled = function() return not self.db[unit].casts or not self:IsUnitEnabled(unit) end,
							order = 1,
						},
						priority = {
							type= "range",
							name = L["Alert priority"],
							desc = L["Select what priority the cast should have - higher equals more priority"],
							get = function() return self.newCastPriority or "" end,
							set = function(info, value) self.newCastPriority = value end,
							disabled = function() return not self.db[unit].casts or not self:IsUnitEnabled(unit) end,
							min = 0, max = 100, step = 1,
							order = 2,
						},
						color = {
							type = "color",
							name = L["Alert color"],
							name = L["Alert overlay color"],
							get = function(info) return self.newCastColor.r, self.newCastColor.g, self.newCastColor.b, self.newCastColor.a end,
							set = function(info, r, g, b, a) self.newCastColor = { r = r, g = g, b = b, a = a } end,
							hasAlpha = true,
							disabled = function() return not self.db[unit].casts or not self:IsUnitEnabled(unit) end,
							order = 3,
						},
						add = {
							type = "execute",
							name = L["Add new cast"],
							func = function(info)
								self.db[unit].castsSpells[self.newCastName] = {
									priority = self.newCastPriority,
									color = self.newCastColor,
								}
								options.casts.args[self.newCastName] = self:SetupCastOptions(options, unit, self.newCastName)
								self.newCastName = nil
								GladiusEx:UpdateFrames()
							end,
							disabled = function() return not self.db[unit].casts or not self:IsUnitEnabled(unit) or not (self.newCastName and self.newCastPriority and self.newCastColor) end,
							order = 4,
						},
					},
				},
			},
		},
		auras = {
			type = "group",
			name = L["Auras"],
			desc = L["Toggle alerts when some auras are active"],
			childGroups = "tree",
			order = 4,
			args = {
				auras = {
					type = "toggle",
					name = L["Auras alerts"],
					disabled = function() return not self:IsUnitEnabled(unit) end,
					order = 1,
				},
				newAura = {
					type = "group",
					name = L["New aura"],
					desc = L["New aura"],
					inline = true,
					order = 1,
					args = {
						name = {
							type = "input",
							dialogControl = HasAuraEditBox() and "Aura_EditBox" or nil,
							name = L["Aura name"],
							desc = L["Name of the aura"],
							get = function() return self.newAuraName or "" end,
							set = function(info, value) self.newAuraName = GetSpellInfo(value) or value end,
							disabled = function() return not self.db[unit].auras or not self:IsUnitEnabled(unit) end,
							order = 1,
						},
						priority = {
							type= "range",
							name = L["Alert priority"],
							desc = L["Select what priority the aura should have - higher equals more priority"],
							get = function() return self.newAuraPriority or "" end,
							set = function(info, value) self.newAuraPriority = value end,
							disabled = function() return not self.db[unit].auras or not self:IsUnitEnabled(unit) end,
							min = 0, max = 100, step = 1,
							order = 2,
						},
						color = {
							type = "color",
							name = L["Alert color"],
							get = function(info) return self.newAuraColor.r, self.newAuraColor.g, self.newAuraColor.b, self.newAuraColor.a end,
							set = function(info, r, g, b, a) self.newAuraColor = { r = r, g = g, b = b, a = a } end,
							hasAlpha = true,
							disabled = function() return not self.db[unit].auras or not self:IsUnitEnabled(unit) end,
							order = 3,
						},
						add = {
							type = "execute",
							name = L["Add new aura"],
							func = function(info)
								self.db[unit].aurasSpells[self.newAuraName] = {
									priority = self.newAuraPriority,
									color = self.newAuraColor,
								}
								options.auras.args[self.newAuraName] = self:SetupAuraOptions(options, unit, self.newAuraName)
								self.newAuraName = nil
								GladiusEx:UpdateFrames()
							end,
							disabled = function() return not self.db[unit].auras or not self:IsUnitEnabled(unit) or not (self.newAuraName and self.newAuraPriority and self.newAuraColor) end,
							order = 4,
						},
					},
				},
			},
		},
	}

	-- set some initial values
	self.newCastPriority = 5
	self.newCastColor = { r = 1, g = 0, b = 0, a = 1 }
	self.newAuraPriority = 5
	self.newAuraColor = { r = 1, g = 0, b = 0, a = 1 }

	-- setup casts
	for cast in pairs(self.db[unit].castsSpells) do
		options.casts.args[cast] = self:SetupCastOptions(options, unit, cast)
	end

	-- setup auras
	for aura in pairs(self.db[unit].aurasSpells) do
		options.auras.args[aura] = self:SetupAuraOptions(options, unit, aura)
	end
	
	return options
end

function Alerts:SetupCastOptions(options, unit, cast)
	return {
		type = "group",
		name = cast,
		desc = cast,
		disabled = function() return not self:IsUnitEnabled(unit) end,
		args = {
			name = {
				type = "input",
				dialogControl = HasSpellEditBox() and "Spell_EditBox" or nil,
				name = L["Spell name"],
				desc = L["Name of the cast"],
				get = function(info) return info[#(info) - 1] end,
				set = function(info, value)
					local old_name = info[#(info) - 1]
					-- create new cast
					self.db[unit].castsSpells[value] = self.db[unit].castsSpells[old_name]
					options.casts.args[value] = self:SetupCastOptions(options, unit, value)
					-- delete old cast
					self.db[unit].castsSpells[old_name] = nil
					options.casts.args[old_name] = nil
					GladiusEx:UpdateFrames()
				end,
				disabled = function() return not self.db[unit].casts or not self:IsUnitEnabled(unit) end,
				order = 1,
			},
			priority = {
				type= "range",
				name = L["Alert priority"],
				desc = L["Select what priority the cast should have - higher equals more priority"],
				min = 0, softMax = 100, step = 1,
				get = function() return self.db[unit].castsSpells[cast].priority end,
				set = function(info, value)
					self.db[unit].castsSpells[cast].priority = value
					GladiusEx:UpdateFrames()
				end,
				order = 2,
			},
			color = {
				type = "color",
				name = L["Alert color"],
				name = L["Alert overlay color"],
				hasAlpha = true,
				get = function(info) return self.db[unit].castsSpells[cast].color.r, self.db[unit].castsSpells[cast].color.g, self.db[unit].castsSpells[cast].color.b, self.db[unit].castsSpells[cast].color.a end,
				set = function(info, r, g, b, a) self.db[unit].castsSpells[cast].color = { r = r, g = g, b = b, a = a } end,
				disabled = function() return not self.db[unit].casts or not self:IsUnitEnabled(unit) end,
				order = 3,
			},
			delete = {
				type = "execute",
				name = L["Delete"],
				func = function(info)
					local name = info[#(info) - 1]
					self.db[unit].castsSpells[name] = nil
					options.casts.args[name] = nil
					GladiusEx:UpdateFrames()
				end,
				disabled = function() return not self.db[unit].casts or not self:IsUnitEnabled(unit) end,
				order = 4,
			},
		},
	}
end

function Alerts:SetupAuraOptions(options, unit, aura)
	return {
		type = "group",
		name = aura,
		desc = aura,
		disabled = function() return not self:IsUnitEnabled(unit) end,
		args = {
			name = {
				type = "input",
				dialogControl = HasAuraEditBox() and "Aura_EditBox" or nil,
				name = L["Aura name"],
				desc = L["Name of the aura"],
				get = function(info) return info[#(info) - 1] end,
				set = function(info, value)
					local old_name = info[#(info) - 1]
					-- create new aura
					self.db[unit].aurasSpells[value] = self.db[unit].aurasSpells[old_name]
					options.auras.args[value] = self:SetupAuraOptions(options, unit, value)
					-- delete old aura
					self.db[unit].aurasSpells[old_name] = nil
					options.auras.args[old_name] = nil
					GladiusEx:UpdateFrames()
				end,
				disabled = function() return not self.db[unit].auras or not self:IsUnitEnabled(unit) end,
				order = 1,
			},
			priority = {
				type= "range",
				name = L["Alert priority"],
				desc = L["Select what priority the aura should have - higher equals more priority"],
				min = 0, softMax = 100, step = 1,
				get = function() return self.db[unit].aurasSpells[aura].priority end,
				set = function(info, value)
					self.db[unit].aurasSpells[aura].priority = value
					GladiusEx:UpdateFrames()
				end,
				order = 2,
			},
			color = {
				type = "color",
				name = L["Alert color"],
				name = L["Alert overlay color"],
				hasAlpha = true,
				get = function(info) return self.db[unit].aurasSpells[aura].color.r, self.db[unit].aurasSpells[aura].color.g, self.db[unit].aurasSpells[aura].color.b, self.db[unit].aurasSpells[aura].color.a end,
				set = function(info, r, g, b, a) self.db[unit].aurasSpells[aura].color = { r = r, g = g, b = b, a = a } end,
				disabled = function() return not self.db[unit].auras or not self:IsUnitEnabled(unit) end,
				order = 3,
			},
			delete = {
				type = "execute",
				name = L["Delete"],
				func = function(info)
					local name = info[#(info) - 1]
					self.db[unit].aurasSpells[name] = nil
					options.auras.args[name] = nil
					GladiusEx:UpdateFrames()
				end,
				disabled = function() return not self.db[unit].auras or not self:IsUnitEnabled(unit) end,
				order = 4,
			},
		},
	}
end
	