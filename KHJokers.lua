KH = SMODS.current_mod

KH.save_config = function(self)
  SMODS.save_mod_config(self)
end

KH.description_loc_vars = function()
  return { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.2, shadow = true }
end

-- cool effect for text
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

-- Credits to N' in JoyousSpring! Check them out! Adds cards to mod page
KH.custom_ui = function(modNodes)
  modNodes[1].nodes[1].config.colour = G.C.BLUE

  G.kh_desc_area = CardArea(
    G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h,
    4.25 * G.CARD_W,
    0.95 * G.CARD_H,
    { card_limit = 5, type = 'title', highlight_limit = 0, collection = true }
  )
  G.kh_desc_area.joy_demo_area = true
  for i, key in ipairs({ "j_kh_sealsalt", "j_kh_roxas", "j_kh_sora", "j_kh_riku", "j_kh_paopufruit", }) do
    local card = Card(G.kh_desc_area.T.x + G.kh_desc_area.T.w / 2, G.kh_desc_area.T.y,
      G.CARD_W, G.CARD_H, G.P_CARDS.empty,
      G.P_CENTERS[key])
    G.kh_desc_area:emplace(card)
    card:flip()
    G.E_MANAGER:add_event(Event({
      blocking = false,
      trigger = "after",
      delay = 0.4 * i,
      func = function()
        play_sound("card1")
        card:flip()
        return true
      end,
    }))
  end

  modNodes[#modNodes + 1] = {
    n = G.UIT.R,
    config = { align = "cm", padding = 0.07, no_fill = true },
    nodes = {
      { n = G.UIT.O, config = { object = G.kh_desc_area } }
    }
  }
end



KH.config_tab = function()
  -- Title box
  local title_box = {
    n = G.UIT.R,
    config = { colour = G.C.BLACK, padding = 0.1, align = "cm", minw = 4, minh = 1, r = 0.1 },
    nodes = {
      { n = G.UIT.T, config = { text = "KINGDOM HEARTS CONFIG", colour = G.C.UI.TEXT_DARK, scale = 1, padding = 0.1, align = "cm" } }
    }
  }

  -- Left toggles
  local left_box = {
    n = G.UIT.C,
    config = { r = 0.1, minw = 3, align = "tm", padding = 0.2, colour = G.C.BLACK },
    nodes = {
      create_toggle({
        id = "enable_jokers",
        label = localize("k_khjokers_config_jokers"),
        info = { localize('k_khjokers_config_restart') },
        ref_table = KH.config,
        ref_value = "enable_jokers",
        callback = function() KH:save_config() end
      }),
      create_toggle({
        id = "enable_tarots",
        label = localize("k_khjokers_config_tarots"),
        info = { localize('k_khjokers_config_restart') },
        ref_table = KH.config,
        ref_value = "enable_tarots",
        callback = function() KH:save_config() end
      }),
      create_toggle({
        id = "enable_spectrals",
        label = localize("k_khjokers_config_spectrals"),
        info = { localize('k_khjokers_config_restart') },
        ref_table = KH.config,
        ref_value = "enable_spectrals",
        callback = function() KH:save_config() end
      }),
    }
  }

  -- Right toggles
  local right_box = {
    n = G.UIT.C,
    config = { r = 0.1, minw = 3, align = "tm", padding = 0.2, colour = G.C.BLACK },
    nodes = {
      create_toggle({
        id = "enable_seal",
        label = localize("k_khjokers_config_seal"),
        info = { localize('k_khjokers_config_restart') },
        ref_table = KH.config,
        ref_value = "enable_seal",
        callback = function() KH:save_config() end
      }),
      create_toggle({
        id = "enable_blind",
        label = localize("k_khjokers_config_blind"),
        info = { localize('k_khjokers_config_restart') },
        ref_table = KH.config,
        ref_value = "enable_blind",
        callback = function() KH:save_config() end
      }),
      create_toggle({
        id = "menu_toggle",
        ref_table = KH.config,
        ref_value = "menu_toggle",
        label = localize("k_khjokers_config_menu_toggle"),
        callback = menu_refresh
      }),
    }
  }

  -- Horizontal row containing left and right boxes
  local toggles_row = {
    n = G.UIT.R,
    config = { r = 0.1, minw = 7, align = "cm", padding = 0.2, colour = G.C.BLACK },
    nodes = { left_box, right_box }
  }

  -- Main layout
  return {
    n = G.UIT.ROOT,
    config = { r = 0.1, minw = 7, align = "tm", padding = 0.1, colour = G.C.BLACK },
    nodes = {
      {
        n = G.UIT.R,
        config = { r = 0.1, minw = 7, align = "cm", padding = 0.1, colour = G.C.BLACK },
        nodes = {
          {
            n = G.UIT.C,
            config = { r = 0.1, minw = 7, minh = 5, align = "tm", padding = 0.2, colour = G.C.BLACK },
            nodes = {
              title_box,
              toggles_row,
            }
          }
        }
      }
    }
  }
end


local oldfunc = Game.main_menu
Game.main_menu = function(change_context)
  local ret = oldfunc(change_context)

  if KH.config.menu_toggle then
    local SC_scale = 1.1 * (G.debug_splash_size_toggle and 0.8 or 1)
    G.SPLASH_KH_LOGO = Sprite(0, 0,
      6 * SC_scale,
      6 * SC_scale * (G.ASSET_ATLAS["kh_logo"].py / G.ASSET_ATLAS["kh_logo"].px),
      G.ASSET_ATLAS["kh_logo"], { x = 0, y = 0 }
    )
    G.SPLASH_KH_LOGO:set_alignment({
      major = G.title_top,
      type = 'cm',
      bond = 'Strong',
      offset = { x = 4, y = 3 }
    })
    G.SPLASH_KH_LOGO:define_draw_steps({ {
      shader = 'dissolve',
    } })

    G.SPLASH_KH_LOGO.tilt_var = { mx = 0, my = 0, dx = 0, dy = 0, amt = 0 }

    G.SPLASH_KH_LOGO.dissolve_colours = { G.C.WHITE, G.C.WHITE }
    G.SPLASH_KH_LOGO.dissolve = 1

    G.SPLASH_KH_LOGO.states.collide.can = true

    function G.SPLASH_KH_LOGO:click()
      play_sound('button', 1, 0.3)
      G.FUNCS['openModUI_kingdomhearts']()
    end

    function G.SPLASH_KH_LOGO:hover()
      G.SPLASH_KH_LOGO:juice_up(0.05, 0.03)
      play_sound('paper1', math.random() * 0.2 + 0.9, 0.35)
      Node.hover(self)
    end

    function G.SPLASH_KH_LOGO:stop_hover() Node.stop_hover(self) end

    --Logo animation
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = change_context == 'splash' and 3.6 or change_context == 'game' and 4 or 1,
      blockable = false,
      blocking = false,
      func = (function()
        play_sound('magic_crumple' .. (change_context == 'splash' and 2 or 3),
          (change_context == 'splash' and 1 or 1.3), 0.9)
        play_sound('whoosh1', 0.2, 0.8)
        ease_value(G.SPLASH_KH_LOGO, 'dissolve', -1, nil, nil, nil,
          change_context == 'splash' and 2.3 or 0.9)
        G.VIBRATION = G.VIBRATION + 1.5
        return true
      end)
    }))
  end


  return ret
end

SMODS.load_file("utilities/atlases.lua")()
SMODS.load_file("utilities/animateObject.lua")()
SMODS.load_file("utilities/functions.lua")()
SMODS.load_file("utilities/hooks.lua")()
SMODS.load_file("utilities/buttons.lua")()

if KH.config.enable_jokers then
  local subdir = "content/cards"
  local cards = NFS.getDirectoryItems(SMODS.current_mod.path .. subdir)
  for _, filename in pairs(cards) do
    assert(SMODS.load_file(subdir .. "/" .. filename))()
  end
  SMODS.load_file("content/challenges/challenges.lua")() -- Loads Challenges if Jokers are enabled
end

if KH.config.enable_tarots then
  SMODS.load_file("content/consumables/tarots.lua")()
end

if KH.config.enable_spectrals then
  SMODS.load_file("content/consumables/spectrals.lua")()
end

if KH.config.enable_seal then
  SMODS.load_file("content/consumables/seal.lua")()
end

if KH.config.enable_blind then
  SMODS.load_file("content/blinds/blinds.lua")()
end

-- load Friends of Jimbo
SMODS.load_file("content/collabs/kingdomheartsxbalatro.lua")()

-- Joker Display Compat
if JokerDisplay then
  SMODS.load_file("content/crossmod/joker_display_definitions.lua")()
end

-- Partner API Support!
if partner then
  SMODS.load_file("content/crossmod/partners.lua")()
end

-- CardSleeves Support!
if CardSleeves then
  SMODS.load_file("content/crossmod/cardsleeves.lua")()
end

SMODS.load_file("content/consumables/vouchers.lua")()

-- Decks
SMODS.Back {
  key = 'kingdom',
  atlas = 'KHDecks',
  pos = { x = 0, y = 0 },
  discovered = true,
  config = { vouchers = { "v_overstock_norm" }, },
  loc_vars = function(self, info_queue, center)
  end,
  apply = function(self, back)
  end,
  calculate = function(self, back, context)
  end
}

SMODS.Back {
  key = 'fairgame',
  atlas = 'KHDecks',
  pos = { x = 1, y = 0 },
  discovered = true,
  config = {
    base = 1,
    odds = 2,
  },
  loc_vars = function(self, info_queue, center)
    local numerator, denominator = SMODS.get_probability_vars(self, self.config.base, self.config.odds,
      'fairgame1')
    return {
      vars = { numerator, denominator }
    }
  end,

  calculate = function(self, back, context)
    if context.modify_hand then
      -- 1 in 2 chance to half base chips and mult
      if SMODS.pseudorandom_probability(self, 'fairgame', self.config.base, self.config.odds, 'fairgame1') then
        print("halved")
        mult = mod_mult(math.max(math.floor(mult * 0.5 + 0.5), 1))
        hand_chips = mod_chips(math.max(math.floor(hand_chips * 0.5 + 0.5), 0))
        update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
        attention_text({
          text = "Tails!",
          scale = 1.3,
          hold = 3,
          align = 'cm',
          offset = { x = 0.05, y = 0 },
          backdrop_colour = G.C.RED,
          silent = true
        })
        -- 1 in 2 chance to double base chips & Mult
      elseif SMODS.pseudorandom_probability(self, 'fairgame67', self.config.base, self.config.odds, 'fairgame1') then
        print("doubled")
        hand_chips = mod_chips(hand_chips * 2)
        mult = mod_mult(mult * 2)
        update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
        attention_text({
          text = "Heads!",
          scale = 1.3,
          hold = 3,
          align = 'cm',
          offset = { x = 0.05, y = 0 },
          backdrop_colour = G.C.GREEN,
          silent = true
        })
      end
    end
  end
}

--[[ idea but i need to like properly think this through or something
what i can do is make custom ranks right based on chain of memories (just general deck but look like kh)
and each rank has a unique effect, and the suits can have an effect which applies to all cards with that suit, and
 basically after playing the cards once it loses a bit of its chips/mult/dollars/xmult etc. it originally has 15 chips bonus
 then reduces to 14, then 13, each hand played. then the magic cards e.g. cure can repair it to its original form, and
 others like fire and thunder can add on extra effects to the playing cards (eg. if one card has 15 chips maybe
 one magic card can buff the original form to 25 chips, so now when you use cure itll make it repair to 25 rather than 15,
 and others can add on extra effects e.g. give $1 when scored) so basically this whole thing is themed around playing cards
 and magic cards rather than jokers for now is what i think. I'll make custom graphics for the playing  cards, for the magic cards etc.
 also for magic cards basiclaly after beating a blind in balatro you get sent to the shop, which will have magic booster packs
 which let you select one magic card to bring to the consumable slot and use later
]]
