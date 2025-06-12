Presently at: 
Wednesday 21 July 2017

Replace redundant PLAY_G macro with PLAYER (no -chan or -kun suffixes)

Add: Sitrus Berry (formerly Gold Berry) restores 25% of max HP, not 30 HP
Fix: Gold Berry heals 25% max HP when held
Sitrus Berry (formerly Gold Berry) restores 25% of max HP, not 30 HP

Add option to run by default.

Make single up-to-date ROM, not separate 1.0+1.0 versions
Leppa Berry restores 10 PP.
whited out → blacked out
Use Gen VI critical hit mechanics
Enemy → Foe
Electric-type Pokémon can't be paralyzed
Hidden Power is ???-type.
Cap Fury Cutter at 3 doublings, since it starts at 40 instead of 10

Add: Show Pokémon portraits when using field moves (thanks to TPP:AC).
Show pokepic when using Flash
Pokepics are colored by species and shininess

Add: Get a free Premier Ball with ever 10 Balls bought.
Poison-type Pokémon always hit with Toxic.
Disable lasts for 4 turns.
Fly to Rock Tunnel/Power Plant Pokémon Center
Rematch Elite 4.
Always show numbers in Pokédex, even in Johto order
Roar, Whirlwind, and Struggle are unaffected by accuracy or evasion, like Swift
Light Ball doubles Pikachu's Attack as well as Special Attack
Oak: "Please tell me your name."

Maximum $9,999,999 money and 50,000 coins
Fix: Game Corner games pay out even if you have 9999+ coins.
Fix bug where money is capped at $999,999 after battles.

Lake of Rage Magikarp are larger, not smaller
Battle Bill after catching all three legendary beasts (For birds check code)

Attacks no longer hit flying Pokémon

"Support trainers with individual shiny Pokémon
Eusine has a shiny Haunter"
Fix bug where wild battles don't load
Generalize trainers' shiny DVs to any unique DVs.
Different shiny DVs
Correct Shiny information

Added Psystrike
Add Flare Blitz

Prepare to add new Poké Balls.
Implement wBattleTurnCounter
Implement Repeat, Quick, and Dusk Balls
Implement Timer Ball (untested)
Repeat, Timer, Quick, and Dusk Balls work
Timer Ball catch rate multiplier is 1 + (turns passed * 3) / 10.
Nest Ball catch rate multiplier is (41 − enemy mon level) / 5.
Quick Ball catch rate multiplier is 5 on the first turn.
Implement Dive Ball
Fix Repeat Ball
Implement Heal Ball
Improve Heal Ball: restores status, and optimized

Trade Pokémon have special Balls
Wonder Trade in different Balls

Actually fixed Growth
Growth raises Attack and Special Attack by two stages in sunlight


Implemented Wonder Trading with the (currently unused) wonder_trade script.
Add Wonder Trade script.
Fix Wonder Trading
Use characters' names for Wonder Trade
Wonder Trade once a day.
Add a maximum level to Wonder Traded Pokémon.
Fix Wonder Trade random DVs.
Add more Wonder Trade OT names
Did not fix Wonder Trade OT gender / caught data
Add more Wonder Trade OT names
Allow three Wonder Trades per day, not just one
Add: Pokémon Go character names as possible Wonder Trade OTs.
* Add: Replace Cianwood Photo Studio with an event that makes your Pokémon happier.
* Fix: No more daily limit on Wonder Trades.
Wonder Traded Pokémon have no OT gender for now.
To do: assign one from the name table.
Add: 1/2048 chance for Wonder Traded Pokémon to have Pokérus.


Replace Mirror Move with Scald
Nidorina and Nidoqueen can breed
Add: Nidorina and Nidoqueen, not just Nidoran♀, can produce either gender of Nidoran eggs.
Don't catch a Transformed Mew as a Ditto
Get Eviolite in exchange for Eon Mail in Goldenrod City
Mr. Pokémon gives you a shiny Ditto egg for the Red Scale
Update base stats, mostly based on Drayano's Sacred Gold/Storm Silver
Play low-pitched cries when a player or foe Pokémon faints (code based on TPP Crystal)
Hidden Power is ???-type and 70 power, but not in the faithful version
Title screen version number ends in "F" for the faithful version (maybe add a D for debug?)
Add: Fishing works 75% of the time, not 50%
Add: X Accuracy boosts accuracy, it does not ignore accuracy checks entirely
Add money loss formula from Gen V
Show amount of money lost when blacking out
Add: Respawn uncaught legendaries (except for Celebi) after beating the Elite Four (Suicune roams).
Change some scripts to specials
X Special → X Spcl.Atk
Add: Bill calls to switch boxes when one is full
Add Mystery Gift girl with random Berries
Trapping moves last 4-5 turns.

Replace Poké Seer with Stats Judge.
Rewrite most of the Stat Judge code

Add: Natures (thanks to FredrIQ)
Add Natures
Keep Nature strings with other tetx
Keep Nature strings with other tetx
Explain Natures
Refactor nature code
Show how natures affect stats
use arrow indicators
Better arrows
NPC comment on natures
Save space with fallthrough
Fix nature stat modifier
Tune natures
Edit: 15 Atk/10 Def DVs result in a Naive nature (+Spe −Sp.Def), not Hardy (neutral)
Edit: Give in-game trades good natures.


Gen VI wild held item chances (50% common, 5% rare, 45% none)
Increase wild held item chances, even more with Amulet Coin

Removal of code
Remove printer functionality.
Remove GameBoy Printer references.

Remove Mystery Gift code.
To do: Remove Mobile Adapter code.

Remove unused mobile and printer music


Add: Buy 12 Moomoo Milk at once.

Start converting TMs/HMs to a bit array.
Note plans for TM mart changes
TM/HM bugfixes in progress
reorganize
Fix CountTMsHMs
Debugging TMs/HMs
Possible bug source found
Fix TM list (except for scroll lag)
Factor out common code
Add space for new items
Fix depositing items in the PC.
Slight bugfix in preparation for TM marts
Start adding TM/HM marts



Refactored move effects that raise 2 stats to use common functions
Implement {Damp, Heat, Smooth, Icy} Rocks and Light Clay


Show Battle Points on trainer card
Earn Battle Points in Battle Tower
Earn BP from Trainer House too

All grass can be Cut.
"anymore" for time, "any more" for quantity

In progress: show caught ball in stats
Commit balls.2bpp
In-progress caught ball indicator
CaughtBall display works! To do: debug gift, trade, and contest Pokémon; give some gift/trade Pokémon special Balls.

Add: Nest, Net, and Luxury Balls.

Two Options pages (TODO: natures, abilities, clock format, Pokédex units)
Skip unused options slot
Add more options (TODO: implement)
Different options order
Add metric Pokédex units option
Implement metric units option
Early game options (TODO: fix buggy toggles)
Fix early options menu. TODO: make the initial settings correct.
Correct initial options
Options → Options1
Move battle style to Options2
Fix crash

Plan to play Lyra's final battle music before the battle starts
Get Silver and Gold leaves via Headbutt
Add: Confirm gender selection.
"<Legendary> appeared!"
Add: Music resumes where it left off after a battle (from TPP).

===========================================
Refactor FinalPkmnMusicAndAnimation
Show dramatic animation after sending out Pokémon
Clear textbox

```	call EmptyBattleTextBox
	call WaitBGMap```

More final Pokémon text
Disable FinalPkmnMusicAndAnimation in link battles
Refactor final quote handling
Implement remaining final quotes
=======================================


Fix: Explosion and Self-Destruct do not halve Defense.
Add some move animations from Pokémon Prism
Add Mulch
More compact fishing code
Acrobatics animation

Proper inverted colors in battle (by MeroMero).

Start adding item icons (lots of commits to this)


Account for Shiny Charm for gift Pokémon
Color gender icons in battle
Shiny star is gold in battle
Fix: Dig and Fly prevent capture. (Fixes #156)
Use RBY Indigo Plateau music for Route 23 and Indigo Plateau itself
Hyper Test complete
Add stat trainers in Battle Tower
Add Fossil Maniac

==================================================
Color varying code written but not tested
To do: fix color varying algorithm
Continue debugging color variance
Add: Use DVs to vary Pokémon colors like in Stadium.
Fix varying colors again
Simplify code
Really fix color variation, for real this time
Rename some things
Slight optimization
Allow color variation to ±4
Refactor code
Remove unused CGB layouts
Refactor layout+color code and remove unused data
MeroMero's code to special-case Smeargle colors.
Tweak Smeargle color code
Color variation is optional
========================================================

Remove Time Capsule
Refactor intro
Remove 2 padding bytes per map, saving 1160 bytes
Remove Unown puzzle padding
Option to calculate stats with perfect IVs
Pokédex numbers in national mode only
Simpler GBC-only crash screen
Trainer stars
================================================
Rewrite the AI switch logic from scratch, freeing up a bunch of space in the process
Fix the switch AI code crashing if you reveal all 4 moves
SWITCH_SOMETIMES
If the player used Transform (or Imposter), reveal all of its moves to the AI
===============================================

Fix an issue in AI switch routine due to an errorneous assumption
Make Teleport always work assuming not trapped/similar
Search "Implement" for new items that were added
Implement up-to-date Egg inheritance mechanics
Implement stat pinch berries, Figy Berry and Gluttony
Implement Oval Charm
Optimize the daycare EXP gain routine
Animate Hone Claws and Moonblast
Fix Moonblast animation
Optimize Pain Split
Add Route 37 leader

Port some Prism optimizations, greatly boosting performance pretty much everywhere



























































































































































Dazzling Gleam and Moonblast animations:
https://github.com/vtrlx/pokecrystal/commit/f7d84a42fe7d02e9de5d99865ca6177f8bd746d5

https://docs.google.com/document/d/1p1Z25Iqp6QQnZ9c2k-b2on9M2ejQLKxKFOjBzT1H-CM/view?tab=t.0