/*!
\defgroup script_commands_add_lists items and NPCs lists
\ingroup script_commands_add

@{
*/

enum additemEntry
{
	__ID,
	__def: 40,
	__name: 30,

};

#define NUM_MAGICALITEMS 4
new __magicalItems[NUM_MAGICALITEMS][additemEntry] =
{
	{0x1F14,"$item_a_recall_rune                    ","Recall rune"}, 
	{0x0EFA,"$item_a_spellbook                      ","Spellbook"}, 
	{0x0E34,"$item_blank_scrolls                    ","Blank scrolls"}, 
	{0x1F6D,"$item_all-spell_scroll                 ","all-spell scroll"} 
}                                                       

                                                        
#define NUM_REAGENTS 8                                  
new __reagents[NUM_REAGENTS][additemEntry] =            
{                                                       
	{0x0F7A,"$item_black_pearl                      ","Black Pearl"},
	{0x0F7B,"$item_bloodmoss                        ","Blood Moss"},
	{0x0F84,"$item_garlic                           ","Garlic"},
	{0x0F85,"$item_ginseng                          ","Ginseng"},
	{0x0F86,"$item_mandrake_root                    ","Mandrake Root"},
	{0x0F88,"$item_nightshade                       ","Nightshade"},
	{0x0F8C,"$item_sulfurous_ash                    ","Sulfurous Ash"},
	{0x0F8D,"$item_spiders_silk                     ","Spiders Silk"}
}                                                       
                                                        
                                                        
                                                        
#define NUM_REAGENTS2 18                                
new __reagents2[NUM_REAGENTS2][additemEntry] =          
{                                                       
	{0x0F78,"$item_batwing                          ","Bat Wing"},
	{0x0F79,"$item_blackmoor                        ","Blackmoor"},
	{0x0F7C,"$item_bloodspawn                       ","Bloodspawn"},
	{0x0F7D,"$item_vial_of_blood                    ","Vial of Blood"},
	{0x0F7E,"$item_bone                             ","Bone"},
	{0x0F7F,"$item_brimstone                        ","Brimstone"},
	{0x0F80,"$item_daemon_bone                      ","Daemon Bone"},
	{0x0F81,"$item_fertile_dirt                     ","Fertile Dirt"},
	{0x0F82,"$item_dragon_blood                     ","Dragon Blood"},
	{0x0F83,"$item_executioners_cap                 ","Executioner's Cap"},
	{0x0F87,"$item_eye_of_newt                      ","Eye of Newt"},
	{0x0F89,"$item_obsidian                         ","Obsidian"},
	{0x0F8A,"$item_pig_iron                         ","Pig Iron"},
	{0x0F8B,"$item_pumice                           ","Pumice"},
	{0x0F8E,"$item_serpents_scale                   ","Serpent Scales"},
	{0x0F8F,"$item_volcanic_ash                     ","Volcanic Ash"},
	{0x0F90,"$item_dead_wood                        ","Dead Wood"},
	{0x0F91,"$item_wyrms_heart                      ","Worms Heart"}
}                                                       
                                                        
                                                        
                                                        
                                                        
#define NUM_BOTTLES 12                                  
new __bottles[NUM_BOTTLES][additemEntry] =              
{                                                       
	{0x0F0E,"$item_bottle_A                         ","Bottle"},
	{0x0E24,"$item_empty_vials                      ","Empty vial"},
	{0x0E25,"$item_bottle                           ","Bottle"},
	{0x0E26,"$item_bottle_1                         ","Bottle"},
	{0x0E27,"$item_bottle_2                         ","Bottle"},
	{0x0E28,"$item_bottle_3                         ","Bottle"},
	{0x0E29,"$item_bottle_4                         ","Bottle"},
	{0x0E2A,"$item_bottle_5                         ","Bottle"},
	{0x0E2B,"$item_bottle_6                         ","Bottle"},
	{0x0E2C,"$item_bottle_7                         ","Bottle"},
	{0x0EFB,"$item_bottle_8                         ","Bottle"},
	{0x0EFC,"$item_bottle_9                         ","Bottle"}
}                                                       
                                                        
#define NUM_POTIONS 12                                  
new __potions[NUM_POTIONS][additemEntry] =              
{                                                       
	{0x0E9B,"$item_mortar_and_pestal                ","Mortar And Pestal"},
	{0x0F06,"$item_night_sight_potion               ","Night Sight Potion"},
	{0x0F07,"$item_cure_potion                      ","Cure_Potion"},
	{0x0F08,"$item_agility_potion                   ","Agility Potion"},
	{0x0F09,"$item_strength_potion                  ","Strength Potion"},
	{0x0F0A,"$item_poison_potion                    ","Poison Potion"},
	{0x0F0B,"$item_energy_potion                    ","Resurrection Potion"},
	{0x0F0C,"$item_lesser_heal_potion               ","Lesser Heal Potion"},
	{0x0F0C,"$item_greater_heal_potion              ","Greater Heal Potion"},
	{0x0F0D,"$item_lesser_explosion_potion          ","Lesser Explosion Potion"},
	{0x0F0D,"$item_explosion_potion                 ","Explosion Potion"},
	{0x0F0D,"$item_greater_explosion_potion         ","Greater Explosion Potion"}
}

#define NUM_WANDS 9
new __wands[NUM_WANDS][additemEntry] =
{
	{0x0DF2,"$item_a_wand_of_greater_heal           ","Greater Heal Wand"},
	{0x0DF3,"$item_a_wand_of_summon_daemon          ","Summon Daemon Wand"},
	{0x0DF4,"$item_a_wand_of_healing                ","Magic Arrow Wand"},
	{0x0DF5,"$item_a_wand_of_resurrection           ","Resurrect Wand"},
	{0x0F5C,"$item_fire_mace                        ","Fireball Mace"},
	{0x0F5C,"$item_a_wand_of_greater_healing        ","greater healing wand"},
	{0x0F5C,"$item_a_wand_of_energy_vortex          ","energy vortex wand"},
	{0x0F5C,"$item_a_wand_of_magic_arrow            ","magic arrow wand"},
	{0x0F5C,"$item_a_wand_of_ressurection           ","ressurection wand"}
}

#define NUM_GATES 3
new __gates[NUM_GATES][additemEntry] =
{
	{0x0F6C,"$item_a_blue_moongate                  ","A Blue Moongate"},
	{0x0DDA,"$item_a_red_moongate                   ","A Red Moongate"},
	{0x1FD4,"$item_a_black_moongate                 ","A Black Moongate"}
}

#define MAX_SCROLLS 64
#define SCROLLS_PER_CIRCLE 8
new __scrolls[ MAX_SCROLLS][additemEntry] =
{
	//1st circle
	{0x1F35,"$item_a_reactive_armor_scroll          ","Agility Scroll"},
	{0x1F36,"$item_a_clumsy_scroll                  ","Cunning Scroll"},
	{0x1F37,"$item_a_create_food_scroll             ","Cure Scroll"},
	{0x1F38,"$item_a_feeblemind_scroll              ","Harm Scroll"},
	{0x1F39,"$item_a_heal_scroll                    ","Magic TraP_Scroll"},
	{0x1F3A,"$item_magic_arrow_scroll               ","Magic UntraP_Scroll"},
	{0x1F3B,"$item_a_night_sight_scroll             ","Protection Scroll"},
	{0x1F3C,"$item_a_weaken_scroll                  ","Strength Scroll"},

	//2nd circle
	{0x1F2D,"$item_a_agility_scroll                 ","Reactive Armor Scroll"},
	{0x1F2E,"$item_a_cunning_scroll                 ","Clumsy Scroll"},
	{0x1F2F,"$item_a_cure_scroll                    ","Create Food Scroll"},
	{0x1F30,"$item_a_harm_scroll                    ","Feeblemind Scroll"},
	{0x1F31,"$item_magic_trap_scroll                ","Heal Scroll"},
	{0x1F32,"$item_magic_untrap_scroll              ","Magic Arrow Scroll"},
	{0x1F33,"$item_a_protection_scroll              ","Night Sight Scroll"},
	{0x1F34,"$item_a_strength_scroll                ","Weaken Scroll"},

	//3rd circle
	{0x1F3D,"$item_a_bless_scroll                   ","Bless Scroll"},
	{0x1F3E,"$item_a_fireball_scroll                ","Fireball Scroll"},
	{0x1F3F,"$item_magic_lock_scroll                ","Magic Lock Scroll"},
	{0x1F40,"$item_a_poison_scroll                  ","Poison Scroll"},
	{0x1F41,"$item_a_telekinesis_scroll             ","Telekinesis Scroll"},
	{0x1F42,"$item_a_teleport_scroll                ","Teleport Scroll"},
	{0x1F43,"$item_an_unlock_scroll                 ","Unlock Scroll"},
	{0x1F44,"$item_a_wall_of_stone_scroll           ","Wall of Stone Scroll"},

	//4th circle
	{0x1F45,"$item_an_archcure_scroll               ","Archcure Scroll"},
	{0x1F46,"$item_an_arch_protection_scroll        ","Arch Protection Scroll"},
	{0x1F47,"$item_a_curse_scroll                   ","Curse Scroll"},
	{0x1F48,"$item_a_fire_field_scroll              ","Fire Field Scroll"},
	{0x1F49,"$item_a_greater_heal_scroll            ","Greater Heal Scroll"},
	{0x1F4A,"$item_a_lightning_scroll               ","Lightning Scroll"},
	{0x1F4B,"$item_a_mana_drain_scroll              ","ManaDrain Scroll"},
	{0x1F4C,"$item_a_recall_scroll                  ","Recall Scroll"},

	//5th circle
	{0x1F4D,"$item_a_blade_spirits_scroll           ","Blade Spirits Scroll"},
	{0x1F4E,"$item_a_dispel_field_scroll            ","Dispel Field Scroll"},
	{0x1F4F,"$item_an_incognito_scroll              ","Incognito Scroll"},
	{0x1F50,"$item_magic_reflection_scroll          ","Magic Reflection Scroll"},
	{0x1F51,"$item_a_mind_blast_scroll              ","Mind Blast Scroll"},
	{0x1F52,"$item_a_paralyze_scroll                ","Paralyze Scroll"},
	{0x1F53,"$item_a_poison_field_scroll            ","Poison Field Scroll"},
	{0x1F54,"$item_a_summon_creature_scroll         ","Summon Creature Scroll"},

	//6th circle
	{0x1F55,"$item_a_dispel_scroll                  ","Dispel Scroll"},
	{0x1F56,"$item_an_energy_bolt_scroll            ","Energy Bolt Scroll"},
	{0x1F57,"$item_an_explosion_scroll              ","Explosion Scroll"},
	{0x1F58,"$item_an_invisibility_scroll           ","Invisibility Scroll"},
	{0x1F59,"$item_a_mark_scroll                    ","Mark Scroll"},
	{0x1F5A,"$item_a_mass_curse_scroll              ","Mass Curse Scroll"},
	{0x1F5B,"$item_a_paralyze_field_scroll          ","Paralyze Field Scroll"},
	{0x1F5C,"$item_a_reveal_scroll                  ","Reveal Scroll"},
	        
	//7th circle
	{0x1F5D,"$item_a_chain_lightning_scroll         ","Chain Lightning Scroll"},
	{0x1F5E,"$item_an_energy_field_scroll           ","Energy Field Scroll"},
	{0x1F5F,"$item_a_flamestrike_scroll             ","Flamestrike Scroll"},
	{0x1F60,"$item_a_gate_travel_scroll             ","Gate Travel Scroll"},
	{0x1F61,"$item_a_mana_vampire_scroll            ","Mana Vampire Scroll"},
	{0x1F62,"$item_a_mass_dispel_scroll             ","Mass Dispel Scroll"},
	{0x1F63,"$item_a_meteor_swarm_scroll            ","Meteor Storm Scroll"},
	{0x1F64,"$item_a_polymorph_scroll               ","Polymorph Scroll"},

	//8th circle
	{0x1F65,"$item_a_earthquake_scroll              ","Earthquake Scroll"},
	{0x1F66,"$item_a_energy_vortex_scroll           ","Energy Vortex Scroll"},
	{0x1F67,"$item_a_resurrection_scroll            ","Resurrection Scroll"},
	{0x1F68,"$item_a_summon_air_elemental_scroll    ","Summon Air Elemental Scroll"},
	{0x1F69,"$item_a_summon_daemon_scroll           ","Summon Daemon Scroll"},
	{0x1F6A,"$item_a_summon_earth_elemental_scroll  ","Summon Earth Elemental Scroll"},
	{0x1F6B,"$item_a_summon_fire_elemental_scroll   ","Summon Fire Elemental Scroll"},
	{0x1F6C,"$item_a_summon_water_elemental_scroll  ","Summon Water Elemental Scroll"}
}

//the XSS def name string is not necessary as it is generated automatically
#define NUM_ARMORS 8
#define ARMOR_PARTS 7
new __armor[NUM_ARMORS*ARMOR_PARTS][additemEntry] =
{
	//platemail
	{0x1412,"                                       ","helm"},
	{0x1413,"                                       ","gorget"},
	{0x1416,"                                       ","chest"},
	{0x1410,"                                       ","sleeves"},
	{0x1414,"                                       ","gloves"},
	{0x141A,"                                       ","legs"},
	{0x1C04,"                                       ","female"},

	//chainmail
	{0x13BB, "                                       ","coif"},
	{INVALID,"                                       ","gorget"},
	{0x13C4, "                                       ","tunic"},
	{INVALID,"                                       ","sleeves"},
	{INVALID,"                                       ","gloves"},
	{0x13C3, "                                       ","legs"},
	{INVALID,"                                       ","female"},

	//ringmail
	{INVALID,"                                       ","coif"},
	{INVALID,"                                       ","gorget"},
	{0x13ED, "                                       ","tunic"},
	{0x13EF, "                                       ","sleeves"},
	{0x13F2, "                                       ","gloves"},
	{0x13F1, "                                       ","legs"},
	{INVALID,"                                       ","female"},

	//studded
	{INVALID,"                                       ","cap"},
	{0x13D6, "                                       ","gorget"},
	{0x13E2, "                                       ","tunic"},
	{0x13D4, "                                       ","sleeves"},
	{0x13DD, "                                       ","gloves"},
	{0x13E1, "                                       ","legs"},
	{0x1C02, "                                       ","female"},

	//leather
	{0x1DBA, "                                       ","cap"},
	{INVALID,"                                       ","gorget"},
	{0x13D3, "                                       ","tunic"},
	{0x13CD, "                                       ","sleeves"},
	{0x13CE, "                                       ","gloves"},
	{0x13D2, "                                       ","legs"},
	{0x1C06, "                                       ","female"},

	//bone
	{0x1451, "                                       ","helm"},
	{INVALID,"                                       ","gorget"},
	{0x144F, "                                       ","chest"},
	{0x144E, "                                       ","sleeves"},
	{0x1450, "                                       ","gloves"},
	{0x1452, "                                       ","legs"},
	{INVALID,"                                       ","female"},

	//helms
	{0x1412, "                                       ","plate_helm"},
	{0x140C, "                                       ","bascinet"},
	{0x1408, "                                       ","close_helm"},
	{0x140A, "                                       ","helmet"},
	{0x140E, "                                       ","nose_helm"},
	{INVALID,"                                       ","legs"},
	{INVALID,"                                       ","female"},

	//Shields
	{0x1B73, "                                       ","buckler"},
	{0x1B7B, "                                       ","metal_shield"},
	{0x1B72, "                                       ","bronze_shield"},
	{0x1B78, "                                       ","wooden_kite_shield"},
	{0x1B74, "                                       ","metal_kite_shield"},
	{0x1B76, "                                       ","heater"},
	{INVALID,"                                       ","female"}
}

#define NUM_WEAPONS 4
#define WEAPONS_PER_GROUP 8
new __weapons[NUM_WEAPONS*WEAPONS_PER_GROUP][additemEntry] =
{
	//Axes
	{0x0F4B, "                                       ","double_axe"},
	{0x0F47, "                                       ","battle_axe"},
	{0x13FB, "                                       ","large_battle_axe"},
	{0x0F49, "                                       ","axe"},
	{0x1442, "                                       ","two-handed_axe"},
	{0x0F45, "                                       ","executioners_axe"},
	{0x13B0, "                                       ","war-axe"},
	{INVALID,"                                       ",""},

	//swords/blades
	{0x0F51,"                                       ","dagger"},
	{0x1440,"                                       ","cutlass"},
	{0x1400,"                                       ","kryss"},
	{0x13FF,"                                       ","katana"},
	{0x13B6,"                                       ","scimitar"},
	{0x0F5E,"                                       ","broadsword"},
	{0x13B8,"                                       ","long_sword"},
	{0x13BA,"                                       ","viking_sword"},

	//maces
	{0x0F5C,"                                       ","mace"},
	{0x143A,"                                       ","maul"},
	{0x1406,"                                       ","war_mace"},
	{0x1438,"                                       ","war_hammer"},
	{0x143C,"                                       ","hammer_pick"},
	{INVALID,"                                       ","legs"},
	{INVALID,"                                       ","legs"},
	{INVALID,"                                       ","legs"},

	//spears/forks/pole arms/bows
	{0x0F62,"                                       ","short_spear"},
	{0x1405,"                                       ","war_fork"},
	{0x0F62,"                                       ","spear"},
	{0x0F42,"                                       ","bardiche"},
	{0x143E,"                                       ","halberd"},
	{0x13B2,"                                       ","bow"},
	{0x0F50,"                                       ","crossbow"},
	{0x13FD,"                                       ","heavy_crossbow"}
}

//^([0-9,A-F][0-9,A-F][0-9,A-F][0-9,A-F]^) ^([a-z,A-Z, ,0-9,(,)]+^)^p^tNPC ^(^$[a-z,A-Z,0-9,_,]+^)
//{0x^1,"^3","^2"},

#define NUM_ANIMALS 26
new __animals[NUM_ANIMALS][additemEntry] =
{
	{0x2120,"$npc_a_horse                           ","Horse 1"},
	{0x211F,"$npc_a_horse_1                         ","Horse 2"},
	{0x2124,"$npc_a_horse_2                         ","Horse 3"},
	{0x2121,"$npc_a_horse_3                         ","Horse 4"},
	{0x20DB,"$npc_a_grizzly_bear                    ","a grizzly bear"},
	{0x20F5,"$npc_a_gorilla                         ","a gorilla"},
	{0x20CF,"$npc_a_black_bear                      ","a brown bear"},
	{0x20D1,"$npc_a_chicken                         ","a chicken"},
	{0x20D4,"$npc_a_great_hart                      ","a deer"},
	{0x20D5,"$npc_a_dog                             ","a dog"},
	{0x20DA,"$npc_an_alligator                      ","an alligator"},
	{0x20E1,"$npc_a_polar_bear                      ","a polar bear"},
	{0x20E1,"$npc_a_vera_bear                       ","a vera bear"},
	{0x20E1,"$npc_a_cave_bear                       ","a cave bear"},
	                                                
	{0x20E2,"$npc_a_rabbit                          ","a rabbit"},
	{0x20EB,"$npc_a_sheep                           ","a sheep"},
	{0x20EE,"$npc_forest_bird                       ","a bird"},
	{0x211D,"$npc_an_eagle                          ","an eagle"},
	{0x20F6,"$npc_a_rideable_llama                  ","a llama"},
	{0x2101,"$npc_a_pig                             ","a pig"},
	{0x2102,"$npc_a_panther                         ","a panther"},
	{0x2103,"$npc_a_cow                             ","a cow"},
	{0x2108,"$npc_a_goat                            ","a goat"},
	{0x211B,"$npc_a_cat                             ","a cat"},
	{0x2126,"$npc_a_pack_horse                      ","a pack horse"},
	{0x2127,"$npc_a_pack_llama                      ","a pack llama"}
}                                                       
	                                                
#define NUM_T2A_MONSTERS 41	                        
new __T2Amonsters[NUM_T2A_MONSTERS][additemEntry] =	 
{	                                                
	{0x005F,"$npc_a_kraken                          ","Kraken"},
	{0x004B,"$npc_a_titan                           ","Titan"},
	{0x0050,"$npc_a_giant_toad                      ","Giant Toad"},
	{0x0051,"$npc_a_bullfrog                        ","Bullfrog"},
	{0x004C,"$npc_a_cyclopedian_warrior             ","Cyclopedian Warrior"},
	{0x0003,"$npc_a_mummy                           ","Mummy"},
	{0x000D,"$npc_a_snow_elemental                  ","Snow Elemental"},
	{0x0034,"$npc_an_ice_serpent                    ","Ice Snake"},
	{0x0035,"$npc_a_frost_troll                     ","Frost Troll"},
	{0x0008,"$npc_a_swamp_tentacle                  ","Swamp Tentacle"},
	{0x0047,"$npc_a_terathan_drone                  ","Terathen Drone"},
	{0x0048,"$npc_a_terathan_warrior                ","Terathen Warrior"},
	{0x0048,"$npc_a_terathan_avenger                ","Terathen Avenger"},
	{0x0046,"$npc_a_terathan_matriarch              ","Terathen Matriarche"},
	{0x0047,"$npc_banker_f                          ","Terathen Newt"},
	{0x001E,"$npc_a_stone_harpy                     ","Stone Harpy"},
	{0x0004,"$npc_a_stone_gargoyle                  ","Stone Gargoyle"},    
	{0x0027,"$npc_an_imp                            ","Imp"},
	{0x0009,"$npc_an_ice_fiend                      ","Ice Fiend"}, 
	{0x0056,"$npc_an_ophidian_warrior               ","Ophidian Warrior"},
	{0x0056,"$npc_an_ophidian_enforcer              ","Ophidian Enforcer"},
	{0x0056,"$npc_an_ophidian_avenger               ","Ophidian Avenger"},
	{0x0055,"$npc_an_ophidian_apprentice_mage       ","Ophidian Apprentice"},
	{0x0055,"$npc_an_ophidian_shaman                ","Ophidian Shaman"},
	{0x0057,"$npc_an_ophidian_matriarch             ","Ophidian Matriarche"},
	{0x00CE,"$npc_a_lava_lizard                     ","Lava Lizard"},
	{0x00CC,"$npc_a_nightmare                       ","A Nightmare"},
	{0x00DA,"$npc_a_frenzied_ostard                 ","Frenzied Ostard"},
	{0x00DB,"$npc_a_forest_ostard                   ","Forest Ostard"},
	{0x00D2,"$npc_a_desert_ostard                   ","Desert Ostard"},
	{0x000D,"$npc_an_efreet                         ","Efreet"},
	{0x0033,"$npc_a_frost_ooze                      ","Frost Ooze"},
	{0x0016,"$npc_an_elder_gazer                    ","Gazer Chief"},
	{0x00C9,"$npc_a_hellcat                         ","Hellcat"},
	{0x00D6,"$npc_a_hellcat_predator                ","Hellcat Predator"},
	{0x000E,"$npc_an_ice_elemental                  ","Ice Elemental"},
	{0x0056,"$npc_an_ophidian_knight-errant         ","Ophidian Knight"},
	{0x0005,"$npc_a_phoenix                         ","Phoenix"},
	{0x0015,"$npc_a_giant_ice_serpent               ","Ice Serpent"},
	{0x0015,"$npc_a_giant_lava_serpent              ","Lava Serpent"},
	{0x001C,"$npc_a_frost_spider                    ","Frost Spider"}
}       

#define NUM_DEAMONS 5
new __deamons[NUM_DEAMONS][additemEntry] =
{
	//daemons
	{0x20D3,"$npc_deamon_unarmed                    ","a daemon"},
	{0x20D3,"$npc_a_daemon                          ","a daemon w/sword"},
	{0x0000,"$npc_an_ice_fiend                      ","ice fiend"},
	{0x20D9,"$npc_a_gargoyle                        ","a gargoyle"},
	{0x0000,"$npc_a_stone_gargoyle                  ","stone gargoyle"}
}                                                       
                                                        
#define NUM_ELEMENTALS 7                                
new __elementals[NUM_ELEMENTALS][additemEntry] =        
{                                                       
	//elementals                                    
	{0x20ED,"$npc_an_air_elemental                  ","an air elemental"},
	{0x20D7,"$npc_an_earth_elemental                ","an earth elemental"},
	{0x20F3,"$npc_a_fire_elemental                  ","a fire elemental"},
	{0x210B,"$npc_a_water_elemental                 ","a water elemental"},  
	{0x210B,"$npc_a_blood_elemental                 ","a blood elemental"},
	{0x20ED,"$npc_a_poison_elemental                ","a poison elemental"},
	{0x0000,"$npc_an_ice_elemental                  ","ice elemental"}
}	                                                  
                                                          
#define NUM_ORCS 12                                       
new __orcs[NUM_ORCS][additemEntry] =                      
{                                                         
	//orc kin                                         
	{0x20D8,"$npc_an_ettin                          ","an ettin"},
	{0x20D8,"$npc_an_ettin_1                        ","an ettin with axe"},
	{0x20E0,"$npc_orc                               ","an orc"},
	{0x20E0,"$npc_orc_mace                          ","an orc with club"},
	{0x20E0,"$npc_an_orcish_mage                    ","an orcish mage"},
	{0x20E0,"$npc_orc_2_hand_axe                    ","an orcish captian"},
	{0x20E0,"$npc_an_orcish_lord                    ","an orcish lord"},
	{0x20DF,"$npc_an_ogre                           ","an ogre"},
	{0x20DF,"$npc_an_ogre_lord                      ","an ogre lord"},
	{0x20E9,"$npc_a_troll                           ","a troll"},
	{0x20E9,"$npc_a_troll_1                         ","a troll 2"},
	{0x20E9,"$npc_a_troll_2                         ","a troll 3"}
}                                                       
                                                        
#define NUM_MONSTERS 17                                 
new __monsters[NUM_MONSTERS][additemEntry] =            
{	                                                
	//other monsters                                
	{0x20D2,"$npc_a_corpser                         ","a corpser"},
	{0x20d0,"$npc_a_giant_rat                       ","a giant rat"},
	{0x20E4,"$npc_a_giant_scorpion                  ","a giant scorpion"},
	{0x20FE,"$npc_a_giant_serpent                   ","a giant serpent"},
	{0x0096,"$npc_a_sea_serpent                     ","a giant sea serpent"},
	{0x20FD,"$npc_a_giant_spider                    ","a giant spider"},
	{0x20FD,"$npc_a_dark_spider                     ","a dark spider"},
	{0x20DE,"$npc_lizardman_short_sword             ","a lizardman"},
	{0x20DE,"$npc_lizardman_fencer                  ","a lizardman with spear"},
	{0x20DE,"$npc_lizardman_macefighter             ","a lizardman with hammer"},
	{0x20F9,"$npc_a_mongbat                         ","a mongbat"},
	{0x20E3,"$npc_ratman_axe                        ","a ratman with club"},
	{0x20E3,"$npc_ratman                            ","a ratman with sword"},
	{0x20FA,"$npc_a_reaper                          ","a reaper"},
	{0x2123,"$npc_a_sewer_rat                       ","a sewer rat"},
	{0x20E8,"$npc_a_slime                           ","a slime"},
	{0x20FC,"$npc_a_snake                           ","a snake"}
}                                                         
                                                          
#define NUM_UNDEADS 15                                    
new __undeads[NUM_UNDEADS][additemEntry] =                
{                                                         
	//undead/mithycal                                 
	{0x20F4,"$npc_a_gazer                           ","a gazer"},
	{0x210A,"$npc_a_headless                        ","a headless"},
	{0x20F8,"$npc_a_lich                            ","a lich"},
	{0x0000,"$npc_a_lich_elder                      ","a liche elder"},
    	{0x20F8,"$npc_a_lich_lord                       ","a lich lord"},
	{0x20DC,"$npc_a_harpy                           ","a harpy"},
	{0x20E7,"$npc_a_bone_knight                     ","a skeletal knight"},
	{0x20E7,"$npc_a_bone_magi                       ","a skeletal mage"},
	{0x20E7,"$npc_a_skeleton                        ","a skeleton"},
	{0x20E7,"$npc_a_skeleton_1                      ","a skeleton with axe"},
	{0x2109,"$npc_a_spectre                         ","a spectre"},
	{0x2100,"$npc_a_wisp                            ","a wisp"},
	{0x20EC,"$npc_a_zombie                          ","a zombie"},
	{0x0000,"$npc_a_zombie_elder                    ","a zombie elder"},
	{0x0000,"$npc_a_wraith                          ","a wraith"}
}                                                         
	                                                  
#define NUM_UNIQUE 5                                      
new __uniqueMonsters[NUM_UNIQUE][additemEntry] =         
{                                                         
	//unique                                          
	{0x20D3,"$npc_the_collector_of_souls            ","the Collector of Souls"},
	{0x20DC,"$npc_a_harpy_hen                       ","a harpy hen"},
	{0x20D3,"$npc_lord_of_the_abyss                 ","the Lord of the Abyss"},
	{0x20D3,"$npc_slayer                            ","the Slayer"},
	{0x20F4,"$npc_xanathar                          ","Xanathar"}
}

#define NUM_FROST_STONE 7
new __frost_stone_monsters[NUM_FROST_STONE][additemEntry] =
{
	//ice frost and stone
	{0x0000,"$npc_an_ice_serpent                    ","ice snake"},
	{0x0000,"$npc_a_giant_ice_serpent               ","ice serpent"},
	{0x0000,"$npc_an_ice_giant                      ","ice giant"},
	{0x0000,"$npc_a_frost_troll                     ","frost troll"},
	{0x0000,"$npc_a_frost_ooze                      ","frost Ooze"},
	{0x0000,"$npc_a_frost_spider                    ","frost spider"},
	{0x0000,"$npc_a_stone_harpy                     ","stone harpy"}
}

#define NUM_DRAGONS 13
new __dragons[NUM_DRAGONS][additemEntry] =
{
	//dragon kin
	{0x0000,"$npc_a_wyvern                          ","a Wyvern (brown)"},
	{0x0000,"$npc_a_drake                           ","a Drake (red)"},
	{0x0000,"$npc_a_drake_1                         ","a Drake (brown)"},
	{0x0000,"$npc_a_dragon                          ","a Dragon (brown)"},
	{0x0000,"$npc_a_dragon_2                        ","a Dragon (red)"},
	{0x0000,"$npc_an_ancient_wyrm                   ","an ancient Wyrm (brown)"},
	{0x0000,"$npc_an_ancient_wyrm_2                 ","an ancient Wyrm (brown)"},
	{0x0000,"$npc_an_ancient_wyrm_1                 ","an ancient Wyrm (red)"},
	{0x0000,"$npc_a_white_wyrm_1                    ","a white wyrm"},
	{0x0000,"$npc_a_white_wyrm                      ","a pure white wyrm"},
	{0x0000,"$npc_a_dragon_1                        ","a Dragon (brown)"},
	{0x0000,"$npc_a_drake_2                         ","a Drake (brown)"},
	{0x0000,"$npc_a_fire_wyrm                       ","a fire wyrm"}
}

#define NUM_PEOPLE_M 29
new __people_male[NUM_PEOPLE_M][additemEntry] =
{
	//people - male
	{0x0000,"$npc_murderer                          ","Murderer"},
	{0x2022,"$npc_artist_m                          ","Artist"},
	{0x202B,"$npc_beggar_m                          ","Beggar"},
	{0x0000,"$npc_sammy                             ","Boy"},
	{0x2106,"$npc_billy                             ","Boy 2"},
	{0x2030,"$npc_brigand_m                         ","Brigand"},
	{0x0000,"$npc_cobbler_m                         ","Cobbler"},
	{0x2106,"$npc_cultist_m                         ","Cultist"},
	{0x2106,"$npc_fighter_m                         ","Fighter"},
	{0x200E,"$npc_guard                             ","Guard"},
	{0x200E,"$npc_dark_knight                       ","Guard Personal"},
	{0x0000,"$npc_chaos_guard_m                     ","Guard Chaos"},
	{0x0000,"$npc_order_guard_m                     ","Guard Order"},
	{0x2033,"$npc_gypsy_m                           ","Gypsy"},
	{0x2011,"$npc_jailor_m                          ","Jailor"},
	{0x2106,"$npc_mondain                           ","Mondain"},
	{0x2009,"$npc_noble_m                           ","Noble"},
	{0x0000,"$npc_archmage                          ","Necromancer"},
	{0x2008,"$npc_peasant_m                         ","Peasant"},
	{0x2015,"$npc_pirate_m                          ","Pirate"},
	{0x0000,"$npc_murderer                          ","PK"},
	{0x0000,"$npc_akbaar                            ","PK Mage"},
	{0x0000,"$npc_kindor_aedrat                     ","PK Archer"},
	{0x2017,"$npc_sailor_m                          ","Sailor"},
	{0x2106,"$npc_adventurer_m                      ","Adventurer"},
	{0x2018,"$npc_shipwright_m                      ","Shipwright"},
	{0x201C,"$npc_thief_m                           ","Thief"},
	{0x2026,"$npc_towncrier_m                       ","Town Crier"},
	{0x2037,"$npc_veterinarian_m                    ","Veterinarian"}
}

#define NUM_PEOPLE_F 22
new __people_female[NUM_PEOPLE_F][additemEntry] =
{
	//people - female
	{0x2022,"$npc_artist_f                          ","Artist"},
	{0x202B,"$npc_beggar_f                          ","Beggar"},
	{0x2030,"$npc_brigand_f                         ","Brigand"},
	{0x2107,"$npc_cultist_f                         ","Cultist"},
	{0x2107,"$npc_fighter_f                         ","Fighter"},
	{0x2107,"$npc_cassandra                         ","Girl"},
	{0x2107,"$npc_isabel                            ","Girl"},
	{0x200E,"$npc_guard_f                           ","Guard"},
	{0x0000,"$npc_chaos_guard_f                     ","Guard Chaos"},
	{0x0000,"$npc_order_guard_f                     ","Guard Order"},
	{0x2033,"$npc_gypsy_f                           ","Gypsy"},
	{0x2011,"$npc_jailor_f                          ","Jailor"},
	{0x2009,"$npc_noble_f                           ","Noble"},
	{0x2008,"$npc_peasant_f                         ","Peasant"},
	{0x2015,"$npc_pirate_f                          ","Pirate"},
	{0x2107,"$npc_len_ikbaan                        ","PK"},
	{0x2017,"$npc_sailor_f                          ","Sailor"},
	{0x2107,"$npc_adventurer_f                      ","Adventurer"},
	{0x2018,"$npc_shipwright_f                      ","Shipwright"},
	{0x201C,"$npc_thief_f                           ","Thief"},
	{0x2027,"$npc_towncrier_f                       ","Town Crier"},
	{0x2038,"$npc_veterinarian_f                    ","Veterinarian"}
}

#define NUM_MERCHANTS_M 32
new __merchants_male[NUM_MERCHANTS_M][additemEntry] =
{
	//merchants - male
	{0x2023,"$npc_alchemist_m                       ","Alchemist"},
	{0x2035,"$npc_animal_trainer_m                  ","Animal Trainer"},
	{0x2031,"$npc_architect_m                       ","Architect"},
	{0x200A,"$npc_armorer_m                         ","Armorer"},
	{0x200B,"$npc_baker_m                           ","Baker"},
	{0x0C0B,"$npc_banker_m                          ","Banker"},
	{0x2106,"$npc_bard_m                            ","Bard"},
	{0x0000,"$npc_beekeeper_m                       ","The BeeKeeper"},
	{0x2106,"$npc_blacksmith_m                      ","Blacksmith"},
	{0x200C,"$npc_bowyer_m                          ","Bowyer"},
	{0x200D,"$npc_butcher_m                         ","Butcher"},
	{0x2020,"$npc_carpenter_m                       ","Carpenter"},
	{0x202A,"$npc_cobbler_m                         ","Cobbler"},
	{0x0190,"$npc_cook_m                            ","Cook"},
	{0x0000,"$npc_que_1                             ","the Engineer"},
	{0x2022,"$npc_farmer_m                          ","Farmer"},
	{0x8414,"$npc_fisherman                         ","Fisherman"},
	{0x200F,"$npc_wandering_healer_m                ","Healer (wandering)"},
	{0x200F,"$npc_healer_m                          ","Healer"},
	{0x2034,"$npc_herbalist_m                       ","Herbalist"},
	{0x2010,"$npc_innkeeper_m                       ","Innkeeper"},
	{0x2012,"$npc_jeweler_m                         ","Jeweler"},
	{0x2013,"$npc_leather_worker_m                  ","Leather Worker"},
	{0x2014,"$npc_mage_m                            ","Mage"},
	{0x202D,"$npc_miner_m                           ","Miner"},
	{0x0000,"$npc_necromancer                       ","Necromancer"},
	{0x2016,"$npc_provisioner_m                     ","Provisioner"},
	{0x201A,"$npc_spinner_m                         ","Spinner"},
	{0x2019,"$npc_tailor_m                          ","Tailor"},
	{0x2021,"$npc_tinker_m                          ","Tinker"},
	{0x0000,"$npc_veterinarian_m                    ","Veterinarian"},
	{0x201F,"$npc_weaponsmith_m                     ","Weaponsmith"}
}

#define NUM_MERCHANTS_F 30
new __merchants_female[NUM_MERCHANTS_F][additemEntry] =
{
	//merchants - female
	{0x2023,"$npc_alchemist_f                       ","Alchemist"},
	{0x2036,"$npc_animal_trainer_f                  ","Animal Trainer"},
	{0x2031,"$npc_architect_f                       ","Architect"},
	{0x200A,"$npc_armorer_f                         ","Armorer"},
	{0x200B,"$npc_baker_f                           ","Baker"},
	{0x2107,"$npc_banker_f                          ","Banker"},
	{0x2107,"$npc_bard_f                            ","Bard"},
	{0x0000,"$npc_beekeper_f                        ","The Beekeeper"},
	{0x2107,"$npc_blacksmith_f                      ","Blacksmith"},
	{0x200C,"$npc_bowyer_f                          ","Bowyer"},
	{0x200D,"$npc_butcher_f                         ","Butcher"},
	{0x2020,"$npc_carpenter_f                       ","Carpenter"},
	{0x202A,"$npc_cobbler_f                         ","Cobbler"},
	{0x0191,"$npc_cook_f                            ","Cook"},
	{0x0000,"$npc_jessie                            ","the Engineer"},
	{0x2024,"$npc_farmer_f                          ","Farmer"},
	{0x8415,"$npc_fisherlady                        ","Fisherlady"},
	{0x200F,"$npc_wandering_healer_f                ","Healer (wandering)"},
	{0x200F,"$npc_healer_f                          ","Healer"},
	{0x2034,"$npc_herbalist_f                       ","Herbalist"},
	{0x2010,"$npc_innkeeper_f                       ","Innkeeper"},
	{0x2012,"$npc_jeweler_f                         ","Jeweler"},
	{0x2013,"$npc_leather_worker_f                  ","Leather Worker"},
	{0x2014,"$npc_mage_f                            ","Mage"},
	{0x202D,"$npc_miner_f                           ","Miner"},
	{0x2016,"$npc_provisioner_f                     ","Provisoner"},
	{0x201A,"$npc_spinner_f                         ","Spinner"},
	{0x2019,"$npc_tailor_f                          ","Tailor"},
	{0x2021,"$npc_tinker_f                          ","Tinker"},
	{0x201F,"$npc_weaponsmith_f                     ","Weaponsmith"}
}

//===================================================================================
//==========================   ITEMS   ==============================================

//^([0-9,A-F][0-9,A-F][0-9,A-F][0-9,A-F]^) ^([a-z,A-Z, ,',0-9,(,),&,/,^-]+^)^p    ADDITEM ^(^$[a-z,A-Z,0-9,_,]+^)
//{0x^1,"^3","^2"},

#define NUM_BEVERAGES 27
new __beverages[NUM_BEVERAGES][additemEntry] =
{
	//Bottled beverages
	{0x099F,"$item_bottles_of_ale1                  ","Bottle of Ale"},
	{0x09A0,"$item_bottles_of_ale2                  ","Bottles of Ale"},
	{0x09A1,"$item_bottles_of_ale3                  ","Bottles of Ale"},
	{0x09A2,"$item_bottles_of_ale4                  ","Bottles of Ale"},
	{0x099B,"$item_bottles_of_liquor1               ","Bottle of Liquor"},
	{0x099C,"$item_bottles_of_liquor2               ","Bottles of Liquor"},
	{0x099D,"$item_bottles_of_liquor3               ","Bottles of Liquor"},
	{0x099E,"$item_bottles_of_liquor4               ","Bottles of Liquor"},
	{0x09C7,"$item_bottles_of_wine1                 ","Bottle of Wine"},
	{0x09C6,"$item_bottles_of_wine2                 ","Bottles of Wine"},
	{0x09C5,"$item_bottles_of_wine3                 ","Bottles of Wine"},
	{0x09C4,"$item_bottles_of_wine4                 ","Bottles of Wine"},
	{0x0FFA,"$item_bucket_of_water                  ","Bucket of Water"},
	{0x09EE,"$item_mug_of_ale_1                     ","Glass of Ale"},
	{0x1F7D,"$item_glass_of_cider_1                 ","Glass of Cider"},
	{0x1F85,"$item_glass_of_liquor_1                ","Glass of Liquor"},
	{0x1F89,"$item_glass_of_milk_1                  ","Glass of Milk"},
	{0x1F91,"$item_glass_of_water_1                 ","Glass of Water"},
	{0x1F8D,"$item_glass_of_wine_1                  ","Glass of Wine"},
	{0x098E,"$item_jugs_of_cider1                   ","Jugs of Cider"},
	{0x098D,"$item_jugs_of_cider2                   ","Jugs of Cider"},
	{0x1F95,"$item_pitcher_of_ale_1                 ","Pitcher of Ale"},
	{0x1F97,"$item_pitcher_of_cider_1               ","Pitcher of Cider"},
	{0x1F99,"$item_pitcher_of_liquor_1              ","Pitcher of Liquor"},
	{0x09AD,"$item_pitcher_of_milk_1                ","Pitcher of Milk"},
	{0x0FF9,"$item_pitcher_of_water_1               ","Pitcher of Water"},
	{0x1F9B,"$item_pitcher_of_wine_1                ","Pitcher of Wine"}
}    

#define NUM_BAKED 39
new __bakedAndVeggys[NUM_BAKED][additemEntry] =
{    
	//Baked and Veggys
	{0x1041,"$item_baked_pie                        ","Baked Pie"},
	{0x1042,"$item_unbaked_pie                      ","Unbaked Pie"},
	{0x09E9,"$item_cake                             ","Cake"},
	{0x097C,"$item_wedges_of_cheese_1               ","Wedge of Cheese"},
	{0x097D,"$item_wedges_of_cheese_2               ","Cut Cheese"},
	{0x097E,"$item_wheels_of_cheese                 ","Wheel of Cheese"},
	{0x098C,"$item_french_bread                     ","French Bread"},
	{0x09EA,"$item_muffins1                         ","Muffin"},
	{0x09FA,"$item_muffins2                         ","Muffins"},
	{0x09EB,"$item_muffins3                         ","Muffins"},
	{0x103C,"$item_bread_loaves_1                   ","Loaf of Bread"},
	{0x1040,"$item_pizzas                           ","Pizza"},
	{0x1083,"$item_uncooked_pizza                   ","Unbaked Pizza"},
	{0x160B,"$item_pan_of_cookies                   ","Pan of Cookies"},
	{0x160C,"$item_plate_of_cookies                 ","Plate of Cookies"},
	{0x09B4,"$item_eggshells                        ","Eggshells"},
	{0x09B5,"$item_eggs                             ","Eggs"},
	{0x09B6,"$item_fried_eggs                       ","Fried Eggs"},
	{0x103F,"$item_cookie_mix                       ","Cookie Mix"},
	{0x10E3,"$item_dough_bowl                       ","Dough"},
	{0x15FE,"$item_bowl_of_carrots1                 ","Carrots"},
	{0x15FF,"$item_bowl_of_corn1                    ","Corn"},
	{0x1600,"$item_bowl_of_lettuce1                 ","Lettuce"},
	{0x1601,"$item_bowl_of_peas1                    ","Peas"},
	{0x1602,"$item_bowl_of_potatoes                 ","Potatoes"},
	{0x1604,"$item_bowl_of_stew                     ","Stew"},
	{0x1606,"$item_tomato_soup                      ","Tomato Soup"},
	{0x15FD,"$item_pewter_bowl                      ","Pewter"},
	{0x09B7,"$item_cooked_birds_1                   ","Cooked Bird"},
	{0x09BB,"$item_roast_pigs_1                     ","Roast Pig"},
	{0x09C0,"$item_sausages_1                       ","Sausages"},
	{0x09C9,"$item_hams_1                           ","Ham"},
	{0x09F2,"$item_cuts_of_ribs                     ","Ribs"},
	{0x097B,"$item_fish_steaks                      ","Fish Steak"},
	{0x1E1A,"$item_fish_head1_1                     ","Fish Head"},
	{0x09CC,"$item_fish1                            ","A fish"},
	{0x1E17,"$item_raw_fish_1                       ","Raw Fish"},
	{0x0976,"$item_slabs_of_bacon_1                 ","Slabs of Bacon"},
	{0x0978,"$item_slices_of_bacon_1                ","Slice of Bacon"}
}

#define NUM_BOWLSMEATFRUIT 28
new __bowlsMeatFruit[NUM_BOWLSMEATFRUIT][additemEntry] =
{
	//Bowls, meat, fruit
	{0x0994,"$item_pears_1                          ","Pear"},
	{0x09D0,"$item_apples                           ","Apple"},
	{0x09D1,"$item_grape_bunches_1                  ","Grape Bunch"},
	{0x09D2,"$item_peaches_1                        ","Peach"},
	{0x0993,"$item_fruit_basket                     ","Fruit Basket"},
	{0x1726,"$item_coconuts1                        ","Coconut"},
	{0x1720,"$item_banana_2                         ","Banana"},
	{0x1721,"$item_bunch_of_bananas_1               ","Bananas"},
	{0x1727,"$item_bunches_of_dates                 ","Dates"},
	{0x1728,"$item_lemons1                          ","Lemon"},
	{0x1729,"$item_lemons2                          ","Lemons"},
	{0x172A,"$item_limes1                           ","Lime"},
	{0x172B,"$item_limes2                           ","Limes"},
	{0x0C74,"$item_honeydew_melons1                 ","Honeydew Melon"},
	{0x0C79,"$item_canteloupes                      ","Canteloupe"},
	{0x0C5D,"$item_watermelons                      ","Water Melon"},
	{0x0F36,"$item_sheaf_of_hay1                    ","Sheaf of Hay"},
	{0x0C70,"$item_lettuce1                         ","Lettuce"},
	{0x0C72,"$item_squash1                          ","Squash"},
	{0x0C76,"$item_carrots                          ","Carrots"},
	{0x0C7B,"$item_heads_of_cabbage                 ","Cabbage"},
	{0x0C7F,"$item_ears_of_corn1_4                  ","Ear of Corn"},
	{0x1AD3,"$item_donuts                           ","Donuts"},
	{0x09EC,"$item_jars_of_honey                    ","Jar of Honey"},
	{0x0C61,"$item_turnip1                          ","Turnip"},
	{0x0C68,"$item_sprouts                          ","Sprouts"},
	{0x0C6A,"$item_pumpkin1                         ","Pumpkin"},
	{0x0C6D,"$item_onions                           ","Onion"}
}

#define NUM_PLANTS 19
new __plants[NUM_PLANTS][additemEntry] =
{
	{0x14f0,"$item_potted_tree                      ","potted tree"},
	{0x14f0,"$item_potted_plant                     ","potted tree"},
	{0x1E0F,"$item_potted_cactus3                   ","Potted Cactus w/flowers"},
	{0x1E10,"$item_potted_cactus1                   ","Potted Cactus"},
	{0x1E11,"$item_potted_cactus2                   ","Potted Cactus w/bush"},
	{0x1E12,"$item_potted_cactus4                   ","Potted Branched Cactus"},
	{0x0C83,"$item_campion_flowers                  ","Campion Flowers"},
	{0x0C84,"$item_potted_foxglove                  ","Foxglove Flowers"},
	{0x0C85,"$item_potted_orfluer                   ","Orfluer Flowers"},
	{0x0C86,"$item_red_poppies1                     ","Red Poppies"},
	{0x0C88,"$item_snow_drops                       ","Snow Drops"},
	{0x0C8F,"$item_hedge1                           ","Hedge"},
	{0x0C93,"$item_blade_plant                      ","Blade Plant"},
	{0x0CA1,"$item_large_fern                       ","Large Fern"},
	{0x0CA5,"$item_pampas_grass1                    ","Pampas Grass"},
	{0x0CC9,"$item_spider_tree                      ","Spider Tree"},
	{0x0CC8,"$item_juniper_bush                     ","Juniper Bush"},
	{0x0CC7,"$item_weed                             ","Weed"},
	{0x0D38,"$item_yucca                            ","Yucca"}
}
    
#define NUM_LIGHTS 18
new __lights[NUM_LIGHTS][additemEntry] =
{
	{0x0A08,"$item_wall_torch                       ","N/S Wall Torch"},
	{0x0A0E,"$item_wall_torch_1                     ","E/W Wall Torch"},
	{0x0E31,"$item_a_brazier                        ","Brazier"},
	{0x0B1A,"$item_candle                           ","Candle"},
	{0x0B1D,"$item_candelabra                       ","Candelabra"},
	{0x0B25,"$item_lamp_post_4                      ","Dark Lamp post"},
	{0x0B23,"$item_lamp_post_2                      ","Fancy Dim Post"},
	{0x0B22,"$item_lamp_post_1                      ","Fancy Lit Post"},
	{0x0B24,"$item_lamp_post_3                      ","Lit Lamp Post"},
	{0x0B20,"$item_lamp_post                        ","Standard Lit Post"},
	{0x0B21,"$item_an_unlit_lamppost                ","Standard Off Post"},
	{0x0B26,"$item_a_candelabra                     ","Tall Candelabra"},
	{0x0A15,"$item_lantern                          ","Lantern"},
	{0x0A12,"$item_torch                            ","Torch"},
	{0x0A0F,"$item_candle_3                         ","Candle"},
	{0x1854,"$item_skull_candle                     ","Skull candle"},
	{0x09FF,"$item_wall_sconce_1                    ","Wall Candle"},
	{0x0A00,"$item_wall_sconce_2                    ","Wall Candle"}
}

#define NUM_SIGNS 125
new __signs[NUM_SIGNS][additemEntry] =
{
	//Roadsigns
	{0x1297,"$item_roadsign                         ","Roadsign"},
	{0x1298,"$item_roadsign_1                       ","Roadsign"},
	{0x1299,"$item_roadsign_2                       ","Roadsign"},
	{0x129A,"$item_roadsign_3                       ","Roadsign"},
	{0x129B,"$item_roadsign_4                       ","Roadsign"},
	{0x129C,"$item_roadsign_5                       ","Roadsign"},
	{0x129D,"$item_roadsign_6                       ","Roadsign"},
	{0x129E,"$item_roadsign_7                       ","Roadsign"},
	{0x1296,"$item_signpost                         ","Signpost"},
	//Shop Signs 1
	{0x0B95,"$item_library                          ","Library"},
	{0x0B96,"$item_library_1                        ","Library"},
	{0x0BA3,"$item_bakery                           ","Bakery"},
	{0x0BA4,"$item_bakery_1                         ","Bakery"},
	{0x0BA5,"$item_tailor                           ","Tailor"},
	{0x0BA6,"$item_tailor_1                         ","Tailor"},
	{0x0BA7,"$item_tinker                           ","Tinker"},
	{0x0BA8,"$item_tinker_1                         ","Tinker"},
	{0x0BA9,"$item_butcher                          ","Butcher"},
	{0x0BAA,"$item_butcher_1                        ","Butcher"},
	{0x0BAB,"$item_healer                           ","Healer"},
	{0x0BAC,"$item_healer_1                         ","Healer"},
	//Shop Signs 2
	{0x0BAD,"$item_magic_shop                       ","Magic"},
	{0x0BAE,"$item_magic_shop_1                     ","Magic"},
	{0x0BAF,"$item_carpenter                        ","Carpenter"},
	{0x0BB0,"$item_carpenter_1                      ","Carpenter"},
	{0x0BB1,"$item_shipwright                       ","Shipwright"},
	{0x0BB2,"$item_shipwright_1                     ","Shipwright"},
	{0x0BB3,"$item_inn                              ","Inn"},
	{0x0BB4,"$item_inn_1                            ","Inn"},
	{0x0BB5,"$item_harbor_master                    ","Harbor Master"},
	{0x0BB6,"$item_harbor_master_1                  ","Harbor Master"},
	{0x0BB7,"$item_stables                          ","Stables"},
	{0x0BB8,"$item_stables_1                        ","Stables"},
	{0x0BB9,"$item_barber                           ","Barber"},
	{0x0BBA,"$item_barber_1                         ","Barber"},
	//Shop Signs 3
	{0x0BBB,"$item_musician                         ","Mucician"},
	{0x0BBC,"$item_musician_1                       ","Mucician"},
	{0x0BBD,"$item_archer_1                         ","Archery"},
	{0x0BBE,"$item_archer_2                         ","Archery"},
	{0x0BBF,"$item_blacksmith                       ","Blacksmith"},
	{0x0BC0,"$item_blacksmith_1                     ","Blacksmith"},
	{0x0BC1,"$item_jewler                           ","Jewler"},
	{0x0BC2,"$item_jewler_1                         ","Jewler"},
	{0x0BC3,"$item_tavern                           ","Tavern"},
	{0x0BC4,"$item_tavern_1                         ","Tavern"},
	{0x0BC5,"$item_alchemist                        ","Alchemist"},
	{0x0BC6,"$item_alchemist_1                      ","Alchemist"},
	{0x0BC7,"$item_armorer                          ","Armorer"},
	{0x0BC8,"$item_armorer_1                        ","Armorer"},
	//Shop Signs 4
	{0x0BC9,"$item_artist                           ","Artist"},
	{0x0BCA,"$item_artist_1                         ","Artist"},
	{0x0BCB,"$item_provisioner                      ","Provisioner"},
	{0x0BCC,"$item_provisioner_1                    ","Provisioner"},
	{0x0BCD,"$item_bowyer                           ","Bowyer"},
	{0x0BCE,"$item_bowyer_1                         ","Bowyer"},
	{0x0C0B,"$item_bank                             ","Bank"},
	{0x0C0C,"$item_bank_1                           ","Bank"},
	{0x0C0D,"$item_theater                          ","Theater"},
	{0x0C0E,"$item_theater_1                        ","Theater"},
	{0x0C43,"$item_beekeeper                        ","Beekeeper"},
	{0x0C44,"$item_beekeeper_1                      ","Beekeeper"},
	//Misc Signs
	{0x0BCF,"$item_wooden_sign                      ","Wooden Sign"},
	{0x0BD0,"$item_wooden_sign_1                    ","Wooden Sign"},
	{0x0BD1,"$item_brass_sign                       ","Brass Sign"},
	{0x0BD2,"$item_brass_sign_1                     ","Brass Sign"},
	{0x0BD1,"$item_brass_sign_2                     ","Plain"},
	{0x0BD2,"$item_brass_sign_3                     ","Plain"},
	{0x1F29,"$item_sign                             ","Sign"},
	{0x1F28,"$item_sign_1                           ","Sign"},
	//Guild Signs 1
	{0x0BD3,"$item_armaments_guild                  ","Armaments Guild"},
	{0x0BD4,"$item_armaments_guild_1                ","Armaments Guild"},
	{0x0BD5,"$item_armorers_guild                   ","Armorers Guild"},
	{0x0BD6,"$item_armorers_guild_1                 ","Armorers Guild"},
	{0x0BD7,"$item_blacksmiths_guild                ","Blacksmiths Guild"},
	{0x0BD8,"$item_blacksmiths_guild_1              ","Blacksmiths Guild"},
	{0x0BD9,"$item_weapons_guild                    ","Weapons Guild"},
	{0x0BDA,"$item_weapons_guild_1                  ","Weapons Guild"},
	{0x0BDB,"$item_bardic_guild                     ","Bardic Guild"},
	{0x0BDC,"$item_bardic_guild_1                   ","Bardic Guild"},
	{0x0BDD,"$item_barders_guild                    ","Barders Guild"},
	{0x0BDE,"$item_barders_guild_1                  ","Barders Guild"},
	{0x0BDF,"$item_provisioners_guild               ","Provisioners Guild"},
	{0x0BE0,"$item_provisioners_guild_1             ","Provisioners Guild"},
	//Guild Signs 2
	{0x0BE1,"$item_traders_guild                    ","Traders Guild"},
	{0x0BE2,"$item_traders_guild_1                  ","Traders Guild"},
	{0x0BE3,"$item_cooks_guild                      ","Cooks Guild"},
	{0x0BE4,"$item_cooks_guild_1                    ","Cooks Guild"},
	{0x0BE5,"$item_healers_guild                    ","Healers Guild"},
	{0x0BE6,"$item_healers_guild_1                  ","Healers Guild"},
	{0x0BE7,"$item_mages_guild                      ","Mages Guild"},
	{0x0BE8,"$item_mages_guild_1                    ","Mages Guild"},
	{0x0BE9,"$item_sorcerers_guild                  ","Sorcerers Guild"},
	{0x0BEA,"$item_sorcerers_guild_1                ","Sorcerers Guild"},
	{0x0BEB,"$item_illusionists_guild               ","Illusionists Guild"},
	{0x0BEC,"$item_illusionists_guild_1             ","Illusionists Guild"},
	{0x0BED,"$item_miners_guild                     ","Miners Guild"},
	{0x0BEE,"$item_miners_guild_1                   ","Miners Guild"},
	//Guild Signs 3
	{0x0BEF,"$item_archers_guild                    ","Archers Guild"},
	{0x0BF0,"$item_archers_guild_1                  ","Archers Guild"},
	{0x0BF1,"$item_seamans_guild                    ","Seamans Guild"},
	{0x0BF2,"$item_seamans_guild_1                  ","Seamans Guild"},
	{0x0BF3,"$item_fishermans_guild                 ","Fishermans Guild"},
	{0x0BF4,"$item_fishermans_guild_1               ","Fishermans Guild"},
	{0x0BF5,"$item_sailors_guild                    ","Sailors Guild"},
	{0x0BF6,"$item_sailors_guild_1                  ","Sailors Guild"},
	{0x0BF7,"$item_shipwrights_guild                ","Shipwrights Guild"},
	{0x0BF8,"$item_shipwrights_guild_1              ","Shipwrights Guild"},
	{0x0BF9,"$item_tailors_guild                    ","Tailors Guild"},
	{0x0BFA,"$item_tailors_guild_1                  ","Tailors Guild"},
	{0x0BFB,"$item_thieves_guild                    ","Thieves Guild"},
	{0x0BFC,"$item_thieves_guild_1                  ","Thieves Guild"},
	//Guild Signs 4
	{0x0BFD,"$item_rouges_guild                     ","Rouges Guild"},
	{0x0BFE,"$item_rouges_guild_1                   ","Rouges Guild"},
	{0x0BFF,"$item_assassins_guild                  ","Assassins Guild"},
	{0x0C00,"$item_assassins_guild_1                ","Assassins Guild"},
	{0x0C01,"$item_tinkers_guild                    ","Tinkers Guild"},
	{0x0C02,"$item_tinkers_guild_1                  ","Tinkers Guild"},
	{0x0C03,"$item_warriors_guild                   ","Warriors Guild"},
	{0x0C04,"$item_warriors_guild_1                 ","Warriors Guild"},
	{0x0C05,"$item_cavalry_guild                    ","Cavalry Guild"},
	{0x0C06,"$item_cavalry_guild_1                  ","Cavalry Guild"},
	{0x0C07,"$item_fighters_guild                   ","Fighters Guild"},
	{0x0C08,"$item_fighters_guild_1                 ","Fighters Guild"},
	{0x0C09,"$item_merchants_guild                  ","Merchants Guild"},
	{0x0C0A,"$item_merchants_guild_1                ","Merchants Guild"}
}

#define NUM_CONTAINERS 18
new __containers[NUM_CONTAINERS][additemEntry] = 
{
	//Containers                                                                																																																																
	{0x0E75,"$item_backpack                         ","Backpack"},          																																																																
	{0x0E76,"$item_leather_bag                      ","Leather Bag"},       																																																																
	{0x0E78,"$item_round_basket                     ","Round Basket"},      																																																																
	{0x0E79,"$item_pouch                            ","Pouch"},             																																																																
	{0x0E7A,"$item_square_basket                    ","Square Basket"},     																																																																
	{0x0E42,"$item_wooden_chest1                    ","Wooden Chest"},      																																																																
	{0x0E7C,"$item_silver_chest                     ","Silver Chest"},      																																																																
	{0x0E40,"$item_metal_chest                      ","Metal Chest"},       																																																																
	{0x0E7D,"$item_wooden_box                       ","Wooden Box"},        																																																																
	{0x0E7E,"$item_small_wooden_crate               ","Small Wooden Crate"},																																																																
	{0x0E3E,"$item_medium_wooden_crate1             ","Medium Wooden Crate"}																																																																		,
	{0x0E3C,"$item_large_wooden_crate1              ","Large Wooden Crate"},																																																																		
	{0x0E7F,"$item_open_wooden_keg                  ","Wooden Keg"},        																																																																		
	{0x0E83,"$item_tub                              ","Tub"},               																																																																		
	{0x0E77,"$item_barrel_with_lid                  ","Barrel"},            																																																																		
	{0x0E80,"$item_brass_box                        ","Brass Box"},         																																																																		
	{0x0A4D,"$item_pine_armoire1_2                  ","Armorie simple"},    																																																																		
	{0x0A4F,"$item_pine_armoire2_2                  ","Armorie fancy"}      																																																																		
}

#define NUM_STATUES_TROPHIES 29
new __statuesTrophies[NUM_STATUES_TROPHIES][additemEntry] = 
{
	//Statues
	{0x12A1,"$item_statue                           ","Statue 1 Left"},
	{0x129F,"$item_statue_1                         ","Statue 1 Center"},
	{0x12A0,"$item_statue_2                         ","Statue 1 Right"},
	{0x12A4,"$item_statue_3                         ","Statue 2 Left"},
	{0x12A2,"$item_statue_4                         ","Statue 2 Center"},
	{0x12A3,"$item_statue_5                         ","Statue 2 Right"},
	{0x12D7,"$item_statue_7                         ","Statue 3 Left"},
	{0x12D5,"$item_statue_8                         ","Statue 3 Center"},
	{0x12D6,"$item_statue_9                         ","Statue 3 Right"},
	{0x12A3,"$item_statue_6                         ","Unfinished Statue"},
	{0x1224,"$item_statue_A                         ","Statue"},
	{0x1225,"$item_statue_B                         ","Statue"},
	{0x1226,"$item_statue_C                         ","Statue"},
	{0x1227,"$item_statue_D                         ","Statue"},
	{0x1228,"$item_statue_E                         ","Statue"},
	//Trophies
	{0x1E60,"$item_trophy                           ","Trophy"},
	{0x1E61,"$item_trophy_1                         ","Trophy"},
	{0x1E62,"$item_trophy_2                         ","Trophy"},
	{0x1E63,"$item_trophy_3                         ","Trophy"},
	{0x1E64,"$item_trophy_4                         ","Trophy"},
	{0x1E65,"$item_trophy_5                         ","Trophy"},
	{0x1E66,"$item_trophy_6                         ","Trophy"},
	{0x1E67,"$item_trophy_7                         ","Trophy"},
	{0x1E68,"$item_trophy_8                         ","Trophy"},
	{0x1E69,"$item_trophy_9                         ","Trophy"},
	{0x1E6A,"$item_trophy_A                         ","Trophy"},
	{0x1E6B,"$item_trophy_B                         ","Trophy"},
	{0x1E6C,"$item_trophy_C                         ","Trophy"},
	{0x1E6D,"$item_trophy_D                         ","Trophy"}
}

#define NUM_HAIR_BEARD 16
new __hairBeard[NUM_HAIR_BEARD][additemEntry] = 
{
	//Hairs
	{0x2046,"$item_buns_hair                        ","Curly"},
	{0x203C,"$item_long_hair                        ","Long Hair"},
	{0x2044,"$item_mohawk                           ","Mohawk"},
	{0x2045,"$item_pageboy                          ","Pageboy"},
	{0x203D,"$item_pony_tail                        ","Pony Tail"},
	{0x2048,"$item_receding_hair                    ","Receding"},
	{0x203B,"$item_short_hair                       ","Short Hair"},
	{0x2049,"$item_2_pig_tails                      ","2 Tails"},
	{0x204A,"$item_krisna_hair                      ","Topknot"},
	//Beards
	{0x2040,"$item_goatee                           ","Goatee"},
	{0x204D,"$item_vandyke                          ","Goatee/Moustache"},
	{0x2041,"$item_mustache                         ","Moustache"},
	{0x203E,"$item_long_beard                       ","Long Beard"},
	{0x204C,"$item_med_short_beard_1                ","Long/Moustache"},
	{0x203F,"$item_short_beard                      ","Short Beard"},
	{0x204B,"$item_med_short_beard                  ","Short/Moustache"}
}

#define NUM_RUGS 90
new __rugs[NUM_RUGS][additemEntry] =
{
	//Red Rug
	{0x0AA9,"$item_rug                              ","Red Rug"},
	{0x0AAA,"$item_rug_1                            ","Red Rug"},
	{0x0AAB,"$item_rug_2                            ","Red Rug"},
	{0x0AAC,"$item_rug_3                            ","Red Rug"},
	{0x0AAD,"$item_rug_4                            ","Red Rug"},
	{0x0AAE,"$item_rug_5                            ","Red Rug"},
	{0x0AAF,"$item_rug_6                            ","Red Rug"},
	{0x0AB0,"$item_rug_7                            ","Red Rug"},
	{0x0AB1,"$item_rug_8                            ","Red Rug"},
	{0x0AB2,"$item_rug_9                            ","Red Rug"},
	//Greenish Rug
	{0x0AB3,"$item_rug_A                            ","Greenish Rug"},
	{0x0AB4,"$item_rug_B                            ","Greenish Rug"},
	{0x0AB5,"$item_rug_C                            ","Greenish Rug"},
	{0x0AB6,"$item_rug_D                            ","Greenish Rug"},
	{0x0AB7,"$item_rug_E                            ","Greenish Rug"},
	{0x0AB8,"$item_rug_F                            ","Greenish Rug"},
	{0x0AB9,"$item_rug_G                            ","Greenish Rug"},
	{0x0ABA,"$item_rug_H                            ","Greenish Rug"},
	{0x0ABB,"$item_rug_I                            ","Greenish Rug"},
	{0x0ABC,"$item_rug_J                            ","Greenish Rug"},
	//Fancy Blue Rug
	{0x0ABD,"$item_carpet                           ","Fancy Blue Rug"},
	{0x0ABE,"$item_carpet_1                         ","Fancy Blue Rug"},
	{0x0ABF,"$item_carpet_2                         ","Fancy Blue Rug"},
	{0x0AC0,"$item_carpet_3                         ","Fancy Blue Rug"},
	{0x0AC1,"$item_carpet_4                         ","Fancy Blue Rug"},
	{0x0AC2,"$item_carpet_5                         ","Fancy Blue Rug"},
	{0x0AC3,"$item_carpet_6                         ","Fancy Blue Rug"},
	{0x0AC4,"$item_carpet_7                         ","Fancy Blue Rug"},
	{0x0AC5,"$item_carpet_8                         ","Fancy Blue Rug"},
	//Fancy Red Rug
	{0x0AC6,"$item_carpet_9                         ","Fancy Red Rug"},
	{0x0AC7,"$item_carpet_A                         ","Fancy Red Rug"},
	{0x0AC8,"$item_carpet_B                         ","Fancy Red Rug"},
	{0x0AC9,"$item_carpet_C                         ","Fancy Red Rug"},
	{0x0ACA,"$item_carpet_D                         ","Fancy Red Rug"},
	{0x0ACB,"$item_carpet_E                         ","Fancy Red Rug"},
	{0x0ACC,"$item_carpet_F                         ","Fancy Red Rug"},
	{0x0ACD,"$item_carpet_G                         ","Fancy Red Rug"},
	{0x0ACE,"$item_carpet_H                         ","Fancy Red Rug"},
	{0x0ACF,"$item_carpet_I                         ","Fancy Red Rug"},
	{0x0AD0,"$item_carpet_J                         ","Fancy Red Rug"},
	//Fancy Blue/Gold Rug
	{0x0AD1,"$item_carpet_K                         ","Fancy Blue/Gold Rug"},
	{0x0AD2,"$item_carpet_L                         ","Fancy Blue/Gold Rug"},
	{0x0AD3,"$item_carpet_M                         ","Fancy Blue/Gold Rug"},
	{0x0AD4,"$item_carpet_N                         ","Fancy Blue/Gold Rug"},
	{0x0AD5,"$item_carpet_O                         ","Fancy Blue/Gold Rug"},
	{0x0AD6,"$item_carpet_P                         ","Fancy Blue/Gold Rug"},
	{0x0AD7,"$item_carpet_Q                         ","Fancy Blue/Gold Rug"},
	{0x0AD8,"$item_carpet_R                         ","Fancy Blue/Gold Rug"},
	{0x0AD9,"$item_carpet_S                         ","Fancy Blue/Gold Rug"},
	//Fancy Golden Rug
	{0x0ADA,"$item_carpet_T                         ","Fancy Golden Rug"},
	{0x0ADB,"$item_carpet_U                         ","Fancy Golden Rug"},
	{0x0ADC,"$item_carpet_V                         ","Fancy Golden Rug"},
	{0x0ADD,"$item_carpet_W                         ","Fancy Golden Rug"},
	{0x0ADE,"$item_carpet_X                         ","Fancy Golden Rug"},
	{0x0ADF,"$item_carpet_Y                         ","Fancy Golden Rug"},
	{0x0AE0,"$item_carpet_Z                         ","Fancy Golden Rug"},
	{0x0AE1,"$item_carpet_Z1                        ","Fancy Golden Rug"},
	{0x0AE2,"$item_carpet_Z2                        ","Fancy Golden Rug"},
	//Fancy Pink Rug
	{0x0AE3,"$item_carpet_Z3                        ","Fancy Pink Rug"},
	{0x0AE4,"$item_carpet_Z4                        ","Fancy Pink Rug"},
	{0x0AE5,"$item_carpet_Z5                        ","Fancy Pink Rug"},
	{0x0AE6,"$item_carpet_Z6                        ","Fancy Pink Rug"},
	{0x0AE7,"$item_carpet_Z7                        ","Fancy Pink Rug"},
	{0x0AE8,"$item_carpet_Z8                        ","Fancy Pink Rug"},
	{0x0AE9,"$item_carpet_Z9                        ","Fancy Pink Rug"},
	{0x0AEA,"$item_carpet_ZA                        ","Fancy Pink Rug"},
	{0x0AEB,"$item_carpet_ZB                        ","Fancy Pink Rug"},
	//Fancy Pink & Blue Rug
	{0x0AEC,"$item_carpet_ZC                        ","Fancy Pink & Blue Rug"},
	{0x0AED,"$item_carpet_ZD                        ","Fancy Pink & Blue Rug"},
	{0x0AEE,"$item_carpet_ZE                        ","Fancy Pink & Blue Rug"},
	{0x0AEF,"$item_carpet_ZF                        ","Fancy Pink & Blue Rug"},
	{0x0AF0,"$item_carpet_ZG                        ","Fancy Pink & Blue Rug"},
	{0x0AF1,"$item_carpet_ZH                        ","Fancy Pink & Blue Rug"},
	{0x0AF2,"$item_carpet_ZI                        ","Fancy Pink & Blue Rug"},
	{0x0AF3,"$item_carpet_ZJ                        ","Fancy Pink & Blue Rug"},
	{0x0AF4,"$item_carpet_ZK                        ","Fancy Pink & Blue Rug"},
	{0x0AF5,"$item_carpet_ZL                        ","Fancy Pink & Blue Rug"},
	{0x0AFA,"$item_carpet_ZM                        ","Fancy Pink & Blue Rug"},
	{0x181D,"$item_alchemical_symbol                ","Alchemical Symbol"},
	{0x181E,"$item_alchemical_symbol_1              ","Alchemical Symbol"},
	{0x181F,"$item_alchemical_symbol_2              ","Alchemical Symbol"},
	{0x1820,"$item_alchemical_symbol_3              ","Alchemical Symbol"},
	{0x1821,"$item_alchemical_symbol_4              ","Alchemical Symbol"},
	{0x1822,"$item_alchemical_symbol_5              ","Alchemical Symbol"},
	{0x1823,"$item_alchemical_symbol_6              ","Alchemical Symbol"},
	{0x1824,"$item_alchemical_symbol_7              ","Alchemical Symbol"},
	{0x1825,"$item_alchemical_symbol_8              ","Alchemical Symbol"},
	{0x1826,"$item_alchemical_symbol_9              ","Alchemical Symbol"},
	{0x1827,"$item_alchemical_symbol_A              ","Alchemical Symbol"},
	{0x1828,"$item_alchemical_symbol_B              ","Alchemical Symbol"}
}

#define NUM_CLOTHING 41
new __clothing[NUM_CLOTHING][additemEntry] =
{
	//Boots
	{0x170B,"$item_boots                            ","Boots"},
	{0x170D,"$item_sandles                          ","Sandals"},
	{0x170F,"$item_shoes                            ","Shoes"},
	{0x1711,"$item_thigh_boots                      ","Thigh boots"},
	//Hats
	{0x1713,"$item_floopy_hat                       ","Floppy hat"},
	{0x1714,"$item_wide_brim_hat                    ","Wide-brim hat"},
	{0x1715,"$item_cap                              ","Cap"},
	{0x1716,"$item_a_tall_straw_hat                 ","Tall straw hat"},
	{0x1717,"$item_straw_hat                        ","Straw hat"},
	{0x1718,"$item_a_wizards_hat                    ","Wizard's hat"},
	{0x1718,"$item_a_magical_wizard`s_hat           ","Magical hat"},
	{0x1719,"$item_bonnet                           ","Bonnet"},
	{0x171A,"$item_feathered_hat                    ","Feathered hat"},
	{0x171B,"$item_tricorne_hat                     ","Tricorne hat"},
	{0x171C,"$item_jester_hat                       ","Jester hat"},
	//Shirts & Robes
	{0x1515,"$item_cloak                            ","Cape"},
	{0x1EFD,"$item_fancy_shirt                      ","Fancy shirt"},
	{0x1517,"$item_shirt                            ","Plain shirt"},
	{0x1FFD,"$item_a_surcoat                        ","Surcoat"},
	{0x1FA1,"$item_a_tunic                          ","Tunic"},
	{0x1F03,"$item_a_robe                           ","Robe"},
	{0x1F9F,"$item_a_jesters_suit                   ","Fancy suit"},
	{0x1F7B,"$item_a_doublet                        ","Doublet"},
	{0x1EFF,"$item_a_fancy_dress                    ","Fancy Dress"},
	{0x1F01,"$item_a_plain_dress                    ","Plain Dress"},
	//Pants
	{0x1516,"$item_a_skirt                          ","Skirt"},
	{0x152E,"$item_short_pants                      ","Short pants"},
	{0x1537,"$item_a_kilt                           ","Kilt"},
	{0x1539,"$item_long_pants                       ","Long pants"},
	//Misc
	{0x153B,"$item_a_half_apron                     ","Half apron"},
	{0x153D,"$item_a_full_apron                     ","Full apron"},
	{0x1540,"$item_a_bandana                        ","Bandana"},
	{0x1541,"$item_a_body_sash                      ","Body sash"},
	{0x1544,"$item_a_skullcap                       ","Skullcap"},
	//Masks
	{0x1547,"$item_a_deer_mask                      ","Deer mask"},
	{0x1545,"$item_a_bear_mask                      ","Bear mask"},
	{0x1F0B,"$item_a_orc_helm                       ","Orc helm"},
	{0x141C,"$item_a_orc_mask                       ","Orc mask"},
	{0x1549,"$item_a_tribal_mask                    ","Tribal mask"},
	{0x154B,"$item_a_tribal_mask_1                  ","Voodoo mask"},
	{0x1546,"$item_polar_bear_mask                  ","Polar bear mask"}
}

#define NUM_JEWELS 60
new __jewels[NUM_JEWELS][additemEntry] =
{
	{0x100F,"$item_gold_key                         ","Gold Key"},
	{0x1010,"$item_iron_key                         ","Iron Key"},
	{0x1012,"$item_magic_key                        ","Magic Key"},
	{0x1013,"$item_bronze_key                       ","Bronze Key"},
	//Coins
	{0x0EEF,"$item_gold_coin                        ","Gold Pile"},
	{0x0EF2,"$item_silver_coin                      ","Silver Pile"},
	{0x0EEC,"$item_silver_coin                      ","Copper Pile"},
	//Jewelry
	{0x108B,"$item_beads                            ","Beads"},
	{0x1086,"$item_bracelet                         ","Bracelet"},
	{0x1087,"$item_earrings                         ","Earrings"},
	{0x1085,"$item_necklace                         ","Necklace"},
	{0x1088,"$item_necklace_1                       ","Necklace"},
	{0x1089,"$item_necklace_2                       ","Necklace"},
	{0x108A,"$item_ring                             ","Ring"},
	//Cut Gems
	{0x0F16,"$item_amethysts                        ","Amethyst"},
	{0x0F17,"$item_amethysts_1                      ","Amethyst"},
	{0x0F15,"$item_citrines                         ","Citrine"},
	{0x0F26,"$item_diamonds_4                       ","Diamond"},
	{0x0F10,"$item_emeralds                         ","Emerald"},
	{0x0F13,"$item_rubies                           ","Ruby"},
	{0x0F14,"$item_rubies_1                         ","Ruby"},
	{0x0F1A,"$item_rubies_2                         ","Ruby"},
	{0x0F1C,"$item_rubies_3                         ","Ruby"},
	{0x0F1D,"$item_rubies_4                         ","Ruby"},
	{0x0F11,"$item_sapphires                        ","Sapphire"},
	{0x0F12,"$item_sapphires_1                      ","Sapphire"},
	{0x0F19,"$item_sapphires_2                      ","Sapphire"},
	{0x0F1F,"$item_sapphires_3                      ","Sapphire"},
	{0x0F0F,"$item_star_sapphires                   ","Sapphire Star"},
	{0x0F1B,"$item_star_sapphires_1                 ","Sapphire Star"},
	{0x0F18,"$item_tourmalines                      ","Tourmaline"},
	{0x0F1E,"$item_tourmalines_1                    ","Tourmaline"},
	{0x0F20,"$item_tourmalines_2                    ","Tourmaline"},
	//UnCut Gems
	{0x0F25,"$item_pieces_of_amber                  ","Amber"},
	{0x0F22,"$item_amethysts_2                      ","Amethyst"},
	{0x0F2E,"$item_amethysts_3                      ","Amethyst"},
	{0x0F23,"$item_citrines_1                       ","Citrine"},
	{0x0F24,"$item_citrines_2                       ","Citrine"},
	{0x0F2C,"$item_citrines_3                       ","Citrine"},
	{0x0F27,"$item_diamonds                         ","Diamond"},
	{0x0F28,"$item_diamonds_1                       ","Diamond"},
	{0x0F29,"$item_diamonds_2                       ","Diamond"},
	{0x0F30,"$item_diamonds_3                       ","Diamond"},
	{0x0F2F,"$item_emeralds_1                       ","Emerald"},
	{0x0F2A,"$item_rubies_5                         ","Ruby"},
	{0x0F2B,"$item_rubies_6                         ","Ruby"},
	{0x0F21,"$item_star_sapphires_2                 ","Sapphire Star"},
	{0x0F2D,"$item_tourmalines_3                    ","Tourmaline"},
	//quest stones/gems
    	{0x1870,"$item_stone_of_compassion              ","Compassion"},
	{0x1C12,"$item_bell_of_courage                  ","Courage"},
	{0x186A,"$item_stone_of_honesty                 ","Honesty"},
	{0x186D,"$item_stone_of_honor                   ","Honor"},
	{0x1869,"$item_stone_of_humility                ","Humility"},
	{0x186B,"$item_stone_of_justice                 ","Justice"},
	{0x1C14,"$item_candle_of_love                   ","Love"},
	{0x186C,"$item_stone_of_sacrifice               ","Sacrifice"},
	{0x186F,"$item_stone_of_spirituality            ","Spirituality"},
	{0x186E,"$item_stone_of_valor                   ","Valor"},
	{0x1C13,"$item_book_of_truth                    ","Truth"},
	{0x1870,"$item_gem_of_immortality               ","Gem of Immortality"}
}

#define NUM_FURNITURE 174
new __furniture[NUM_FURNITURE][additemEntry] =
{
	{0x0B3F,"counter1_1                               ","counter"},
	{0x0B3D,"counter1_2                               ","counter"},
	{0x0B40,"counter2_1                               ","counter"},
	{0x0B3e,"counter2_2                               ","counter"},
	{0x0B4a,"writing_desk_1                           ","writing desk"},
	{0x0B4b,"writing_desk_2                           ","writing desk"},
	{0x0B4c,"writing_desk_3                           ","writing desk"},
	{0x0B49,"writing_desk_4                           ","writing desk"},
	{0x0B6E,"table_A1_1                               ","table"},
	{0x0B6F,"table_A1_2                               ","table"},
	{0x0B82,"table_A2_1                               ","table"},
	{0x0B81,"table_A2_2                               ","table"},
	{0x0B70,"table_B1_1                               ","table"},
	{0x0B71,"table_B1_2                               ","table"},
	{0x0B72,"table_B1_3                               ","table"},
	{0x0B73,"table_B1_4                               ","table"},
	{0x0B74,"table_B1_5                               ","table"},
	{0x0B83,"table_B2_1                               ","table"},
	{0x0B84,"table_B2_2                               ","table"},
	{0x0B85,"table_B2_3                               ","table"},
	{0x0B86,"table_B2_4                               ","table"},
	{0x0B87,"table_B2_5                               ","table"},
	{0x0B75,"table_C1_1                               ","table"},
	{0x0B76,"table_C1_2                               ","table"},
	{0x0B89,"table_C2_1                               ","table"},
	{0x0B88,"table_C2_2                               ","table"},
	{0x0B77,"table_D1_1                               ","table"},
	{0x0B78,"table_D1_2                               ","table"},
	{0x0B79,"table_D1_3                               ","table"},
	{0x0B7A,"table_D1_4                               ","table"},
	{0x0B7B,"table_D1_5                               ","table"},
	{0x0B8A,"table_D2_1                               ","table"},
	{0x0B8B,"table_D2_2                               ","table"},
	{0x0B8C,"table_D2_3                               ","table"},
	{0x0B8D,"table_D2_4                               ","table"},
	{0x0B8E,"table_D2_5                               ","table"},
	{0x0B7C,"table_E1                                 ","Table"},
	{0x0B8F,"table_E2                                 ","table"},
	{0x0b7d,"table_F1                                 ","table"},
	{0x0B90,"table_F2                                 ","table"},
	{0x0B34,"table_G1_1                               ","table"},
	{0x0B37,"table_G1_2                               ","table"},
	{0x0B35,"table_G2_1                               ","table"},
	{0x0B38,"table_G2_2                               ","table"},
	{0x0B6B,"table_H1_1                               ","table"},
	{0x0B6D,"table_H1_2                               ","table"},
	{0x0B6C,"table_H1_3                               ","table"},
	{0x0B7F,"table_H2_1                               ","table"},
	{0x0B80,"table_H2_2                               ","table"},
	{0x0B7E,"table_H2_3                               ","table"},
	{0x118b,"table_I                                  ","table"},
	{0x118c,"table_J                                  ","table"},
	{0x118d,"table_K                                  ","table"},
	{0x118e,"table_L                                  ","table"},
	{0x118f,"table_M1_1                               ","table"},
	{0x1190,"table_M1_2                               ","table"},
	{0x1191,"table_M2_1                               ","table"},
	{0x1192,"table_M2_2                               ","table"},
	{0x0A2A,"stool1                                   ","stool"},
	{0x0A2B,"stool2                                   ","stool"},
	{0x0B5F,"bench_A1_1                               ","bench"},
	{0x0B61,"bench_A1_2                               ","bench"},
	{0x0B60,"bench_A1_3                               ","bench"},
	{0x0B66,"bench_A2_2                               ","bench"},
	{0x0B67,"bench_A2_3                               ","bench"},
	{0x0B65,"bench_A2_1                               ","bench"},
	{0x0B62,"bench_B1_1                               ","bench"},
	{0x0B64,"bench_B1_2                               ","bench"},
	{0x0B63,"bench_B1_3                               ","bench"},
	{0x0B69,"bench_B2_1                               ","bench"},
	{0x0B6A,"bench_B2_2                               ","bench"},
	{0x0B68,"bench_B2_3                               ","bench"},
	{0x0B92,"bench_C1_1                               ","bench"},
	{0x0B91,"bench_C1_2                               ","bench"},
	{0x0B93,"bench_C2_1                               ","bench"},
	{0x0B94,"bench_C2_2                               ","bench"},
	{0x0B2C,"wooden_bench_D1                          ","wooden bench"},
	{0x0B2D,"wooden_bench_D2                          ","wooden bench"},
	{0x0B32,"throne1                                  ","throne"},
	{0x0B33,"throne2                                  ","throne"},
	{0x0B2E,"wooden_chair1_1                          ","wooden chair"},
	{0x0B2F,"wooden_chair1_2                          ","wooden chair"},
	{0x0B30,"wooden_chair1_3                          ","wooden chair"},
	{0x0B31,"wooden_chair1_4                          ","wooden chair"},
	{0x0B56,"wooden_chair2_1                          ","wooden chair"},
	{0x0B57,"wooden_chair2_2                          ","wooden chair"},
	{0x0B58,"wooden_chair2_3                          ","wooden chair"},
	{0x0B59,"wooden_chair2_4                          ","wooden chair"},
	{0x0B4E,"fancy_chair1_1                           ","fancy chair"},
	{0x0B4F,"fancy_chair1_2                           ","fancy chair"},
	{0x0B50,"fancy_chair1_3                           ","fancy chair"},
	{0x0B51,"fancy_chair1_4                           ","fancy chair"},
	{0x0B52,"fancy_chair2_1                           ","fancy chair"},
	{0x0B53,"fancy_chair2_2                           ","fancy chair"},
	{0x0B54,"fancy_chair2_3                           ","fancy chair"},
	{0x0B55,"fancy_chair2_4                           ","fancy chair"},
	{0x0B5A,"straw_chair1_1                           ","straw chair"},
	{0x0B5B,"straw_chair1_2                           ","straw chair"},
	{0x0B5C,"straw_chair1_3                           ","straw chair"},
	{0x0B5D,"straw_chair1_4                           ","straw chair"},
	{0x0A2C,"chest_of_drawers1_1                      ","chest of drawers"},
	{0x0A34,"chest_of_drawers1_2                      ","chest of drawers"},
	{0x0A30,"chest_of_drawers2_2                      ","fancy chest of drawers"},
	{0x0A38,"chest_of_drawers2_1                      ","fancy chest of drawers"},
	{0x0A97,"bookcase1_1                              ","bookcase"},
	{0x0A98,"bookcase1_2                              ","bookcase"},
	{0x0A9B,"bookcase1_3                              ","bookcase"},
	{0x0A99,"bookcase2_1                              ","bookcase"},
	{0x0A9A,"bookcase2_2                              ","bookcase"},
	{0x0A9C,"bookcase2_3                              ","bookcase"},
	{0x0A9D,"wooden_shelf1                            ","bookcase"},
	{0x0A9E,"wooden_shelf2                            ","bookcase"},
	{0x0a3c,"dresser1_2                               ","dresser"},
	{0x0a3d,"dresser1_1                               ","dresser"},
	{0x0a44,"dresser2_1                               ","dresser"},
	{0x0a45,"dresser2_2                               ","dresser"},
	{0x0A4D,"armoire1_1                               ","fancy armorie"},
	{0x0A51,"armoire1_2                               ","fancy armoire"},
	{0x0A4F,"armoire2_1                               ","armoire"},
	{0x0A53,"armoire2_2                               ","armoire"},
	{0x0a5d,"bed_headboard_A1_1                       ","bed"},
	{0x0a69,"bed_headboard_A1_2                       ","bed"},
	{0x0a6a,"bed_headboard_A1_3                       ","bed"},
	{0x0a60,"bed_headboard_A1_4                       ","bed"},
	{0x0a62,"bed_feet_A1_1                            ","bed"},
	{0x0a6b,"bed_feet_A1_2                            ","bed"},
	{0x0a61,"bed_feet_A1_3                            ","bed"},
	{0x0a63,"bed_headboard_A2_1                       ","bed"},
	{0x0a66,"bed_headboard_A2_2                       ","bed"},
	{0x0a67,"bed_headboard_A2_3                       ","bed"},
	{0x0a5e,"bed_headboard_A2_4                       ","bed"},
	{0x0a5c,"bed_feet_A2_1                            ","bed"},
	{0x0a68,"bed_feet_A2_2                            ","bed"},
	{0x0a5f,"bed_feet_A2_3                            ","bed"},
	{0x0a70,"bigbed_headleft_A1_1                     ","bed"},
	{0x0a84,"bigbed_headleft_A1_2                     ","bed"},
	{0x0a7a,"bigbed_headleft_A1_3                     ","bed"},
	{0x0a7c,"bigbed_headleft_A1_4                     ","bed"},
	{0x0a90,"bigbed_headleft_A1_5                     ","bed"},
	{0x0a8e,"bigbed_headleft_A1_6                     ","bed"},
	{0x0a71,"bigbed_feetleft_A1_1                     ","bed"},
	{0x0a86,"bigbed_feetleft_A1_2                     ","bed"},
	{0x0a78,"bigbed_feetleft_A1_3                     ","bed"},
	{0x0a8c,"bigbed_feetleft_A1_4                     ","bed"},
	{0x0a72,"bigbed_feetright_A1_1                    ","bed"},
	{0x0a87,"bigbed_feetright_A1_2                    ","bed"},
	{0x0a79,"bigbed_feetright_A1_3                    ","bed"},
	{0x0a8d,"bigbed_feetright_A1_4                    ","bed"},
	{0x0a73,"bigbed_headright_A1_1                    ","bed"},
	{0x0a85,"bigbed_headright_A1_2                    ","bed"},
	{0x0a7b,"bigbed_headright_A1_3                    ","bed"},
	{0x0a7d,"bigbed_headright_A1_4                    ","bed"},
	{0x0a91,"bigbed_headright_A1_5                    ","bed"},
	{0x0a8f,"bigbed_headright_A1_6                    ","bed"},
	{0x0a77,"bigbed_headleft_A2_1                     ","bed"},
	{0x0a89,"bigbed_headleft_A2_2                     ","bed"},
	{0x0a80,"bigbed_headleft_A2_3                     ","bed"},
	{0x0a83,"bigbed_headleft_A2_4                     ","bed"},
	{0x0db3,"bigbed_headleft_A2_5                     ","bed"},
	{0x0db5,"bigbed_headleft_A2_6                     ","bed"},
	{0x0a76,"bigbed_feetleft_A2_1                     ","bed"},
	{0x0a8b,"bigbed_feetleft_A2_2                     ","bed"},
	{0x0a7f,"bigbed_feetleft_A2_3                     ","bed"},
	{0x0db1,"bigbed_feetleft_A2_4                     ","bed"},
	{0x0a71,"bigbed_feetright_A2_1                    ","bed"},
	{0x0a8a,"bigbed_feetright_A2_2                    ","bed"},
	{0x0a7e,"bigbed_feetright_A2_3                    ","bed"},
	{0x0db0,"bigbed_feetright_A2_4                    ","bed"},
	{0x0a74,"bigbed_headright_A2_1                    ","bed"},
	{0x0a88,"bigbed_headright_A2_2                    ","bed"},
	{0x0a81,"bigbed_headright_A2_3                    ","bed"},
	{0x0a82,"bigbed_headright_A2_4                    ","bed"},
	{0x0db2,"bigbed_headright_A2_5                    ","bed"},
	{0x0db4,"bigbed_headright_A2_6                    ","bed"}
}

#define NUM_CARPENTER 89
new __carpenter[NUM_CARPENTER][additemEntry] = 
{
	{0x1BD7,"$item_boards                           ","board"},
	{0x1BE0,"$item_logs                             ","log"},
	{0x0F43,"$item_hatchet                          ","hatchet"},   
	{0x0F44,"$item_hatchet2                         ","hatchet"},
	{0x1026,"$item_chisel                           ","chisel"},
	{0x1027,"$item_chisel2                          ","chisel"},
	{0x1028,"$item_dovetail_saw                     ","dovetail saw"},
	{0x1029,"$item_dovetail_saw2                    ","dovetail saw"},
	{0x102A,"$item_hammer                           ",""},
	{0x102B,"$item_hammer2                          ",""},
	{0x102C,"$item_moulding_planes                  ",""},
	{0x102d,"$item_moulding_planes2                 ",""},
	{0x102E,"$item_nails                            ",""},
	{0x102f,"$item_nails2                           ",""},
	{0x1030,"$item_jointing_plane                   ",""},
	{0x1031,"$item_jointing_plane2                  ",""},
	{0x1032,"$item_smoothing_plane                  ",""},
	{0x1033,"$item_smoothing_plane2                 ",""},
	{0x1034,"$item_saw                              ",""},
	{0x1035,"$item_saw2                             ",""},
	{0x10E4,"$item_draw_knife                       ",""},
	{0x10E5,"$item_froe                             ",""},
	{0x10E6,"$item_inshave                          ",""},
	{0x10E7,"$item_scorp                            ",""},
	{0x19f1,"$item_woodworkers_bench1_1             ","woodworkers bench"},
	{0x19f2,"$item_woodworkers_bench1_2             ","woodworkers bench"},
	{0x19f3,"$item_woodworkers_bench1_3             ","woodworkers bench"},
	{0x19f8,"$item_vise1                            ","vise"},
	{0x19f7,"$item_woodworkers_bench2_1             ","woodworkers bench"},
	{0x19f6,"$item_woodworkers_bench2_2             ","woodworkers bench"},
	{0x19f5,"$item_woodworkers_bench2_3             ","woodworkers bench"},
	{0x19f4,"$item_vise2                            ","vise"},
	{0x19f9,"$item_coopers_bench1_1                 ","coopers bench"},
	{0x19fa,"$item_coopers_bench1_2                 ","coopers bench"},
	{0x19fb,"$item_coopers_bench2_1                 ","coopers bench"},
	{0x19fc,"$item_coopers_bench2_2                 ","coopers bench"},
	//Misc
	{0x0A9F,"$item_display_case_border_1            ","display case_border" },
	{0x0AA0,"$item_display_case_border_2            ","display case_border" },
	{0x0AA1,"$item_display_case_border_3            ","display case_border" },
	{0x0AA2,"$item_display_case_border_4            ","display case_border" },
	{0x0AA3,"$item_display_case_border_5            ","display case_border" },
	{0x0AA4,"$item_display_case_border_6            ","display case_border" },
	{0x0AA5,"$item_display_case_border_7            ","display case_border" },
	{0x0b18,"$item_display_case_border_8            ","display case_border" },
	{0x0Afd,"$item_display_case_border_9            ","display case_border" },
	{0x0Afe,"$item_display_case_border_10           ","display case_border" },
	{0x0Aff,"$item_display_case_border_11           ","display case_border" },
	{0x0b03,"$item_display_case_border_12           ","display case_border" },
	{0x0b04,"$item_display_case_border_13           ","display case_border" },
	{0x0b05,"$item_display_case_border_14           ","display case_border" },
	{0x0b0b,"$item_display_case_border_15           ","display case_border" },
	{0x0b0c,"$item_display_case_border_16           ","display case_border" },
	{0x0B00,"$item_display_case_1                   ","display case"},
	{0x0B01,"$item_display_case_2                   ","display case"},
	{0x0B02,"$item_display_case_3                   ","display case"},
	{0x0B06,"$item_display_case_4                   ","display case"},
	{0x0B07,"$item_display_case_5                   ","display case"},
	{0x0B08,"$item_display_case_6                   ","display case"},
	{0x0B09,"$item_display_case_7                   ","display case"},
	{0x0B0a,"$item_display_case_8                   ","display case"},
	{0x0B0d,"$item_display_case_9                   ","display case"},
	{0x0B0e,"$item_display_case_10                  ","display case"},
	{0x0B0f,"$item_display_case_11                  ","display case"},
	{0x0B10,"$item_display_case_12                  ","display case"},
	{0x0B11,"$item_display_case_13                  ","display case"},
	{0x0B12,"$item_display_case_14                  ","display case"},
	{0x0B13,"$item_display_case_15                  ","display case"},
	{0x0B14,"$item_display_case_16                  ","display case"},
	{0x0B15,"$item_display_case_17                  ","display case"},
	{0x0B16,"$item_display_case_18                  ","display case"},
	{0x0B17,"$item_display_case_19                  ","display case"},
	{0x0E3C,"$item_large_wooden_crate               ","large wooden crate"},
	{0x0E3E,"$item_medium_wooden_crate1             ","medium wooden crate"},
	{0x0e3f,"$item_medium_wooden_crate2             ","medium wooden crate"},
	{0x0E42,"$item_wooden_chest1                    ","wooden chest"},
	{0x0E43,"$item_wooden_chest2                    ","wooden chest"},
	{0x0E83,"$item_tub                              ","tub"},
	{0x0E77,"$item_barrel_without_lid               ","open barrel"},
	{0x0fae,"$item_barrel_with_lid                  ","closed barrel"},
	{0x1db8,"$item_barrel_lid                       ","a barrel lid"},
	{0x1eb2,"$item_barrel_staves                    ","barrel staves"},
	{0x1db7,"$item_barrel_hoops                     ","barrel hoops"},
	{0x10e1,"$item_barrel_hoops2                    ","barrel hoops"},
	{0x10e2,"$item_barrel_hoops3                    ","barrel hoops"},
	{0x0E7F,"$item_open_wooden_keg                  ","wooden keg"},
	{0x1940,"$item_wooden_keg1_1                    ","wooden keg"},        
	{0x1ad6,"$item_wooden_keg1_2                    ","wooden keg"},
	{0x1ad7,"$item_wooden_keg2_1                    ","wooden keg"},
	{0x14e0,"$item_bucket                           ","bucket"}
}

#define NUM_TAILOR 15
new __tailor[NUM_TAILOR][additemEntry] =
{
	{0x0FA9,"$item_dyes                             ","dyes"},
	{0x0FAB,"$item_a_dying_tub                      ","a dying tub"},
	{0x0F9D,"$item_sewing_kit                       ",""},
	{0x1766,"$item_cut_cloth                        ",""},
	{0x0F9E,"$item_scissors                         ",""},
	{0x101d,"$item_spinning_wheel                   ",""},
	{0x10A4,"$item_spinning_wheel_1                 ",""},
	{0x10A5,"$item_spinning_wheel_2                 ",""},
	{0x0DF8,"$item_piles_of_wool_1                  ",""},
	{0x0E1D,"$item_balls_of_yarn                    ",""},
	{0x0E1E,"$item_balls_of_yarn_1                  ",""},
	{0x0E1F,"$item_balls_of_yarn_2                  ",""},
	{0x0DF9,"$item_bales_of_cotton                  ",""},
	{0x0FA0,"$item_spools_of_thread_1               ",""},
	{0x0EC6,"$item_dress_form                       ",""}
}

#define NUM_BLACKSMITH 11
new __blacksmith[NUM_BLACKSMITH][additemEntry] =
{
	{0x0FB1,"$item_forge                            ",""},
	{0x0FAF,"$item_anvil                            ",""},
	{0x0FB0,"$item_anvil_1                          ",""},
	{0x197A,"$item_bellows                          ",""},
	{0x197E,"$item_forge_1                          ",""},
	{0x1982,"$item_forge_2                          ",""},
	{0x1986,"$item_bellows_2                        ",""},
	{0x198a,"$item_forge_5                          ",""},
	{0x198e,"$item_forge_6                          ",""},
	{0x0F39,"$item_shovel                           ",""},
	{0x1BF2,"$item_iron_ingots                      ",""}
}

#define NUM_MUSICIAN 7
new __musician[NUM_MUSICIAN][additemEntry] =
{
	{0x0E9C,"$item_drum                             ",""},
	{0x0E9D,"$item_tambourine                       ",""},
	{0x0E9E,"$item_tambourine_1                     ",""},
	{0x0EB1,"$item_standing_harp                    ",""},
	{0x0EB2,"$item_lap_harp                         ",""},
	{0x0EB3,"$item_lute                             ",""},
	{0x0EB4,"$item_lute_1                           ",""}
}

#define NUM_THIEF 1
new __thief[NUM_THIEF][additemEntry] =
{
	{0x14FB,"$item_lockpicks                        ",""}
}

#define NUM_FISHER 1
new __fisher[NUM_FISHER][additemEntry] =
{
	{0x0DBF,"$item_a_fishing_pole","Fishing Pole"}
}

#define NUM_TINKER 10
new __tinker[NUM_TINKER][additemEntry] =
{
	{0x104F,"$item_clock_parts                      ",""},
	{0x1051,"$item_axles_with_gears                 ",""},
	{0x1053,"$item_gears                            ",""},
	{0x1055,"$item_hinges                           ",""},
	{0x1059,"$item_sextant_parts                    ",""},
	{0x105B,"$item_axles                            ",""},
	{0x105D,"$item_springs                          ",""},
	{0x1EBC,"$item_tinkers_tools                    ",""},
	{0x104F,"$item_clock                            ","clock"},
	{0x104D,"$item_clock_frames                     ","clock frame"}
}

#define NUM_BOWYER 10
new __bowyer[NUM_BOWYER][additemEntry] =
{
	{0x100A,"$item_archery_butte                    ",""},
	{0x100B,"$item_archery_butte_1                  ",""},
	{0x1020,"$item_feathers_1                       ",""},
	{0x1021,"$item_feathers_2                       ",""},
	{0x1022,"$item_arrow_fletching                  ",""},
	{0x1023,"$item_arrow_fletching_1                ",""},
	{0x1024,"$item_arrow_shafts                     ",""},
	{0x1025,"$item_arrow_shafts_1                   ",""},
	{0x0F3F,"$item_arrow                            ",""},
	{0x1BFB,"$item_crossbow_bolt                    ",""}
}

#define NUM_SPAWNERS 114
new __spawners[NUM_SPAWNERS][additemEntry] =
{
	{INVALID,"$item_orc_lord_spawner                 ","orc lord spawner"},
	{INVALID,"$item_orc_spawner                      ","orc spawner"},
	{INVALID,"$item_orc_mage_spawner                 ","orc mage spawner"},
	{INVALID,"$item_ettin_spawner                    ","ettin spawner"},
	{INVALID,"$item_ogre_spawner                     ","ogre spawner"},
	{INVALID,"$item_troll_spawner                    ","troll spawner"},
	{INVALID,"$item_harpy_spawner                    ","harpy spawner"},
	{INVALID,"$item_banker_spawner-f                 ","female banker spawner"},
	{INVALID,"$item_bard_spawner-f                   ","female bard spawner"},
	{INVALID,"$item_bard_spawner-m                   ","male bard spawner"},
	{INVALID,"$item_miner_spawner-m                  ","male miner spawner"},
	{INVALID,"$item_miner_spawner-f                  ","female miner spawner"},
	{INVALID,"$item_weaponsmith_spawner-m            ","male weaponsmith spawner"},
	{INVALID,"$item_weaponsmith_spawner-f            ","female weaponsmith spawner"},
	{INVALID,"$item_baker_spawner-m                  ","male baker spawner"},
	{INVALID,"$item_baker_spawner-f                  ","female baker spawner"},
	{INVALID,"$item_provisioner_spawner-m            ","male provisioner spawner"},
	{INVALID,"$item_provisioner_spawner-f            ","female provisioner spawner"},
	{INVALID,"$item_cobbler_spawner-m                ","male cobbler spawner"},
	{INVALID,"$item_cobbler_spawner-f                ","female cobbler spawner"},
	{INVALID,"$item_innkeeper_spawner-m              ","male innkeeper spawner"},
	{INVALID,"$item_innkeeper_spawner-f              ","female innkeeper spawner"},
	{INVALID,"$item_mage_spawner-m                   ","male mage spawner"},
	{INVALID,"$item_mage_spawner-f                   ","female mage spawner"},
	{INVALID,"$item_herbalist_spawner-m              ","male herbalist spawner"},
	{INVALID,"$item_herbalist_spawner-f              ","female herbalist spawner"},
	{INVALID,"$item_butcher_spawner-m                ","male butcher spawner"},
	{INVALID,"$item_butcher_spawner-f                ","female butcher spawner"},
	{INVALID,"$item_tailor_spawner-m                 ","male tailor spawner"},
	{INVALID,"$item_tailor_spawner-f                 ","female tailor spawner"},
	{INVALID,"$item_bowyer_spawner-m                 ","male bowyer spawner"},
	{INVALID,"$item_bowyer_spawner-f                 ","female bowyer spawner"},
	{INVALID,"$item_jewler_spawner-m                 ","male jewler spawner"},
	{INVALID,"$item_jewler_spawner-f                 ","female jewler spawner"},
	{INVALID,"$item_leather_worker_spawner-m         ","male leather worker spawner"},
	{INVALID,"$item_leather_worker_spawner-f         ","female leather worker spawner"},
	{INVALID,"$item_shipwright_spawner-m             ","male shipwright spawner"},
	{INVALID,"$item_shipwright_spawner-f             ","female shipwright spawner"},
	{INVALID,"$item_spinner_spawner-m                ","male spinner spawner"},
	{INVALID,"$item_spinner_spawner-f                ","female spinner spawner"},
	{INVALID,"$item_armorer_spawner-m                ","male ar"},
	{INVALID,"$item_armorer_spawner-f                ","female ar"},
	{INVALID,"$item_blacksmith_spawner-m             ","male blacksmith spawner"},
	{INVALID,"$item_blacksmith_spawner-f             ","female blacksmith spawner"},
	{INVALID,"$item_architect_spawner-m              ","male architect spawner"},
	{INVALID,"$item_architect_spawner-f              ","female architect spawner"},
	{INVALID,"$item_carpenter_spawner-m              ","male carpenter spawner"},
	{INVALID,"$item_carpenter_spawner-f              ","female carpenter spawner"},
	{INVALID,"$item_farmer_spawner-m                 ","male farmer spawner"},
	{INVALID,"$item_farmer_spawner-f                 ","female farmer spawner"},
	{INVALID,"$item_cook_spawner-m                   ","male cook spawner"},
	{INVALID,"$item_cook_spawner-f                   ","female cook spawner"},
	{INVALID,"$item_animal_trainer_spawner-m         ","male animal trainer spawner"},
	{INVALID,"$item_animal_trainer_spawner-f         ","female animal trainer spawner"},
	{INVALID,"$item_fisherman_spawner                ","fisherman spawner"},
	{INVALID,"$item_fisherlady_spawner               ","fisherlady spawner"},
	{INVALID,"$item_alchemist_spawner-m              ","male alchemist spawner"},
	{INVALID,"$item_alchemist_spawner-f              ","female alchemist spawner"},
	{INVALID,"$item_tinker_spawner-m                 ","male tinker spawner"},
	{INVALID,"$item_tinker_spawner-f                 ","female tinker spawner"},
	{INVALID,"$item_engineer_spawner-m               ","male engineer spawner"},
	{INVALID,"$item_engineer_spawner-f               ","female engineer spawner"},
	{INVALID,"$item_banker_spawner-m                 ","male banker spawner"},
	{INVALID,"$item_random_orc_spawn                 ","random orc spawn"},
	{INVALID,"$item_random_lizard_spawn              ","random lizard spawn"},
	{INVALID,"$item_random_ratmen_rpawn              ","random ratmen rpawn"},
	{INVALID,"$item_random_dragon_and_drake          ","random dragon and drake"},
	{INVALID,"$item_random_cows_horses_etc           ","random cows horses etc"},
	{INVALID,"$item_goat_spawner                     ","goat spawner"},
	{INVALID,"$item_random_arctic_spawner            ","random arctic spawner"},
	{INVALID,"$item_random_cave_spawner              ","random cave spawner"},
	{INVALID,"$item_random_desert_spawner            ","random desert spawner"},
	{INVALID,"$item_random_dungeon_spawner           ","random dungeon spawner"},
	{INVALID,"$item_random_eerie_place_spawner       ","random eerie place spawner"},
	{INVALID,"$item_random_farm_spawner              ","random farm spawner"},
	{INVALID,"$item_random_forest_spawner            ","random forest spawner"},
	{INVALID,"$item_random_jungle_spawner            ","random jungle spawner"},
	{INVALID,"$item_random_mountain_spawner          ","random mountain spawner"},
	{INVALID,"$item_random_ocean_spawner             ","random ocean spawner"},
	{INVALID,"$item_random_swamp_spawner             ","random swamp spawner"},
	{INVALID,"$item_random_town_spawner              ","random town spawner"},
	{INVALID,"$item_random_volcanic_spawner          ","random volcanic spawner"},
	{INVALID,"$item_random_drow_spawner              ","random drow spawner"},
	{INVALID,"$item_random_diablo_spawner            ","random diablo spawner"},
	{INVALID,"$item_random_wood_elves_spawner        ","random wood elves spawner"},
	{INVALID,"$item_random_high_elves_spawner        ","random high elves spawner"},
	{INVALID,"$item_town_crier_spawner-m             ","male town crier spawner"},
	{INVALID,"$item_town_crier_spawner-f             ","female town crier spawner"},
	{INVALID,"$item_register_of_names                ","Register of names"},
	{INVALID,"$item_random_cowshorsesect             ","random cowshorsesect"},
	{INVALID,"$item_random_dragon_and_drake_1        ","random dragon and drake"},
	{INVALID,"$item_random_ratmen                    ","random ratmen"},
	{INVALID,"$item_random_lizzardmen                ","random lizzardmen"},
	{INVALID,"$item_random_orcs                      ","random orcs"},
	{INVALID,"$item_random_birds                     ","random birds"},
	{INVALID,"$item_random_all_animals               ","random all animals"},
	{INVALID,"$item_random_small_animals             ","random small animals"},
	{INVALID,"$item_random_productive_animals        ","random productive animals"},
	{INVALID,"$item_random_bears                     ","random bears"},
	{INVALID,"$item_random_overworld_monsters        ","random overworld monsters"},
	{INVALID,"$item_random_strong_undead             ","random strong undead"},
	{INVALID,"$item_random_weak_undead               ","random weak undead"},
	{INVALID,"$item_random_all_undead                ","random all undead"},
	{INVALID,"$item_random_daemons                   ","random daemons"},
	{INVALID,"$item_random_elementals                ","random elementals"},
	{INVALID,"$item_random_elementals_and_daemons    ","random elementals and daemons"},
	{INVALID,"$item_random_ettinsogres_and_trolls    ","random ettinsogres and trolls"},
	{INVALID,"$item_random_med_orcs                  ","random med orcs"},
	{INVALID,"$item_random_weaker_orcs               ","random weaker orcs"},
	{INVALID,"$item_random_crc-kin                   ","random crc"},
	{INVALID,"$item_town_area_spawner                ","town area spawner"},
	{INVALID,"$item_swamp_area_spawner               ","swamp area spawner"},
	{INVALID,"$item_jungle_area_spawner              ","jungle area spawner"},
	{INVALID,"$item_cocoon_spawner                   ","cocoon spawner"}
}

#define NUM_DEEDS 48
new __deeds[NUM_DEEDS][additemEntry]
/*=
{
	{INVALID,"$item_lighthouse_deed                  ","lighthouse deed" },
	{INVALID,"$item_telescope_deed                   ","telescope deed" },
	{INVALID,"$item_arbitoir_deed                    ","arbitoir deed" },
	{INVALID,"$item_deed                             ","deed" },
	{INVALID,"$item_small_tower_deed                 ","small tower deed" },
	{INVALID,"$item_small_marble_shop_deed           ","small marble shop deed" },
	{INVALID,"$item_farm_house_deed                  ","farm house deed" },
	{INVALID,"$item_small_stone_shop_deed            ","small stone shop deed" },
	{INVALID,"$item_2-story_villa_deed               ","2-story villa deed" },
	{INVALID,"$item_sandstone_patio_house_deed       ","sandstone patio house deed" },
	{INVALID,"$item_large_marble_patio_house_deed    ","large marble patio house deed" },
	{INVALID,"$item_employment_deed                  ","employment deed" },
	{INVALID,"$item_christmas_tree_deed              ","christmas tree deed" },
	{INVALID,"$item_dartboard_deed                   ","Dartboard Deed" },
	{INVALID,"$item_dartboard_deed_1                 ","Dartboard Deed" },
	{INVALID,"$item_trashcan_deed                    ","Trashcan Deed" },
	{INVALID,"$item_townstone_deed                   ","townstone deed" },
	{INVALID,"$item_small_stone_plaster_house_deed   ","small stone & plaster house deed" },
	{INVALID,"$item_small_stone_house_deed           ","small stone house deed" },
	{INVALID,"$item_small_brick_house_deed           ","small brick house deed" },
	{INVALID,"$item_small_wood_house_deed            ","small wood house deed" },
	{INVALID,"$item_small_wood_plaster_house_deed    ","small wood & plaster house deed" },
	{INVALID,"$item_small_wood_house_straw_roof_deed ","small wood house with straw roof deed" },
	{INVALID,"$item_blue_tent_deed                   ","blue tent deed" },
	{INVALID,"$item_green_tent_deed                  ","green tent deed" },
	{INVALID,"$item_3_room_brick_house_deed          ","3 room brick house deed" },
	{INVALID,"$item_2_story_wood_plaster_house_deed  ","2 story wood & plaster house deed" },
	{INVALID,"$item_2_story_stone_plaster_house_deed ","2 story stone & plaster house deed" },
	{INVALID,"$item_tower_deed                       ","tower deed" },
	{INVALID,"$item_keep_deed                        ","keep deed" },
	{INVALID,"$item_4_room_house_deed                ","4 room house deed" },
	{INVALID,"$item_castle_deed                      ","castle deed" },
	{INVALID,"$item_large_smithy_deed                ","large smithy deed" },
	{INVALID,"$item_a_forge_deed                     ","a forge deed" },
	{INVALID,"$item_anvil_1_deed                     ","an anvil deed (facing south)" },
	{INVALID,"$item_anvil_2_deed          _          ","an anvil deed (facing east)" },
	{INVALID,"$item_a_spinning_wheel_deed_facing_south_","a spinning wheel deed (facing south)" },
	{INVALID,"$item_archery_butte_deed_facing_east_  ","an archery butte deed (facing east)" },
	{INVALID,"$item_archery_butte_deed_facing_south_ ","an archery butte deed (facing south)" },
	{INVALID,"$item_a_training_dummy_deed_facing_south_","a training dummy deed (facing south)" },
	{INVALID,"$item_a_training_dummy_deed_facing_east_ ","a training dummy deed (facing east)" },
	{INVALID,"$item_a_pickpocket_dip_deed_facing_south_","a pickpocket dip deed (facing south)" },
	{INVALID,"$item_a_pickpocket_dip_deed_facing_east_ ","a pickpocket dip deed (facing east)" },
	{INVALID,"$item_pentagram_deed                     ","pentagram deed" },
	{INVALID,"$item_a_cannon_deed                      ","a cannon deed" },
	{INVALID,"$item_a_large_forge_facing_south_deed    ","a large forge facing south deed" },
	{INVALID,"$item_a_large_forge_facing_east_deed     ","a large forge facing east deed" },
	{INVALID,"$item_a_skull_candle_deed                ","a skull candle deed" }
}*/
/*! }@ */