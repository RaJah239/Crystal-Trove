TroveContent::

TroveTextEdits:
TroveScenes:
TroveEventEdits::
TroveItemTradeNPCs::
TroveQuestNPCs::
TroveMapEdits::

50 rare Candies for defending champ title. if can't collect send home in an item ball, and can't enter league (have guards block) until it's picked up home.

show how many tms are in teh inventory by battle tower mart's tm coin trader

Have Elm give the Type Chart item

Take out weather text when battle starts like “the sunlight got bright”?

In berry master house, have her husband (berry enthusiast) buy any berry for $1000
take acrobatics aniamtin from tim kun? 

Have E4 step aside / walk around the player so they can just walk upwards after talking to them. 

Search chatty Crystal for “nice file” for optimizations 

use map script macro nooryes for rematches end game 

Abilities:
Raikou: Volt Absorb + KO to increase speed
Entei: Fire Absorb + KO to increase Attack
Suicune: KO to increase Defense

Starters:
Blaziken: Fire/Fighting
Blastoise: Water/Steel
Toterra: Grass/Ground: half damage from fire/ice and flying types, first and second stages only half flying damage 

Book in shiny call giver’s house. 
3 options to view text?
There’s natively a 1 in 256 chance to find a shiny pokemon. I hear someone Prof. Oak knows gives an item that boosts it to even higher. Explains the Hidden Power types gotten for male, female and gender less. Can’t run from shiny mons 

Pokemon league round 2 each room is a map call back to have a named trainer appear to fight for your title. Maybe 10 per room? Defeating the person in Lance room gives xx Crystal/rare candy???
Winning this time has lance appear to carry the player to the registration room. 
Named trainers include rockets archer, Ariana, petrel, Green, Proton ect?

rapid spin to remove:
bind, clamp, fire spin, leech sheed, spikes, wrap, stealth rock
sticky web, toxic spikes, whirlpool

Take Ambrosia’s use people’s teams to fight another team in battle frontier 

When releasing the beasts in burnt tower, don’t add Suicune as it shows it’s in Tin Tower when it can’t be there yet..it roams around 

Have to have fought Celebi to fight round 2 league as it’s a time related thing and to prevent weirdness 

defog to remove safeguard and mist as well

type_matchups.asm to be exactly as types in battle menu like:
add dark/ghost resistance to Steel Types in 

Skip “Pokemon used move text” when fast battles is ON

check wCoins throughout to learn how to add more than 255 battle points

Maybe figure out to get this commit "Display shiny icon on naming screen" to work eventually

Test all animations on both sides of the screen (player and enemy) and fix if needed

NPC note "Before choosing a move in the battle menu Press Select to view enemy’s" type(s)

Do not display the About menu on the continue screen in the debug rom?

Insane mode: no exp, level caps, hard mode, remove enemy health bar 

	db NOCTOWL ; 164

	db 110,  50,  60,  90,  96, 100
	;   hp  atk  def  spd  sat  sdf

Skips wants tk battle text from trainers if it doesn’t already occur

use transitions from getkoriski and ambrosia from this folder

Zero Exp mode:
change this ld a, [wBaseExp] to ld a, o or xor a in engine/battle/core.asm 

NotesFAQs:
Light Clay does not extend switch Light Screen and Reflect + need to optimise weather rock, check commit

Rename berries to official berry names. Check Polished for naming if needed

My expert belt doesn’t work 100% right too but I’ll keep it. It gives the boost even if one of the types should resist. Example: using Thunder bolt on Dragonite still gives the 10% boost. When it should deal neutral damage when expert belt is held. Super minor but I can live with it until Im smart enough to fix this. 

I’ve never cared about nuzlockes to play myself but it’s hilarious what’s can be done in a romhack..bloody delete the save file and reset game on wipeout 🙃

Ironman challenge mode? Check what that is 

All challenge mode (not normal) “This is not recommended, especially as a first play through. This is completeable though”
So

Make instant text as default text option, remove from debug rom

Rename Battle Scene option to Battle Animations?

Change the gbc crash screen’s message 

Search “to optimise” and do so in my commits. 

Zero exp mode still shares EVs so exp share is still recommended tk be set ON

Btw, there’s a very easy way to make all pokemon have any level’s (say level 50) stats - including HP. So example, get the starter, it’s level 5, however it’ll have level 50 stats. It’ll level but the stats stay the same except for Evs/Stat exp gains. They will learn moves as normal. When it evolves, it’ll have the evolution’s stats. Can be turned into a mode too. Can kinda be like a Stadium-esque simulator but with travel. Too many ideas.. have a check to have Berries recover say 50 HP instead of 10. 

Add back gain exp in daycare to see how it works with level cap now thats ive prevented trading and Raikou/entei can’t be more than he level cap

maybe edit item data constants and have items max at 255 insted of 99?

play burn animation to user when flame orb ignites

99 (or a ceratin amount that would be similar or more than the chance of finding a shiny) gold leaves for a shiny ball trade

Switch in barrier ability for Mewtwo or others?
“A barrier encased this pokemon!”

Shiny Pokemon NPC encyclopedia. States all possible HP types for male, female and gender less pokemon and the fact that it is not possible to get a shiny pokemon with HP fighting. 

“Remember the only need 1 shiny ball because as soon as a regular pokemon enters it, it becomes shiny and can be caught with another pokeball”

Have a list appear of three (Male, Female and Genderless) and selecting any gives their explanation

Gift 1at stage lucario to show a happen pokemon in first slot in azalea. It’s gotten from day care odd egg. Lucario is far in the wild though. 

Remove trainer blocked ball from item effects and animation and it’s constant 

Starmie: Safe Guard and Natural Cure abilities 

Dark Pulse’s animation: by sourapple to credit

Have Lance at league say that thanks for stopping team Rocket. Word of that incident only came through after your bringing down of them. (No phone or radio works in pokemon league due to mountains and height). And it’s difficult to reach here in general due to the strong pokemon, mountains and natural obstacles. 

Liquidation (move) to consider

replace kanto badge page with another for end game scores??

Add FakeOut as a move since the Effect has been added

verify safeguard works only for the user
DrUltimaMan: "That particular instance has a known issue. The auto safeguard ability doesn't work properly in wild battles when the opponent sets it up, but everything should be working as intended in actual trainer battles. "

change faint_attack to feint_attack
Fake Out effect's added, need to add it to a move

check prism, get graphics for glitch city, for pancero. make a glitch city quest for it

Scizor second ability switch in +1 speed
Scyther Defog + Multiscale

field actions: rare candy to not show stat up screen on ow
Lots more items field actions to do 

;===========================================================

ShinyBallMMultiplier:
	call Random
	and %00000111 ; limit to 0–7
	ld hl, ShinyBallMTable
	jr ShinyBallJump

ShinyBallFMultiplier:
.loop_f
	call Random
	and %00001111
	cp 9
	jr c, .ok_f
	jr .loop_f
.ok_f
	ld hl, ShinyBallFTable
	jr ShinyBallJump

ShinyBallGMultiplier:
	call Random
	and %00001111 ; now gives 0–15
	ld hl, ShinyBallGTable
	jr ShinyBallJump

ShinyBallJump:
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	call SetShinyDV
	ret

; Common DV handler
SetShinyDV:
	push af
	ld [wEnemyMonDVs], a
	ld a, $ff
	ld [wEnemyMonDVs + 1], a
	pop af
	ld b, $ff
	ret

; M Table - 8 entries
ShinyBallMTable:
	db $01 ; Poison
	db $03 ; Rock
	db $12 ; Steel
	db $21 ; Grass
	db $23 ; Psychic
	db $32 ; Dark
	db $70 ; Ice
	db $10 ; Bug

; F Table - 9 entries
ShinyBallFTable:
	db $33 ; Fairy
	db $00 ; Flying
	db $02 ; Ground
	db $11 ; Ghost
	db $13 ; Fire
	db $20 ; Water
	db $22 ; Electric
	db $30 ; Ice
	db $31 ; Dragon

; G Table - 16 entries ; missing fighting type
ShinyBallGTable:
	db $33 ; Fairy
	db $01 ; Poison
	db $03 ; Rock
	db $12 ; Steel
	db $21 ; Grass
	db $23 ; Psychic
	db $32 ; Dark
	db $70 ; Ice
	db $00 ; Flying
	db $02 ; Ground
	db $11 ; Ghost
	db $13 ; Fire
	db $20 ; Water
	db $22 ; Electric
	db $31 ; Dragon
	db $10 ; Bug

;===========================================================

have someone say in game that changing the Daylight savings time back and forth may cause trainer phone calls

Expert level of the main battle building has lv 60 Pokémon while the player is capped at lv 50

AI to update:
If sees a kill, but slower than player and has a set up move that increases speed, use it, then kill, unless teh player has a priority move

Note: When run out of pp when using choice band you get a message “encore ended” and can choose another new move 

Optimise focus blast with hyper beam’a animation

Maybe replace Dig with Drill Run, animation added at start of Animation file

Add a zero exp mode
Add a zero exp hard mode, add all the text and end game pokemon league text for it

Remove return’s effect and make it a standard 102 attack and delete the trainer happiness flag I added long ago

Add shiny bonus to bug catching contest?

In item effects, if a shiny pokemon bursts out a ball, it plays its shiny animation again? Or is this tedious?

Speed up trade and battle room entries in pokecentre 2F

Colour Voltorb flip machines differently 
Note that I could probably use Crystal Clear’s pokedex to check possible shiny palettes?

Add a secret location that can only be accessed via end game warping
Since I can warp anywhere. Maybe add the SECRET (like Battle Network 3) area in Kanto. Make it a super large map and add the buildings? Take a look at vanilla Kanto Saffron and Celadon maps 
Have me appear post champ battle and tells you how to respawn pokemon and have a book appear on the table to always have it. I will be where the curse giver was in the mansion
You’re healed before and after all battles here. Items backup and restored every battle here as well
"Huh? You think just because I made this game, I have something special for you? Why yes, I do! Go to your start menu, you'll find a fast warp menu to warp to familiar places now and a new Secret Area. Hope you enjoy it" etc

Lanturn (+ volt absorb) and Ampharos (+ reflect) always hits with Thunder
Hariyama no miss with Meteor Mash + Guts
Write a text that plays for switch in abilities like “<User>’s Intimidate lowers <target>’s attack”
“<User>’s Moxie boosts its own attack after scoring a KO” etc. 
Make Fly a tutor move in Violet city, after beating Flakner and remove it as a HM. Edit the pack graphics to have it show TMs, not TM, rename the pocket to TM Pocket instead of TM/HM Pocket

Make a scoring streak for anything like special trainers in the battle facilities and special trainers?

I know it's not really a bug per se, but more an inconsistency: when AncientPower raises all stats, it will list: Attack/Defense/Speed/Sp. Attack/Sp. Defense. For the sake of consistency, Speed is generally listed last since that's how the stats are always arranged. (At least in modern games, I think Gen 2 still put Sp. Attack/Sp. Defense last).

Battle Points added, rolls over though. Need to..
	readvar VAR_BATTLEPOINTS
	ifequal 2, .xxx
like Buena's buena and here's how to store battle points. Maybe make max 100?

readmem wBattlePoints
addval 1
writemem wBattlePoints

Reduce the amount of time sand storm and hail battle animation plays 

Remove FLY as a HM. Remove it from the Pokedex Move page. Add someone in Violet that teaches Fly (60) for a Silver Leaf. Have Falkner tell the player about this after winning that the guy in the Mart will teach Fly to…. Here’s a scene there that gets set in the gym after beating Falkner. If gone to the Mart prior there’ll be a scene where the Mart person will say if you beat Falkner I’ll teacher your pokemon Fly for a Silver Leaf

Streak Idea: enter a place, can be like how it was for CAL, talk to the receptionist, move to the fight area. Fight an opponent, after each fight if won, increment his streak Battle Counter for him by 1. It maxes at 255 (probably). readmem 255, .MaxBattleStreak to skip adding. If lost, streak ends. You save here. Resetting the game looses the streak. Have two records. Current and max. Or have it like an arcade console in the battle tower, maybe near back. to talk too that gives the Missingno sprite from GrateOracle. Use Ambrosia Tetris theme
Have a bunch of arcades and the high scores appear on the trainer card by pressing select!!

Violet gives Nuggets, not Crystals. It checks gender and uses appropriate DVs for a shiny ball+ unique Hidden Power type

Add 50% sand storm or 50% hail at silver cave

99 gold leaves for a shiny ball trade
X gold leaves for a Crystal 

Expert level of the main battle building has lv 60 Pokémon while the player is capped at lv 50

Rename berries to official berry names. Check Polished for naming if needed

Update perfect Accuracy moves after adding all moves 

Make a list of things that occur in Debug Mode for an ASM file reminder 

Rename Healing Light to “Regen Ray”

BW3G grottos?

Final Scarlet has to go into "BossTrainers:" array when added

Add quest for battle inverse and neutral battles 
Check Tim’s commit

Snorlax gets the Gen 1 Kanto theme
Rival Pokemon league gets some sort of remix. Maybe zinnia?
Mew and Celebi gets the same theme
3 birds gets their remixes
MewTwo gets Kanto wild theme?


Red2 gets the championship theme (to unlock best him in Mt. Silver to have him appear in the gym leader trainer house

Sell Nuggets somewhere for the Gholdengo Quest have wild pokemon have it rarely

Move the fountain elsewhere like Mahogany Town?
You can just copy/paste what you need, but you'll need to edit the tileset_anims.asm so that the fountain animation plays on which ever tileset you're adding it to

SideQuests:
Hydreigan side quests: make a new beasts check to check if captured all dark mons and have a map call back or event that gets sets to have Hydreigan appear deep in dark cave or a cave opens up where he’s located, this would be better so his event can easily be cleared on beating Red. Mapcall back, beast check, iftrue earthquake like Rock Smash, Strength sound and a message stating: “A sound of rocks moving/crumbling nearby. A path may have cleared up” which have.

use zinnia_battle_final battle theme somewhere

Needed to figure out a way to get it to print a special 'attack missed due to levitate' message though
“Ground moves miss”
“levitating foes!”

If got through, can do a few things like play back protect animation if protecting. Same with endure. Sleeping pikemon show Zzzz, para pokemon show para gains. Evade text also shows pokemon moving aside lol 

Berserk Gene has to effect, revert this back to normal or replace it altogether

Polished Crystal stat reduction animation 
Reuse Endure’s animation for Stat ups + sound effects

Goldenrod roof top sale sells vitamins and nuggets at selling price 

Gym leader/boss trainer house. There’s an elevator in this building . 

Special house with 3 floors. One is ground floor. The next is the fight a trainer, 4 times in a row, 10x Crystals for winning. and Next floor is inverse and does the same as prior but reverse battles. There’s an elevator in this building . Each battle room has a similar layout as the trainer house but with both an elevator and stairs to the upper and lower floors. Has PCs as well

Change Elm’s lab music to the happy one from black and white, Himula city?

Add more stations to the radio as more music gets heard. Check how the rocket takeover or ruins of Alph does it

Remove headbutt trees in cities with no encounters

rapid spin only clears spikes. Should it clear sticky web, steathr rock and toxic spikes? check this up

Moved this down:


	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
	cp LANDMARK_BATTLE_TOWER
	ld de, MUSIC_UNOVA_ELITE_FOUR_BATTLE
	jmp z, .done

Add a check event for inverse battles event set to play the puzzle theme here, add it from Ambrosia in battlestart.asm for the code above

Incase I want to have another trainer like special trainers aside from battle tower trainers 

Super Pokemon Sidequest:
Puzzle cave solution: left path, up path, up path
And finally right path to the exit.
Has an exit at the bottom to leave the cave.
Used for XXX mon?

optimise vanilla daily flags for lapras, bug catching contest, mt moon clefairy etc.

Gold leaf to sell for 9,800
Use Gold Leaf system alone to Buy pokemon held items like Leftovers, Scope Lens, etc.
in the Battle Tower similar to the battle tower crystal move tutor
These items in the special mart above call ALL be gotten from Wild Pokemon as their 2% item slot

Loot items like Tiny Mushroom, Silver Leaf, Gold Lead - more usage
in cianwood pokeseer house, trade 10 mushroom for 1 silver leaf with a NPC
and back in Ecruteak, a NPC that trades 10 Silver Leaves for a Gold Leaf in probably a new house
Silver leaf is on the bellsprout line at 23% steal and Gold Leaf at 2% steal only. Btw, I like bellsprout
These Silver and Gold leaves can be used for ceratin things like move tutors,
getting pokemon and quests that I can come up with
So this can build on what I wrote above. You can try for the 2% steal item or
get a gold leaf by working up the trade chain and 100% get any desired item.

Battle Tower to be only 4 trainers and prize is 2 Crystal

No pokeflute station needed for Snorlax, just a simple overworld encounter.
Text would be something like “You shook the sleeping pokemon.
The Snorlax awoke in a grumpy rage and attacked!”
then
Random 1 in 100 of Snorlax appearing in its original map after capture/defeat
Put it in south of Route 46 at start of game so it can be seen
but not accessed until reaching blackthorn. Then when someone is beaten/event is set,
changeblock to make it easy to access after reaching Blackthorn,
similar to Johto Legends in design.
Also have the special post game phone call speak of this.
A map call back in blackthorn to set and event to changeblock route 46 by Snorlax,
like vanilla south Fuschia city changeblock

I thought about having Lugia be a quest chasing it around Johto with with Eusine or someone else but it always flying away until it eventually goes home to Whirl Islands but doing it logical and not hand holding is tricky
Have the female rival chase with the player and she calls to tell you where to go next!!
“She hears rumours”
Have a scene where the Whirl Cave reacts to Silver Wing and the path/cave opens to allow the player to enter and meet Lugia. Just has the set scene in the same script as where I give the Silver Wing

Battle tower mart clerk: give 1 Silver Leaf for a random berry.
Berries aren’t sold anywhere else in the game

Tsareena line like stats but reduced special attack for attack in meganium line?

Add gym trainers to Jasmine’s gym like 4dorin

Add new music for battle tower trainers or have them pull from a pool like the random party trainer and remove item caluse

Make a macro for finding more than 1 item? (Excluding hidden items) or just use the vanilla battle tower gift script each time. 

Tutor for Bulldozer, Rock Tomb & Icy Wind?
Tutor: Elemental Punch tutor in Goldenrod Mart
Swap the Tutor from out Goldenrod to inside the game corner. The tutor outside the game corner sells the Tbolt, flamethrower and ice beam tm. And inside Blizz, Thunder and Fire Blast. 
Blackthorn Recoil tutor: Double Edge, Sky Attack, Outrage
Support Tutor: Light Screen, Reflect, T-Wave
Hard Hitting tutor: Close Combat, Gunk Shot, Hydro Pump (90% Accuracy, 100 Damage, 100% accuracy in rain + damage boost)
Make a Shadow Punch tutor in Ecruteak cemetery?
Weather tutor for all 4 weather moves in the Sandstorm house
Someone teaches Rockslide at the pokeseer house for a Silver Leaf
Add a tiny mushroom trader that trades 10 Tiny Mushrooms for a single silver leaf. Have them in pokeseer’s house as well.

Add a trader that trades 10 Silver Leaves for a single Gold Leaf as 1:12 is about right so round down. This person as someone in Ecruteak city? Have him say that some people collect Gold Leaves for tutor moves, favours or gifts but he’s a Silver Leaf collector and would trade 10 Silver Leaves for a Gold Leaf. He says that his favourite pokemon evolution line has it in the wild and a move like Bug Bite or Peck can steal them from them if your pikemon isn’t already holding an item! Or you can capture them to acquire the leaf
Don’t forget to add back Nayru’s scene after completing the pokedex in oaks lab. She’ll say that it affects all pokemon but breeding with a shiny Ditto or Male parent(?), boosts it even more! (Like 3.25%). It has no effect on Eggs btw (to verify)
Delete unreferenced text in ruins of Alph research centre 
Have Pryce checkitem Red Scale and see that you have the Red Scale and say something like “wasn’t there a guy in route 30/31 that raves over rare things..? Never mind..” old people know each other 
Elm's post-game phone call added!
Make rival appear at the pokemon league and dragon's den daily
remove executive m and f overworld sprites, class, parties
Add Second Rival
Headbutt trees' and Rocksmash encounters in different areas, I think rockmons change in TimKun55's project
Not sure if adding: Pokémon Mart's Delibird Std Script added. 
Pokédex now accurately display the percent of Johto + Kanto's grass & surf encounters.
Add a scene to cherry grove pokecentre about turning off intro scenes
Have both porygon and chansey registered in pokedex via Elm’s script when he tells you of both?
Replace some items or hidden items in ilex forest with trainers (maybe?)

Colour gender icons from TimKun

Different note at pokemon league for hard mode players “Hard Mode Extreme” maybe? Check event Hard mode to jump to it. 
Maybe on the score card put “Xtreme” points or some variant for the hard mode points?

Give a pokemon 50 rare candies to see if it maxes happiness and if not, increase rate candy happiness gain

Add what each option does in Elm’s lab book shelves 

Up arrow means it’s not a flying type but it is levitating so ground moves won’t hit 

If you say no to elm’s request he will ask again, if you say no again, play credits hehe

Have someone in goldenrod dept store say “each vitamin gives 4 effort values..whatever that is”

Blank out mart’s cancel box with an empty box like the battle tower mart’s move tutor box 

Make a Bellsprout swarm for easier gold leaf farming 

Check if morning + day hours equals to evening + night hours 

Harden should +2 defense 

Make Charizard rarely appear in Dragon Den’s Grotto. Make Blastoise rarely appear in Whirl Island’s grotto. Make Venusaur rarely randomly appear in route 43(?) near lake of rage’a grotto. Rare means 1%! Each had random rare swarms in their respective areas. Also 1% and says something like “An ULTRA RARE OUTBREAK HAS OCCURRED!”

Screen big shakes between each Dragon’s Double Dash and turns black before impact? Like double edge 

Check if Suicune text in pokedex special area, adjust as needed

Post Gym battle they give a random pokemon that they used and they are the same pokemon with a custom move set and Shinys like the gym leader. Will check out Dratini code

Shiny Ball gift: “the first one’s always free!” Like a drug dealer 

make back nurse healing like vanilla and add extra text for champion and grand champion texts like emerald

Play Tetris theme from ambrosia when doing 6 vs 6 inverse battles 

general battle speed ups..maybe remove stat up and down messages?

Make a streak board. Make it as a special to be called. Have it appear with a text box. Read the wvariable and display what’s stored. Easier to do now that I think of it. Or make it an item effect that is given by Rajah in the battle area. Name is “Streak/Score Card”. May have 2 pages? Add a check for hard mode, make a different variable like wHInverse6v6 or something to store the hard mode streaks !

Edit Cianwood world map and whirl islands back to vanilla, maybe remove landmark south of Cherrygrove, may not adding
Use a map call back instead of Basement Key to save an item slot if running out?
have someone say what the symbols mean in the battle menu for physical/special/other in earl's academy
After naming the Rival have the scene continue to elm like polished

E4 Round 2 respawns: Sudowoodo appears (no squirt bottle needed), regular Gyarados appears where Red Gyarados was, all mahogany electrodes…

On player menu screen add a left arrow that goes to badges 

Chikorita line: Grass/Fairy. Think Fat + Immune to Poison and it’s respective attacks like how Steel is

Check if pokedoll works on trap battles like in rocket hideout or red Gyarados. If not, replace this item. Doesn’t smoke ball do the same thing??

Double Edge split into two hits as dragon dash double hit to replace dragon claw?

Make Raikou and Entei be lv 20 as roamers. (So can’t get the daycare deposit/withdraw glitch) Suicune should be bumped to near the level cap whenever it can be fought. 

Have a choice to clearflag Unown dex Incase the player wants to catch them over in the right order
keep printer for unowns, relabel it to just display all, add the final unown that should be in the vacant spot

Have 7 encounter slots for all water routes as well, make it like grass too: 1%, 5%, 16%, 19%, 19%, 20%, 20% (update grass encounter slots)

Save added to Celebi encounter so save, then encounter to reset for shiny

Remove all unused tiles 
Redo pallet town map with Johto tiles to remove all those tiles 

Add password tutorial for “RBG” starters

Remove:
Unused Sky Attack effect

Replaced all PP UPs in game and its effect

Reminder: The music player is great but as soon as I enter a house on the same land mark, the music reverts to the map music. Something I wanted to do myself is learned how to have the radio as well not change when in the same land mark even though I moved to another area

Move Buena’s radio station to the start of the pokegear. Rearrange the pokegear time reset, maps, radio etc. put radio first and time last?
remove Expn card engine flag for radio, also put Beuna's station as the first

Swap the Ruins Aerodactly room and Omastar rooms so that strength will be needed to get to Aerodactly. Maybe add some blockage to Ho-Oh’s puzzle for last?
In each Ruins room back, a fossil of the respective can be gotten as puzzle picture

can use events to have the old guy remember what swarm is active in goldenrod pokebros house

update party icons to be the same as overworld npc sprite colours esepcailly for daycare pokemon

Streamlined Sudowoodo and Flower Shop Florina stuff.
Mom Buys some dolls, also, maybe have her buy useful items worth it for the playthrough like evostones? tms, leftovers etc?
decorations are bought in Goldenrod Marts and 
dolls are bought in the mart as well…

A full training kit would be 26 of each vitamin, of each of the 6 stats would cost:
$1,528,800 not including 50 Rare Candy which is 240,000 so total would be:
$1,768,800. Make the Goldenrod roof bargain sell all vitamins at selling price ($4900 instead of $9800) so the deal above is about the same price so with that bargain factored in as the cost of all 156 vitamins + 50 rare candies is $1,004,400 which is a great deal as Rare Candies can’t be purchased!

Have a fortune teller in each town that when pay a fee checks your events and slyly tells you what to do next?
Post game she tells you of how to reset legends, battle facilities, shiny, etc and finally get the world is your oyster? Would use a similar std script like the center nurse

In game gives multiple TMs from trainers and itemballs
colour code all different pocket items

redo Mart blocks to face the player on entry and have delibirds in all marts
remove daisy's daily grooming to someone else
have catching tutorial guy leave after his scene if you viewed the catch tutorial or not

replace rattata back sprite on route 30 battle
replace charcoal man's farfetch with ow scyther and have that run around

remove bill's scene in Ecruteak and add him in Goldenrod with his Eevee to give the player right away

Maybe mapcallback check event Surf gotten, Morty beaten, Suicune seen to set the scene for the guard with female rival fight here

Move the Karate King closer to the entrance in Mt.Mortar as a precursor to Chuck and up much deeper add entrace to Mt. Moon's Square?

test how shinies are gotten with a ditto with 16 dvs to special/speed (whichever is needed) and if so, maybe add a special for checking if have desired amount of dvs

Maybe even make Goldenrod city larger? Add Pokemon GF mansion in Goldenrod and during the take over, have a rocket block the building saying they’ll have these game developers make games for them to make money and “I hear RaJa239 isn’t here, I wouldn’t mind meeting him in a dark alley for him not giving us grunts names.”

Have RaJa239 coord event when the player first time enters the battle area. Use generic pokefreak sprite. “Im not a battler, more of a cheer guy who like watching others have fun”

After the effort score side quests clear an event that has someone appear in earls academy that explains what the scores mean, that they are earned by KOs and be seen by how many points in the Pokedex or vitamins. Vitamins alone can even max them out, expensive though

Person in a Cherrygrove house gives amulet coin for $2000. Says he thought it was used at goldenrod game corner but it’s not so he can part with it. 

Violet city house/pokecentre - trade a silver leaf found on bellsprout for a chinchou. He explains where to get it (via bellsprout evo line, check pokedex for percentages) and how to get it, via bug bite and peck. 

Change Violet rocky trade to rhyhorn

Violet city, new house, stop map music at night. NPC says they feel chills at night and the music changes at night? Feels as though something is watching me. Gastly is in the sink? From Johto legends event

Selling a pokemon for elsewhere uses same words from ImportedCheese video Ponyta in Azalea

Ponyta is found on Route south of Ecruteak and  west route if it near barn, both routes there

Add Good rod to Ecruteaks unused  house
He tells you he doesn’t need it anymore as this town alone relaxes his soul 

Add Super Rod to Olivine 

Change headbutt, rock smash & fishing items

Add an attendant in goldenrod game corner above the Voltorb Flip row that explains it fully. 
Remove the need for having coins to play it as well

Goldenrod roof bargain sale to have all vitamins alone

Kimono girls are in the middle of their rehearsal so they can't be bothered with until Morty is beaten? When you do enter, you get a scene of them dancing as they finish up? This way I can remove the Badge requirement for Paddle Boat/Surf or can also have a scene after beating Morty where Petrel harasses/accosts them and you warding them off, you get the Paddle Boat?

Someone in game says a Pikachu can surf on water, it looks cool!

Add the complete "TRAINING KIT" to Silver Cave's pokemon centre

Make union cave and mt mortar dark?

Female rival nicknames all her pokemon 

Still have Red Disappear after beating him and clearing all necessary events. He reappears post Round 2 Pokemon league

Add HM tutors since the original HMs will just be items

Giovanni gives the final level cap because he used to be a gym leader

Flakner gives fly, the only HM. Can only be used by bigger mons 

Random Teams from a pool tutorial to make a random battle tower like building? Check Tim’s challenge building to make it 7 in a row

Have Rival jump the player on entering Bugsy gym. After Bugsy is beaten, then the scyther and cut guy appears in ilex forest.

Have rival dialogue change in olivine to represent you met him in mahogany 
“The gym leader is not here. She’s at the light house. She’s known to be strong but she cares about the sick..” that dragon guy.. he too was kind.. am I missing something?
…
…
I don’t have time for this!” then he storms away

in victory road is where he treats his pokemon well, plays boss music and tell you to "don't lose"

Battle Tower, 4 trainers, wins 2  CRYSTALS 

Mew final pokemon side quest. Catch all pokemon fly home, in the tile to enter the house is a coord event to have the player walk to the centre of the town. Mew teleports around with the player turning to face each time. And finally settings in a spot awaiting to be fought and captured.

Do like Ardorin for Ecruteak and Blackhorns gyms, mapcallback outside the gym/respective city to reset trainers in gym
Elms speech about chansey. “Chanseys are known to be lucky pikemon and any trainer that meets once should talk to it. It heals your party”

Have a Polished Crystal's advanced sign that says "When EXP Share is set ON, all participants gain 100% Exp and non participants gain 50% of exp" word this better
remove/replace ss ticket item
recall that Kanto badge engine constants are no longer used
BillsGrandfather special to rename and use, as very useful
Put Bill's grandfather in goldenrod bill's family house, keep evo stones in mart unavailabel until late game or just trainers and bill's grand father
remember there are sprite constatns to remove/replace
make sure all items in the game are availabel in game
E4 and Lance first and second matches have 2 teams each random! to prevent planning for a single team

Every map/cave/area 
Check daily engine flag in each map
Random 10
Appear NPC that trades/sells something
Set daily flag
Make him have different stuff? No, even better, a different Odd Egg for a cost of 99x Crystal
Each odd eggs has unique moves, pokerus, shiny
Only get 1 Egg per day and he warps/teleports/black fades (sets his event) after, he says. “That’s all I’ve got for today, Im Off”

Prevent trading until end game/last level cap to prevent the bug with the day care?
check event final level cap trainer event, prevent trading

remove unused sprites from Kanto like diglet from cerulean police station etc
remove unused variable sprites from fuchsia

NPC Route 29/30/31? “Careful, the moves Bug Bite and Peck can steal held items if none are equipped”.

Digletts dug the slow poke well

Have the route 29 tree NPC say that on evenings you can encounter pokemon from the day and night
have his overworld pokemon change by time

Make a note in my docs to check grateoracle AI scoring and switch for ideas to use like his U-turn, Teleport, Baton Pass

Check Tim’s pins on how to convert a gif to an animation and out it in the animation section of my document

Modify/make a new macro based on “givepoke” to gift a shiny?

Have the Kimono girls have sto evo mons since most Eevees are out:
Arcanine
Poliwrath 
Victreebel
Raichu
Nidoqueen 

Change Kabuto Unown Puzzle description to “a pokemon that were in caves?)

Test U-turn in link battles
fruit trees per route and their constants needs to be edits for the removed ones done in kanto

rename routes 1,2,3,4,5 etc.

Togepi around day care at 1% has lucky eggs common and Miracle Berry/Everstone rare ? Available as a swarm

End game bug catching contest, check flag, top tier bugs. Lv 2-50 bugs. Participation prize is a sunstone, 1st place: Master Ball, 2nd Place: 11 Crystal, 3rd: 4x Sacred Ash

Top floor has maxima alone mainly because he’ll have some maybe a lot of nicknames pokemon 

Remove scientists from Rock battle animation as it does so in the battle tower or make a new trainer class and give it to that use the same sprite as scientists but still remove the battle transition from scientists so it won’t affect the battle tower. 

After a Pokemon is successfully caught play the animation from prism

Mt Mortar top, add Mt Moon Square, call it: Mt. Mortar Square

If you talk to the tv after learning the spawn, it says “All outbreaks end tend to end at midnight (12:00am)”

Get a new sprite for Player’s father

The Gym Guide will tell you that Gym Leaders and certain boss trainers will not consume held items in battle

General TODO
Complete Unown dex to see Hidden Power type on 4 status page 
Also, to unlock Nown battle to capture 

Only 1 HM and it’s fly and can be forgotten anytime. Gotten early gym 1?. HM items given out and doesn’t require getting gym badges to work.

Catch all non lengend dragon and fairy mons for Alataria to appear somewhere. Have a hint via NPCs?

“Every pokemon has a hidden attribute that can only be brought out with two moves “Hidden Power” and “Hidden Force”.
Make a physical hidden power too!!! Name it “Hidden Force” (Add TM too!) + name it “Hidden Type/Inner Attribute” on 4th stat page + it’s animation:
It does the same Hidden Power start up animation with the orbs floating around and then a hit animation like “tackle” so it’ll fit all pokemon

GoldenrodCityPanUpScript:  for the radio tower, battle tower and anyt thing else from polished crystal

Make side quests for caught time, Hidden Power and Effort Values to appear on 4th stat page

Add new map landmark and name for Dark Cave Blackthorn side

Remove Pokemon centre fast heal! Add back vanilla's and modify for evening

Add the abandoned power plant between Goldenrod and Ruins of Alph 
Remove goldenrod check for pokerus

Max level is 50

Gym leaders have their ace next to them and their events get set when the leader loses

When the swarm system is added to the TV ensure it says that swarms usually end at 12:00am

Map call back shadow, rustling grass, water movement or dust cloud in caves for random pokemon like the grottos I originally wanted. 

Elms post league phone call tells the player that the battle resort is open to you. Have a book or something in the player’s room that tells of the post game stuff like infinitely recatchable legendaries, Snorlax, Sudowoodo etc. each person in the resort has a side quest before battling. 

Upon entering the Gym lounge, the gym guide is there has a scene and tells you about the place. Has a porygon PC and chansey on each floor and each person here you need to do a quest to be allowed to fight them. More people you unlocked, the more that will appear, so first floor is Johto leader, second is Kanto, third is Agatha, Lorelei, Blue and Red

Giovanni is in Tojo falls post Blue beating he appears. Have a hint about him. 

Side quests to unlock trainers, everyone except Blue unlocks round 2 pokemon league, that unlocks Blue, Blue unlocks Red. Blue, Red, Agatha and Lorelei are on the top most floor. After everyone gets unlocked, they battle on certain days. Agatha and Lorelei are unlocked when all gym leaders are beaten except Blue. They both unlock Round 2 pokemon league, that unlocks blue and blue unlocks Red. Everyone battles on specific days after. Red unlocks Mt Silver to claim MewTwo

Side quests:
Falkner - capture all non legend flying mons?
Bugsy - See/Captured Volcorona
Withney -
Morty -
Pryce -
Chuck -
Jasmine -
Clair - Beat previous three?

Brock -
Misty-
Surge -
Erika - Find 10 Gold Leaves
Janine -
Sabrina -
Blaine -
Blue -

Replace Train Station

Expand maps in general, add more map objects. Give a reason to always revisit maps post game 

Team Rocket at Lake of Rage is using device to control pokemon, force them to evolve too to make them money makers

Radio Tower take over to control pokemon world wide!

Rewrite Team Rocket scripts and have Giovanni be the final boss in the radio tower? Radio tower take over is post Gym 8. Has Mewtwo as a single pokemon (says it was created from the progenitor of all pokemon in a lab far away) and MewTwo releases itself after. 

Check TM locations in vanilla and determine where to put them now 

Elm’s lab is normal but have Oak’s lab in the battle resort and have him say that he used to be a serious trainer when he was young and they wanted him here for his expertise but continues his research as well here. Replace references to him saying he is from Kanto

Violet City:
A new haunted house in violet city and a woman says that she feels chills at night as a map callback post morty? or someone else. Come back at night and she’ll says it’s chilly right now. Each day speaking to a spot in there give an encounter or duskull

Slowpoke well connects to Union Cave. 

Ecruteak:
The cemetery or pokemon tower is in Ecruteak at the back like the shrine in Polished Crystal’s back. Optional and has trainers. No ghosts in burned tower or bell sprout tower but in Ecruteak’s cemetery and Curse TM is at the top

Have Eusine in the Suicune Tin Tower event after the battle he should tell you he’ll head home. Here he does the beast check and gives the Rainbow Wing if you catch all dogs
Eusine’s house in Ecruteak

Mt. Mortar
Clefairy dance spot above Mt Mortar
Zapdos appears after collecting 8 Badge deep inside past the waterfall

Route 38 berry farm

Olivine:
Have Olivine City's Boat go to Cianwood city

Battle Resort:
Gym Leader/Important Character house
Beat everyone (set event everyone) for Blue to appear, beat Blue for Red to appear
Oaks lab downstairs, research on a new way of battling (inverse battles side quest)

Inverse battle building locked (old trainer house) until the oak’s inverse battle side quest is over. It has a sign on the door “Renovations ongoing” or put it in the sign 

Battle Tower Mart
The clerk there, trades coins for TMs. Is the Battle Tower endorsing gambling?
Battle Tower gives 3 Crystals and a trainer like a gym leader or RED gives 1 Crystal and no money 

In oaks lab, getting the shiny charm has a book appear in the day care that tells the player that it does affect eggs but a a shiny ditto or parent (which ever is right, make or female) will give the egg a 3% chance to be shiny 

Cianwood City:
SS Aqua ticket gotten here to travel back faster

Ice Path:
Articuno

Prior to victory road is the badge checks from RBY

Victory Road:
Moltres

Daily shadows on the ow for flying pokemon encounters check Mae Orange for my ideas 

Encounter percentages per slot. 7 slots: 16%, 17%, 16%, 17%, 16%, 17%, 1%
BW3G-Items for items like expert belt and such and move effects (start from the initial commit and move up)
Even Improve the Hidden Grotto Item system commit and hidden grotto items
Replace cleanse tag item
Rematch trainers to always play their encounter music on each rematch
```object_event x, y, sprite, movement, rx, ry, h1, h2, palette, type, range, script, event_flag ```
That's not super clear 😛 In this case, h stands for hour. You can define a range of hours of the day during which the object appears. It won't show up outside those hours.
Look at the battle tower code for receiving more than one item and use it in elms lab for getting 5x Pokeballs. Maybe consider using this more when finding more than 1 item in the ow? Maybe make a std script for it?
In rock smash rocks, add appropriate mons
Use the monster sprite for all Grotto encounters but with the appropriate palette to save sprite spots first
Pay for pokemon at the battle tower back with money or crystals, use a scrolling menu too like the TMs if possible
Grate Crystal Noctowl Sprite:
It's from the Spaceworld leaks, which showed a bunch of beta designs from gen 2. That's what Noctowl looked like at earlier stages of development. I think we can all agree they should've kept it.
Edit pokegear moon to be more visible, check day and morn icons too
Make Gyarados to Physically orientated Water/Dragon with 540 BST Haxorous stats. Kingdra more specially orientated with 540 BST Haxoorus reshuffled stats!

Have a Pokédex/book on top of Elm’s pokeball table post Red that gives the phone call message from Elm

In Pokédex remove old mode and only keep regular mode + A-Z mode 

Have grottos use generic ow sprites like vanilla party icons example he oddish to represent grass mons, the monster sprite for 4 legged mons, bird sprite for all birds,  etc. use different ow palettes to differentiate 

Use “waitsfx” when lance gives trophies and check if it saves space. 

Give an event for all gym leaders in their gyms, Check event best Red, have them disappear on certain days and have them appear in a gym leader rematch house like grate Crystal ? Give an event after the first battle so the text will be shorter on each subsequent battle. Can lose, no money, give Crystal for winning. Also, use the same checkevtn Red in gyms to have the leaders give a different quote like “up for a rematch? Can’t be today, let meet in the gym leader lounge on Xxxday of the week”. Have the gym guide at he lounge too. Have neat interactions between gym leaders? Like Bugsy and Misty? Move victor here. Have Brock be next to Jasmine. He says he and Jasmine has a lot in common. Have Agatha and Lorelei in the ow, and after beating them and after event beat RED, have them appear here..?Lt Surge and Chuch has things in common since they’ve both trained a lot. Whitney and Erika are friends, some can stand alone by themselves

Check for text that get used more than once and textfar them like the trees text

Battle tower has a blocker and says that it’s only open to trainers that have proven themselves and have at least 8 badge or 7? 

Add different game corner prize pokemon on different days to make shiny hunting easier and reduce the number of ow sprites used for pokemon and grotto maps (for space)

Remove the code for trading to gen1 and remove and make smaller pokecentre F2

Remove Lucky number show and give a random item daily

Add Hydreigon - Dark/Dragon + Float. Make a quest for it. 

Take a look at rock smash encounter Pokémon tutorial, adapt it to work on headbutt trees to get silver and gold leaves 

Remove player mom walking frames and edit the script so the player walks to the mother and check how space is taken up by either in comparison - with the walking frames and without 

Have Kurt’s daughter slowpoke grow back it’s tail after some event, mapcallback, and have an event to have her tell you that it grew back and then she gives a random apricorn daily 

When entering Union cave grotto, in that scene script have all Pokémon disappear and verify if this works. 

On my Pokédex using BGB emulator, make it a certain size, cut out all the types as pngs to he used in google sheets

Mary interview, neat idea, even beat R: Implement Mary's interview; lay basis for future interviews · shasocastris/crystal_castris@9066fe0
Also make a Red2 defeat flag that when set, Mary gives random 2: 1x Master Ball, 4x Sacred Ash or 33x Crystal. After receiving the item, she clears the flag for next time Red is beaten 

To save Event slots, change all grotto Pokémon to Event_Grotto_Mon_1, Event_Grotto_Mon_2, Event_Grotto_Mon_3, Event_Grotto_Mon_4 and Event_Grotto_Mon_5 at the bottom of the file and verify it works with that spot and all spots properly with appearing and disappearing of Pokémon 

Add special areas for grotto Pokémon in the dex Like how Ho-oh and other Pokémon were done. Have scarlet in union cave say that your Pokédex even have a special page for grotto Pokémon and certain special Pokémon.  

Trainer card star system, check mauvesea hack or search “charm” on pret to find her GitHub

https://github.com/TimKun55/pokecrystal/commit/c6364bc647f11629945812437ad01411b6ce8a1c

Make levels ranging from 2-max level of each grass patch?
Have 10 encounters per grass/water tile. 11% for 9 and 1% for 1. So 99% common encounters and 1% rare.
Do levels 2-max for bug catching contest too
Check a site to calculate the players bug catching contest score and use that to edit the NPCs potential scores then test. 

Get quick claw to play the berry animation when it activates. 
Same with focus sash, focus band etc.

Ensure all Key items can fit in bag 

Flanker after battle text should be something like “swoop in anytime!”

Bugsy “ready to take on my swarm?”

Make all gym leaders, phone trainers rematches at lv 100 Can lose battles end game except E4 and have elm’s phone call indicate that

Put the list here:
Falkner 
Elder Li
Bugsy etc. 

Have Elder Li say: Gym Leaders and other Boss trainers do not give money upon defeat but they give items which can be sold???

Make all trainers Can Lose end game. Have elms phone call state so - rematches and lv 100 phone call trainers

Check how much money a Lv100 trainer with Class Money of 24 gives. Double to for Amulet Coin effect and Proportionally give that value in Crystals end game and battle tower

Battle tower to be a streak of 4 and 2 crystals given when won

Level Caps:
Gym badge caps: 9, 16, 19, 24, 30, 35, 45, 50 (use level cap based on gym badge) (8 bages and all level should base on Kanto badges)

In gym leader scripts remove set event trainers since the mapcallback already does that? Test if it works too like that

Edit ruins of alph research centre map script about printer stuff
Pokecentre 2F mystery gift guy needs to be removed/replaced with something better, remove its scene too

https://github.com/pret/pokecrystal/wiki/Add-a-new-battle-transition -
New battle transition for Rival M, Rival F, Gym Leaders, E4 Members, Lance, Red, Maxima Gets an X, Lorelei and Agatha have the same. Oak has a unique one too, check polished crystal

Remove normalbox and gorgeous box items, effects, extra text etc.

When using Teleport make the text say “returning to the last pokecentre visited…”

Have the player Father around at different times..like early morning before work and evenings. Special dialogue when you become champion from both parents. Have the father around and not Scarlett’s mom at the start of the game. Have the father be home on Weekends too doing different things throughout the day. Another exit for their bedroom too. 

Change the intro Pokémon to ..Mareep
Shorten oak’s text(?). Have also, tell you that there is no need to rush, take your time, explore, speak to everyone on your journey
Change her dialogue about pro elm wanting to see you but about getting your first pokemon
Since the skateboards have been added. Have the mom say that she sees you enjoy using your skateboard and remember if you just want to walk, hold done B and the directional pad. 
Let the mom tell you about “Do Not Disturb” mode and Mom tells you that she sees you enjoy the running shoes and to remember to press B to walk when desired. 
Change mom saving money dialogue script. 

Elms Lab:
Elms also tells you of Porygon PC and to look out for them. You can use them or a PC to manage Pokémon.
Add female rival there. She takes the weak to starter and immediate battle ensues, then she leaves. She also gives you her phone number?
Elm’s lab assistant after bringing back the odd egg, he should tell the player how someone stole the pokemon, its unbelievable.. It’s something that group from Kanto would’ve done
Have pro elm assistant who gives exp share says it shares the same EVs to all Pokémon also tells to talk to the book in earls lab to learn about EVs. 

Make all ow Pokémon register in the Pokédex and show their pokepics when interacting with them

Need to check if the pokegear in all areas display the name there correctly due to Nayru’s edit. 

When oak gives the Pokédex let him say that he made the original dex and  Nayru62, a talented user upgraded it. It’s has lots of options now to help the diligent trainer. 







Newbark Town:
In scarlet’s house always give her theme when talking ot her
After getting a pokemon, have mom’s text change that your pokemon is cute and “what’s this? You got an errand too?” And maybe continue her regular dialouge?
Replace the green fat guy with the tips bug catcher.
Tips Boy:
Hi X. How are you? I wish to travel the world one day so I’m making notes. Want to hear them?
Yes: list them out 
No: “I wonder how vast the world is…”
After the initial event: want to hear my travel tips X?

Let the tips boy tell you about Porygon and Chansey in the OW + he shows the poke pics. Do not disturb, taking off encounters, walking, slow surfing, resetting with B + select, reminder that there’s a school in violet that will net even more info.
When you leave pro elm’s lab and scarlet’s scene, edit her text, have her say that “you’re going on an adventure too? Then continue her dialogue? She needs to know that you too are going to go on an adventure.
Edit mom’s text after talking to Sarlet, she should know you already have a pokemon
In scarlet’s house the pokegear should say Scarlet’s house not neighbours house
Elm gives the pocket pc after beating the pokemon league

Route 29:
Make poke balls a different colour in the OW, swap to the icon of TimKun’s
Have the guy that tells you if your Pokémon are too weak to stay out the grass say something like “If you would like to travel safer don’t forget to turn off Encounters in your options. Be sure to keep it ON to train and find new Pokémon. Or something like that. 
Have that guy that tells you of fleeing pokemon..who was originally about saving, have him say a pokemon stole his held item with bug bite. To be careful and luckily I had a pokemon with peck that stole it back lol

Cherry Grove:
Have the Nurse in the Centre know who you are after beating RED.
Check Event event beat red jump to “The usual right Champion/ <PLAY_G>?
Remove the print option from the pokemon centre “Change Box” option
Give the blue teacher dialogue since now she needs less due to the above. Maybe add a Pidgey to her side and make her sprite stay still
Mart - dialogue change for poisoning since poison won’t KO in the OW. 
Man in the house that tells you to collect all badges, after collecting Clair’s he should give you a Sacred Ash.
Have an extended scene where the rival says you have his trainer card and oh no you saw his name. He then takes it back. Check polished crystal. 
Make all ow Pokémon register in the Pokédex and show their pokepics when interacting with them
Redo floor 2 of the Centre if my game can’t trade with Gen1 and remove the time capsule.

Route 30:
Edit Mr. Pokémon’s house, remove the broken PC..and it’s relevant text
The route 30 sign that tells you not to steal Pokémon needs to be changed. Also, shorten or remove the text for throwing balls at Pokémon. Or better yet, remove all that code. 
Edit the berry teacher’s text in her house that when you meet a berry tree the first time it’ll always be a berry but anytime thereafter only on certain days they bear fruit. Bear fruit, I have it wrong present…as bare fruit.
Route 30 sign about Mr. Pokemon’s house and mr. pokemon’s house sign should be all caps!
Every phone number that gets added, remove their text for the denial of it. 


Route 31:
Add route leader that fights if all trainers in route 30&31 are beaten. The cooltrainer guy next to dark cave. Give him a coord scene. He gives the Key Item Escape Rope(?). Give him a coord event so the escape rope won’t be missed. Let him tell you he has an escape rope he’d part with. Remove all other escape ropes in teh game thereafter.
Wade calls and gifts a single Miracle Berry.

Dark Cave:
The sign outside should read “DARK CAVE next line, the name says it all”



Violet city:
Earl gives a type chart + books added to the desks, “Remember that EVs earned in battle only takes effect upon level ups or depositing/ withdrawing said mon for the PC”
Change Earl’s dialogue to sound normal and clean it up. 
Add books to Earl’s school tables to teach about EVs, types etc. Make note about Levitating Pokémon
Gym - the guide has a scene. Talks to the player. Tells that Falkner won’t battle unless the sprout tower is cleared. And gym trainers reset in all gyms to come prepared when going after the badge and this can be used to make some extra money and train up new party members. 
In the mart add another NPC to talk about X items/ change the one that talks about loving mons. 
Make all ow Pokémon register in the Pokédex and show their pokepics when interacting with them
Let the Red walking super nerd near the sprout tower say that if you beat the leader you’ll be able to go further. 
Have elder li tell the player flash is a HM and cannot be deleted except by a special person. And you don’t need to teach a mon it can be used as long as Pokémon can learn it.
Gym badge play a SFX for level cap & obeisance level increase and proper prompts
Shorten the scientist dialogue. Go by elm before collecting it and shorten his dialogue too. 
Mart person - text “X Items are great for wild Pokémon battles. It’s too bad they can’t be used in trainers battles or I’d be invincible!
Line: But, so would everyone...”
Add falkner’s dad..or some reference to him? Says he’s overseas? Idk yet.
Have the guy in the onix trade house tell you that the level cap and disobedience threshold is the same level so no need to worry about a traded pokemon disobeying you, unless its traded of course. Change that trade to Rhyhorn as onix will be quite good as a rock/dragon in the future and change the boy’s after trade text as he talks about how is his old onix going..
Earl’s blackboard to say both fire and water types can’t be burned, ice and fire types can’be be frostbitten
Make the trade faster..less delays or call delays? Idk yet what causes the test delays here..
In the mart the guy that tells you about items held by pokemon..that all the items that get stored in the battle item pocket can be used by pokemon in battle or have held effects..soemthing like that
Earl’s movement outside of the violet gym..ensure he has no extra movement data in the map script
Have the young boy that say she saw the wiggly tree ahead and after you fight it, he says something else

Ruins of Alph:
Prevent Escape Rope from being used in Ruins of Alph. So after fighting NOWN or whatever, a scene with Mew ensues after exiting the room of NOWN? Or new Mew side quest?
Kabuto chamber change the description since it won’t be a water/rock type, rock/bug now
Mew Quest
Catching all Unowns, showing the scientist them all, there will be a scene, he will head outside and when the player goes outside too, another scene with him will say there’s a powerful presence emanating from the ruins to please go check it out. Entering the ruins, a scene plays out. The player immediately hears mew’s cry, then gets an exclamation mark, turns all directions slowly and settles on the direction Mew is in. Mew appears infront the player the same direction the player is facing, the scene ends. After fighting Mew, he’ll have another scene to say that it was the Mystical Mew? And say he has even more work to study. Hopes you visit again. He then goes back to the research Centre. Talking to him will say “Thanks for all the help with the ruins investigation and his researching papers is coming along nicely thanks to the player”
Route36/Ruins gate, have the old guy’s speech change after clearing sudowoodo
Have the fossil professor have an intro speech and everytime after he only asks if you have a fossil
Remove the printing machine on the top right corner as there won’t be any printing eventually


Route 32:
Edit this cool trainer dailogue and give him the Route leader coord event for beating all trainers in route 32. Set his scene after fighting Scarlet. Gives..idk.. Miracle Seed/exp charm regular item?
Ralph shouldn’t say anything about finding anything rare when he offers his phone number
Route 32 pokecentre text is too large for the pokegear, fix this
Union Cave:
Have the hiker when entering with the onix say that yes, he did have 1million dollars but not anymore
Smoothen eric the explorer’s exit. Also go to all grotto signs and ensure them all have grotto in all cap in the sign
Have Union Cave Eric say that pokemon that appear in grottos don’t appear in the pokedex?
Make Eric scene on the tile to enter the Grotto, the player gets an exclamation mark when standing on the tile, takes one step to the left, then faces right, Eric appears, faces down, left, then right, gets an exclamation mark then starts talking. Will have to set his event at the start of the game. Then he walks away after.
Onix 1% in this cave. Remove it as a Grotto Encounter here?
Make grotto Pokémon each be 1 in 20 to appear? I don’t know yet 
Route 33:
Girl here scene, if beat everyone in the cave + the guy out here she fights. Gives a thick club(?). 
Ponyta should be in this grass
Hiker Anthony shouldn’t say anything about rare pokemon when he gives his number
Ilex Forest:

Make all mushroom sprites in ilex forest variable sprites that gets turned to a paras 1/10 and attack the player.
Put a few trees in Ilex Forest using the same daily flag as the Mushrooms here


Azelea Town:
Replace the farfetch'd in the charcoal house
All rival battles get a winloss quote
Slowpoke well, Good Samaritan, the G in good should be capitalized
After clearing the slow poke well…in Kurt’s house..after beating teh league, his niece says that slowpoke’s tail completely grew back and has a moving sprite now.




Route 34:
Have the Gym guide disappear after beating the next Gym Leader in the list
Add a route leader cooltrainer M/F to each route that allows battling once after defeating everyone in the area. Also, they give an item.
Add a book to the daycare table that explains how to have Pokémon lay eggs and how the room works like my previous project. For eggs, remove the text in the status screen that don’t get used anymore since all eggs take much less time to hatch. 


Goldenrod:
Add Celadon Mansion with game freak here to get the diploma
Have the gate blocker say “I best be on my way. Loads more to experience/see” check which is grammatically correct in ChatGPT 
Clean up text in the game corner especially since the coin case can’t be missed. 
Ice beam, T bolt & Flamethrower now become TMs. The 110 attacks moves are tutor moves. 
Ice/thunder/fire punch tutor for 5000 coins in the mart
In the underground edit the guys text that tells you about Hiker Anthony 
Buena, edit her list, maybe keep Nugget and still have it at 3 Points.
Have the Gym guide disappear after beating the next Gym Leader in the list
redo payout for card flip in game corners
Update all Odd Eggs, make them all Shiny and give them great Hidden Power types
officer Kieth needs to talk after battle. He doesn’t right now. 
Verify Burma’s password works after a day or days past
Have everstone also act like eviolite. 
In the poke  gear the goldenrod centre is too large. 
Goldenrod mart basement need to change the machoke  sprite
Add someone in the vitamin store that says they will give protein to their tyrogue to ensure its attack is higher than its defense on level up to get a hitmonlee. You out to check evolutions in your Pokédex. 
Bill’s sister gives the phone number immediately and not question asked. 
goldenrod underground. Add a sign to the wall or book to a desk to state the shops and opening hours. 
goldenrod underground the pokemaniac that talks about Hiker Anthony after battle, edit his text
In the pokebros house, in the pokegear change it to pokebros house 
Goldenrod deep underground change the tricky item that requires the switches to get with a Sacred Ash. 
Change the warp when ending the game corner to end up on the right side on entry instead of left. 
Edit the game corner to like my previous project adding the leftovers as well + text edits + more lucky machines. 
Bike Shop sign, have BIKE SHOP, next para the description 
add people to the Johto train station when the power plant gets fixed. 
For the radio card quiz instead of bird Pokémon for Faulkner, make it “flying type Pokémon”
redo Beuna’s prizes but keep the Nugget as 5 points, vitamins as 1 point, same 1 point to ultra call, full restore and leave Rare Candy as 3. So re-order the list with the ultra ball first, full restore, vitamins, rare candy and Nugget last. Change  Rare candy cost to  $0. 
Sacred ash in the underground in the switch room that’s super hard to get too
Change pokegear name rater house to PokeBros
Look at odd egg code to have special eggs with special Moves on hatch via Battle Tower  or add more ?
Add bike customers for after the phone call, see tim kun’s
Buena Blue Card filled 30 points for 3x sacred ash
Check event for Swarm gramps that aslso allows swarms or snorlax? I don’t know yet.
Game corner to have different Pokémon each day for easier shiny hunting and tk reduce the amount of overworld sprite constants used and grotto Pokémon
Make the underground entrance as soon as entered to face the steps from the city to inside to make it enter more seamlessly by adjusting the warp points
Have someone (make a std script) check how much coins you have and if you have less than 10, they give 69 “to have fun with” in each game corner. Make the coins expensive To buy?


Route 35.
Bird keeper to say that most Pokémon flee so Kurt’s fast ball are very effective 
Route leader for beating everyone here??
Officer dirk to talk after his battle like the other.



National Park:
Add a route leader cooltrainer M/F to each route that allows battling once after defeating everyone in the area. Also, they give an item. Beat everyone in route 35 and national park to challenge. Make sure it disappears when the bug catching contest starts..or make this person the route 36 route leader instead?
The boys talking about pokedex stickers dialogues need to be changed and the girl near the centre says things about her bag and pokdex stickers
Change the sign here about printing mail
Change the text of the gameboy kid about printing stuff out
For the contest, change the contestants dialogue..Barry’s is waay off! Have him say to try to catch a pokemon at full hp to get more points, 

Route 36
Make all rock smash items super rare to encourage more use and make the fossils the less rare, maybe 3/256 and all other items 1/256?
Route 36 sign needs to change
Ecruteak
Have the Gym guide disappear after beating the next Gym Leader in the list
Exruteak blocker text “here’s an ongoing investigation presently inside. You’ll have to come back later. I hear the dance theatre is popular with both locals and travelers/visitors/some word to mean outsiders”
Bill gives his phone number in ecruteak if you don’t already have it from his sister. His cannot be deleted.
All rival battles get a winloss quote
In the burned tower there should be an invisible Sacred Ash.
The trade back kid’s text during the trade says, TBGuy, fix that
Ecruteak centre pokegear needs to fix 
Fat green guy that says the light house Pokémon is sick should say something different after it’s been healed
Check if Rhydon and Rhyhorn over world Pokémon sprites are both used. If so, remove rhyhorn and keep Rhydon. 
Morty’s script needs more para and less cont 
Colour code kimono girls 
Scarlet after first talking to, she gets an event to say “Shhh, I’m studying” or something like that

Tin Tower scene replace the correct sprite with Eusine..the super nerd is still there and missing a sage sprite..Also have Eusine speak about Lugia here. 

Mt. Mortar
Mt mortar to get magnetons since it’s a magnetic cave and houses Zappos. 
Have someone in the cave or a new trainer that says that this cave’s magnetic pull attracts certain pokemon like Maneton.
Mt.Mortar 2F, the guy that speaks about the gother guy with a slowpoke with strength, edit this appropriately
Mt.Mortar 1F, the guy speaks of a seadra user with waterfall, edit this stuff approriately

Mahogany
Have the Gym guide disappear after beating the next Gym Leader in the list
All rival battles get a winloss quote. Give him a battle in the rocket section
Lance heals the player after the Arianna fight so the player when weaken can take on the electrodes 
Lance gives fly HM. Chuck’s wife gives whirlpool and the stablilizer..but name this something else..it’s so bad..
Have The shady mart have different items and replace the Slowpoke Tail item. That should not be in the game..
The centre here, change the boy and girl’s dialogue about learning moves and evolution 
fix the Murkrow sprite..should not be Moltres
have the eliminate guy says “Oh no! I’ve been eliminated instead” lol
In the gym, fix the guy that tells you he’ll frost bite your Pokémon so they can’t do a thing, his text is too long
Make Pryce’s bage allow fly usage
Remove extra coord event under rage candy guy’s sprite..wastes space


Route 43
Add a route leader cooltrainer M/F to each route that allows battling once after defeating everyone in the area. Also, they give an item. Beat everyone here except the week day sibling before doing the stuff at the lake of rage?
In the gym have a gym say that fire types can’t be frosbitten and remove teh code to defrost? Or leave it as it shouldn’t ever come into play..





Lake of rage
Make sure Gyarados is not a flee pokemon
Check item red scale, have lance have extra dialogue that he hears there’s a guy on Route 30 that enjoys rare items 
Hidden Power guy to say the type depends on the Pokémon and not Pokémon has vented the Fairy type hidden power
Understand how the fishing Guru works and put magikatp to be rodded up in the lake of rage?
Have lance check item for red scale and if you do have it have new dialogue that tells the player he hears of a guy in route 30 that collects rare things, he may want it
Make the Gyarados shiny with a good Hidden Power type. Also, seems there’s a delay between the text and the Cry of it, remove the delay
Make Garyados not flee
The cool trainer that appears after the Rocket event under the Hidden Power house. Move him somewhere closer and have him as the route leader. 



Route 38 & 39
Add a route leader cooltrainer M/F to each route that allows battling once after defeating everyone in the area. Also, they give an item. Beat everyone in route 38 and 39 to challenge this person.
Have Bird Keeper Toby say something different other than teaching his pokemon to fly in cianwood
Night trainer to have an appropriate pokemon



Olivine
Have the Gym guide disappear after beating the next Gym Leader in the list
That kid with two dialgoues about pokedex and gear, combine or keep one to save space?
Have the good rod fishing guru say that the POKEGEAR shows the fishing groups..not the pokdex, I think that’s what I read
At the port, make sure Shellder are easy to catch with rods there..as the fisher there says
Lighthouse 5F, change the guy talking about going to Cianwood to teach his Pokémon to learn Fly
Lighthouse cianwood change Jasmine dialogue as amphy won’t be unattended since Scarlet is there. 
Olivine Battle Tower sign, remove the opening part as it’s open



S.S. AQUA
In the bin near the sea sick guy, have a message same as Gen1 “uhhrr I should not have looked”
Many bins here..add some stuff?


Route 40
Have Monica Monday not say Bird Pokémon but flying types Pokémon
Reduce rock smash item acquisition rates..like 1 or 2 out or 256 per item?



Route 40 gate
Change the text of the boy about winning special gifts


Battle Tower
Replace the berry seller in the battle tower?
The old woman that says you can use items..edit this dialogue. 
Populate battle mart with more people 
Make fossils sell for $0
Make stones sell for $5000(?)
Make Nugget 1/256 from rock smashes 
Add a unique battle tower theme, check sourcrystal, crystal ultimate, polished crystal etc.
Odd eggs never shiny (so you can’t get the perfect Pokémon here and shiny hunting is still worth it) + unique moves for max money! that replaced the berry seller. 
Take a look at sour crystal’s battle tower teams



Route 41
That girl that talks about Staryu..change that to Starmie and make sure they are found in the water at night 


Cianwood:
Make Cianwood city vanilla shape to eventually add in Safari Zone
Have the Gym guide disappear after beating the next Gym Leader in the list
Change the Seer to a move tutor
Change the Seer sign outside to Tutor ahead
Change the pokegear to say Cianwood Tutor
The pharmacy after Verbosegiveitem Secret Potion needs prompt after it
Post Red removes boulders from here
The gym blocker fix the grammar, he needs to say “I better get back into the gym” or something 
have the Shukie giver only give the player it due for I the happiness of the first party Pokémon permanently so there won’t be a reason to use a daily flag 

Bird Keeper Vance near Ice Path, move to elsewhere or change his dialogue?

Home after Blackthorn fight and wishes you the best in the pokemon league, she disappears when blue goes back to his gym

Blackthorn 
A quick exit warp added to Clair’s Gym, in this commit has it: Finalized all Rematches · SoupPotato/sourcrystal@5d1fcc7 or mapcall back to have the bridge appear or don’t since you won’t rematch her here
Have the Gym guide disappear after beating the next Gym Leader in the list
Dratini will have extreme speed by default so only give one here to save space
Add a scene for Scarlet to tell you good luck when going to enter Blackhtorn gym tile the guy was on, have her exit the gym? Stop and talk?
In the gym second floor, near the guy that has the two boulders to move into the hole, the cooltrainer M, he should have no dragons in his team
Dragons den the first guy that ambushes the player should remove the line about the grotto in there
After event beat red, change block to go to Clair easier
Dragonflies/Yanma/Yanmega in the water in dragon’s den

Route 45
Add a route leader cooltrainer M/F to each route that allows battling once after defeating everyone in the area. Also, they give an item. Defeat everyone in Route 45 and 46 
Camper that talks about the battle tower text doesn’t open after the battle so fix that to save space. 



Route 46
The item ball next to the two people move it down a bit to see from early game..maybe make it something g else 




Route 27
Girl outside tohjo falls doesn’t tell the player that evolved pokemon learns moves later..



Route 26
Day of the week siblings, give a sacred ash of floor if met all, check crystal legacy for the code for this



Victory road
All rival battles get a winloss quote



Pokemon league
All rival battles get a winloss quote, this Final Pokémon league battle against him can be lost.
Make the Elite 4 all have the Kanto Gym Leader teams
Ensure you only fight Pokémon League rival post RED
Give Violet different item trade lists on different days 


Saffron city
A quick exit warp added to Sabrina's Gym, in this commit has it: Finalized all Rematches · SoupPotato/sourcrystal@5d1fcc7
Route6SaffronGate - remove Route6SaffronGateNoopScene - unusable
The kid outside that speaks of the trainer house should say he here they’re preparing something special there for the future
In siphco, change the dialogue after receiving Up Grade, to something like it’s used to trade a special pokemon
Saffron-Cerulean Gate block - Broken Gate: The actual gate mechanism is stuck, and the repair crew hasn’t arrived yet.

Route 8
Trainer about magnets, fix the typo to: “the power of magnets are awesome!”


Lavender City
Pokegear pokecentre doesnt fit

Fuschia City
Bills sister house is name wrong in pokegear and edit the boy’s dialuge here too
Add two more trees above in this area like the vanilla game
















Pewter City
Kanto birds. Same side quest but I’m a house and a scene as soon as the player enters it.
Remake mt moon? Add mushrooms to Mt.Moon. Also update my Big Mishroom’s sprite to his.

Birds check from Lunatic Crystal:
```
PewterCityGrampsScript:
    checkitem SILVER_WING
    iftrue .GotSilverWing
    faceplayer
    opentext
    writetext PewterCityGrampsText
    promptbutton
    special BirdsCheck
    iftrue .Lugia
    waitbutton
    closetext
    end

.Lugia
    showemote EMOTE_SHOCK, PEWTERCITY_GRAMPS, 20
    opentext
    writetext PewterCityGrampsGiveSilverWing
    promptbutton
    verbosegiveitem SILVER_WING
    setevent EVENT_GOT_SILVER_WING
    closetext
    end

.GotSilverWing:
    faceplayer
    opentext
    writetext PewterCityGrampsText_GotSilverWing
    waitbutton
    closetext
    end
```






```PewterCityGrampsText:
    text "Ah, you came all"
    line "the way out here"
    cont "from JOHTO?"

    para "That brings back"
    line "memories. When I"

    para "was young, I went"
    line "to JOHTO to train."

    para "I've always dreamt"
    line "of becoming a"
    
    para "trainer worthy of"
    line "the legendary"
    cont "bird trio:"
    
    para "ZAPDOS, ARTICUNO"
    line "and MOLTRES, but"
    
    para "I never came"
    line "even close…"
    
    para "They're said to"
    line "be led by the"
    
    para "guardian of the"
    line "seas: LUGIA."
    
    para "To face it, one"
    line "must prove"
    cont "themselves by"
    
    para "capturing the"
    line "bird trio first."
    
    para "I would be"
    line "happy to give a"
    
    para "special item to"
    line "an individual"
    
    para "who can"
    line "accomplish such"
    cont "a feat."
    done
    
PewterCityGrampsGiveSilverWing:
    text "…!"
    
    para "You… you've done"
    line "it!"
    
    para "You've captured"
    line "the bird trio!"
    
    para "I never thought"
    line "I'd run into"
    cont "such a trainer!"
    
    para "Here take this,"
    line "it's the"
    cont "SILVER WING."
    
    para "With this, you"
    line "will be able to"
    
    para "challenge LUGIA"
    line "in the"
    cont "WHIRL ISLANDS."
    done
```














Viridian City
Have the Viridian trainer house trainer also give no money on each battle and a crsytal for winning if possible
Viridian trainer house. A NPC tells you about Bluntmons and winning with them in any facility or lv 100 rematch would be super tough! Maybe other things like Nuzlocke, Trashlocke etc?

https://www.smogon.com/forums/threads/bluntmons-pokemon-without-stabs.3485502/

Another gym guide scene he tells you it’s been an honour to follow your journey and he challenges you to a battle and then wishes you the best! He disappears after unlocking Mt. Silver and appears in the pokemon league there after wishing you the best again..?
Fix sprites in the house with spearow and raticate
Pokegear pokecentre
Gym guide fights the player before Blue, check Crystal Ultimate






Pallet Town
Put Nayru in oaks lab. She gives the shiny charm after completing the dex. Have oaks rating tell you to talk to Nayru in his lab and there is a building in celadon you should visit. Give her Loreilie’s sprite Blue in ow palette
Have talking to oak play his music before and after the battle if it doesn’t already. His music is in Mr. Pokemon’s house
Oak’s lab Aides have the same dialogue to change
Green fat guy that talks about trading pokemon across time..edit text



Nurses and clerks make colour-coded based on the city's name

Cinnabar / seafoam islands
Edit sea foam islands to make it look closed up. Look at Gen1 map. Have someone in the water say that Lava fell on it..destroying it and sealed up the entrance. Articuno and all the Pokémon in it  fled and seeked shelter elsewhere
Check out cinnabar island in sour crystal island and maybe take some stuff from it or make up my own after taking a good look at it.
Change Blue’s ow icon to the colour blue. Depending on how it looks, maybe keep it?



Silver Cave
All rival battles get a winloss quote
The cabin here, add the correct sprite
in Elms post red phone call have him say that you can talk to him in his lab for a repeat of this call. Change his lab text accordingly.  
Have elm’s call says that all people who’s phone numbers you got will have their final level 100 teams now
Trainers who gift items to give 5x of the item, since it’s end game lv 100

Level Caps:
Check engine/battle/effect_commands at .obeylevel to adjust these for traded pokemon obedience levels
Start of Game: Lv 14
Beat Violet Gym: Lv 24
Beat Azalea Gym: Lv 32
Beat Goldenrod Gym: Lv 40
Beat Ecruteak Gym: Lv 48?
Mahogany : Lv  56
Beat Cianwood Gym: Lv 64
Beat Olivine Gym: Lv 64

Beat Blackthorn Gym: Lv 72
Beat Lance: Lv 80 - all Kanto Gym Leaders are lv 80
Beat blue: lv 100

All level caps gets an audible sfx like the trophies. All rematches get an event to check if it’s the first battle, all subsequent battles get a shorter text like “Let’s have a rematch <PLAY_G>!” Something that’s two lines long. 

Edit swarms, wild Pokémon, double check grottos, rock smash Pokémon,

Give all gym leaders, bosses, rivals, maxima, rematches loss quotes

Only two levels to the battle tower, lv50 and lv100. Level 100 unlocks after event_beat_red
Give the battle tower trainers a unique and new theme

Mom tells about running shoes. She understands what no means to explaining pokegear
Remove the mom walking frames, have the player walk towards her (test which saves space and keep that)

https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/7f852417a66d63a4b57642c096a5968576581ac9
https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/c365a4e4caf93e470ffc2d29263ee8a35fcf6466

https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/11e3907da61bc7a31ef91e8dc78577c8cd7335b0

Idain Commits to do:
Battle Tower fixes + Gender fixes + Growth changes in AI
Between-turn effects now consider speed when switching out Pokémon
https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/de37548c2e0a1df0fa14accda61f4001cacb37f3

https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/cc4a5118c9b926d366381e9977caaa8a24765042
https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/9853d2e0c6fb88d754a15e2f8c8d59abbb710aec
https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/e2e145451152d9d2e524e51a9169b888eaa118c5
https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/75d7b0578453680041723247b80c18199c2b2270
https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/b7ed184fc6884c9dcf0f6516190f8161b55fe634
https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/033287cfa452f39cd3f478b84560bb6423a9196e
https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/7c6f48b335c7d53e3d7aed540fd2f8c022c51ac5
https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/60e94fdb4f027db43697580aa047bebdcf916e6d
Check all his sprite and take some!!
if this wasn't already added: https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/4a88c684a2df77485f6ca900b24ee95f3beababe

===================================
Naming Screen redone:

https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/d38760b1f22c91ecf0bae8efb6e837581430688a

https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/02426a47c5389ea948a007f835dd25cfd8322c09

https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/bec26ae57bc75d14c6600c81568c42ad2e2f8746

https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/9faeac382dc1572017e804fcba19a4ad886eb383

https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/a3358c6d23b6aae1ec322ab7face8e31c9693425

https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/ef72025eabbeadf7be7094ec118004a1815fa04a
===================================

https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/c4e8104c1c67232946c9bad384e09f49295c1596

https://github.com/Idain/Another-PKMN-Crystal-Remaster/commit/831851d3495f5a6baa6fc93cd7938dbd2ac0fa75

Newbark Town 
Remove/replace green npc
Elm tells you about porygon pcs too
Increase delay frame when talking to signs/yes/no boxes to prevent taking steps after talking to text box 

When showing Elm Togepi, have him tell you the everstone both prevents evolution + raises the defense and special defense of pokemon that can evolve 

Continue Elm’s lab police scene without having to talk to ELa again 

Route 29
Guy says he’s waiting for a pokemon that appears only on evenings and night and that pokemon that appear on evenings appear day and night 

Take route 45-46 from Johto legends making it easier to pass after going to blackthorn. Have a cave in on Route 46 early game 

Sprout Tower old man teaches flash for a silver leaf upon defeat after giving lantern

Catch a single Unown to have the scientist appear to upgrade the pokedex 

Ilex forest cut man teleports you both to his house, gives a Hedger and teaches cut after for a silver leaf

Headbutt guy teaches headbutt for a Gold Leaf (not silver)

Golenrod
Have the bike shop owner tell you that encounter rate doubles when using it

Do something else for Dipolma printing and unown printing since they have been removed
Add entire music ost to radio?

Write special text for special stationary encounters in the pokedex

Stats and Ev Distribution:
<45 = 0 EVs 
45+ = 1 EV
90+ = 2 EVs
120+ = 3 EVs

So Mew would give 2 in HP/Atk/Def/SpA/SpD/Spe after each KO

But Snorlax would give:
3 HP/ 2Atk/ 1 Def/ 1 SpA/ 2 SpD / 0 Spe after each KO

Remove print support for the diploma and mail and all references to it. 
Edit fish/rod groups, surf routes and edit their levels. Have all johto encounters lower level so the trainers will be stronger and will require more effort to train up a newly caught pokemon
Colour code nurse and mart vendors to the town/city
Press b to go to the run option in wild battles
And item that calls a display of teh type chart..probably similar to the map
Remove mystery gift and print from game

Use stuff from here 
https://www.deviantart.com/frenchorange/art/Pokemon-Crystal-Trainer-Sprite-Edits-1109410918

Adjust rooftop sales : C:\cygwin64\home\My Computer\CT\data\items\rooftop_sale.asm and add all vitamins here

Take sour crystal link trade animation 
remove "add_special TrainerHouse"??? Ask grate oracle about it

Allow map tiles to appear above sprites (so NPCs can walk behind tiles) with PRIORITY colors · pret/pokecrystal Wiki (github.com) since this wastes like 0.20% romspace

Remove unused special from specialpointers.asm like what was done for the PhotoStudio code
There’s mobile code here.
Delete mobile data in the game to do more things after with that extra space

Maybe I can eventually add an event to a special egg for Togepi so Elm can only see it as the right one and none other? or maybe just give up on this..

NPC in challenge house. “These trainers are super strong, Im gonna try to win with pokemon that have zero EVs in every stats as a self impose challenge”

Add badge scaling marts, eventually no low tier items but those can always be gotten in Goldenrod’s mega mart


From ALL Idain's Prism "optimiz"

Add a challenge option that give zero statexp/EVs at the start of the game using a set flag to set parameters to zero and post lance resets the flag. So the player has zero EVs until post game. Pokemon league registration shows “Hardcore”. Actually main options menu also displays hardcore as well until lance has been beaten

Have a special check for shinys:
May have to use: call CheckShininess
then takes 99x crystals to switch its hidden power type to a random one. Ensure it stays the right gender 

Reminder - Added:
Overworld Sprites and trainer pics:
Giovanni
Proton
Petrel
Agatha
Lorelei
Maxima
Scarlet
Ariana
ArcherEusine

Trainer Picture:
Maxima

Key Item escape rope?