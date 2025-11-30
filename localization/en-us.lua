return {
	descriptions = {

		Partner = {
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
					"Balances {C:purple}#1#%{} of",
					"{C:chips}Chips{} and {C:mult}Mult{}",
					"when a hand is played",
					"Click to pay {C:money}$#3#{} and",
					"increase by {C:purple}+#2#%{}",
				},
			},

			pnr_kh_nobody = {
				name = '{E:kh_pulse}Nobody',
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
					"Start run with the",
					"{C:attention,T:v_overstock_norm}Overstock{} voucher",

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

			sleeve_kh_rechain = {
				name = "{E:kh_pulse}Re:Chain Sleeve",
				text = {
					"{C:green}Reroll{} costs reset every {C:attention}Ante{}",
					"Start run with the",
					"{C:attention,T:v_kh_moogleskip}Moogle Skip{} voucher",
				},
			},
			sleeve_kh_rechain_alt = {
				name = "{E:kh_pulse}Re:Chain Sleeve",
				text = {
					"{C:green}Reroll{} costs reset every {C:attention}Ante{}",
					"Start run with {C:attention,T:v_kh_moogleskip}Moogle Skip{}",
					"and {C:attention,T:v_reroll_surplus}Reroll Surplus{}",
				},
			},
		},

		Back = {

			b_kh_rechain = {
				name = "{E:kh_pulse}Re:Chain Deck",
				text = {
					"{C:green}Reroll{} costs reset",
					"every {C:attention}Ante{}",
					"Start run with the",
					"{C:attention,T:v_kh_moogleskip}Moogle Skip{} voucher",
				},
			},
			b_kh_kingdom = {
				name = "{E:kh_pulse}Kingdom Deck",
				text = {
					"{C:legendary}Kingdom Hearts{} {C:attention}Jokers{} are",
					"{C:attention}3X{} more likely to appear",
					"Start run with the",
					"{C:attention,T:v_overstock_norm}Overstock{} voucher",
				},
			},
		},
		Joker = {
			j_kh_magnet = {
				name = '{E:kh_pulse}Munny Magnet',
				text = {
					"{C:attention}Steel{} cards are moved",
					"to the top of",
					"your {C:attention}full deck{}",
					"and give {C:money}$#1#{}",
					"when triggered",

				},
			},

			j_kh_kingdomhearts = {
				name = '{E:kh_pulse}Kingdom Hearts',
				text = {
					"Unused {C:red}discards{}",
					"this ante carry over to",
					"the {C:attention}Boss Blind{}",
					"{C:inactive}(Currently {C:red}#1#{}{C:inactive} Discards)"

				},
			},

			j_kh_tamagotchi = {
				name = '{E:kh_pulse}Tamagotchi',
				text = {
					"Destroy all held {C:attention}consumables{}",
					"at the end of the {C:attention}shop{}",
					"gains {X:mult,C:white}X#2#{} for",
					"each one destroyed",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
				},
			},
			j_kh_xehanort = {
				name = '{E:kh_pulse}Master Xehanort',
				text = {
					{

						"This Joker gains {C:mult}+#1#{} Mult",
						"per {C:attention}consecutive{} hand played",
						"that isn't the same",
						"as previously played hand",
						"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
					},
				},
			},
			j_kh_com = {
				name = '{E:kh_pulse}Chain of Memories',
				text = {
					"Adds {C:chips}Chips{} and {C:mult}Mult{}",
					"from previous poker hand",
					"to current hand",
					"{C:inactive}({C:attention}#1#{}{C:inactive}: {X:chips,C:white}#2#{} {C:mult}X{} {X:mult,C:white}#3#{}{C:inactive})",
				},
			},
			j_kh_lethimcook = {
				name = '{E:kh_pulse}Let Him Cook',
				text = {
					"When an adjacent",
					"{C:attention}Joker{} is triggered,",
					"it's values",
					"increase by {X:enhanced,C:white}X0.05{}",
					"{C:inactive,s:0.8}Hollup... Let Him Cook",

				},
			},
			j_kh_lethimcook_alt = {
				name = '{E:kh_pulse}Let Him Cook',
				text = {
					"This Joker gains {X:mult,C:white}X#2#{} Mult",
					"When a {C:attention}Joker{} is triggered,",
					"{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult)",
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
						"this Joker cycles through",
						"it's {C:attention}modes{}:",
					},
					{
						"If played hand contains",
						"at least {C:attention}4{} cards",
						"destroy all cards",
						"held in hand",
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
						"{X:mult,C:white}X4{} Mult"
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
					'by #2# every {C:attention}#4#{} {C:inactive}(#3#){} {C:green}rerolls',
					'{C:inactive}(Most Played: {C:attention}#1#{}{C:inactive})',
					--"{C:inactive,s:0.8}I'm not afraid of the darkness!",
					"{C:inactive,s:0.8}I'm thinking RIKU RIKU oo ee oo",
				}

			},

			j_kh_kairi_a = {
				name = '{E:kh_pulse}Kairi',
				text = {
					"{C:chips}+#3#{} Chip per {C:diamonds}Light Suit{} scored",
					"{C:chips}-#4#{} Chip per {C:spades}Dark Suit{} scored",
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
					"This Joker gains {C:chips}+#2#{} Chips",
					"per unique {C:attention}suit{}",
					"in first played hand",
					"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
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

			j_kh_axel_alt = {
				name = '{E:kh_pulse}Axel',
				text = {
					"Add {C:dark_edition}Foil{}, {C:dark_edition}Holographic{},",
					"or {C:dark_edition}Polychrome{} edition",
					"to leftmost {C:attention}Joker{}",
					"when {C:attention}Boss Blind{} is defeated",
					"{C:inactive,s:0.8}Got it Memorized?",

				},
			},

			j_kh_axel = {
				name = '{E:kh_pulse}Axel',
				text = {
					"{C:white,X:enhanced}X2{} values of leftmost {C:attention}Joker{}",
					"and applies a {C:spectral}Perishable{} sticker",
					"when {C:attention}Boss Blind{} is defeated",
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
					"Played {C:attention}Kings{} have a",
					"{C:green}#1# in #2#{} chance to",
					"add a {C:red}Red Seal{},",
					"{C:green}#1# in #3#{} chance to",
					"become {C:attention}Steel{} cards,",
					"{C:inactive,s:0.8}Did somebody mention",
					"{C:inactive,s:0.8}the Door to Darkness?"
				}
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
					"All cards {C:attention}held in hand{}",
					"count in scoring",
					"with a {C:green}#1# in #2#{} chance",
					"to retrigger",
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

			j_kh_dummy = {
				name = "Munny",
				text = {
					"Earn {C:money}$(pouch sell value){} at",
					"end of round",
					"Decreases by {C:red}$1{}",
					"every round."
				}
			},
			j_kh_invitation = {
				name = "{E:kh_pulse}Invitation",
				text = {
					"{C:green}#1# in #2#{} chance",
					"to add {C:dark_edition}Negative{} edition",
					"to Jokers {C:attention}purchased{}",
					"from the {C:attention}shop",
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
						'Loses {C:chips}-#3#{} Chips for every',
						'{C:attention}second{} passed this round,',

					},
					{
						'Chips increase by {X:chips,C:white}X1.5{}',
						'when a {C:attention}Boss Blind{} is defeated.',
						"{C:inactive,s:0.8}I'd rather we just skip the formalities",
					},

				},
			},

			j_kh_khtrilogy_kh1 = {
				name = "{E:kh_pulse}Kingdom Hearts 1",
				text = {
					{
						"{C:chips}+#5#{} Chips",
						"Win a blind in one",
						"hand to {C:legendary}level up{}",
					},
					{
						"{C:inactive}(Next level: {C:mult}+#1#{C:inactive} Mult)",
						"{C:inactive,s:0.8}A true classic",
					},
				}
			},

			j_kh_khtrilogy_kh2 = {
				name = "{E:kh_pulse}Kingdom Hearts 2",
				text = {
					{
						"{C:mult}+#1#{} Mult",
						"Discard {C:attention}#7#{} {C:inactive}(#6#){}",
						"cards to {C:legendary}level up{}",
					},
					{
						"{C:inactive}(Next level: {X:mult,C:white}X#2#{C:inactive} Mult)",
						"{C:inactive,s:0.8}peak has arrived",
					},
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
						"Complete a task to earn a prize!",
						"New task appears after completion",
						"{C:red,E:2,s:1}When no tasks remain,",
						"{C:red,E:2,s:1}Self Destructs and earn $15"
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
						"Gains {C:money}$#3#-$#4#{} of",
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

			j_kh_randomjoker = {
				name = '{E:kh_pulse}Random Joker',

				text = {
					"of {C:mult}Mult{} and {C:chips}Chips{}",
					"when a hand is played"
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

			v_kh_moogleskip = {
				name = "Moogle Skip",
				text = {
					"{C:attention}+1{} skip button",
					"available in blind selection",
				},
			},
			v_kh_moogleshop = {
				name = "Moogle Shop",
				text = {
					"Enter the {C:attention}Shop{}",
					"when a {C:attention}Blind{} is skipped"
				},
			},

		},
		Other = {

			kh_shuffled = {
				name = "Shuffled",
				text = {
					"This Joker is shuffled",
					"before scoring"
				}
			},
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

			kh_no_blockbuster = {
				name = "Note!",
				text = {
					"This Joker currently has",
					"an alternate effect as",
					"{C:attention}Blockbuster-ValueManipulation{}",
					"is not installed."
				}
			},
			kh_lhceffect = {
				name = "Original Effect",
				text = {
					"When an adjacent",
					"{C:attention}Joker{} is triggered,",
					"it's values",
					"increase by {X:enhanced,C:white}X0.05{}",
				}
			},
			kh_axleffect = {
				name = 'Original Effect',
				text = {
					"{x:enhanced,C:white}X2{} values of leftmost {C:attention}Joker{}",
					"when {C:attention}Boss Blind{} is defeated",

				},
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
					"Score 7 {C:attention{}Face{} cards",
					"to get {C:attention}+1{} {C:blue}Hand{}"
				}
			},

			kh_drawing = {
				name = "Cargo Climb",
				text = {
					"Draw {C:attention}20{} cards in a single round",
					"to get {C:attention}+1{} {C:green}Hand Size{}",
				}
			},

			kh_shopping = {
				name = "Poster Duty",
				text = {
					"Spend {C:money{}${}20 in one shop",
					"to get {C:attention}+1{} Shop Slot"
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
					"Cards held in hand",
					"permanently gain",
					"{C:chips}+#1#{} Chips",
					"when {C:attention}discarded",
				}
			},

			kh_attack = {
				name = 'Attack',
				text = {
					"If played hand contains",
					"at least {C:attention}4{} cards",
					"destroy all cards",
					"held in hand",
				}
			},

			kh_magic = {
				name = 'Magic',
				text = {
					"After scoring",
					"Return first card",
					"played to hand",
				}
			},

			kh_items = {
				name = 'Items',
				text = {
					"When an {C:attention}Ace{} is played,",
					"create a random",
					"{C:attention}consumable{}",
					"{C:inactive}(Must Have Room)",
				}
			},

			kh_drive = {
				name = 'Drive',
				text = {
					"{X:mult,C:white}X4{} Mult"
				}
			},

			p_kh_drive_mini = {
				name = "Mini Drive Pack",
				text = {
					"Choose {C:attention}#1#{}",
					"{C:orange}Drive{} card",
				},
			},

			p_kh_drive_normal = {
				name = "Drive Pack",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{C:orange} Drive{} cards",
				},
			},
			p_kh_drive_jumbo = {
				name = "Jumbo Drive Pack",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{C:orange} Drive{} cards",
				},
			},
			p_kh_drive_mega = {
				name = "Mega Drive Pack",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{C:orange} Drive{} cards",
				},
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
			c_kh_kingdom = {
				name = "Hearts",
				text = {
					"Select {C:attention}#1#{} card to",
					"apply {C:attention}Kingdom Seal{}"
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
					"{C:inactive}(Must have room)",
				},
			},

		},

		Drive = {

			c_kh_valorform = {
				name = "Valor Form",
				text = {
					"Adds {C:mult}+4{} base {C:mult}Mult{}",
					"to next played hand",
					"before scoring",
				},
			},

			c_kh_wisdomform = {
				name = "Wisdom Form",
				text = {
					"{C:enhanced}Swap{} base {C:chips}Chips{} and {C:mult}Mult{}",
					"of next played hand",
					"before scoring",
					"{C:inactive}(Cannot Stack){}",
				},
			},

			c_kh_limitform = {
				name = "Limit Form",
				text = {
					"Adds {C:chips}+30{} base {C:chips}Chips{}",
					"to next played hand",
					"before scoring"
				},
			},

			c_kh_masterform = {
				name = "Master Form",
				text = {
					"{X:mult,C:white}X2{} {C:mult}Mult{}",
					"when calculating score",
					"for next played hand",
				},
			},


			c_kh_finalform = {
				name = "Final Form",
				text = {
					"{C:enhanced}Doubles{} base {C:chips}Chips{} and {C:mult}Mult{}",
					"of next played hand",
					"before scoring"
				},
			},

			c_kh_antiform = {
				name = "Anti Form",
				text = {
					"{C:enhanced}Balances{} {C:blue}Chips{} and",
					"{C:red}Mult{} when calculating",
					"score for next played hand",
					"{C:inactive}(Cannot Stack){}",
				},
			},


		},
		Mod = {
			kingdomhearts = {
				name = "Final Mix",
				text = {
					"Adds {C:red}30{} Jokers and more content",
					"based on the {C:attention,E:kh_pulse}Kingdom Hearts{} Series!",
					"code and art by {C:attention}cloudz{}!",
					" ",
					" ",
					"Here's the {C:blue}website{}:",
					"{C:attention}https://cloudzxiii.github.io/{}",
				}
			},
		},

	},

	misc = {
		quips = {

			kh_friendsmult = {
				"My friends are my multiplier!"
			},

			kh_simpleclean = {
				"Simple and Clean",
				"is the way that you're",
				"making me feel tonight!"
			},

			kh_walkaway = {
				"When you walk away…",
				"you don't hear me say,",
				"{C:attention}Fold{}!"
			},

			kh_kairiinside = {
				"Kairi... Kairi's inside me?"
			},

			kh_rikubugs = {
				"Mickey! It's Riku!",
				"They put bugs in him!",
			},

			kh_theyregone = {
				"They're gone! All our",
				"{E:kh_pulse}chips{} are gone!"
			},

			kh_icecream = {
				"No! Who else will I have ice cream with?"
			},

		},

		achievement_descriptions = {},
		achievement_names = {},
		blind_states = {},
		challenge_names = {},
		collabs = {},

		dictionary = {
			-- config
			k_finalmix_config_jokers = "Enable KH Jokers",
			k_finalmix_config_tarots = "Enable Tarot cards",
			k_finalmix_config_spectrals = "Enable Spectral cards",
			k_finalmix_config_vouchers = "Enable Vouchers",
			k_finalmix_config_seal = "Enable Seal",
			k_finalmix_config_blind = "Enable Boss Blind",
			k_finalmix_config_drive = "Enable Drive cards (WIP)",
			k_finalmix_config_menu_toggle = "Toggle Custom Title Screen",
			k_finalmix_config_restart = "(requires restart)",

			-- kairi/namine
			kh_a_side = 'Kairi',
			kh_b_side = 'Naminé',

			-- misc text
			kh_plus_consumeable = '+1 Consumable!',
			kh_king = 'Fellas!',
			b_open_link = "Opens in browser",
			kh_destroyed = "Destroyed!",
			kh_copying = "Copying!",
			kh_riku_no = "RIKU NO!",
			kh_sealed = "Sealed!",
			kh_tasks_complete = "Tasks Complete!",
			kh_complete = "Complete!",
			kh_stolen = "Stolen!",
			kh_munny = "Munny!",
			kh_returned = "Returned!"
		},

		high_scores = {},
		labels = {
			kh_luckyemblem_seal = "Lucky Emblem",
			kh_kingdom_seal = "Kingdom Seal",
			kh_shuffled = "Shuffled"
		},
		poker_hand_descriptions = {},
		poker_hands = {},
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
