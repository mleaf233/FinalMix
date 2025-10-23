SMODS.Challenge {
  key = 'got_it_memorized',
  loc_txt = {
    name = "Got it Memorized?"
  },
  jokers = {
    { id = "j_kh_axel", eternal = true },
    { id = "j_joker" },
  },
  rules = {
    custom = {
      { id = "kh_got_it_memorized" },
      { id = "no_skipping" },
    },
  },
  deck = {
    type = "Challenge Deck",
  },
  restrictions = {
    banned_cards = {
      { id = "j_luchador" },
      { id = "j_chicot" },
      { id = "j_throwback" },
      { id = "j_diet_cola" },
      { id = "v_directors_cut" },
      { id = "v_retcon" },
    },
    banned_other = {},
  },
}

SMODS.Challenge {
  key = 'tick_tock',
  loc_txt = {
    name = "Tick Tock"
  },
  jokers = {
    { id = "j_kh_luxord" },
  },
  rules = {
    custom = {
      { id = "no_skipping" },
      { id = "no_time" }
    },
  },
  deck = {
    type = "Challenge Deck",
  },
  restrictions = {
    banned_cards = {
      { id = "j_throwback" },
      { id = "j_diet_cola" },
    },
    banned_other = {},
  },

  calculate = function(self, context)
    if G.GAME.luxord_destroyed or G.GAME.luxord_sold then
      G.STATE = G.STATES.GAME_OVER; G.STATE_COMPLETE = false -- causes game over
    end

    if G.STATES.GAME_OVER then -- sets checks back to false on a game over
      G.GAME.luxord_destroyed = false
      G.GAME.luxord_sold = false
    end
  end
}
