SMODS.Blind {
  key = 'kingdom_hearts',
  discovered = true,
  vars = {},
  dollars = 5,
  mult = 2,
  debuff = {},
  boss = { min = 2 },
  boss_colour = HEX('2777a8'),
  pos = { x = 0, y = 1 },
  atlas = 'KHBlind',
  calculate = function(self, blind, context)
    if context.final_scoring_step then
      G.E_MANAGER:add_event(Event({
        func = function()
          local hand_count = #G.play.cards

          for i = 1, hand_count do
            draw_card(G.discard, G.deck, i * 100 / hand_count, 'down', nil, nil, 0.08)
          end

          G.deck:shuffle('kh' .. G.GAME.round_resets.ante)

          return true
        end
      }))
    end
  end
}

SMODS.Blind {
  key = 'crown',
  discovered = true,
  vars = {},
  dollars = 5,
  mult = 2,
  debuff = {},
  boss = { min = 2 },
  boss_colour = HEX('bfc0c4'),
  pos = { x = 0, y = 2 },
  atlas = 'KHBlind',
  debuff_hand = function(self, cards, hand, handname, check)
    for i = 1, #cards do
      if cards[i]:is_face() then
        return false
      end
    end
    return true
  end,
  in_pool = function(self)
    for _, playing_card in ipairs(G.playing_cards or {}) do
      if playing_card:is_face() then
        return true
      end
    end
    return false
  end
}

SMODS.Blind {
  key = 'keyhole',
  discovered = true,
  vars = {},
  dollars = 5,
  mult = 2,
  debuff = {},
  boss = { min = 2 },
  boss_colour = HEX('4b4b4b'),
  pos = { x = 0, y = 0 },
  atlas = 'KHBlind',
  press_play = function(self)
    G.hand:change_size(-1)
    G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) - 1
  end,
}
