return {
	descriptions = {

		Partner = {
			--[[pnr_kh_sora = {
				name = "{E:kh_pulse}Sora",
				text = {
					"This Joker gains {X:mult,C:white}X#2#{} Mult",
					"For each scored {C:hearts}heart{} card, resets",
					"when {C:attention}Boss Blind{} is defeated{}",
					"but Mult gained increases by {X:mult,C:white}X#3#{}",
					"{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult)",
				},
			},--]]
			pnr_kh_sora = {
				name = "{E:kh_pulse}Sora",
				text = {
					"Every played {C:hearts}Heart{} card",
					"permanently gains",
					"{X:mult,C:white}X#1#{} Mult when scored.",
				},
			},

			pnr_kh_donald = {
				name = "{E:kh_pulse}Ducklings",
				text = {
					"Copies the ability of a",
					"random {C:attention}Joker{}",
					"every hand played",
					"{C:inactive}(Currently copying: {C:attention}#1#{C:inactive})",
				},
			},

			pnr_kh_mickey = {
				name = "{E:kh_pulse}Mickey",
				text = {
					"The first scoring card",
					"has a {C:green}#1# in #2#{} chance",
					"to become a {C:attention}King{}",
				},
			},

			pnr_kh_randompartner = {
				name = '{E:kh_pulse}Random Partner',
				text = {
					"First and Last",
					"cards {C:attention}held in hand{}",
					"count in scoring",
				},
			},
		},

		Sleeve = {
			sleeve_kh_kingdom = {
				name = "{E:kh_pulse}Kingdom Sleeve",
				text = {
					"{C:legendary}Kingdom Hearts{} {C:attention}Jokers{} are",
					"{C:attention}3X{} more likely to appear",
					"Start run with",
					"{C:attention,T:v_overstock_norm}Overstock{}",

				}
			},

			sleeve_kh_kingdom_alt = {
				name = "{E:kh_pulse}Kingdom Sleeve",
				text = {
					"{C:legendary}Kingdom Hearts{} {C:attention}Jokers{} are",
					"{C:attention}3X{} more likely to appear",
					"Start run with {C:attention,T:v_overstock_norm}Overstock{}",
					"and {C:attention,T:v_overstock_plus}Overstock Plus{}",

				}
			},

			sleeve_kh_fairgame = {
				name = "{E:kh_pulse}Fair Game Sleeve",
				text = {
					"When a hand is played",
					"{C:attention}Flip{} a {C:money}Coin{}",
					"If {C:attention}Heads{}, doubles",
					"base chips and mult",
					"If {C:attention}Tails{}, halves",
					"base chips and mult"

				}
			},
		},

		Back = {

			b_kh_kingdom = {
				name = "{E:kh_pulse}Kingdom Deck",
				text = {
					"Kingdom Hearts Jokers are",
					"{C:attention}3X{} more likely to appear",
					"Start run with the",
					"{C:attention,T:v_overstock_norm}Overstock{} Voucher",
				},
			},

			b_kh_fairgame = {
				name = "{E:kh_pulse}Fair Game Deck",
				text = {
					"When a hand is played",
					"{C:attention}Flip{} a {C:money}Coin{}",
					"If {C:attention}Heads{}, doubles",
					"base chips and mult",
					"If {C:attention}Tails{}, halves",
					"base chips and mult"

				}
			},
		},
		Joker = {

			j_kh_magnet = {
				name = '{E:kh_pulse}Munny Magnet',
				text = {
					"Unused Hands/Discards",
					"this ante",
					"carry over to",
					"the {C:attention}boss blind{}",
					"{C:inactive}(Currently {C:blue}#2#{}{C:inactive} Hands, {C:red}#1#{}{C:inactive} Discards)"

				},
			},

			j_kh_lethimcook = {
				name = '{E:kh_pulse}Let Him Cook',
				text = {
					"Multiply values of",
					"adjacent {C:attention}Jokers{}",
					"by {X:legendary,C:white}X1.5{}",
					"{C:inactive,s:0.8}Hollup... Let Him Cook",

				},
			},
			j_kh_commandmenu_kh0 = {
				name = {
					"{E:kh_pulse,C:dark_edition,s:1.0}Command Menu{}",
					"{E:kh_pulse,C:dark_edition,s:0.8}Attack{}",
				},
				text = {
					{
						"When a {C:attention}Blind{} is selected,",
						"this Joker  cycles through",
						"it's {C:attention}modes{}:",
					},
					{
						"Destroy least common",
						"card when a hand",
						"is played",
					},
				},
			},

			j_kh_commandmenu_kh1 = {
				name = {
					"{E:kh_pulse,C:dark_edition,s:1.0}Command Menu{}",
					"{E:kh_pulse,C:dark_edition,s:0.8}Magic{}",
				},
				text = {
					{
						"When a {C:attention}Blind{} is selected,",
						"this Joker cycles through",
						"it's {C:attention}modes{}",
					},
					{
						"After scoring",
						"Return first card",
						"played to hand",
					},
				},
			},

			j_kh_commandmenu_kh2 = {
				name = {
					"{E:kh_pulse,C:dark_edition,s:1.0}Command Menu{}",
					"{E:kh_pulse,C:dark_edition,s:0.8}Items{}",
				},
				text = {
					{
						"When a {C:attention}Blind{} is selected,",
						"this Joker cycles through",
						"it's {C:attention}modes{}",
					},
					{
						"When an {C:attention}Ace{} is played,",
						"create a random",
						"{C:attention}consumable{}",
						"{C:inactive}(Must Have Room)",
					},
				},
			},

			j_kh_commandmenu_kh3 = {
				name = {
					"{E:kh_pulse,C:dark_edition,s:1.0}Command Menu{}",
					"{E:kh_pulse,C:dark_edition,s:0.8}Drive{}",
				},
				text = {
					{
						"When a {C:attention}Blind{} is selected,",
						"this Joker cycles through",
						"it's {C:attention}modes{}",
					},
					{
						"Gives {X:mult,C:white}X1{} per",
						"unique rarity in your",
						"Joker Slots"
					},
				},
			},

			j_kh_sora = {
				name = '{E:kh_pulse}Sora',
				text = {
					"This Joker gains {X:mult,C:white}X#2#{} Mult",
					"For each scored {C:hearts}heart{} card, resets",
					"when {C:attention}Boss Blind{} is defeated.{}",
					"{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult)",
					"{C:inactive,s:0.8}My Friends are my Power!",
				},
			},

			j_kh_riku = {
				name = '{E:kh_pulse}Riku',
				text = {
					'Levels up most played hand',
					'by #2# every {C:attention}#4#{} {C:inactive}#3#{} {C:green}rerolls',
					'{C:inactive}(Most Played: {C:attention}#1#{}{C:inactive})',
					--'{C:inactive}(Reroll {C:attention}#3#{}{C:inactive}/#4#){}',
					--"{C:inactive,s:0.8}I'm not afraid of the darkness!",
					"{C:inactive,s:0.8}I'm thinking RIKU RIKU oo ee oo",
				}

			},

			j_kh_kairi_a = {
				name = '{E:kh_pulse}Kairi',
				text = {
					"{C:chips}+#3#{} Chip per {C:diamonds}Light Suit{} scored",
					"{C:chips}-#4#{} Chip {C:spades}Dark Suit{} scored",
					"{C:inactive,s:0.8}I know you will!",
				}
			},
			j_kh_kairi_b = {
				name = '{E:kh_pulse}Naminé',
				text = {
					"{C:mult}+#3#{} Mult per {C:spades}Dark Suit{} scored",
					"{C:mult}-#4#{} Mult per {C:diamonds}Light Suit{} scored",
					"{C:inactive,s:0.8}It's me, Naminé",

				}
			},

			j_kh_kairi_extra = {
				text = {
					"{C:inactive}(Currently {C:chips}+#1#{}{C:inactive} Chips, {C:mult}+#2#{}{C:inactive} Mult){}",
					'{C:inactive}Joker flips at end of round',

				}
			},

			j_kh_roxas = {
				name = '{E:kh_pulse}Roxas',
				text = {
					"This Joker gains {C:chips}+#1#{} Chips",
					"every {C:attention}#2#{} {C:inactive}[#3#]{} cards discarded",
					"{C:inactive}(Currently {C:chips}+#4#{C:inactive} Chips)",
					"{C:inactive,s:0.8}looks like my summer vacation is... over",

				},
			},

			j_kh_brycethenobody = {
				name = "{E:kh_pulse}BryceTheNobody",
				text = {
					"Every played {V:1}#4#{} card",
					"permanently gain",
					"{C:mult}+#1#{} Mult when scored",
					"{s:0.8}suit changes at end of round",
					"{C:inactive,s:0.8}Glad i could help some people out"
				},
			},

			j_kh_axel = {
				name = '{E:kh_pulse}Axel',
				text = {
					"{C:enhanced}Doubles{} values of leftmost {C:attention}Joker{}",
					"and applies a {C:spectral}Perishable{} sticker",
					"after defeating a {C:attention}boss blind",
					"{C:inactive,s:0.8}Got it Memorized?",

				},
			},

			j_kh_xigbar = {
				name = "{E:kh_pulse}Half Face",
				text = {
					"This Joker gains {X:mult,C:white}X#2#{} Mult",
					"for each {C:attention}face{} card in played",
					"hand that {C:attention}does not score{}",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}",
					"{C:inactive,s:0.8}Me? I'm already half Xehanort"
				},
			},

			j_kh_mickey = {
				name = '{E:kh_pulse}Meeska Mooska',
				text = {

					--"First and last played cards have",
					"{C:green}#1# in #2#{} chance",
					"for {C:attention}first{} and {C:attention}last{}",
					"played cards to become",
					"{C:attention}Kings{} when scored",
					"{C:inactive,s:0.8}Did somebody mention",
					"{C:inactive,s:0.8}the Door to Darkness?"
				},
			},

			j_kh_donald = {
				name = '{E:kh_pulse}Donald Duck',
				text = {
					"Copies the ability of a",
					"{C:attention}random Joker{} each round.",
					"{C:inactive}(Currently copying: {C:attention}#1#{C:inactive})",
					"{C:inactive,s:0.8}The Snowstorm can't get us here."
				},
			},

			j_kh_goofy = {
				name = "{E:kh_pulse}Wild Goofy",
				text = {
					{
						"{C:attention}Wild{} Cards give",
						"random bonuses",
						"when they score:",
					},
					{
						"{s:0.8,X:mult,C:white}X#3#{} {s:0.8}Mult, {s:0.8,C:money}$#4#{}",
						"{s:0.8,C:mult}+#1#{} {s:0.8}Mult, {s:0.8,C:chips}+#2#{} {s:0.8}Chips",
						"{C:inactive,s:0.8}Gawrsh..."
					},
				},
			},

			j_kh_disney = {
				name = '{E:kh_pulse}Master Yen Sid',
				text = {
					"{C:green}#1# in #2#{} chance to",
					"upgrade level of a",
					"random {C:attention}poker hand{} when",
					"a {C:purple}Tarot{} card is used",
					"{C:inactive,s:0.8}Sora, do NOT dissappoint me.",
				},
			},

			j_kh_keyblade = {
				name = '{E:kh_pulse}Keyblade',
				text = {
					"If {C:attention}first hand{} of round is",
					"a single {C:attention}#1#{}, destroy it and",
					"create a {C:dark_edition}random {}{C:attention}Tag{}",
					"{s:0.8}Rank changes every round",
					"{C:inactive,s:0.8} May your heart be your guiding key",
				},
			},

			j_kh_paopufruit = {
				name = '{E:kh_pulse}Paopu Fruit',
				text = {
					"Add a random {C:dark_edition}Edition{},",
					"{C:dark_edition}Enhancement{}, and {C:attention}Seal{} to",
					"first scored card for",
					"the next {C:attention}#1#{} hands",
					"{C:inactive,s:0.8} the winner gets to share a Paopu with Kairi."
				},
			},

			j_kh_sealsalt = {
				name = "{E:kh_pulse}Seal Salt Ice Cream",
				text = {
					"If played hand contains",
					"a card with a {C:attention}seal{}, add a",
					"random {C:attention}seal{} to a random",
					"{C:attention} playing card{} held in hand",
					"{C:inactive,s:0.8} man, this is some good ice cream, huh?",
				},
			},

			j_kh_nobody = {
				name = '{E:kh_pulse}Nobody',
				text = {
					"Gains {C:chips}+#2#{} Chips per",
					"unique {C:attention}suit{} in played hand",
					"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
					"{C:inactive,s:0.8} Nobody? Who's Nobody?",
				},
			},

			j_kh_moogle = {
				name = '{E:kh_pulse}Moogle',
				text = {
					"Earn {C:money}$#1#{} at end of round",
					"for each {C:attention}Joker{} card",
					"{C:inactive}(Currently {C:money}$#2#{}{C:inactive})",
					"{C:inactive,s:0.8}Greetings"
				},
			},

			j_kh_cloudz = {
				name = "{E:kh_pulse}Time",
				text = {
					"{C:inactive}(Currently: {X:mult,C:white}X#3#{C:inactive} Mult)",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
					"{C:inactive}(Currently: {C:chips}+#1#{C:inactive} Chips)",
				},
			},

			j_kh_invitation = {
				name = "{E:kh_pulse}Invitation",
				text = {
					"Gain {C:money}$#1#{}",
					"for every card sold,",
					"Create a {C:dark_edition}Negative{} {C:spectral}Perishable{} Joker",
					"every {C:attention}#2#{} {C:inactive}(#3#{}{C:inactive}){} {C:attention}Jokers{} sold",
					"{C:inactive,s:0.8}A new challenger approaches...!",
				},
			},
			j_kh_chipanddale = {
				name = "{E:kh_pulse}Gummi Phone",
				text = {
					"When {C:attention}Blind{} is selected,",
					"add {C:attention}one tenth{} of the chips",
					"in {C:attention}last played{} hand to this {C:red}Mult",
					"{C:inactive}(Last Hand: {C:chips}#1#{C:inactive} Chips)",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",

				},
			},
			j_kh_luxord = {
				name = '{E:kh_pulse}Luxord',
				text = {
					{
						'Gains {C:chips}+#3#{} Chips for every',
						'{C:attention}second{} passed this round,',
						'{C:red,E:2,s:1.1}self destructs at #2# Chips',
					},
					{
						'Each scored card',
						'increases the cap by {C:green}#4#{}',
					},
					{
						'Each hand increases the',
						'total Chips gained by {C:green}#5#{}',
						"{C:inactive,s:0.8}I'd rather we just skip the formalities",
					},

				},
			},

			j_kh_khtrilogy_kh1 = {
				name = "{E:kh_pulse}Kingdom Hearts 1",
				text = {
					"{C:chips}+#5#{} Chips",
					"Win a blind in one",
					"hand to {C:legendary}level up{}",
					"{C:inactive}(Next level: {C:mult}+#1#{C:inactive} Mult)",
					"{C:inactive,s:0.8}A true classic",
				}
			},

			j_kh_khtrilogy_kh2 = {
				name = "{E:kh_pulse}Kingdom Hearts 2",
				text = {
					"{C:mult}+#1#{} Mult",
					"Discard {C:attention}#7#{} {C:inactive}[#6#]{}",
					"cards to {C:legendary}level up{}",
					"{C:inactive}(Next level: {X:mult,C:white}X3{C:inactive} Mult)",
					"{C:inactive,s:0.8}peak has arrived",
				}
			},

			j_kh_khtrilogy_kh3 = {
				name = "{E:kh_pulse}Kingdom Hearts 3",
				text = {
					"{X:mult,C:white}X#2#{} Mult",
					"{C:inactive,s:0.8}KH4 when???",
				}
			},

			j_kh_helpwanted = {
				name = "{E:kh_pulse}Help Wanted!",
				text = {
					{
						"Complete a task to earn a prize!.",
						"New task appears after completion.",
						"{C:red,E:2,s:1}Self Destructs when no tasks remain",
					},
					{
						"{C:attention}Current Task:{} #1#",
						"{C:attention}Current Prize:{} #2#",
						"{C:inactive,s:0.8}Maybe... today we'll finally hit the beach!"
					},
				}
			},

			j_kh_munnypouch = {
				name = '{E:kh_pulse}Munny Pouch',
				text = {
					{
						"Gains {C:money}$1-$5{} of",
						"{C:money}sell value{} at",
						"end of round",
					},
					{
						"{C:green}#1# in #2#{} chance",
						"this Joker is {C:red}Destroyed!{}",
					},
					{
						"Sell this Joker",
						"to create {C:attention,E:kh_pulse}Munny{}",
					}
				},
			},

			j_kh_munny = {
				name = '{E:kh_pulse}Munny',
				text = {
					"Earn {C:money}$#1#{} at",
					"end of round",
					"Payout decreases by {C:red}$1{}",
					"every round."
				},
			},

			--[[j_kh_lethimcook = {
				name = '{E:kh_pulse}Let Him Cook',
				text = {
					"Gain {C:money}$#1#{} for",
					"every card",
					"{C:attention}Retriggered{}",
					"{C:inactive,s:0.8}Hollup... Let Him Cook",
				},
			},--]]

			j_kh_randomjoker = {
				name = '{E:kh_pulse}Random Joker',
				text = {
					"All cards {C:attention}held in hand{}",
					"count in scoring",
					"with a {C:green}#1# in #2#{} chance",
					"to retrigger",
				},
			},
		},

		Tag = {
			tag_kh_kingdom = {
				name = "Kingdom Tag",
				text = {
					"Shop has a free",
					"{C:legendary}Kingdom Hearts Joker",
				},
			},
		},

		Voucher = {
			v_kh_moogleshop = {
				name = "Moogle Shop",
				text = {
					"Enter the {C:attention}Shop{}",
					"when a {C:attention}Blind{} is skipped"
				},
			},
		},
		Other = {

			kh_lightsuit = {
				name = "Light Suit",
				text = {
					"{C:hearts}Hearts{} or {C:diamonds}Diamonds{}",
				}
			},

			kh_darksuit = {
				name = "Dark Suit",
				text = {
					"{C:spades}Spades{} or {C:clubs}Clubs{}",
				}
			},

			kh_unstackable = {
				name = "Unstackable",
				text = {
					"Cannot double a {C:attention}Joker{}",
					"That is {C:enhanced}perishable{}.",
				}
			},

			kh_perishable = {
				name = "Perishable",
				text = {
					"Debuffed after",
					"{C:attention}5{} rounds",
				}
			},

			kh_play_face = {
				name = "Grand Stander",
				text = {
					"Score 15 {C:attention{}Face{} cards",
					"to get {C:attention}+1{} {C:blue}Hand{}"
				}
			},

			kh_destroy_cards = {
				name = "Cargo Climb",
				text = {
					"Destroy 7 cards",
					"to get {C:attention}+1{} {C:red}Discard{}",
				}
			},

			kh_selling = {
				name = "Mail Delivery",
				text = {
					"Sell 7 cards",
					"to get {C:attention}-1{} Ante"
				}
			},
			kh_skipping = {
				name = "Junk Sweep",
				text = {
					"Skip 2 Blinds",
					"to get {C:attention}+1{} Hand Size"
				}
			},

			kh_shopping = {
				name = "Poster Duty",
				text = {
					"Spend {C:money{}${}30 in one shop",
					"to get {C:attention}+1{} Shop Slot"
				}
			},

			kh_munny_info = {
				name = "Munny",
				text = {
					"Earn {C:money}$[pouch sell value]{} at",
					"end of round",
					"Decreases by {C:red}$1{}",
					"every round."
				}
			},

			kh_luckyemblem_seal = {
				name = "Lucky Emblem",
				text = {
					"When {C:attention}scored{}, convert",
					"a card {C:attention}held in hand{}",
					"into this card's {C:attention}rank{]}",
					"and {C:attention}suit{}"
				}
			},

			kh_kingdom_seal = {
				name = 'Kingdom Seal',
				text = {
					"Increases rank of card by 1",
					"when {C:attention}discarded{} and converts",
					"it to your {C:attention}most common{}",
					"suit in your {C:attention}full deck{}",
					"{C:inactive}(Currently {V:1}#1#{}{C:inactive}){}"
				}
			},
		},

		Spectral = {

			c_kh_sorcerer = {
				name = "Sorcerer",
				text = {
					"Select {C:attention}#1#{} card to",
					"apply {C:attention}Lucky Seal{}"
				}
			},

			c_kh_gummiship = {
				name = "Gummi Ship",
				text = {
					"Destroy a random {C:attention}Joker{}",
					"and create a new {C:attention}Joker{}",
					"of the same rarity",
				},
			},

		},

		Tarot = {

			c_kh_awakening = {
				name = "Awakening",
				text = {
					"Creates a random",
					"{C:legendary}Kingdom Hearts{} {C:attention}Joker{}",
					"{C:inactive}[Must have room]",
				},
			},

		},
		Mod = {
			kingdomhearts = {
				name = "KHJokers",
				text = {
					"Adds {C:red}30{} Jokers and more content based on the",
					"{C:attention,E:kh_pulse}Kingdom Hearts{} Series!",
					"art by {C:attention}cloudz{}!",
					" ",
					" ",
					"Includes the following {C:green}cross-mod{} content:",
					"{C:attention}JokerDisplay{}, {C:attention}CardSleeves{} and 5 new {C:attention}Partners{}!",
					" ",
					" ",
					"Here's the {C:blue}website{}:",
					"{C:attention}https://cloudzxiii.github.io/{}",
				}
			},
		},

	},

	misc = {

		achievement_descriptions = {},
		achievement_names = {},
		blind_states = {},
		challenge_names = {},
		collabs = {},

		dictionary = {
			k_khjokers_config_jokers = "Enable KH Jokers",
			k_khjokers_config_tarots = "Enable Tarot cards",
			k_khjokers_config_spectrals = "Enable Spectral cards",
			k_khjokers_config_seal = "Enable Seal",
			k_khjokers_config_blind = "Enable Boss Blind",
			k_khjokers_config_menu_toggle = "Toggle Custom Title Screen",
			k_khjokers_config_restart = "(requires restart)",
			kh_a_side = 'Kairi',
			kh_b_side = 'Naminé',
			kh_plus_consumeable = '+1 Consumable!',
			kh_king = 'Fellas!',
			b_open_link = "Opens in browser",
		},

		high_scores = {},
		labels = {
			kh_luckyemblem_seal = "Lucky Emblem",
			kh_kingdom_seal = "Kingdom Seal"
		},
		poker_hand_descriptions = {},
		poker_hands = {},
		quips = {},
		ranks = {},
		suits_plural = {
			kh_com = "Kingdom Cards"
		},
		suits_singular = {
			kh_com = "Kingdom Card"
		},
		tutorial = {},
		v_dictionary = {},

		v_text = {
			ch_c_kh_got_it_memorized = { "All Blinds are {C:attention}Boss Blinds{}" },
			ch_c_no_skipping = { "Skipping is {C:attention}disabled{}" },
			ch_c_no_time = { "Game Over if {C:attention}Luxord{} gets {C:attention}Sold{} or {C:attention}Destroyed{}" },
		},
	},
}
