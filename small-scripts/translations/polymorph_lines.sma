/*
decbody = decimal value of InsideUO-Anim,
hexbody = hex value of InsideUO-Anim,
hextile = hex value of anim tile pic (InsideUO artworks),
animname = name char when polymorphed should have 
To extend poly menu, simply edit or add your anims into the array, count the lines of array = new NUM_anims value
script does the rest
*/
const NUM_anims = 99;

enum animprop
{ 
scriptname: 27,
hextile,
animname: 23
};

public animProperty[NUM_anims][animprop] = {
{"$npc_an_alligator         ", 0x20da, "alligator"},
{"$npc_a_black_bear         ", 0x20cf, "black bear"},
{"$npc_a_grizzly_bear       ", 0x20db, "grizzly bear"},
{"$npc_a_polar_bear         ", 0x20e1, "polar bear"},
{"$npc_forest_bird          ", 0x211a, "bird"},
{"$npc_summoned_blade_spirit", 0x37ab, "blade spirit"},
{"$npc_a_boar               ", 0x2101, "boar"},
{"$npc_a_bullfrog           ", 0x2130, "bullfrog"},
{"$npc_a_bull               ", 0x20ef, "bull"},
{"$npc_a_bull_1             ", 0x20f0, "bull"},
{"$npc_a_cat                ", 0x211b, "cat"},
{"$npc_a_chicken            ", 0x20d1, "chicken"},
{"$npc_a_corpser            ", 0x20d2, "corpser"},
{"$npc_a_cow                ", 0x2103, "black cow"},
{"$npc_a_cow_1              ", 0x2103, "brown cow"},
{"$npc_a_cyclopedian_warrior", 0x212d, "cyclops with hammer"},
{"$npc_a_titan              ", 0x212e, "cyclops"},
{"$npc_deamon_unarmed       ", 0x20d3, "deamon"},
{"$npc_a_daemon             ", 0x20d3, "deamon with sword"},
{"$npc_a_dog                ", 0x211c, "dog"},
{"$npc_a_dolphin            ", 0x20f1, "dolphin"},
{"$npc_a_dragon             ", 0x20d6, "grey dragon"},
{"$npc_a_dragon_2           ", 0x20d6, "red dragon"},
{"$npc_a_drake              ", 0x20d6, "red drake"},
{"$npc_a_drake_1            ", 0x20d6, "grey drake"},
{"$npc_an_eagle             ", 0x211d, "eagle"},
{"$npc_an_air_elemental     ", 0x20ed, "air elemental"},
{"$npc_an_earth_elemental   ", 0x20d7, "earth elemental"},
{"$npc_a_fire_elemental     ", 0x20f3, "fire elemental"},
{"$npc_a_fire_elemental     ", 0x210b, "water elemental"},
{"$npc_an_ettin             ", 0x20d8, "ettin"},
{"$npc_an_ettin_1           ", 0x20d8, "ettin with mace"},
{"$npc_redlady              ", 0x20ce, "female"},
{"$npc_a_gargoyle           ", 0x20d9, "gargoyle"},
{"$npc_a_gazer              ", 0x20f4, "gazer"},
{"$npc_a_ghost              ", 0x1f03, "ghost"},
{"$npc_a_goat               ", 0x2108, "goat"},
{"$npc_a_gorilla            ", 0x20f5, "gorilla"},
{"$npc_a_harpy              ", 0x20dc, "harpie"},
{"$npc_a_great_hart         ", 0x20d4, "hart"},
{"$npc_a_headless           ", 0x210a, "headless"},
{"$npc_a_hind               ", 0x20d4, "hind"},
{"$npc_a_horse              ", 0x2124, "horse"},
{"$npc_a_horse_1            ", 0x211f, "horse"},
{"$npc_a_horse_2            ", 0x2120, "horse"},
{"$npc_a_horse_3            ", 0x2121, "horse"},
{"$npc_a_pack_horse         ", 0x2126, "pack horse"},
{"$npc_an_imp               ", 0x20f9, "imp"},
{"$npc_a_lava_lizard        ", 0x2131, "lava lizard"},
{"$npc_a_lich               ", 0x20f8, "lich"},
{"$npc_lizardman_fencer     ", 0x20de, "lizardman with spear"},
{"$npc_lizardman_macefighter", 0x20de, "lizardman with mace"},
{"$npc_lizardman            ", 0x20de, "lizardman"},
{"$npc_a_rideable_llama     ", 0x20f6, "llama"},
{"$npc_a_pack_llama         ", 0x2127, "pack llama"},
{"$npc_fancy_nobleman       ", 0x20cd, "male"},
{"$npc_an_ogre              ", 0x20df, "ogre"},
{"$npc_a_slime              ", 0x20e8, "ooze"},
{"$npc_an_ophidian_warrior  ", 0x0056, 0x2133, "ophidian warrior"},
{"$npc_an_ophidian_shaman   ", 0x2132, "ophidian mage"},
{"$npc_an_ophidian_matriarch", 0x2134, "ophidian queen"},
{"$npc_orc                  ", 0x20e0, "orc"},
{"$npc_orc_mace             ", 0x20e0, "orc with mace"},
{"$npc_orc_2_hand_axe       ", 0x20e0, "orc with axe"},
{"$npc_a_forest_ostard      ", 0x2137, "forrest ostard"},
{"$npc_a_frenzied_ostard    ", 0x2136, "frenzied ostard"},
{"$npc_a_desert_ostard      ", 0x2135, "desert ostard"},
{"$npc_a_panther            ", 0x2102, "panther"},
{"$npc_a_pig                ", 0x2101, "pig"},
{"$npc_a_rabbit             ", 0x2125, "rabbit"},
{"$npc_a_sewer_rat          ", 0x2123, "sewer rat"},
{"$npc_a_giant_rat          ", 0x20d0, "giant rat"},
{"$npc_ratman               ", 0x20e3, "ratman with sword"},
{"$npc_ratman_axe           ", 0x20e3, "ratman with axe"},
{"$npc_ratman_archer        ", 0x20e3, "ratman"},
{"$npc_a_reaper             ", 0x20fa, "reaper"},
{"$npc_a_giant_scorpion     ", 0x20e4, "giant scorpion"},
{"$npc_a_giant_serpent      ", 0x20fc, "giant serpent"},
{"$npc_a_sea_serpent        ", 0x20fb, "sea serpent"},
{"$npc_a_ghoul              ", 0x2109, "ghoul"},
{"$npc_sheered_sheep        ", 0x20e6, "sheered sheep"},
{"$npc_a_sheep              ", 0x20eb, "unsheered sheep"},
{"$npc_a_skeleton           ", 0x20e7, "skeleton"},
{"$npc_a_skeleton_1         ", 0x20e7, "skeleton with axe"},
{"$npc_a_bone_knight        ", 0x20e7, "skeleton with scimitar"},
{"$npc_a_snake              ", 0x20fe, "snake"},
{"$npc_a_giant_spider       ", 0x20fd, "giant spider"},
{"$npc_a_terathan_drone     ", 0x212b, "terathan drone"},
{"$npc_a_terathan_warrior   ", 0x212a, "terathan warrior"},
{"$npc_a_terathan_matriarch ", 0x212c, "terathan matriarch"},
{"$npc_a_giant_toad         ", 0x212f, "giant toad"},
{"$npc_a_troll              ", 0x20e9, "troll with axe"},
{"$npc_a_troll_1            ", 0x20e9, "troll"},
{"$npc_a_troll_2            ", 0x20e9, "troll with maul"},
{"$npc_a_kraken             ", 0x20e8, "unknown sea creature"},
{"$npc_a_zombie             ", 0x20ec, "zombie"},
{"$npc_a_walrus             ", 0x20ff, "walrus"},
{"$npc_a_wisp               ", 0x2100, "wisp"},
{"$npc_a_timber_wolf        ", 0x2122, "wolf"}
};