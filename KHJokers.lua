SMODS.Atlas {
    key = "modicon",
    path = "mod_icon.png",
    px = 34,
    py = 34,
}

SMODS.Atlas {
    key = "KHJokers",
    path = "KHJokers.png",
    px = 71,
    py = 95,
}

SMODS.Atlas({
    key = 'consumabels',
    px = 71,
    py = 95,
    path = 'consumabels.png'
})


SMODS.Atlas({
    key = 'decks',
    px = 71,
    py = 95,
    path = 'decks.png'
})

SMODS.Atlas({
  key = 'khblind',
  path = 'blinds.png',
  px = 34, py = 34,
  frames = 21,
  atlas_table = 'ANIMATION_ATLAS'})


KH = SMODS.current_mod

KH.save_config = function(self)
  SMODS.save_mod_config(self)
end

-- config
KH.config_tab = function()
  return {
    n = G.UIT.ROOT,
    config = {
      r = 0.1, minw = 5, align = "cm", padding = 0.2, colour = G.C.BLACK
    },
    nodes = {
	  
	  create_toggle({
        id = "enable_jokers",
        label = localize("k_khjokers_config_jokers"),
        info = {localize('k_khjokers_config_restart')},
        ref_table = KH.config,
        ref_value = "enable_jokers",
        callback = function()
          KH:save_config()
        end,
      }),
	  
      create_toggle({
        id = "enable_tarots",
        label = localize("k_khjokers_config_tarots"),
        info = {localize('k_khjokers_config_restart')},
        ref_table = KH.config,
        ref_value = "enable_tarots",
        callback = function()
          KH:save_config()
        end
      }),
	  
	  create_toggle({
        id = "enable_spectrals",
        label = localize("k_khjokers_config_spectrals"),
        info = {localize('k_khjokers_config_restart')},
        ref_table = KH.config,
        ref_value = "enable_spectrals",
        callback = function()
          KH:save_config()
        end
      }),
	  
    }
  }
end

if KH.config.enable_jokers then
	local subdir = "content/cards"
	local cards = NFS.getDirectoryItems(SMODS.current_mod.path .. subdir)
	for _, filename in pairs(cards) do
		assert(SMODS.load_file(subdir .. "/" .. filename))()
	end
end

if KH.config.enable_tarots then
	SMODS.load_file("content/consumables/tarots.lua")()
end

if KH.config.enable_spectrals then 
  SMODS.load_file("content/consumables/spectrals.lua")()
end

-- load Friends of Jimbo
SMODS.load_file("content/collabs/kingdomheartsxbalatro.lua")()

-- Joker Display Compat
if JokerDisplay then
    SMODS.load_file("content/JokerDisplay/joker_display_definitions.lua")()
end

SMODS.load_file("content/consumables/seal.lua")()

SMODS.load_file("content/challenges/challenges.lua")()



-- blinds
SMODS.Blind {
    key = 'khblind',
    loc_txt = {
        name = 'Shuffled',
        text = {
            'Shuffles Jokers',
            'When hand is played',
        }
    },
    vars = {},
    dollars = 5,
    mult = 2,
    debuff = {},
    boss = {min = 2, max = 10},
    boss_colour = HEX('c88465'),
    pos = {x = 0, y = 0},
    atlas = 'khblind',
    press_play = function(self)
      G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 0.2,
              func = function()
                for i = 1, 3 do
                  G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15 * (i - 1),
                    func = function()
                      G.jokers:shuffle('aajk')
                      play_sound('cardSlide1', 0.85 + 0.15 * i)
                      return true
                    end
                  }))
                end
              return true
        end
        }))
    end
}

SMODS.Back {
  key = 'kingdom',
  atlas = 'decks',
  pos = { x = 0, y = 0 },
  config = {vouchers = { "v_overstock_norm"},},
  loc_vars = function(self, info_queue, center)
  end,
  calculate = function(self, back, context)
  end
}
