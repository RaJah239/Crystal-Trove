After kanto's removal: 1027 event slots free

Level caps/Obedience cap:
New game: Lv9
Violet: lv 16
Azalea: 21
Goldenrod: 26
Ecruteak: 31
Mahogany: 36
Cianwood: 37
Olivine: 42
Blackthorn: 50 (max level)

Remove Viridian Gym's tiles



=====================================================================================================================================
Done but needs testing:

- Added Removed the "family relations" check to allow any two Pokémon that can breed, will breed.
- Need to complete Uown dex, it works as it should atm.
- Expanded tilesets from 192 to 255 tiles. (verify this completely is right)
- Check if removing the newly added fly points will will fix the Kanto Map “KANTO” text issue

Working:
- Evs are doubled when pokerus is active
- Gen3+ EVs replace Stat Exp. However max out all stats at 252. Basically, getting the same results as stat exp but also saving space.
- Zinc added to Goldenrod and Celadon Marts.
- max out EVs on a pokemon and verified the seer thinks it's maxed?
- POKéRUS confirmed doubling EVs gained after battle
- Split Mon battle menu stat: par slp tox psn etc to not cover the player or enemy levels 
=====================================================================================================================================

optimise vanilla daily flags for lapras, bug catching contest, mt moon clefairy etc.

Cianwood daily photographer added.
Cianwood Photo Studio Sign's text edited.
squash both?

Removed presently unused PhotoStudio code.

Removed unused trainer constants + respective parties.

Deleted more unreferenced code and unused data.

Trainers only call for battles or gift items now.

remove vanilla tree system
Add SourApple's fruit trees

Caught Level Fix

Bugfix: Level Caught Design Flaw Fix by Vulcandth and Rangi - taken from Ferropexola's Johto Lengends:
verify if this works

Expanded Daily Flags 1.
Used 1 daily flag for all Route 29's trees. (Need to do all remaining trees)
Replace old fruit trees system

Double check bugfixes and design flaws

update to latest pret

Battle Tower Win streak record/counter like pokemoncentre battle record 

Type chart (similar to the diploma code)

Made the Lottery Corner generate a lucky number daily instead of weekly.
stress test the crap outta this to ensure it works, maybe add 4th and 5th prize

https://github.com/pret/pokecrystal/wiki/Allow-map-tiles-to-appear-above-sprites-(so-NPCs-can-walk-behind-tiles)-with-PRIORITY-colors

last incase not adding it..
https://github.com/pret/pokecrystal/wiki/Battle-Autoprompts
https://github.com/pret/pokecrystal/wiki/Make-new-battle-text-to-distinguish-status-move-misses-and-fails
