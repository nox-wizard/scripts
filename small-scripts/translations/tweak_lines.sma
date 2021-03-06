const NUM_itmevent = 16;
enum eventItm_prop
{
eventItmname: 24,
eventItmnum
};
public eventItm_array[NUM_itmevent][eventItm_prop] = {
{"on equip:              ", 02},
{"on unequip:            ", 03},
{"on check can use:      ", 09},
{"on click:              ", 04},
{"on double click:       ", 05},
{"on put in backpack:    ", 06},
{"on drop in land:       ", 07},
{"on take from container:", 17},
{"on trade to someone:   ", 10},
{"on thief has stolen it:", 11},
{"on try lockpicking:    ", 15},
{"on try to disarm trap: ", 14},
{"on poisoned:           ", 12},
{"on cause damage:       ", 01},
{"on decay:              ", 13},
{"on chr walks over it:  ", 16}
};

const NUM_itmtweak = 96;
enum Itm_tweaklines
{
it_linetype,
it_linename: 18,
it_propnumber,
it_infotype,
it_propval,
it_inputname: 10
};
//0: empty line for sorting lines at pages or use with text entry if helpful
//1: property field, eg itemname
//2: infofield, eg weight
//3: inputfield, eg Nightsight
//4: checkbox
//5: radiobutton
//6: subproperties (morex/morey/morez)
//7: stock function call: ct_propnumber is number of stock function, ct_infotype: string:1 and integer: 0
public itm_twkarray[NUM_itmtweak][Itm_tweaklines] = {
{2,"Ownerserial:     ", 225, 0, 0, "         "},
{2,"Serial:          ", 233, 0, 0, "         "},
{1,"Hex ID:          ", 404, 0, 0, "         "},
{1,"Itemtype:        ", 245, 0, 0, "         "},
{1,"Incognito:  ?    ",   0, 0, 0, "         "},
{1,"Attackpower:     ", 200, 0, 0, "         "},
{1,"Armorvalue:      ", 204, 0, 0, "         "},
{1,"Dex bonus:       ", 205, 0, 0, "         "},
{1,"Dex required:    ", 206, 0, 0, "         "},
{1,"Hitpoints:       ", 213, 0, 0, "         "},
{1,"Max. Hitpoints:  ", 219, 0, 0, "         "},
{1,"Min. Damage:     ", 217, 0, 0, "         "},
{1,"Max. Damage:     ", 212, 0, 0, "         "},
{1,"Int bonus:       ", 214, 0, 0, "         "},
{1,"Int required:    ", 215, 0, 0, "         "},
{1,"Str bonus:       ", 238, 0, 0, "         "},
{1,"Weight:          ", 248, 0, 0, "         "},
{1,"Color:           ", 403, 0, 0, "         "},
{2,"Scriptid:        ", 251, 0, 0, "         "},
{5,"Visible by:  all:", 120, 0, 2, "         "},
{5,"   owner & GM:   ", 120, 1, 0, "         "},
{5,"   only GM:      ", 120, 2, 0, "         "},
{5,"Movable default: ", 111, 0, 3, "         "},
{5,"   all:          ", 111, 1, 0, "         "},
{5,"   never:        ", 111, 2, 0, "         "},
{5,"   owner only:   ", 111, 3, 0, "         "},
{2,"Pile able:       ", 454, 0, 0, "         "},
{4,"Is Newbie-Item:  ", 118, 2, 0, "         "},
{6,"X Position:      ", 227, 0, 3, "         "},
{6,"Y Position:      ", 227, 1, 0, "         "},
{6,"Z Position:      ", 227, 2, 0, "         "},
{6,"More1:           ", 112, 1, 3, "         "},
{6,"More2:           ", 112, 2, 0, "         "},
{6,"More3:           ", 112, 3, 0, "         "},
{6,"More4:           ", 112, 4, 0, "         "},
{6,"MoreB 1:         ", 113, 1, 3, "         "},
{6,"MoreB 2:         ", 113, 2, 0, "         "},
{6,"MoreB 3:         ", 113, 3, 0, "         "},
{6,"MoreB 4:         ", 113, 4, 0, "         "},
{6,"MoreX:           ", 220, 0, 2, "         "},
{6,"MoreY:           ", 220, 1, 0, "         "},
{6,"MoreZ:           ", 220, 2, 0, "         "},
{1,"Good:          ? ", 211, 0, 0, "         "},
{1,"Money Value:     ", 247, 0, 0, "         "},
{2,"Random valuerate:", 231, 0, 0, "         "},
{1,"Rank:            ", 228, 0, 0, "         "},
{1,"Creator:         ", 450, 0, 0, "         "},
{4,"Can Decay:       ", 118, 1, 0, "         "},
{1,"Decay after msec:", 203, 0, 0, "         "},
{1,"Wipeable:        ", 249, 0, 0, "         "},
{1,"Can be dyed:     ", 105, 0, 0, "         "},
{2,"Is Corpse:       ", 102, 0, 0, "         "},
{1,"Is in Container: ", 202, 0, 0, "         "},
{2,"Is disabled:     ", 207, 0, 0, "         "},
{1,"Time unused:   ? ", 240, 0, 0, "         "},
{1,"How long unused? ", 241, 0, 0, "         "},
{1,"Gatenumber:   ?  ", 208, 0, 0, "         "},
{1,"Gatetime:     ?  ", 209, 0, 0, "         "},
{2,"Door-Dir:        ", 103, 0, 0, "         "},
{2,"Door is open:    ", 104, 0, 0, "         "},
{2,"Layer:           ", 110, 0, 0, "         "},
{1,"Damagetype:      ", 121, 0, 0, "         "},
{2,"Weapon Speed:    ", 237, 0, 0, "         "},
{1,"Magic dmg type:  ", 122, 0, 0, "         "},
{1,"Resists type:    ", 253, 0, 0, "         "},
{1,"Magic Dmg-power: ", 254, 0, 0, "         "},
{2,"Used Ammo type:  ", 255, 0, 0, "         "},
{1,"Used Ammo Fx:    ", 256, 0, 0, "         "},
{1,"Is poisoned:  ?  ", 217, 0, 0, "         "},
{1,"Multiserial:     ", 221, 0, 0, "         "},
{1,"Is secure chest: ", 232, 0, 0, "         "},
{1,"smelt:        ?  ", 234, 0, 0, "         "},
{6,"Item type2:    ? ", 246, 0, 0, "         "},
{2,"Animation ID:    ", 252, 0, 0, "         "},
{0,"Spawner Stuff    ",   0, 0,11, "         "},
{1,"Max at Spawner:  ", 400, 0, 0, "         "},
{1,"Now at Spawner:  ", 401, 0, 0, "         "},
{6,"Script to Spawn: ", 220, 0, 2, "         "},
{6,"Minimal time(min)", 220, 1, 0, "         "},
{6,"Maximum time(min)", 220, 2, 0, "         "},
{1,"Item=61 or NPC=62", 245, 0, 0, "         "},
{7,"Min. to Spawn:   ", 0, 113, 0, "         "},
{7,"Max. to Spawn:   ", 1, 113, 0, "         "},
{1,"Spawn Region:    ", 235, 0, 0, "         "},
{1,"Spawner serial:  ", 236, 0, 0, "         "},
{1,"Restockrate:  ?  ", 230, 0, 0, "         "},
{0,"Treasure Map:    ",   0, 0, 6, "         "},
{7,"Map X1:          ", 0, 112, 0, "         "},
{7,"Map Y1:          ", 1, 112, 0, "         "},
{7,"Map X2:          ", 0, 113, 0, "         "},
{7,"Map Y2:          ", 1, 113, 0, "         "},
{6,"Treasure X:      ", 220, 0, 1, "         "},
{6,"Treasure Y:      ", 220, 1, 0, "         "},
{1,"Direction:       ", 402, 0, 0, "         "},
{1,"Disabled-Message:", 452, 0, 0, "         "},
{1,"Corpse-Murderer: ", 453, 0, 0, "         "}
};

const NUM_lay = 24;
enum ct_layerlines
{
	lt_used,
	lt_name: 11
};
public ct_layerprop[NUM_lay][ct_layerlines] = {
{0,"Hand 1"},
{0,"Hand 2"},
{0,"Shoes"},
{0,"Pants"},
{0,"Shirt"},
{0,"Helm"},
{0,"Gloves"},
{0,"Ring"},
{0,"Light"},
{0,"Neck"},
{0,"Hair"},
{0,"Waist"},
{0,"Chest"},
{0,"bracelet"},
{0,"Unused"},
{0,"Beard"},
{0,"mid torso"},
{0,"Ears"},
{0,"Arms"},
{0,"Cloak"},
{0,"Backpack"},
{0,"Robe"},
{0,"Skirts"},
{0,"inner legs"}
};

const NUM_chrevent = 42;
enum eventChr_prop
{
eventname: 23,
eventnum
};
public eventChr_array[NUM_chrevent][eventChr_prop] = {
{"on start combat:      ", 33},
{"on try hit:           ", 34},
{"on begin attack:      ", 12},
{"on begin defense:     ", 13},
{"on hit:               ", 02},
{"on hit miss:          ", 03},
{"on get hit:           ", 04},
{"on wounded:           ", 01},
{"on death:             ", 00},
{"on died:              ", 37},
{"on kill:              ", 31},
{"on resurrect:         ", 07},
{"on skill advance:     ", 10},
{"on stat advance:      ", 11},
{"on get skillcap:      ", 22},
{"on get statcap:       ", 23},
{"on cast spell:        ", 21},
{"on dispel:            ", 06},
{"on break meditation:  ", 27},
{"on snooped:           ", 17},
{"on stolen:            ", 18},
{"on poisoned:          ", 19},
{"on change region:     ", 20},
{"on change reputation: ", 05},
{"on change flag:       ", 08},
{"on walk:              ", 09},
{"on block:             ", 24},
{"on check npcai        ", 36},
{"on mount:             ", 29},
{"on dismount:          ", 30},
{"on transfer:          ", 14},
{"on hear player:       ", 32},
{"on speech             ", 35},
{"on multi enter:       ", 15},
{"on multi leave:       ", 16},
{"on start:             ", 25},
{"on heart beat:        ", 26},
{"on click:             ", 28},
{"on dblclick:          ", 41},
{"on open chat:         ", 38},
{"on open status:       ", 39},
{"on open skills:       ", 40}
};

const NUM_chrtweak = 208;
enum Chr_tweaklines
{
ct_linetype,
ct_linename: 19,
ct_propnumber,
ct_infotype,
ct_propval,
ct_inputname: 10
};
//0: empty line for sorting lines at pages or use with text entry if helpful
//1: property field, eg itemname
//2: infofield (for example weight): ct_propnumber is property num to get info or if 0 custom info function (then ct_infotype defines the number for custom function), ct_propval: string:1 and integer: 0
//3: inputfield, eg Nightsight, ct_propnumber = 1 for TFX-Effects, ct_propnumber = 2 for LocalVars Int, ct_propnumber = 3 for LocalVars Str
//4: checkbox: ct_propnumber is property num to change or -1 if custom function (then ct_infotype defines the number for custom function)
//5: radiobutton: ct_propnumber is property num to get info, ct_infotype is TRUE-value, ct_propval for grouping at page: how many MORE props in group?
//6: subproperties (morex/morey/morez), ct_propnumber is property num to get info, ct_infotype subproperty num, ct_propval for grouping at page: how many MORE props in group?
//7: stock function call: ct_propnumber is number of stock function, ct_infotype: string:1 and integer: 0
public chr_twkarray[NUM_chrtweak][Chr_tweaklines] = {
{1, "Char name:        ", 453, 0, 0, "         "},
{1, "Char title:       ", 455, 0, 0, "         "},
{1, "Karma:            ", 237, 0, 0, "         "},
{1, "Fame:             ", 218, 0, 0, "         "},
{6, "Strength:         ", 295, 2, 0, "         "},
{6, "Hits(from Str):   ", 295, 3, 0, "         "},
{6, "Reg-Rate HP:      ", 269, 0, 0, "         "},
{6, "Dexterity:        ", 216, 2, 0, "         "},
{6, "Stamina(from Dex):", 216, 3, 0, "         "},
{6, "Reg-Rate Stam:    ", 269, 2, 0, "         "},
{6, "Intelligence:     ", 236, 2, 0, "         "},
{6, "Mana (from Int):  ", 236, 3, 0, "         "},
{6, "Reg-Rate Mana:    ", 269, 1, 0, "         "},
{2, "Weight:           ", 312, 0, 0, "         "},
{2, "Is overweighted:  ",  15, 0, 0, "         "},
{7, "Skill sum:        ",   0, 0, 0, "         "},
{7, "Bank gold:        ",   0, 1, 0, "         "},
{4, "Open Bank box:    ",   0, 1, 0, "         "},
{4, "Open Gold bank:   ",   0, 2, 0, "         "},
{0, "Optical stuff     ",   0, 0, 0, "         "},
{1, "Body color:       ", 404, 0, 0, "         "},
{1, "Body old color:   ", 406, 0, 0, "         "},
{1, "Body hexID:       ", 403, 0, 0, "         "},
{1, "Body old hexID:   ", 405, 0, 0, "         "},
{7, "Beard color:      ", 205, 6, 0, "         "},
{2, "Beard serial:     ", 205, 0, 0, "         "},
{7, "Beard style:      ", 205, 7, 0, "         "},
{7, "Hair color:       ", 229, 8, 0, "         "},
{2, "Hair serial:      ", 229, 0, 0, "         "},
{7, "Hair style:       ", 229, 9, 0, "         "},
{2, "Is in region:     ", 123, 0, 0, "         "},
{2, "idle since:       ", 210, 0, 0, "         "},
{2, "will logout in:   ", 241, 0, 0, "         "},
{2, "ScriptID:         ", 272, 0, 0, "         "},
{2, "Command level:    ", 103, 0, 0, "         "},
{2, "Skill used:       ", 242, 0, 0, "         "},
{3, "Hunger:           ",  2,1002,0, "         "},
{3, "Thirst:           ",  2,1003,0, "         "},
{6, "X Position:       ", 262, 0, 2, "         "},
{6, "Y Position:       ", 262, 1, 0, "         "},
{6, "Z Position:       ", 262, 2, 0, "         "},
{6, "X Old Position:   ", 254, 0, 2, "         "},
{6, "Y Old Position:   ", 254, 1, 0, "         "},
{6, "Z Old Position:   ", 254, 2, 0, "         "},
{7, "Char created at:  ",   4, 0, 0, "         "},
{2, "Creation day prop:", 212, 0, 0, "         "},
{2, "Is muted:         ", 292, 0, 0, "         "},
{2, "Mute ends in:     ", 248, 0, 0, "         "},
{4, "Invulnerable:     ", 134, 4, 0, "         "},
{4, "Freeze priv:      ", 121, 2, 0, "         "},
{5, "Invis by skill:   ", 110, 1, 3, "         "},
{5, "Invis by spell:   ", 110, 2, 0, "         "},
{5, "permanent Invis:  ", 121, 8, 0, "         "},
{5, "Visible:          ", 110, 0, 0, "         "},
{1, "GM port effect:   ", 224, 0, 0, "         "},
{1, "Face direction:   ", 104, 0, 0, "         "},
{3, "Nightsight:       ",   1, 2, 0, "millisec "},
{4, "Polymorph:        ",  -1, 4, 0, "         "},
{2, "Incognito tfx:    ",   0, 2, 0, "         "},
{4, "Incognito prop:   ",   6, 0, 0, "         "},
{4, "See House as Icon:", 121, 4, 0, "         "},
{2, "Owns house no.:   ", 245, 0, 0, "         "},
{1, "Steps to fly:     ", 108, 0, 0, "         "},
{3, "Hallucination:    ",   1,20, 0, "millisec "},
{2, "Criminal:         ", 213, 0, 0, "         "},
{4, "Can move all:     ", 121, 1, 0, "         "},
{4, "Can Broadcast:    ", 134, 2, 0, "         "},
{4, "Can dispel:       ", 121,20, 0, "         "},
{2, "Is jailed:        ",   5, 0, 0, "         "},
{4, "Needs no mana:    ", 121,10, 0, "         "},
{4, "Needs no reagents:", 121,80, 0, "         "},
{4, "Can see serials:  ", 134, 8, 0, "         "},
{4, "No skill title:   ", 134,10, 0, "         "},
{4, "Can snoop all:    ", 134,40, 0, "         "},
{1, "Is disabled:      ", 217, 0, 0, "         "},
{1, "Object use delay: ", 253, 0, 0, "         "},
{1, "Skill use delay:  ", 277, 0, 0, "         "},
{1, "Smokes after:     ", 279, 0, 0, "         "},
{1, "Smoking time:     ", 280, 0, 0, "         "},
{1, "Msgboard posttype:", 263, 0, 0, "         "},
{0, "Guild Stuff       ",   0, 0, 8, "         "},
{2, "Guild serial:     ", 273, 0, 0, "         "},
{2, "Guild number:     ", 226, 0, 0, "         "},
{7, "Guild name:       ",   1, 2, 0, "         "},
{7, "Guild leader:     ",   1, 3, 0, "         "},
{4, "Go to Guild:      ",   0, 3, 0, "         "},
{2, "Is Guild traitor: ",   4, 0, 0, "         "},
{4, "Show Guildname:   ",  14, 0, 0, "         "},
{2, "Guild fealthy:    ", 225, 0, 0, "         "},
{0, "Fight Stuff       ",   0, 0, 0, "         "},
{2, "Delay for spells: ", 250, 0, 0, "         "},
{2, "Spell attack delay", 281, 0, 0, "         "},
{2, "Spell attack time:", 282, 0, 0, "         "},
{2, "Spell attack type:", 283, 0, 0, "         "},
{2, "Spell using:      ", 286, 0, 0, "         "},
{2, "Spell action:     ", 287, 0, 0, "         "},
{2, "Spell time:       ", 288, 0, 0, "         "},
{1, "Re-attack in:     ", 250, 0, 0, "         "},
{2, "Hit message:      ", 210, 1, 0, "         "},
{2, "Swing will hit:   ", 297, 0, 0, "         "},
{2, "Aims at:          ", 300, 0, 0, "         "},
{7, "Kill/Dead:        ",   1, 5, 0, "         "},
{2, "Murderer was:     ", 246, 0, 0, "         "},
{2, "Death number:     ", 214, 0, 0, "         "},
{1, "Kills number:     ", 239, 0, 0, "         "},
{1, "Kill number stays:", 247, 0, 0, "         "},
{2, "Attack power:     ", 202, 0, 0, "         "},
{2, "Defense value:    ", 215, 0, 0, "         "},
{6, "Resist pure:      ", 132, 0, 0, "         "},
{6, "Resist slash:     ", 132, 1, 0, "         "},
{6, "Resist pierce:    ", 132, 2, 0, "         "},
{6, "Resist bludgeon:  ", 132, 3, 0, "         "},
{6, "Resist backstab:  ", 132, 4, 0, "         "},
{6, "Resist fire:      ", 132, 5, 0, "         "},
{6, "Resist electrical:", 132, 6, 0, "         "},
{6, "Resist mental:    ", 132, 7, 0, "         "},
{6, "Resist poison:    ", 132, 8, 0, "         "},
{6, "Resist cold:      ", 132, 9, 0, "         "},
{6, "Resist force:     ", 132,10, 0, "         "},
{6, "Resist holy:      ", 132,11, 0, "         "},
{6, "Resist magic:     ", 132,12, 0, "         "},
{2, "Is Attacker:      ",  12, 0, 0, "         "},
{2, "Attacker is:      ", 203, 0, 0, "         "},
{4, "Warmode:          ", 128, 0, 0, "         "},
{2, "Reactive Armor:   ",   0, 1, 0, "         "},
{1, "Is poisoned:      ", 258, 0, 0, "         "},
{1, "Poison text:      ", 260, 0, 0, "         "},
{1, "Poison wearoff:   ", 261, 0, 0, "         "},
{1, "Poison dmg delay: ", 259, 0, 0, "         "},
{4, "Magic reflect:    ", 121,40, 0, "         "},
{2, "Has shield:       ",   0, 3, 0, "         "},
{0, "NPC Stuff         ",   0, 0, 0, "         "},
{2, "Is NPC:           ", 114, 0, 0, "         "},
{1, "Wandermode:       ", 116, 0, 0, "         "},
{2, "old wandermode:   ", 117, 0, 0, "         "},
{1, "Flee at HP of:    ", 219, 0, 0, "         "},
{0, "Wander mode 'free'",   0, 0, 0, "         "},
{6, "X Foodposition:   ", 220, 0, 2, "         "},
{6, "Y Foodposition:   ", 220, 1, 0, "         "},
{6, "Z Foodposition:   ", 220, 2, 0, "         "},
{6, "X Work Position:  ", 262, 0, 2, "         "},
{6, "Y Work Position:  ", 262, 1, 0, "         "},
{6, "Z Work Position:  ", 262, 2, 0, "         "},
{6, "X Home Position:  ", 233, 0, 2, "         "},
{6, "Y Home Position:  ", 233, 1, 0, "         "},
{6, "Z Home Position:  ", 233, 2, 0, "         "},
{0, "Wander mode 'box' ",   0, 0, 0, "         "},
{6, "X1 Box:           ", 221, 0, 2, "         "},
{6, "Y1 Box:           ", 221, 1, 0, "         "},
{6, "Z1 Box:           ", 221, 2, 0, "         "},
{6, "X2 Box:           ", 222, 0, 2, "         "},
{6, "Y2 Box:           ", 222, 1, 0, "         "},
{6, "Z2 Box:           ", 222, 2, 0, "         "},
{2, "Move time:        ", 252, 0, 0, "         "},
{1, "Follow char No.:  ", 223, 0, 0, "         "},
{1, "Summontimer left: ", 296, 0, 0, "         "},
{1, "Speech type:      ", 127, 0, 0, "         "},
{1, "Taming needed:    ", 299, 0, 0, "         "},
{1, "Is owned by:      ", 255, 0, 0, "         "},
{2, "Spawnerserial:    ", 285, 0, 0, "         "},
{2, "Spawned in region:", 284, 0, 0, "         "},
{2, "Stablemaster is:  ", 293, 0, 0, "         "},
{2, "Is on horse:      ",   7, 0, 0, "         "},
{2, "Is ridden:        ",  16, 0, 0, "         "},
{4, "Is Vendor:        ",  11, 0, 0, "         "},
{4, "Can train:        ",   0, 0, 0, "         "},
{1, "trains in:        ", 133, 0, 0, "         "},
{1, "NPC Poison attack:", 257, 0, 0, "         "},
{6, "Damage pure:      ", 135, 0, 0, "         "},
{6, "Damage slash:     ", 135, 1, 0, "         "},
{6, "Damage pierce:    ", 135, 2, 0, "         "},
{6, "Damage bludgeon:  ", 135, 3, 0, "         "},
{6, "Damage backstab:  ", 135, 4, 0, "         "},
{6, "Damage fire:      ", 135, 5, 0, "         "},
{6, "Damage electrical:", 135, 6, 0, "         "},
{6, "Damage mental:    ", 135, 7, 0, "         "},
{6, "Damage poison:    ", 135, 8, 0, "         "},
{6, "Damage cold:      ", 135, 9, 0, "         "},
{6, "Damage force:     ", 135,10, 0, "         "},
{6, "Damage holy:      ", 135,11, 0, "         "},
{6, "Damage magic:     ", 135,12, 0, "         "},
{1, "Max. damage:      ", 231, 0, 0, "         "},
{1, "Min. damage:      ", 240, 0, 0, "         "},
{1, "Split chance:     ", 291, 0, 0, "         "},
{1, "Split into:       ", 290, 0, 0, "         "},
{2, "Gold Vendor has:  ", 232, 0, 0, "         "},
{0, "unclear           ",   0, 0, 0, "         "},
{2, "Is dead:          ",   1, 0, 0, "         "},
{2, "Is guarded:       ",   3, 0, 0, "         "},
{2, "Is trained:       ",  13, 0, 0, "         "},
{2, "Is blocked:       ", 101, 0, 0, "         "},
{2, "Dir 2:            ", 105, 0, 0, "         "},
{2, "Fixed light:      ", 106, 0, 0, "         "},
{2, "reputation:       ", 107, 0, 0, "         "},
{2, "gm restriction:   ", 109, 0, 0, "         "},
{2, "nxw flags:        ", 131, 0, 0, "         "},
{2, "advancement gate: ", 201, 0, 0, "         "},
{2, "Is casting:       ", 209, 0, 0, "         "},
{2, "Skill used now:   ", 242, 0, 0, "         "},
{2, "Is meditating:    ", 243, 0, 0, "         "},
{2, "Keynumber:        ", 238, 0, 0, "         "},
{2, "Name deed is:     ", 249, 0, 0, "         "},
{2, "Backpack is:      ", 256, 0, 0, "         "},
{2, "Bounty post:      ", 266, 0, 0, "         "},
{2, "Bounty reward:    ", 267, 0, 0, "         "},
{2, "Bounty target rgn:", 268, 0, 0, "         "},
{2, "Bounty source rgn:", 269, 0, 0, "         "},
{2, "carve (internal): ", 208, 0, 0, "         "}
};