// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (small_speech.sma)                               ||
// || Maintained by Horian                                                ||
// || Last Update 13/6/04                                                 ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file should include every ingame speech/message as array line! ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

/*customizable ingame messages*/
const NUM_nxwlibSENT = 8;
public msg_nxwlibDef[NUM_nxwlibSENT][]={
"Select first rectangle corner",
"Invalid map location!",
"Select second rectangle corner",
"You can't reach that! Go closer!",
"That's far beyond you possibilities",
"It's too heavy for you, get stronger!",
"You moved that.",
"You easily moved that."
};

const NUM_housemenuSENT = 16;
public msg_housemenuDef[NUM_housemenuSENT][]={
"Only house owner are allowed to use the house menu",
"Whom you want to become co-owner?",
"You already have %d coowner.",
"Whom you want to become friend?",
"You already have %d friends.",
"Whom you want to ban?",
"You already have %d banned people at your list.",
"Whom you want to bounce out of the house?",
"Whom do you want to make new Owner?",
"Only player can be co-owner!",
"Only player can be friends!",
"Only player can be banned!",
"You have been bounced out of the house.",
"You are no longer Owner of this house.",
"You own now this house",
"Because you are at the Ban-list."
};

const NUM_sk_anatomySENT = 40;
public msg_sk_anatomyDef[NUM_sk_anatomySENT][]={
"Whom shall I examine?",
"Target invalid",
"You cannot analize yourself!",
"You need to be closer to find out more about them",
"You are not certain..",
"superhumanly strong",
"rather feeble",
"somewhat weak",
"to be of normal strength",
"somewhat strong",
"very strong",
"extremely strong",
"extraordinarily strong",
"as strong as an ox",
"like one of the strongest people you have ever seen",
"of unknown strenght",
"superhumanly agile",
"very clumsy",
"somewhat uncoordinated",
"moderately dexterous",
"somewhat agile",
"very agile",
"extremely agile",
"extraordinarily agile",
"like they move like quicksilver",
"like one of the fastest people you have ever seen",
"of unknown dexterity",
"That person looks %s and %s.",
"He/She is completely tired [%d%%]",
"He/She is extremely tired [%d%%]",
"He/She is very much tired [%d%%]",
"He/She is very tired [%d%%]",
"He/She is tired [%d%%]",
"He/She is slightly tired [%d%%]",
"He/She is not tired [%d%%]",
"He/She is slightly fresh [%d%%]",
"He/She is almost fresh [%d%%]",
"He/She is fresh [%d%%]",
"He/She is fully fresh [%d%%]",
"He/She is at %d%% stamina"
};

const NUM_sk_mainSENT = 3;
public msg_sk_mainDef[NUM_sk_mainSENT][]={
"You must wait a few moments before using another skill.",
"You cannot do that as a ghost.",
"This skill is not yet implemented, use the standard skills menu"
};

const NUM_sk_alchSENT = 20;
public msg_sk_alchDef[NUM_sk_alchSENT][]={
"bloodmoss    ",
"garlic       ",
"sulfurous_ash",
"ginseng      ",
"spiders_silk ",
"nightshade   ",
"black_pearl  ",
"mandrake_root",
"It must be inside your backpack",
"Unknown Potion Category, please report this!",
"These potions need %s as reagent.",
"Notices: ",
"Amount:",
"unknown button %d in alchemy gump, please tell a gm",
"You have too few empty bottles!",
"Your alchemic experiment fails and you destroy some reagents and bottles.",
"*%s starts grinding some %s in the mortar.*",
"Your skill is not high enough",
"You have not enough reagents",
"Your skill is too low and you have not enough reagents"
};

const NUM_sk_miscSENT = 4;
public msg_sk_miscDef[NUM_sk_miscSENT][]={
"What cloth should I use these scissors on?",
"You cut some cloth into bandages, and put it in your backpack",
"You cannot cut anything from that item.",
"An error occurred while creating additional skills, please contact a GM"
};

const NUM_sk_cookSENT = 6;
public msg_sk_cookDef[NUM_sk_cookSENT][]={
"It must be in your backpack.",
"What do you want to use this on?",
"You can use this only at items!",
"You need 4 sheeves of wheat for this.",
"This can't be combined.",
"You are not skilled enough to make this."
};

const NUM_sk_dhiddenSENT = 8;
public msg_sk_dhiddenDef[NUM_sk_dhiddenSENT][]={
"Where do you want to search for someone?",
"That is too far away to search there, if you want to search there go closer.",
"You have been revealed",
"You revealed %s.",
"You fail to find anyone.",
"There is someone nearby who prevents you to hide.",
"You slip inconspicuous into the shadows.",
"Your attempt to hide is not succesfull."
};

const NUM_sk_evalintSENT = 30;
public msg_sk_evalintDef[NUM_sk_evalintSENT][]={
"Whom shall I examine?",
"Target invalid",
"You cannot analize yourself!",
"You need to be closer to find out more about them",
"You are not certain..",
"superhumanly intelligent in a manner you cannot comprehend",
"slightly less intelligent than a rock.",
"fairly stupid",
"not the brightest",
"about average",
"moderately intelligent",
"very intelligent",
"extraordinarily intelligent",
"like a formidable intellect, well beyond the ordinary",
"like a definite genius",
"superhumanly intelligent in a manner you cannot comprehend",
"of unknown intelligence",
"That person looks %s.",
"He/She is completely tired [%d%%]",
"He/She is extremely tired [%d%%]",
"He/She is very much tired [%d%%]",
"He/She is very tired [%d%%]",
"He/She is tired [%d%%]",
"He/She is slightly tired [%d%%]",
"He/She is not tired [%d%%]",
"He/She is slightly fresh [%d%%]",
"He/She is almost fresh [%d%%]",
"He/She is fresh [%d%%]",
"He/She is fully fresh [%d%%]",
"He/She is at %d%% mana"
};

const NUM_sk_fishSENT = 15;
public msg_sk_fishDef[NUM_sk_fishSENT][]={
"You have to equip it!",
"Where do you want to fish?",
"Invalid target",
"This is too far!",
"You can't fish here!",
"You didn't catch any fish...",
"You caught a ... water elemental!",
"You caught a fish!",
"Hah, the old boots...",
"Hmm, good painting...",
"It could be tasty....",
"Yhm...",
"You are now the owner of a strong, good chest!",
"Hmm, a strange magic item!",
"Unknown."
};

const NUM_sk_inscripSENT = 11;
public msg_sk_inscripDef[NUM_sk_inscripSENT][]={
"Select scroll...",
"What are you trying to do?",
"That's not a scroll %d",
"It must be in your backpack",
"You dont have blank scroll in your backpack.",
"You success to copy that spell",
"You failed to copy that spell",
"You destroyed the orginal scroll !",
"You suffered serious magic damage !",
"Select spell",
"Empty"
};

const NUM_carpSENTENCE = 102;
public msg_carpenterDef[NUM_carpSENTENCE][]={
"You need a saw inside your backpack!", //0
"Which boards do you want to use?", //1
"You need at least one pack nails.", //2
"The boards need to be in your backpack.", //3
"You are not skilled enough to use this boards.", //4
"You have to choose boards to use.", //5
"     carpenter menu", //6
"normal tables 1", //7
"normal tables 2", //8
"normal tables 3", //9
"other furniture", //10
"benchs",
"chairs",
"small beds",
"big beds",
"last crafted", //15
"     normal tables 1 Menu!",
"Counter 1",
"Counter 2",
"Table A 1",
"Table A 2", //20
"Table B 1",
"Table B 2",
"Table B 3",
"Table B 4",
"Table B 5",
"Table E ",
"     normal tables 2 Menue!",
"Table C 1",
"Table C 2",
"Table D 1", //30
"Table D 2",
"Table D 3",
"Table D 4",
"Table D 5",
"Table E",
"Table F",
"Table G 1",
"Table G 2",
"     normal table 3 menu!",
"Table H 1", //40
"Table H 2",
"Table H 3",
"Table I",
"Table J",
"Table K",
"Table L",
"Table M 1",
"Table M 2", //48
"     other furniture menu!",
"Writing desk", //50
"Chest of drawers",
"Fancy chest of drawers",
"Dresser 1",
"Dresser 2",
"Armoire",
"Fancy armoire",
"filled bookcase 1",
"filled bookcase 2",
"filled bookcase 3",
"empty bookcase", //60
"     benches menu!",
"Bench A1",
"Bench A2",
"Bench A3",
"Bench B1",
"Bench B2",
"Bench B3",
"Bench C1",
"Bench C2",
"Bench D", //70
"     chairs menu!",
"Stool A",
"Stool B",
"Throne",
"Chair 1",
"Chair 2",
"Fancy chair 1",
"Fancy chair 2",
"Straw chair",
"     small beds menu!", //80
"Bed headboard A1",
"Bed headboard A2",
"Bed headboard A3",
"Bed headboard A4",
"Bed feet A1",
"Bed feet A2",
"Bed feet A3",
"     big beds menu!",
"Bed head left A1",
"Bed feet left A1",//90
"Bed feet right A1",
"Bed head right A1",
"Bed head left A2",
"Bed feet left A2",
"Bed feet right A2",
"Bed head right A2",
"Bed feet A5",
"     big beds menu!",
"You have no idea how to make this.",
"You don't have enough boards.",
"wood of unknown color %d!"
};

const NUM_sk_lumbSENT = 19;
public msg_sk_lumbDef[NUM_sk_lumbSENT][]={
"pine    ",
"yew     ",
"maple   ",
"alder   ",
"walnut  ",
"cedar   ",
"oak     ",
"beech   ",
"mahogany",
"ebony   ",
"%s wood",
"You lumber some %s and put it in your pack.",
"You are too unexperienced to work with this kind of wood.",
"Your hand slips and you destroy the left over wood.",
"Your hand slips and a part of your wood is destroied.",
"%s board",
"You create boards out of the wood.^nCarefully you put the %s in your pack.",
"pine    ",
"There is no more wood left to chop.",
};

const NUM_sk_meditSENT = 8;
public msg_sk_meditDef[NUM_sk_meditSENT][]={
"You are in war mode!",
"You are casting spell!",
"You are carring too much!",
"Your hands must be free!",
"You are already meditating!",
"*Meditating*",
"You lost your concentration",
"*Stops meditating*"
};

/*Here all ingame messages used in blacksmith menu, order of sentences is essential!*/
const NUM_smithSENTENCE = 89;
public msg_blacksmithDef[NUM_smithSENTENCE][]={
"You are to far away from forge.", 
"Choose the item you want to repair or the ingots you want to use", 
"You have no tong or smithy hammer to blacksmith.",
"The ingots need to be inside your backpack!",
"You are not skilled enough to use this metall.",
"You need to select ingots or an item a blacksmith can create!",
"     Blacksmith Menu",
"ringmail",
"chainmail",
"platemail",
"helms",
"shields",
"swords/blades",
"maces/Haemmer",
"spears",
"aces",
"pole arms",
"repeat last item",
"     ringmail menu!",
"gloves",
"sleeves",
"leggings",
"tunic",
"     chainmail menu!",
"coif",
"     platemail menu!",
"gorget",
"plate helm",
"female plate",
"     helms menu!",
"bascinet",
"close helm",
"helmet",
"nose helm",
"     shield menu!",
"buckler",
"metal shield",
"round shield",
"Drachenschild",
"metal kite shield",
"heater",
"     sword and blades menu!",
"dagger",
"cutlass",
"kryss",
"katana",
"scimitar",
"broad sword",
"long sword",
"viking sword",
"mace",
"maul",
"war mace",
"war hammer",
"hammer pick",
"     spears and forks menu!",
"short spear",
"war fork",
"spear",
"     axes menu!",
"double axe",
"battle axe",
"large battle axe",
"axe",
"two handed axe",
"executioners axe",
"war axe",
"     Pole Arms menu!",
"bardiche",
"halberd",
"You have no idea how to make this.",
"You have to few ingots.",
"mady by",
"ERROR! PUBLIC ITEM_CREATION: outside parameter(0..9)",
"exceptional",
"You create the item with exceptional quality.",
"You create the item.",
"ERROR! PUBLIC ITEM_CREATION:outside of parameter(90..100)",
"You create the item with a quality below average.",
"ERROR! PUBLIC ITEM_CREATION: outside of parameter(0-100)",
"You are not skilled enough to repair something.",
"It must be inside your backpack.",
"This can not be repaired.",
"This is already in best shape.",
"You have too few ingots of this metall to repair it.",
"Your try to repair fails and now the item is even in worse shape.",
"Your try to repair fails and the item has been weakened.",
"     mace menu!",
"You repair the item."
};

const NUM_sk_miningSENT = 18;
public msg_sk_miningDef[NUM_sk_miningSENT][]={
"iron    ",
"shadow  ",
"Merkit  ",
"Kupfer  ",
"silver  ",
"Bronze  ",
"Gold    ",
"Agapit  ",
"Verit   ",
"Mythril ",
"%s ore",
"You find some %s and put it into your backpack.",
"You are too unexperienced to smelt this ore.",
"Your hand slips and you pour some of the left over ore into the blaze.",
"Your hand slips and you pour some of your ore into the blaze.",
"%s ingots",
"You smelt the ore.",
"Carefully you place the %s in your backpack."
};

const NUM_sk_tailorSENT = 1;
public msg_sk_tailorDef[NUM_sk_tailorSENT][]={
"You are not skilled enough for this kind of material."
};

const NUM_sk_tameSENT = 26;
public msg_sk_tameDef[NUM_sk_tameSENT][]={
"You are now doing something else!",
"You want to tame yourself?",
"You can't tame hidden creatures!",
"Hmm maybe just ask, if he want to sarve you...",
"This animal is already tamed",
"You are to far away!",
"Only honurable people can tame this creature!",
"Only women can tame Unicorns!",
"Only man can tame Ki-Rin!",
"Only evil people can tame the Nightmare!",
"There is something between you and the target",
"You can't tame that!",
"You are not able to tame this creature",
"You are too far away!",
"There is something between you and the animal",
"What a pretty animal!",
"*Smiles to the creature*",
"Come to daddy...",
"Come to mammy...",
"I won't hurt you",
"Will you become my new friend?",
"%s is at your commands!",
"You enraged this creature!",
"You failed to tame this creature.",
"You are taming another creature now!",
"Select a creature you want to tame."
};

const NUM_sk_tasteSENT = 5;
public msg_sk_tasteDef[NUM_sk_tasteSENT][]={
"What do you want to taste?",
"You can't taste that!",
"This item is poisoned!",
"This item shows no poison",
"You do not understand if this item is poisoned or not"
};

public typeQuestion[3][] = {
	"Which animal do you wish to track?",
	"Which creature do you wish to track?",
	"Whom do you wish to track?"
};

public where[8][] = {
"North",
"Northeast",
"East",
"Southeast",
"South",
"Southwest",
"West",
"Northwest"
};

const NUM_sk_trackSENT = 11;
public msg_sk_trackDef[NUM_sk_trackSENT][]={
"Animals",
"Creatures",
"Players",
"You cannot see any signs",
"%s to the %s",
"a man to the %s",
"a woman to the %s",
"a creature to the %s",
"You see no signs of any animals.",
"You see no signs of any creatures.",
"You see no signs of anyone."
};

const NUM_api_partySENT = 22;
public msg_api_partyDef[NUM_api_partySENT][]={
"You have invited them to join the party.",
"%s : You are invited to join the party. Type /accept to join or /decline to decline the offer.",
"You may only add members to the party if you are the leader.",
"You may only have 10 in your party (this includes candidates).",
"Who would you like to add to your party?",
"You may only add living things to your party!",
"You cannot add yourself to a party.",
"Nay, I would rather stay here and watch a nail rust.",
"You may only add members to the party if you are the leader.",
"You may only have 10 in your party (this includes candidates).",
"The creature ignores your offer.",
"This person is already in your party!",
"This person is already in a party!",
"Select the one to remove to the party..",
"You're not in a party!",
"You may only remove yourself from a party if you are not the leader.",
"You have chosen to allow your party to loot your corpse.",
"You have chosen to prevent your party from looting your corpse.",
"%s  : joined the party.",
"You have been added to the party.",
"%s  : Does not wish to join the party.",
"You notify them that you do not wish to join the party."
};

const NUM_commandsSENT = 261;
public msg_commandsDef[NUM_commandsSENT][]={
"No other players connected",
"Users Online : ",
"there are less than n players online",
"you must specify a character serial",
"you must specify a valid character serial",
"%s is not online",
"Invalid map location",
"Select object.. ",
"Options work only on object",
"Options on item",
"Name : ",//10
"Serial : %d",
"Account : %d",
"Stats",
"Tweak",
"Move character here",
"Go to Character",
"Release",
"Jail",
"Frozen",
"There are no pageable GMs or counselors online",//20
"Online pageable staff is:",
"Select the character you want to see the pages",
"You must target a player",
"test page 1",
"%s is solving %s's page",
"%s is solved %s's page number %d",
"Select the character you want to solve a page",
"You must target a player",
"You must give the skill and value as integers",
"skill and value must be positive",//30
"Select character.. ",
"You must target a character",
"Invalid skill value '%d'",
"Skills work only on character" ,
"Strength :",
"Dexterity :",
"Intelligence :",
"About whom/what do you want info ?",
"Select a char or item, please",
"Tweak Menue", //40
"Main infos",
"Flags1",
"Flags2",
"Flags3",
"LocalVars",
"Events",
"Flags4",
"Skills",
"Layer",
"Owner :",//50
"Serial:",
"Itemtype:",
"LocalVars 1",
"None:",
"Str:",
"Int:",
"Add LocalVar:",
"(No.)",
"(Value)",
"next page (%d)",//60
"page 1",
"previous page (%d)",
"LocalVars %d",
"Int %d",
"Str %d %s",
"Account number :",
"NPC-AI:",
"Events 2",
"Events 3",
"Events 1",//70
"Miscellaneous",
"Combat Ratings",
"Actions",
"Lore & Knowledge",
"Nothing",
"A number must be inserted!",
"The localVar number must consist of 0-9, no letters or other signs!",
"This localVar already exists!", //78, checked
"Action must be an integer",
"Select a character that will perform the action", //80
"You must specify the alignment direction: x y z",
"Alignment direction MUST be x y or z",
"Select reference item or character",
"An error occurred!",
"Select the object to be moved",
"You must select an item or a character",
"Object moved to %d %d %d",
"Command area cleared",
"No more command areas available",
"Standard area set", //90
"First parameter must be the area radius",
"Radius must be a positive number",
"You must specify all parameters",
"The include mode can only be: itm chr all",
"You must specify all parameters",
"Number of commands must be a number or 'unlimited'",
"Target the area center",
"area set",
"You must specify the property to set",
"%s set to %d characters", //100
"Select a character to set the %s",
"property set to %d",
"You must target an item",
"You must specify the direction: n ne e se s sw w nw",
"invalid direction, choose between: n ne e se s sw w nw",
"Maybe you wanted to type'speech','split' or 'splitchance'?",
"Maybe you wanted to type 'trigger' or 'trainer'?",
"Invalid property, allowed properties are: ai dir owner spattack spadelay speech train trigger",
"Integer value required",
"property set", //110
"Invalid property, allowed properties are: food home work",
"You must specify the amount of damage to do",
"You must specify the stat to be damaged: hp stam or mana",
"%d characters damaged",
"Select a character to damage",
"You have to specify the decay time, or 'off'",
"%d items had decay set",
"Select an item to set decay",
"Item will decay at %dms",
"%d items copied", //120
"Select an item to duplicate",
"It must be an item",
"Item must not be in a container",
"That item can't be duplicated",
"Sorry, the dye menu hasn't been done yet",
"Color code must be an hexadecimal (preceded by 0x) or integer number",
"%d items dyed",
"Select an item to dye",
"Item dyed",
"Select an item to flip", //130
"You must specify on or off",
"You must specify 'on' 'off' or 'target' as first parameter",
"%d characters frozen",
"%d characters unfrozen",
"Select a character to freeze",
"character frozen",
"charcater unfrozen",
"%d characters set to full stats",
"Select a character to raise stats",
"stats raised", //140
"Select a character to open his backpack",
"That character does not have a backpack",
"There are less than %d players online",
"you must specify a character serial",
"you must specify a valid character serial",
"%s is not online",
"%d characters set to heal",
"Select a character to heal",
"healed",
"You must specify at least the first parameter (on,off,toggle), other params are optional", //150
"You must specify 'on','off' or 'toggle' as first parameter",
"unhidden",
"hidden",
"%d characters %s",
"Select a character to toggle hiding status",
"Select a character to unhide",
"Select a character to hide",
"%d characters invulnerabilized",
"%d characters vulnerabilized",
"%s set to %d characters", //160
"Select an item to set the %s",
"maybe you want to type 'value'or 'visible'",
"Invalid property, allowed properties are: amount dir movable type value visible wipe",
"Select a character to jail",
"%d characters killed",
"Select a character to kill",
"Select a character to kill his beard",
"Select a character to kill his hair",
"you must specify 0-15 or -1",
"You must specify 'gm','gmpageable', 'cns' or 'player'", //170
"Choose a player to make GM",
"Choose a player to make counselor",
"Choose a GM or couselor to make player",
"Choose a player to make pageable GM",
"Privlevel of character set to %d",
"Select a location where to go",
"Select an object to move to you",
"Select an object to move to a location",
"Select an item to move",
"x and y must be numbers", //180
"x and y must be positive numbers in abs mode",
"%d objects moved",
"Select an object to move",
"You must select an object",
"Select the destination",
"That character does not have a valid backpack",
"You must target a location or an object!",
"Select an npc",
"You must target a removable object",
"Wander limits set to: %d %d %d %d", //190
"Whom do you want to polymorph/unmorph?",
"Select a char/npc,please",
"Polymorph Menu",
"custom name:",
"(name)",
"custom color:",
"(decimal)",
"keep stats:",
"Message from %s",
"The command works but there's no way to swtich back possession at present, so it's better not to use it", //200
"Select a character to possess",
"You understand how %s says: %s",
" %s says something in an unknown language.",
"Guarded",
"Can recall",
"Can mark",
"sun",
"Weather:  ",
"rain",
"snow", //210
"Can gate",
"No magic damage",
"Invalid weather %s",
"Region properties updated",
"%d characters resended",
"Select a character to resend",
"%d characters resurrected",
"Select a character to resurrect",
"charcater resurrectd",
"%d objects (chars and items) turned into direction", //220
"Select an item or object to set the direction",
"You must target an item or character",
"You have to specify 1 value for moreb12!",
"%d items had moreb12 set",
"Select an item to set moreb12",
"New moreb12:%d",
"You have to specify 1 value for moreb34!",
"%d items had moreb34 set",
"Select an item to set moreb34",
"New moreb34:%d", //230
"You have to specify 3 values for morex morey morez",
"morex morey morez must be integer numbers",
"%d items had morex morey morez set",
"Select an item to set morex morey morez",
"New morex: %d morey:%d morez:%d",
"You must enter the privlevel to set",
"privlevel must be number between 0(guest) and 255 (admin)",
"Privlevel set to %d characters ",
"Select a character",
"Privlevel set to %d", //240
"Your privlevel has been modified,now it's %d",
"You have to specify the type as an integer number",
"%d items had type set",
"Select an item to set type",
"type set",
"Select a character to open his bankbox",
"Invalid bankbox item, may be an error",
"%d characters set to full stamina",
"Select a character to raise stamina",
"stats raised", //250
"If you want to pass parameters you must pass at least nX and nY",
"x y z and z-scale must be integer numbers",
"Select an item to tile",
"Select a character to unjail",
"You are in %s region, at %d %d %d",
"Select an object to wipe",
"You must target a removable object",
"Object removed",
"Items removed",
"%d objects removed", //260
"Property value is currently %d"
};