KH = SMODS.current_mod
XIII = XIII or {}

SMODS.Gradient {
  key = "badge",
  colours = {
    HEX('334362'),
    HEX('5973B2'),
    HEX('7A8CCF'),
    HEX('8A7FBF'),
    HEX('404D80'),
  },
  cycle = 10,
  interpolation = 'trig',
}

KH.badge_colour = SMODS.Gradients.kh_badge

KH.description_loc_vars = function()
  return { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.2, shadow = true }
end

KH.save_config = function(self)
  SMODS.save_mod_config(self)
end

SMODS.DynaTextEffect {
  key = "pulse",
  func = function(dynatext, index, letter)
    local t = G.TIMERS.REAL * 1.2 + index * 0.25
    letter.y = math.sin(t) * 2
    letter.r = math.sin(t * 0.5) * 0.2
  end
}

-- tailsman thingy
to_big = to_big or function(x) return x end
to_number = to_number or function(x) return x end

SMODS.current_mod.optional_features = {
  post_trigger = true,
  retrigger_joker = true
}

-- Utility Functions
local cards = NFS.getDirectoryItems(SMODS.current_mod.path .. "utilities")
for _, filename in pairs(cards) do
  assert(SMODS.load_file("utilities/" .. filename))()
end

-- Blockbuster Support!
if Blockbuster then
  SMODS.load_file("content/crossmod/value_manipulation.lua")()
end

-- Jokers
local subdir = "content/cards"
local cards = NFS.getDirectoryItems(SMODS.current_mod.path .. subdir)
for _, filename in pairs(cards) do
  assert(SMODS.load_file(subdir .. "/" .. filename))()
end

-- Misc
local cards = NFS.getDirectoryItems(SMODS.current_mod.path .. "content/misc")
for _, filename in pairs(cards) do
  assert(SMODS.load_file("content/misc/" .. filename))()
end

-- Consumables
SMODS.load_file("content/consumables/tarots.lua")()
SMODS.load_file("content/consumables/spectrals.lua")()

-- Friends of Jimbo
SMODS.load_file("content/collabs/kingdomheartsxbalatro.lua")()

-- Joker Display Support!
if JokerDisplay then
  SMODS.load_file("content/crossmod/joker_display_definitions.lua")()
end

-- Partner API Support!
if Partner_API then
  SMODS.load_file("content/crossmod/partners.lua")()
end

-- CardSleeves Support!
if CardSleeves then
  SMODS.load_file("content/crossmod/cardsleeves.lua")()
end

--[[ WIP
if BLINDSIDE then
  SMODS.load_file("content/crossmod/blindside_blinds.lua")()
  SMODS.load_file("content/crossmod/blindside_jokers.lua")()
end
--]]
