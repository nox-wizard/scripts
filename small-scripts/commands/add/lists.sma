/*!
\defgroup script_command_add_lists items and NPCs lists
\ingroup script_commands_add

@{
*/

enum additemEntry
{
	__ID,
	__def: 40,
	__name: 30,
	
};

#define NUM_MAGICAL_ITEMS 4
new magicalItems[NUM_MAGICAL_ITEMS][additemEntry] =
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
	
	//spears/forks/pole arms
	{0x0F62,"                                       ","short_spear"},
	{0x1405,"                                       ","war_fork"},
	{0x0F62,"                                       ","spear"},
	{0x0F42,"                                       ","bardiche"},
	{0x143E,"                                       ","halberd"},
	{INVALID,"                                       ",""},
	{INVALID,"                                       ",""},
	{INVALID,"                                       ",""}
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
	{0x099F,"$item_bottle_of_ale                    ","Bottle of Ale"},
	{0x09A0,"$item_bottles_of_ale                   ","Bottles of Ale"},
	{0x09A1,"$item_bottles_of_ale_1                 ","Bottles of Ale"},
	{0x09A2,"$item_bottles_of_ale_2                 ","Bottles of Ale"},
	{0x099B,"$item_bottle_of_liquor                 ","Bottle of Liquor"},
	{0x099C,"$item_bottles_of_liquor                ","Bottles of Liquor"},
	{0x099D,"$item_bottles_of_liquor_1              ","Bottles of Liquor"},
	{0x099E,"$item_bottles_of_liquor_2              ","Bottles of Liquor"},
	{0x09C7,"$item_bottle_of_wine                   ","Bottle of Wine"},
	{0x09C6,"$item_bottles_of_wine                  ","Bottles of Wine"},
	{0x09C5,"$item_bottles_of_wine                  ","Bottles of Wine"},
	{0x09C4,"$item_bottles_of_wine_2                ","Bottles of Wine"},
	{0x0FFA,"$item_bucket_of_water                  ","Bucket of Water"},
	{0x09EE,"$item_mug_of_ale                       ","Glass of Ale"},
	{0x1F7D,"$item_glass_of_cider                   ","Glass of Cider"},
	{0x1F85,"$item_glass_of_liquor                  ","Glass of Liquor"},
	{0x1F89,"$item_glass_of_milk                    ","Glass of Milk"},
	{0x1F91,"$item_glass_of_water                   ","Glass of Water"},
	{0x1F8D,"$item_glass_of_wine                    ","Glass of Wine"},
	{0x098E,"$item_jugs_of_cider                    ","Jugs of Cider"},
	{0x098D,"$item_jugs_of_cider_1                  ","Jugs of Cider"},
	{0x1F95,"$item_pitcher_of_ale                   ","Pitcher of Ale"},
	{0x1F97,"$item_pitcher_of_cider                 ","Pitcher of Cider"},
	{0x1F99,"$item_pitcher_of_liquor                ","Pitcher of Liquor"},
	{0x09AD,"$item_pitcher_of_milk                  ","Pitcher of Milk"},
	{0x0FF9,"$item_pitcher_of_water                 ","Pitcher of Water"},
	{0x1F9B,"$item_pitcher_of_wine                  ","Pitcher of Wine"}
}    

#define NUM_BAKED 36
new __bakedAndVeggys[NUM_BAKED][additemEntry] =
{    
	//Baked and Veggys
	{0x1041,"$item_baked_pie                        ","Baked Pie"},
	{0x1042,"$item_unbaked_pie                      ","Unbaked Pie"},
	{0x09E9,"$item_cake                             ","Cake"},
	{0x097C,"$item_wedges_of_cheese                 ","Wedge of Cheese"},
	{0x097D,"$item_wedges_of_cheese_1               ","Cut Cheese"},
	{0x097E,"$item_wheels_of_cheese                 ","Wheel of Cheese"},
	{0x098C,"$item_french_bread                     ","French Bread"},
	{0x09EA,"$item_muffins                          ","Muffin"},
	{0x09FA,"$item_muffins_1                        ","Muffins"},
	{0x09EB,"$item_muffins_2                        ","Muffins"},
	{0x103C,"$item_bread_loaves                     ","Loaf of Bread"},
	{0x1040,"$item_pizzas                           ","Pizza"},
	{0x1083,"$item_uncooked_pizza                   ","Unbaked Pizza"},
	{0x160B,"$item_pan_of_cookies                   ","Pan of Cookies"},
	{0x160C,"$item_plate_of_cookies                 ","Plate of Cookies"},
	{0x09B4,"$item_eggshells                        ","Eggshells"},
	{0x09B5,"$item_eggs                             ","Eggs"},
	{0x09B6,"$item_fried_eggs                       ","Fried Eggs"},
	{0x103F,"$item_cookie_mix                       ","Cookie Mix"},
	{0x10E3,"$item_dough_bowl                       ","Dough"},
	{0x15FE,"$item_bowl_of_carrots                  ","Carrots"},
	{0x15FF,"$item_bowl_of_corn                     ","Corn"},
	{0x1600,"$item_bowl_of_lettuce                  ","Lettuce"},
	{0x1601,"$item_bowl_of_peas                     ","Peas"},
	{0x1602,"$item_bowl_of_potatoes                 ","Potatoes"},
	{0x1604,"$item_bowl_of_stew                     ","Stew"},
	{0x1606,"$item_tomato_soup                      ","Tomato Soup"},
	{0x15FD,"$item_pewter_bowl                      ","Pewter"},
	{0x09B7,"$item_cooked_birds                     ","Cooked Bird"},
	{0x09BB,"$item_roast_pigs                       ","Roast Pig"},
	{0x09C0,"$item_sausages                         ","Sausages"},
	{0x09C9,"$item_hams                             ","Ham"},
	{0x09F2,"$item_cuts_of_ribs                     ","Ribs"},
	{0x097B,"$item_fish_steaks                      ","Fish Steak"},
	{0x0976,"$item_slabs_of_bacon                   ","Slabs of Bacon"},
	{0x0978,"$item_slices_of_bacon                  ","Slice of Bacon"}
}

#define NUM_BOWLSMEATFRUIT 28
new __bowlsMeatFruit[NUM_BOWLSMEATFRUIT][additemEntry] =
{
	//Bowls, meat, fruit
	{0x0994,"$item_pears                            ","Pear"},
	{0x09D0,"$item_apples                           ","Apple"},
	{0x09D1,"$item_grape_bunches                    ","Grape Bunch"},
	{0x09D2,"$item_peaches                          ","Peach"},
	{0x0993,"$item_fruit_basket                     ","Fruit Basket"},
	{0x1726,"$item_coconuts                         ","Coconut"},
	{0x1720,"$item_banana                           ","Banana"},
	{0x1721,"$item_banana                           ","Bananas"},
	{0x1727,"$item_bunches_of_dates                 ","Dates"},
	{0x1728,"$item_lemons                           ","Lemon"},
	{0x1729,"$item_lemons_1                         ","Lemons"},
	{0x172A,"$item_limes                            ","Lime"},
	{0x172B,"$item_limes_1                          ","Limes"},
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
    
#define NUM_DOORS 44
new __doors[NUM_DOORS][additemEntry] =
{
	//Metal Door 1
	{0x0675,"$item_a_metal_door                     ","West Door"},
	{0x0677,"$item_a_metal_door_1                   ","East Door"},
	{0x067D,"$item_a_metal_door_2                   ","South Door"},
	{0x067F,"$item_a_metal_door_3                   ","North Door"},
	//Barred Metal Door
	{0x0685,"$item_a_barred_metal_door              ","West Door"},
	{0x0687,"$item_barred_metal_door                ","East Door"},
	{0x068D,"$item_barred_metal_door_1              ","South Door"},
	{0x068F,"$item_barred_metal_door_2              ","North Door"},
	//Rattan Door
	{0x0695,"$item_rattan_door                      ","West Door"},
	{0x0697,"$item_rattan_door_1                    ","East Door"},
	{0x069D,"$item_rattan_door_2                    ","South Door"},
	{0x069F,"$item_rattan_door_3                    ","North Door"},
	//Wooden Door 1
	{0x06A5,"$item_wooden_door                      ","West Door"},
	{0x06A7,"$item_wooden_door_1                    ","East Door"},
	{0x06AD,"$item_wooden_door_2                    ","South Door"},
	{0x06AF,"$item_wooden_door_3                    ","North Door"},
	//Wooden Door 2
	{0x06B5,"$item_wooden_door_4                    ","West Door"},
	{0x06B7,"$item_wooden_door_5                    ","East Door"},
	{0x06BD,"$item_wooden_door_6                    ","South Door"},
	{0x06BF,"$item_wooden_door_7                    ","North Door"},
	//Metal Door 2
	{0x06C5,"$item_metal_door                       ","West Door"},
	{0x06C7,"$item_metal_door_1                     ","East Door"},
	{0x06CD,"$item_metal_door_2                     ","South Door"},
	{0x06CF,"$item_metal_door_3                     ","North Door"},
	//Wooden Door 3
	{0x06D5,"$item_wooden_door_8                    ","West Door"},
	{0x06D7,"$item_wooden_door_9                    ","East Door"},
	{0x06DD,"$item_wooden_door_A                    ","South Door"},
	{0x06DF,"$item_wooden_door_B                    ","North Door"},
	//Wooden Door 4
	{0x06E5,"$item_wooden_door_C                    ","West Door"},
	{0x06E7,"$item_wooden_door_D                    ","East Door"},
	{0x06ED,"$item_wooden_door_E                    ","South Door"},
	{0x06EF,"$item_wooden_door_F                    ","North Door"},
	//Wooden Gate 1
	{0x0839,"$item_wooden_gate                      ","West Door"},
	{0x083B,"$item_wooden_gate_1                    ","East Door"},
	{0x0841,"$item_wooden_gate_2                    ","South Door"},
	{0x0843,"$item_wooden_gate_3                    ","North Door"},
	//Iron Gate
	{0x084C,"$item_iron_gate                        ","West Door"},
	{0x084E,"$item_iron_gate_1                      ","East Door"},
	{0x0854,"$item_iron_gate_2                      ","South Door"},
	{0x0856,"$item_iron_gate_3                      ","North Door"},
	//Wooden Gate 2
	{0x0866,"$item_wooden_gate_4                    ","West Door"},
	{0x0868,"$item_wooden_gate_5                    ","East Door"},
	{0x086E,"$item_wooden_gate_6                    ","South Door"},
	{0x0870,"$item_wooden_gate_7                    ","North Door"}
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


#define NUM_SIGNS 69
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
	//Misc Signs
	{0x0BCF,"$item_wooden_sign                      ","Wooden Sign"},
	{0x0BD0,"$item_wooden_sign_1                    ","Wooden Sign"},
	{0x0BD1,"$item_brass_sign                       ","Brass Sign"},
	{0x0BD2,"$item_brass_sign_1                     ","Brass Sign"},
	{0x1F29,"$item_sign                             ","Sign"},
	{0x1F28,"$item_sign_1                           ","Sign"}
}


#define NUM_FLOORS 123
new __floors[NUM_FLOORS][additemEntry] =
{
	//Marble 1
	{0x0491,"$item_floor_tile                       ","Marble"},
	{0x0492,"$item_floor_tile_1                     ","Marble"},
	{0x0493,"$item_floor_tile_2                     ","Marble"},
	{0x0494,"$item_floor_tile_3                     ","Marble"},
	{0x0495,"$item_marble_floor                     ","Marble"},
	{0x0496,"$item_marble_floor_1                   ","Marble"},
	{0x0497,"$item_marble_floor_2                   ","Marble"},
	{0x0498,"$item_marble_floor_3                   ","Marble"},
	{0x049B,"$item_floor_tile_4                     ","Marble"},
	//Marble 2
	{0x049C,"$item_grey_slate_tile                  ","Marble"},
	{0x050D,"$item_marble_floor_4                   ","Marble"},
	{0x050E,"$item_white_marble                     ","Marble"},
	{0x050F,"$item_green_marble_floor               ","Marble"},
	{0x0510,"$item_green_marble_floor_1             ","Marble"},
	{0x0511,"$item_marble_floor_5                   ","Marble"},
	{0x0512,"$item_marble_floor_6                   ","Marble"},
	{0x0513,"$item_marble_floor_7                   ","Marble"},
	{0x0514,"$item_marble_floor_8                   ","Marble"},
	//Sandstone Pavers
	{0x049D,"$item_sandstone_floor                  ","Sandstone Pavers"},
	{0x049E,"$item_sandstone_floor_1                ","Sandstone Pavers"},
	{0x049F,"$item_sandstone_floor_2                ","Sandstone Pavers"},
	{0x04A0,"$item_sandstone_floor_3                ","Sandstone Pavers"},
	//Wooden Planks
	{0x04A1,"$item_wooden_planks                    ","Wooden Planks"},
	{0x04A2,"$item_wooden_planks_1                  ","Wooden Planks"},
	{0x04A3,"$item_wooden_planks_2                  ","Wooden Planks"},
	{0x04A4,"$item_wooden_planks_3                  ","Wooden Planks"},
	//Wooden Boards 1
	{0x04A5,"$item_wooden_boards                    ","Wooden Boards"},
	{0x04A6,"$item_wooden_boards_1                  ","Wooden Boards"},
	{0x04A7,"$item_wooden_boards_2                  ","Wooden Boards"},
	{0x04A8,"$item_wooden_boards_3                  ","Wooden Boards"},
	{0x04A9,"$item_wooden_boards_4                  ","Wooden Boards"},
	{0x04AA,"$item_wooden_boards_5                  ","Wooden Boards"},
	{0x04AB,"$item_wooden_boards_6                  ","Wooden Boards"},
	{0x04AC,"$item_wooden_boards_7                  ","Wooden Boards"},
	{0x04AD,"$item_wooden_boards_8                  ","Wooden Boards"},
	{0x04AE,"$item_wooden_boards_9                  ","Wooden Boards"},
	{0x04AF,"$item_wooden_boards_A                  ","Wooden Boards"},
	{0x04B0,"$item_wooden_boards_B                  ","Wooden Boards"},
	{0x04B1,"$item_wooden_boards_C                  ","Wooden Boards"},
	{0x04B2,"$item_wooden_boards_D                  ","Wooden Boards"},
	//Wooden Boards 2
	{0x04B3,"$item_wooden_boards_E                  ","Wooden Boards"},
	{0x04B4,"$item_wooden_boards_F                  ","Wooden Boards"},
	{0x04B5,"$item_wooden_boards_G                  ","Wooden Boards"},
	{0x04B6,"$item_wooden_boards_H                  ","Wooden Boards"},
	{0x04B7,"$item_wooden_boards_I                  ","Wooden Boards"},
	{0x04B8,"$item_wooden_boards_J                  ","Wooden Boards"},
	{0x04B9,"$item_wooden_boards_K                  ","Wooden Boards"},
	{0x04BA,"$item_wooden_boards_L                  ","Wooden Boards"},
	{0x04BB,"$item_wooden_boards_M                  ","Wooden Boards"},
	{0x04BC,"$item_wooden_boards_N                  ","Wooden Boards"},
	{0x04BD,"$item_wooden_boards_O                  ","Wooden Boards"},
	{0x04BE,"$item_wooden_boards_P                  ","Wooden Boards"},
	{0x04BF,"$item_wooden_boards_Q                  ","Wooden Boards"},
	{0x04C0,"$item_wooden_boards_R                  ","Wooden Boards"},
	//Bricks
	{0x04E2,"$item_bricks                           ","Bricks"},
	{0x04E3,"$item_bricks_1                         ","Bricks"},
	{0x04E4,"$item_bricks_2                         ","Bricks"},
	{0x04E5,"$item_bricks_3                         ","Bricks"},
	{0x04E6,"$item_bricks_4                         ","Bricks"},
	{0x04E7,"$item_bricks_5                         ","Bricks"},
	{0x04E8,"$item_bricks_6                         ","Bricks"},
	{0x04E9,"$item_bricks_7                         ","Bricks"},
	//Cobble & Flagstones
	{0x04FC,"$item_flagstones                       ","Flagstones"},
	{0x04FD,"$item_flagstones_1                     ","Flagstones"},
	{0x04FE,"$item_flagstones_2                     ","Flagstones"},
	{0x04FF,"$item_flagstones_3                     ","Flagstones"},
	{0x0515,"$item_cobblestones                     ","Cobblestones"},
	{0x0516,"$item_cobblestones_1                   ","Cobblestones"},
	{0x0517,"$item_cobblestones_2                   ","Cobblestones"},
	{0x0518,"$item_cobblestones_3                   ","Cobblestones"},
	//Wooden Logs
	{0x04C1,"$item_wooden_logs                      ","Wooden Logs"},
	{0x04C2,"$item_wooden_logs_1                    ","Wooden Logs"},
	{0x04C3,"$item_wooden_logs_2                    ","Wooden Logs"},
	{0x04C4,"$item_wooden_logs_3                    ","Wooden Logs"},
	{0x04C5,"$item_wooden_logs_4                    ","Wooden Logs"},
	{0x0504,"$item_wooden_logs_5                    ","Wooden Logs"},
	{0x0505,"$item_wooden_logs_6                    ","Wooden Logs"},
	{0x0506,"$item_wooden_logs_7                    ","Wooden Logs"},
	{0x0507,"$item_wooden_logs_8                    ","Wooden Logs"},
	{0x0508,"$item_wooden_logs_9                    ","Wooden Logs"},
	{0x0509,"$item_wooden_logs_A                    ","Wooden Logs"},
	{0x050A,"$item_wooden_logs_B                    ","Wooden Logs"},
	{0x050B,"$item_wooden_logs_C                    ","Wooden Logs"},
	{0x050C,"$item_wooden_logs_D                    ","Wooden Logs"},
	//Stone Pavers
	{0x0519,"$item_stone_floor                      ","Stone Pavers"},
	{0x051A,"$item_stone_floor_1                    ","Stone Pavers"},
	{0x051B,"$item_stone_floor_2                    ","Stone Pavers"},
	{0x051C,"$item_stone_floor_3                    ","Stone Pavers"},
	{0x051D,"$item_stone_floor_4                    ","Stone Pavers"},
	{0x051E,"$item_stone_floor_5                    ","Stone Pavers"},
	{0x051F,"$item_stone_floor_6                    ","Stone Pavers"},
	{0x0520,"$item_stone_floor_7                    ","Stone Pavers"},
	//Red & Blue Tiles
	{0x04EA,"$item_blue_tiles                       ","Blue Tile"},
	{0x04EB,"$item_blue_tiles_1                     ","Blue Tile"},
	{0x04EC,"$item_blue_tiles_3                     ","Blue Tile"},
	{0x04ED,"$item_blue_tiles_4                     ","Blue Tile"},
	{0x04EE,"$item_blue_tiles_5                     ","Blue Tile"},
	{0x04EF,"$item_blue_tiles_6                     ","Blue Tile"},
	{0x04F0,"$item_blue_tiles_7                     ","Blue Tile"},
	{0x04F1,"$item_blue_tiles_8                     ","Blue Tile"},
	{0x04F2,"$item_red_tiles                        ","Blue Tile"},
	{0x04F3,"$item_red_tiles_1                      ","Blue Tile"},
	{0x04F4,"$item_red_tiles_2                      ","Red Tile"},
	{0x04F5,"$item_red_tiles_3                      ","Red Tile"},
	{0x04F6,"$item_red_tiles_4                      ","Red Tile"},
	{0x04F7,"$item_red_tiles_5                      ","Red Tile"},
	{0x04F8,"$item_red_tiles_6                      ","Red Tile"},
	{0x04F9,"$item_red_tiles_7                      ","Red Tile"},
	{0x04FA,"$item_red_tiles_8                      ","Red Tile"},
	{0x04FB,"$item_flagstone                        ","Red Tile"},
	//Sandstone Floors 
	{0x0526,"$item_sandstone_floor_4                ","Sandstone Floor"},
	{0x0527,"$item_sandstone_floor_5                ","Sandstone Floor"},
	{0x0528,"$item_sandstone_floor_6                ","Sandstone Floor"},
	{0x0529,"$item_sandstone_floor_7                ","Sandstone Floor"},
	{0x052A,"$item_sandstone_floor_8                ","Sandstone Floor"},
	{0x052B,"$item_sandstone_floor_9                ","Sandstone Floor"},
	{0x052C,"$item_sandstone_floor_A                ","Sandstone Floor"},
	{0x052F,"$item_sandstone_floor_B                ","Sandstone Floor"},
	{0x0530,"$item_sandstone_floor_C                ","Sandstone Floor"},
	{0x0531,"$item_sandstone_floor_D                ","Sandstone Floor"},
	{0x0532,"$item_sandstone_floor_E                ","Sandstone Floor"},
	{0x0533,"$item_sandstone_floor_F                ","Sandstone Floor"},
	{0x0534,"$item_sandstone_floor_G                ","Sandstone Floor"}
}

#define NUM_WALLS 101
new __walls[NUM_WALLS][additemEntry] = 
{
	//Wooden Walls I
	{0x0006,"$item_wooden_wall                      ","SE Corner"},
	{0x0010,"$item_wooden_wall_7                    ","SE Corner Small"},
	{0x0014,"$item_wooden_wall_A                    ","SE Corner Really Small"},
	{0x0007,"$item_wooden_wall_1                    ","E-W Wall"},
	{0x000a,"$item_wooden_wall_3                    ","E-W Wall"},
	{0x000c,"$item_wooden_wall_5                    ","E-W Wall"},
	{0x000e,"$item_window                           ","E-W Wall with Window"},
	{0x0012,"$item_wooden_wall_9                    ","E-W Small Wall"},
	{0x0016,"$item_wooden_wall_C                    ","E-W Really Small Wall"},
	//Stone Walls I
	{0x001A,"$item_stone_wall                       ","SE Corner"},
	{0x0024,"$item_stone_wall_8                     ","SE Small Corner"},
	{0x002D,"$item_stone_wall_C                     ","Really Small SE Corner"},
	{0x001C,"$item_stone_wall_2                     ","E-W Wall"},
	{0x001E,"$item_stone_wall_4                     ","E-W Wall with Wood"},
	{0x0021,"$item_stone_wall_7                     ","E-W Wall with Wood"},
	{0x0022,"$item_window_2                         ","E-W Wall with Window"},
	{0x002F,"$item_stone_wall_E                     ","Really Small E-W Wall"},
	{0x0031,"$item_stone_wall_G                     ","Really Small E-W Wall 2"},
	{0x0025,"$item_stone_wall_9                     ","E-W Small Wall"},
	{0x001B,"$item_stone_wall_1                     ","N-S Wall"},
	//Brick Walls I
	{0x0033,"$item_brick_wall                       ","SE Corner"},
	{0x0034,"$item_brick_wall_1                     ","E-W Wall"},
	{0x0035,"$item_brick_wall_2                     ","N-S Wall"},
	{0x0036,"$item_brick_wall_3                     ","Brick Post"},
	{0x0037,"$item_brick_wall_4                     ","E-W Wall with Wood"},
	{0x0038,"$item_brick_wall_5                     ","N-S Wall with Wood"},
	{0x0039,"$item_brick_wall_6                     ","E-W Wall with Wood"},
	{0x003A,"$item_brick_wall_7                     ","N-S Wall with Wood"},
	{0x003B,"$item_window_4                         ","E-W Wall with Window"},
	{0x003C,"$item_window_5                         ","N-S Wall with Window"},
	{0x003D,"$item_brick_wall_8                     ","SE Corner Small"},
	{0x003E,"$item_brick_wall_9                     ","E-W Wall Small"},
	{0x003F,"$item_brick_wall_A                     ","N-S Wall Small"},
	//Brick Walls II
	{0x0040,"$item_brick_wall_B                     ","Small Brick Post"},
	{0x0041,"$item_brick_wall_C                     ","SE Corner"},
	{0x0042,"$item_brick_wall_D                     ","E-W Wall Really Small"},
	{0x0043,"$item_brick_wall_E                     ","N-S Wall Really Small"},
	{0x0044,"$item_brick_arch                       ","Really Small Post"},
	{0x0045,"$item_brick_arch                       ","SE Corner Arch"},
	{0x0046,"$item_brick_arch_1                     ","N-S Arch"},
	{0x0047,"$item_brick_arch_2                     ","E-W Arch"},
	{0x0048,"$item_brick_arch_3                     ","E-W Arch"},
	{0x0049,"$item_brick_arch_4                     ","N-S Arch"},
	{0x004A,"$item_brick_wall_F                     ","E-W Arched Top Wall"},
	{0x004B,"$item_brick_wall_G                     ","N-S Arched Top Wall"},
	{0x004C,"$item_brick_wall_H                     ","N-S Arched Top Wall"},
	{0x004D,"$item_brick_wall_I                     ","E-W Arched Top Wall"},
	{0x004E,"$item_brick_wall_J                     ","E-W Top Arch End"},
	//Brick Walls III
	{0x004F,"$item_brick_wall_K                     ","N-S Top Arch End"},
	{0x0050,"$item_brick_wall_L                     ","E-W Top Arch Middle"},
	{0x0051,"$item_brick_wall_M                     ","N-S Top Arch Middle"},
	{0x0052,"$item_brick_wall_N                     ","SE Corner Blocks"},
	{0x0053,"$item_brick_wall_O                     ","E-W Blocks"},
	{0x0054,"$item_brick_wall_P                     ","N-S Blocks"},
	{0x0055,"$item_brick_wall_Q                     ","E-W Blocks"},
	{0x0056,"$item_brick_wall_R                     ","N-S Blocks"},
	//Wooden Walls II
	{0x0018,"$item_wooden_wall_D                    ","E-W Really Small Wall"},
	{0x0008,"$item_wooden_wall_2                    ","N-S Wall"},
	{0x000b,"$item_wooden_wall_4                    ","N-S Wall"},
	{0x000d,"$item_wooden_wall_6                    ","N-S Wall"},
	{0x000f,"$item_window_1                         ","N-S Wall with Window"},
	{0x0011,"$item_wooden_wall_8                    ","N-S Small Wall"},
	{0x0015,"$item_wooden_wall_B                    ","N-S Really Small Wall"},
	{0x0019,"$item_wooden_wall_E                    ","N-S Really Small Wall"},
	{0x0009,"$item_wooden_post                      ","Wooden Post"},
	{0x0013,"$item_wooden_post_1                    ","Wooden Post"},
	{0x0017,"$item_wooden_post_2                    ","Small Corner Post"},
	//Stone Walls II
	{0x001F,"$item_stone_wall_5                     ","N-S Wall with Wood"},
	{0x0020,"$item_stone_wall_6                     ","N-S Wall with Wood"},
	{0x0023,"$item_window_3                         ","N-S Wall with Window"},
	{0x0026,"$item_stone_wall_A                     ","N-S Small Wall"},
	{0x002E,"$item_stone_wall_D                     ","Really Small N-S Wall"},
	{0x0032,"$item_stone_wall_H                     ","Really Small N-S Wall 2"},
	{0x0030,"$item_stone_wall_F                     ","Really Small Stone Post"},
	{0x001D,"$item_stone_wall_3                     ","Stone Post"},
	{0x0027,"$item_stone_wall_B                     ","Small Stone Post"},
	{0x0028,"$item_stone_arch                       ","SE Arch"},
	{0x0029,"$item_stone_arch_1                     ","E-W Arch"},
	{0x002A,"$item_stone_arch_2                     ","N-S Arch"},
	{0x002B,"$item_stone_arch_3                     ","N-S Arch"},
	{0x002C,"$item_stone_arch_4                     ","E-W Arch"},
	//Walls
	{0x0229,"$item_wooden_post_3                    ","Corner Pole"},
	{0x0223,"$item_palisade_B                       ","Palisade Corner"},
	{0x0221,"$item_palisade_B                       ","Palisade N-S"},
	{0x0222,"$item_palisade_B                       ","Palisade E-W"},
	{0x0421,"$item_palisade_2                       ","Palisade Skull N-S"},
	{0x0422,"$item_palisade_4                       ","Palisade Skull E-W 1"},
	{0x0431,"$item_palisade_6                       ","Palisade Skull E-W 2"},
	{0x0430,"$item_palisade_5                       ","Palisade Skull E-W 3"},
	{0x0425,"$item_palisade                         ","Small Palisade Corner"},
	{0x0424,"$item_palisade_1                       ","Small Palisade N-S"},
	{0x0423,"$item_palisade_3                       ","Small Palisade E-W"},
	{0x021E,"$item_palisade_7                       ","Small Palisade Slant N-S 1"},
	{0x0220,"$item_palisade_8                       ","Small Palisade Slant N-S 2"},
	{0x021D,"$item_palisade_9                       ","Small Palisade Slant E-W 1"},
	{0x021F,"$item_palisade_A                       ","Small Palisade Slant E-W 2"},
	{0x0226,"$item_wooden_wall_F                    ","Un-spiked Palisade Corner"},
	{0x0227,"$item_wooden_wall_G                    ","Un-spiked Palisade N-S"},
	{0x022B,"$item_wooden_wall_H                    ","Un-spiked Palisade N-S"},
	{0x0228,"$item_wooden_wall_I                    ","Un-spiked Palisade E-W"},
	{0x022A,"$item_wooden_wall_J                    ","Un-spiked Palisade E-W"}
}

/*! }@ */