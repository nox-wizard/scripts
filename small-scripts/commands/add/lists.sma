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

//magic menu #defines
#define MAGIC_MENU_IDX 0

#define NUM_MAGICALITEMS 4
#define MAGICALITEMS_IDX MAGIC_MENU_IDX
 
#define NUM_REAGENTS 8
#define REAGENTS_IDX NUM_MAGICALITEMS + MAGICALITEMS_IDX

#define NUM_REAGENTS2 18
#define REAGENTS2_IDX NUM_REAGENTS + REAGENTS_IDX

#define NUM_BOTTLES 12
#define BOTTLES_IDX NUM_REAGENTS2 + REAGENTS2_IDX

#define NUM_POTIONS 12
#define POTIONS_IDX NUM_BOTTLES + BOTTLES_IDX

#define NUM_WANDS 9
#define WANDS_IDX NUM_POTIONS + POTIONS_IDX

#define NUM_GATES 3
#define GATES_IDX NUM_WANDS + WANDS_IDX

#define NUM_SCROLLS1 8
#define NUM_SCROLLS2 8
#define NUM_SCROLLS3 8
#define NUM_SCROLLS4 8
#define NUM_SCROLLS5 8
#define NUM_SCROLLS6 8
#define NUM_SCROLLS7 8
#define NUM_SCROLLS8 8

#define NUM_SCROLLS 64
#define SCROLLS_IDX NUM_GATES + GATES_IDX

//NPC menu #defines
#define NPC_MENU_IDX SCROLLS_IDX + NUM_SCROLLS

#define NUM_ANIMALS 26
#define IDX_ANIMALS NPC_MENU_IDX

#define NUM_T2A_MONSTERS 41	                        
#define IDX_T2A_MONSTERS IDX_ANIMALS + NUM_ANIMALS

#define NUM_DEAMONS 5
#define IDX_DEAMONS IDX_T2A_MONSTERS + NUM_T2A_MONSTERS

#define NUM_ELEMENTALS 7                                
#define IDX_ELEMENTALS IDX_DEAMONS + NUM_DEAMONS

#define NUM_ORCS 12
#define IDX_ORCS IDX_ELEMENTALS + NUM_ELEMENTALS

#define NUM_MONSTERS 17
#define IDX_MONSTERS IDX_ORCS + NUM_ORCS

#define NUM_UNDEADS 15
#define IDX_UNDEADS IDX_MONSTERS + NUM_MONSTERS

#define NUM_UNIQUE 5
#define IDX_UNIQUE IDX_UNDEADS + NUM_UNDEADS

#define NUM_FROST_STONE 7
#define IDX_FROST_STONE IDX_UNIQUE + NUM_UNIQUE

#define NUM_DRAGONS 13
#define IDX_DRAGONS IDX_FROST_STONE + NUM_FROST_STONE

#define NUM_PEOPLE_M 30
#define IDX_PEOPLE_M IDX_DRAGONS + NUM_DRAGONS

#define NUM_PEOPLE_F 23
#define IDX_PEOPLE_F IDX_PEOPLE_M + NUM_PEOPLE_M

#define NUM_MERCHANTS_M 32
#define IDX_MERCHANTS_M IDX_PEOPLE_F + NUM_PEOPLE_F

#define NUM_MERCHANTS_F 30
#define IDX_MERCHANTS_F IDX_MERCHANTS_M + NUM_MERCHANTS_M

//supply menu #defines
#define SUPPLY_MENU_IDX IDX_MERCHANTS_F + NUM_MERCHANTS_F 

#define NUM_BEVERAGES 27
#define IDX_BEVERAGES SUPPLY_MENU_IDX

#define NUM_BAKED 39
#define IDX_BAKED IDX_BEVERAGES + NUM_BEVERAGES

#define NUM_BOWLSMEATFRUIT 28
#define IDX_BOWLSMEATFRUIT IDX_BAKED + NUM_BAKED

#define NUM_PLANTS 19
#define IDX_PLANTS IDX_BOWLSMEATFRUIT + NUM_BOWLSMEATFRUIT

#define NUM_LIGHTS 22
#define IDX_LIGHTS IDX_PLANTS + NUM_PLANTS

#define NUM_CONTAINERS 10
#define IDX_CONTAINERS IDX_LIGHTS + NUM_LIGHTS

#define NUM_STATUES_TROPHIES 29
#define IDX_STATUES_TROPHIES IDX_CONTAINERS + NUM_CONTAINERS

#define NUM_HAIR_BEARD 16
#define IDX_HAIR_BEARD IDX_STATUES_TROPHIES + NUM_STATUES_TROPHIES

#define NUM_CLOTHING 40
#define IDX_CLOTHING IDX_HAIR_BEARD + NUM_HAIR_BEARD

#define NUM_RUGS 82
#define IDX_RUGS IDX_CLOTHING + NUM_CLOTHING

#define NUM_JEWELS 60
#define IDX_JEWELS IDX_RUGS + NUM_RUGS

//Signs menu defines
#define SIGNS_MENU_IDX IDX_JEWELS + NUM_JEWELS 

#define NUM_WORKER 36
#define IDX_WORKER SIGNS_MENU_IDX

#define NUM_GUILD 28
#define IDX_GUILD IDX_WORKER + NUM_WORKER

//furniture menu defines
#define FURNITURE_MENU_IDX IDX_GUILD + NUM_GUILD

#define NUM_FURNITURE 24
#define IDX_FURNITURE FURNITURE_MENU_IDX

#define NUM_TABLES 54
#define IDX_TABLES IDX_FURNITURE + NUM_FURNITURE

#define NUM_CHAIRS 42
#define IDX_CHAIRS IDX_TABLES + NUM_TABLES

#define NUM_BEDS 14
#define IDX_BEDS IDX_CHAIRS + NUM_CHAIRS

#define NUM_BIGBEDS 40
#define IDX_BIGBEDS IDX_BEDS + NUM_BEDS

//Tools menu defines

#define TOOLS_MENU_IDX IDX_BIGBEDS + NUM_BIGBEDS

#define NUM_CARPENTER1 36
#define IDX_CARPENTER1 TOOLS_MENU_IDX

#define NUM_CARPENTER2 52
#define IDX_CARPENTER2 IDX_CARPENTER1 + NUM_CARPENTER1

#define NUM_TAILOR 15
#define IDX_TAILOR IDX_CARPENTER2 + NUM_CARPENTER2

#define NUM_BLACKSMITH 18
#define IDX_BLACKSMITH IDX_TAILOR + NUM_TAILOR

#define NUM_MUSICIAN 7
#define IDX_MUSICIAN IDX_BLACKSMITH + NUM_BLACKSMITH

#define NUM_THIEF 1
#define IDX_THIEF IDX_MUSICIAN + NUM_MUSICIAN

#define NUM_FISHER 1
#define IDX_FISHER IDX_THIEF + NUM_THIEF

#define NUM_TINKER 10
#define IDX_TINKER IDX_FISHER + NUM_FISHER

#define NUM_BOWYER 10
#define IDX_BOWYER IDX_TINKER + NUM_TINKER

//Spawners
#define NUM_SPAWNERS 114
#define IDX_SPAWNERS IDX_BOWYER + NUM_BOWYER

//total items = last idx + last number
#define NUM_ADD_ITEMS IDX_SPAWNERS + NUM_SPAWNERS

new __listAllocationMap[58] =
{
	//magic
	NUM_MAGICALITEMS,
	NUM_REAGENTS,
	NUM_REAGENTS2,
	NUM_BOTTLES,
	NUM_POTIONS,
	NUM_WANDS,
	NUM_GATES,
	NUM_SCROLLS1,
	NUM_SCROLLS2,
	NUM_SCROLLS3,
	NUM_SCROLLS4,
	NUM_SCROLLS5,
	NUM_SCROLLS6,
	NUM_SCROLLS7,
	NUM_SCROLLS8,
	
	//npc
	NUM_ANIMALS,
	NUM_T2A_MONSTERS,	                        
	NUM_DEAMONS,
	NUM_ELEMENTALS,                                
	NUM_ORCS,
	NUM_MONSTERS,
	NUM_UNDEADS,
	NUM_UNIQUE,
	NUM_FROST_STONE,
	NUM_DRAGONS,
	NUM_PEOPLE_M,
	NUM_PEOPLE_F,
	NUM_MERCHANTS_M,
	NUM_MERCHANTS_F,

	//supply
	NUM_BEVERAGES,
	NUM_BAKED,
	NUM_BOWLSMEATFRUIT,
	NUM_PLANTS,
	NUM_LIGHTS,
	NUM_CONTAINERS,
	NUM_STATUES_TROPHIES,
	NUM_HAIR_BEARD,
	NUM_CLOTHING,
	NUM_RUGS,
	NUM_JEWELS,
	
	//signs
	NUM_WORKER,
	NUM_GUILD,
	
	//furniture	
	NUM_FURNITURE,
	NUM_TABLES,
	NUM_CHAIRS,
	NUM_BEDS,
	NUM_BIGBEDS,
	
	//tools
	NUM_CARPENTER1,
	NUM_CARPENTER2,
	NUM_TAILOR,
	NUM_BLACKSMITH,
	NUM_MUSICIAN,
	NUM_THIEF,
	NUM_FISHER,
	NUM_TINKER,
	NUM_BOWYER,
	
	//Spawners
	NUM_SPAWNERS
};

new __addMenuList[NUM_ADD_ITEMS][additemEntry] =
{
	//magical items
	{0x1F14,"$item_recall_rune                    ","Recall rune"}, 
	{0x0EFA,"$item_spellbook                      ","Spellbook"}, 
	{0x0E34,"$item_blank_scrolls                    ","Blank scrolls"}, 
	{0x1F6D,"$item_all-spell_scroll                 ","all-spell scroll"},
	
	//reagents                                  
	{0x0F7A,"$item_black_pearl                      ","Black Pearl"},
	{0x0F7B,"$item_bloodmoss                        ","Blood Moss"},
	{0x0F84,"$item_garlic                           ","Garlic"},
	{0x0F85,"$item_ginseng                          ","Ginseng"},
	{0x0F86,"$item_mandrake_root                    ","Mandrake Root"},
	{0x0F88,"$item_nightshade                       ","Nightshade"},
	{0x0F8C,"$item_sulfurous_ash                    ","Sulfurous Ash"},
	{0x0F8D,"$item_spiders_silk                     ","Spiders Silk"},

	//reagents 2
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
	{0x0F91,"$item_wyrms_heart                      ","Worms Heart"},

	//bottles                                                       
	{0x0F0E,"$item_bottle10                         ","Bottle"},
	{0x0E24,"$item_empty_vials                      ","Empty vial"},
	{0x0E25,"$item_bottle11                         ","Bottle"},
	{0x0E26,"$item_bottle1                          ","Bottle"},
	{0x0E27,"$item_bottle2                          ","Bottle"},
	{0x0E28,"$item_bottle3                          ","Bottle"},
	{0x0E29,"$item_bottle4                          ","Bottle"},
	{0x0E2A,"$item_bottle5                          ","Bottle"},
	{0x0E2B,"$item_bottle6                          ","Bottle"},
	{0x0E2C,"$item_bottle7                          ","Bottle"},
	{0x0EFB,"$item_bottle8                          ","Bottle"},
	{0x0EFC,"$item_bottle9                          ","Bottle"},

	//potions                                                
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
	{0x0F0D,"$item_greater_explosion_potion         ","Greater Explosion Potion"},

	//wands
	{0x0DF2,"$item_wand_of_greater_heal             ","Greater Heal Wand"},
	{0x0DF3,"$item_wand_of_summon_daemon            ","Summon Daemon Wand"},
	{0x0DF4,"$item_wand_of_healing                  ","Magic Arrow Wand"},
	{0x0DF5,"$item_wand_of_resurrection             ","Resurrect Wand"},
	{0x0F5C,"$item_fire_mace                        ","Fireball Mace"},
	{0x0F5C,"$item_wand_of_greater_healing          ","greater healing wand"},
	{0x0F5C,"$item_wand_of_energy_vortex            ","energy vortex wand"},
	{0x0F5C,"$item_wand_of_magic_arrow              ","magic arrow wand"},
	{0x0F5C,"$item_wand_of_ressurection             ","ressurection wand"},

	//gates
	{0x0F6C,"$item_blue_moongate                    ","Blue Moongate"},
	{0x0DDA,"$item_red_moongate                     ","Red Moongate"},
	{0x1FD4,"$item_black_moongate                   ","Black Moongate"},

	//scrolls
	//1st circle
	{0x1F35,"$item_reactive_armor_scroll            ","Agility Scroll"},
	{0x1F36,"$item_clumsy_scroll                    ","Cunning Scroll"},
	{0x1F37,"$item_create_food_scroll               ","Cure Scroll"},
	{0x1F38,"$item_feeblemind_scroll                ","Harm Scroll"},
	{0x1F39,"$item_heal_scroll                      ","Magic TraP_Scroll"},
	{0x1F3A,"$item_magic_arrow_scroll               ","Magic UntraP_Scroll"},
	{0x1F3B,"$item_night_sight_scroll               ","Protection Scroll"},
	{0x1F3C,"$item_weaken_scroll                    ","Strength Scroll"},

	//2nd circle
	{0x1F2D,"$item_agility_scroll                   ","Reactive Armor Scroll"},
	{0x1F2E,"$item_cunning_scroll                   ","Clumsy Scroll"},
	{0x1F2F,"$item_cure_scroll                      ","Create Food Scroll"},
	{0x1F30,"$item_harm_scroll                      ","Feeblemind Scroll"},
	{0x1F31,"$item_magic_trap_scroll                ","Heal Scroll"},
	{0x1F32,"$item_magic_untrap_scroll              ","Magic Arrow Scroll"},
	{0x1F33,"$item_protection_scroll                ","Night Sight Scroll"},
	{0x1F34,"$item_strength_scroll                  ","Weaken Scroll"},

	//3rd circle
	{0x1F3D,"$item_bless_scroll                     ","Bless Scroll"},
	{0x1F3E,"$item_fireball_scroll                  ","Fireball Scroll"},
	{0x1F3F,"$item_magic_lock_scroll                ","Magic Lock Scroll"},
	{0x1F40,"$item_poison_scroll                    ","Poison Scroll"},
	{0x1F41,"$item_telekinesis_scroll               ","Telekinesis Scroll"},
	{0x1F42,"$item_teleport_scroll                  ","Teleport Scroll"},
	{0x1F43,"$item_unlock_scroll                    ","Unlock Scroll"},
	{0x1F44,"$item_wall_of_stone_scroll             ","Wall of Stone Scroll"},

	//4th circle
	{0x1F45,"$item_archcure_scroll                  ","Archcure Scroll"},
	{0x1F46,"$item_arch_protection_scroll           ","Arch Protection Scroll"},
	{0x1F47,"$item_curse_scroll                     ","Curse Scroll"},
	{0x1F48,"$item_fire_field_scroll                ","Fire Field Scroll"},
	{0x1F49,"$item_greater_heal_scroll              ","Greater Heal Scroll"},
	{0x1F4A,"$item_lightning_scroll                 ","Lightning Scroll"},
	{0x1F4B,"$item_mana_drain_scroll                ","ManaDrain Scroll"},
	{0x1F4C,"$item_recall_scroll                    ","Recall Scroll"},

	//5th circle
	{0x1F4D,"$item_blade_spirits_scroll             ","Blade Spirits Scroll"},
	{0x1F4E,"$item_dispel_field_scroll              ","Dispel Field Scroll"},
	{0x1F4F,"$item_incognito_scroll                 ","Incognito Scroll"},
	{0x1F50,"$item_magic_reflection_scroll          ","Magic Reflection Scroll"},
	{0x1F51,"$item_mind_blast_scroll                ","Mind Blast Scroll"},
	{0x1F52,"$item_paralyze_scroll                  ","Paralyze Scroll"},
	{0x1F53,"$item_poison_field_scroll              ","Poison Field Scroll"},
	{0x1F54,"$item_summon_creature_scroll           ","Summon Creature Scroll"},

	//6th circle
	{0x1F55,"$item_dispel_scroll                    ","Dispel Scroll"},
	{0x1F56,"$item_energy_bolt_scroll               ","Energy Bolt Scroll"},
	{0x1F57,"$item_explosion_scroll                 ","Explosion Scroll"},
	{0x1F58,"$item_invisibility_scroll              ","Invisibility Scroll"},
	{0x1F59,"$item_mark_scroll                      ","Mark Scroll"},
	{0x1F5A,"$item_mass_curse_scroll                ","Mass Curse Scroll"},
	{0x1F5B,"$item_paralyze_field_scroll            ","Paralyze Field Scroll"},
	{0x1F5C,"$item_reveal_scroll                    ","Reveal Scroll"},
	        
	//7th circle
	{0x1F5D,"$item_chain_lightning_scroll           ","Chain Lightning Scroll"},
	{0x1F5E,"$item_energy_field_scroll              ","Energy Field Scroll"},
	{0x1F5F,"$item_flamestrike_scroll               ","Flamestrike Scroll"},
	{0x1F60,"$item_gate_travel_scroll               ","Gate Travel Scroll"},
	{0x1F61,"$item_mana_vampire_scroll              ","Mana Vampire Scroll"},
	{0x1F62,"$item_mass_dispel_scroll               ","Mass Dispel Scroll"},
	{0x1F63,"$item_meteor_swarm_scroll              ","Meteor Storm Scroll"},
	{0x1F64,"$item_polymorph_scroll                 ","Polymorph Scroll"},

	//8th circle
	{0x1F65,"$item_earthquake_scroll                ","Earthquake Scroll"},
	{0x1F66,"$item_energy_vortex_scroll             ","Energy Vortex Scroll"},
	{0x1F67,"$item_resurrection_scroll              ","Resurrection Scroll"},
	{0x1F68,"$item_summon_air_elemental_scroll      ","Summon Air Elemental Scroll"},
	{0x1F69,"$item_summon_daemon_scroll             ","Summon Daemon Scroll"},
	{0x1F6A,"$item_summon_earth_elemental_scroll    ","Summon Earth Elemental Scroll"},
	{0x1F6B,"$item_summon_fire_elemental_scroll     ","Summon Fire Elemental Scroll"},
	{0x1F6C,"$item_summon_water_elemental_scroll    ","Summon Water Elemental Scroll"},
	
	//animals
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
	{0x2127,"$npc_a_pack_llama                      ","a pack llama"},
	
	//T2A monsters
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
	{0x001C,"$npc_a_frost_spider                    ","Frost Spider"},
	
	//daemons
	{0x20D3,"$npc_deamon_unarmed                    ","a daemon"},
	{0x20D3,"$npc_a_daemon                          ","a daemon w/sword"},
	{0x0000,"$npc_an_ice_fiend                      ","ice fiend"},
	{0x20D9,"$npc_a_gargoyle                        ","a gargoyle"},
	{0x0000,"$npc_a_stone_gargoyle                  ","stone gargoyle"},
	
	//elementals                                    
	{0x20ED,"$npc_an_air_elemental                  ","an air elemental"},
	{0x20D7,"$npc_an_earth_elemental                ","an earth elemental"},
	{0x20F3,"$npc_a_fire_elemental                  ","a fire elemental"},
	{0x210B,"$npc_a_water_elemental                 ","a water elemental"},  
	{0x210B,"$npc_a_blood_elemental                 ","a blood elemental"},
	{0x20ED,"$npc_a_poison_elemental                ","a poison elemental"},
	{0x0000,"$npc_an_ice_elemental                  ","ice elemental"},
	
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
	{0x20E9,"$npc_a_troll_2                         ","a troll 3"},
	
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
	{0x20FC,"$npc_a_snake                           ","a snake"},
	
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
	{0x0000,"$npc_a_wraith                          ","a wraith"},
	
	//unique                                          
	{0x20D3,"$npc_the_collector_of_souls            ","the Collector of Souls"},
	{0x20DC,"$npc_a_harpy_hen                       ","a harpy hen"},
	{0x20D3,"$npc_lord_of_the_abyss                 ","the Lord of the Abyss"},
	{0x20D3,"$npc_slayer                            ","the Slayer"},
	{0x20F4,"$npc_xanathar                          ","Xanathar"},
	
	//forst/stone
	{0x0000,"$npc_an_ice_serpent                    ","ice snake"},
	{0x0000,"$npc_a_giant_ice_serpent               ","ice serpent"},
	{0x0000,"$npc_an_ice_giant                      ","ice giant"},
	{0x0000,"$npc_a_frost_troll                     ","frost troll"},
	{0x0000,"$npc_a_frost_ooze                      ","frost Ooze"},
	{0x0000,"$npc_a_frost_spider                    ","frost spider"},
	{0x0000,"$npc_a_stone_harpy                     ","stone harpy"},
	
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
	{0x0000,"$npc_a_fire_wyrm                       ","a fire wyrm"},
	
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
	{0x200E,"$npc_guard_m                           ","Guard"},
	{0x200E,"$npc_teleportguard_m                   ","Teleporting Guard"},
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
	{0x2037,"$npc_veterinarian_m                    ","Veterinarian"},
	
	//people - female
	{0x2022,"$npc_artist_f                          ","Artist"},
	{0x202B,"$npc_beggar_f                          ","Beggar"},
	{0x2030,"$npc_brigand_f                         ","Brigand"},
	{0x2107,"$npc_cultist_f                         ","Cultist"},
	{0x2107,"$npc_fighter_f                         ","Fighter"},
	{0x2107,"$npc_cassandra                         ","Girl"},
	{0x2107,"$npc_isabel                            ","Girl"},
	{0x200E,"$npc_guard_f                           ","Guard"},
	{0x200E,"$npc_teleportguard_f                   ","Teleporting Guard"},
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
	{0x2038,"$npc_veterinarian_f                    ","Veterinarian"},
	
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
	{0x0000,"$npc_que                               ","the Engineer"},
	{0x2022,"$npc_farmer_m                          ","Farmer"},
	{0x8414,"$npc_fisherman_m                       ","Fisherman"},
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
	{0x201F,"$npc_weaponsmith_m                     ","Weaponsmith"},
	
	//merchants - female
	{0x2023,"$npc_alchemist_f                       ","Alchemist"},
	{0x2036,"$npc_animal_trainer_f                  ","Animal Trainer"},
	{0x2031,"$npc_architect_f                       ","Architect"},
	{0x200A,"$npc_armorer_f                         ","Armorer"},
	{0x200B,"$npc_baker_f                           ","Baker"},
	{0x2107,"$npc_banker_f                          ","Banker"},
	{0x2107,"$npc_bard_f                            ","Bard"},
	{0x0000,"$npc_beekeeper_f                       ","The Beekeeper"},
	{0x2107,"$npc_blacksmith_f                      ","Blacksmith"},
	{0x200C,"$npc_bowyer_f                          ","Bowyer"},
	{0x200D,"$npc_butcher_f                         ","Butcher"},
	{0x2020,"$npc_carpenter_f                       ","Carpenter"},
	{0x202A,"$npc_cobbler_f                         ","Cobbler"},
	{0x0191,"$npc_cook_f                            ","Cook"},
	{0x0000,"$npc_jessie                            ","the Engineer"},
	{0x2024,"$npc_farmer_f                          ","Farmer"},
	{0x8415,"$npc_fisherman_f                       ","Fisherlady"},
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
	{0x201F,"$npc_weaponsmith_f                     ","Weaponsmith"},
	
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
	{0x1F9B,"$item_pitcher_of_wine_1                ","Pitcher of Wine"},
	
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
	{0x0978,"$item_slices_of_bacon_1                ","Slice of Bacon"},
	
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
	{0x0C6D,"$item_onions                           ","Onion"},
	
	//plants
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
	{0x0D38,"$item_yucca                            ","Yucca"},
	
	//lights
	{0x0A05,"$item_wall_torch1_1                    ","Wall Torch"},
	{0x0A06,"$item_torch_holder_1                   ","Torch holder"},
	{0x0A07,"$item_wall_torch2_1                    ","Wall Torch"},
	{0x0A0A,"$item_wall_torch1_2                    ","Wall Torch"},
	{0x0A0B,"$item_torch_holder_2                   ","Torch holder"},
	{0x0A0C,"$item_wall_torch2_2                    ","Wall Torch"},
	{0x0E31,"$item_brazier                          ","Brazier"},
	{0x0B1A,"$item_candle                           ","Candle"},
	{0x0B1D,"$item_candelabra                       ","Candelabra"},
	{0x0B20,"$item_lamp_post1_1                     ","Lamp post"},
	{0x0B21,"$item_lamp_post1_2                     ","Lamp Post"},
	{0x0B22,"$item_lamp_post2_1                     ","Lamp Post"},
	{0x0B23,"$item_lamp_post2_2                     ","Lamp Post"},
	{0x0B24,"$item_lamp_post3_1                     ","Lamp Post"},
	{0x0B25,"$item_lamp_post3_2                     ","Lamp Post"},
	{0x0B26,"$item_candelabra                       ","Tall Candelabra"},
	{0x0A15,"$item_lantern                          ","Lantern"},
	{0x0A12,"$item_torch                            ","Torch"},
	{0x0A0F,"$item_candle_3                         ","Candle"},
	{0x1854,"$item_skull_candle                     ","Skull candle"},
	{0x09FF,"$item_wall_sconce_1                    ","Wall Candle"},
	{0x0A00,"$item_wall_sconce_2                    ","Wall Candle"},
	
	//Containers                                                                																																																																
	{0x0E75,"$item_backpack                         ","Backpack"},          																																																																
	{0x0E76,"$item_leather_bag                      ","Leather Bag"},       																																																																
	{0x0E78,"$item_round_basket                     ","Round Basket"},      																																																																
	{0x0E79,"$item_pouch                            ","Pouch"},             																																																																
	{0x0E7A,"$item_square_basket                    ","Square Basket"},     																																																																
	{0x0E7C,"$item_silver_chest                     ","Silver Chest"},      																																																																
	{0x0E40,"$item_metal_chest1                     ","Metal Chest"},       																																																																
	{0x0E7F,"$item_open_wooden_keg                  ","Wooden Keg"},        																																																																		
	{0x0E83,"$item_tub                              ","Tub"},               																																																																		
	{0x0E80,"$item_brass_box                        ","Brass Box"},         																																																																		
	
	//Statues
	{0x12A1,"$item_statue1                          ","Statue 1 Left"},
	{0x129F,"$item_statue2                          ","Statue 1 Center"},
	{0x12A0,"$item_statue3                          ","Statue 1 Right"},
	{0x12A4,"$item_statue4                          ","Statue 2 Left"},
	{0x12A2,"$item_statue5                          ","Statue 2 Center"},
	{0x12A3,"$item_statue6                          ","Statue 2 Right"},
	{0x12AE,"$item_statue7                          ","Statue 3 Left"},
	{0x12D7,"$item_statue8                          ","Statue 3 Center"},
	{0x12D5,"$item_statue9                          ","Statue 3 Right"},
	{0x12D6,"$item_statue10                         ","Unfinished Statue"},
	{0x1224,"$item_statue11                         ","Statue"},
	{0x1225,"$item_statue12                         ","Statue"},
	{0x1226,"$item_statue13                         ","Statue"},
	{0x1227,"$item_statue14                         ","Statue"},
	{0x1228,"$item_statue15                         ","Statue"},
	//Trophies
	{0x1E60,"$item_trophy1                          ","Trophy"},
	{0x1E61,"$item_trophy2                          ","Trophy"},
	{0x1E62,"$item_trophy3                          ","Trophy"},
	{0x1E63,"$item_trophy4                          ","Trophy"},
	{0x1E64,"$item_trophy5                          ","Trophy"},
	{0x1E65,"$item_trophy6                          ","Trophy"},
	{0x1E66,"$item_trophy7                          ","Trophy"},
	{0x1E67,"$item_trophy8                          ","Trophy"},
	{0x1E68,"$item_trophy9                          ","Trophy"},
	{0x1E69,"$item_trophy10                         ","Trophy"},
	{0x1E6A,"$item_trophy11                         ","Trophy"},
	{0x1E6B,"$item_trophy12                         ","Trophy"},
	{0x1E6C,"$item_trophy13                         ","Trophy"},
	{0x1E6D,"$item_trophy14                         ","Trophy"},
	
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
	{0x204B,"$item_med_short_beard                  ","Short/Moustache"},
	
	
	//Boots
	{0x170B,"$item_boots                            ","Boots"},
	{0x170D,"$item_sandles                          ","Sandals"},
	{0x170F,"$item_shoes                            ","Shoes"},
	{0x1711,"$item_thigh_boots                      ","Thigh boots"},
	//Hats
	{0x1713,"$item_floopy_hat                       ","Floppy hat"},
	{0x1714,"$item_wide_brim_hat                    ","Wide-brim hat"},
	{0x1715,"$item_cap                              ","Cap"},
	{0x1716,"$item_tall_straw_hat                   ","Tall straw hat"},
	{0x1717,"$item_straw_hat                        ","Straw hat"},
	{0x1718,"$item_wizards_hat                      ","Wizard's hat"},
	{0x1719,"$item_bonnet                           ","Bonnet"},
	{0x171A,"$item_feathered_hat                    ","Feathered hat"},
	{0x171B,"$item_tricorne_hat                     ","Tricorne hat"},
	{0x171C,"$item_jester_hat                       ","Jester hat"},
	//Shirts & Robes
	{0x1515,"$item_cloak                            ","Cape"},
	{0x1EFD,"$item_fancy_shirt                      ","Fancy shirt"},
	{0x1517,"$item_shirt                            ","Plain shirt"},
	{0x1FFD,"$item_surcoat                          ","Surcoat"},
	{0x1FA1,"$item_tunic                            ","Tunic"},
	{0x1F03,"$item_robe1                            ","Robe"},
	{0x1F9F,"$item_jesters_suit                     ","Fancy suit"},
	{0x1F7B,"$item_doublet                          ","Doublet"},
	{0x1EFF,"$item_fancy_dress                      ","Fancy Dress"},
	{0x1F01,"$item_plain_dress                      ","Plain Dress"},
	//Pants                                         
	{0x1516,"$item_skirt                            ","Skirt"},
	{0x152E,"$item_short_pants                      ","Short pants"},
	{0x1537,"$item_kilt                             ","Kilt"},
	{0x1539,"$item_long_pants                       ","Long pants"},
	//Misc                                          
	{0x153B,"$item_half_apron                       ","Half apron"},
	{0x153D,"$item_full_apron                       ","Full apron"},
	{0x1540,"$item_bandana                          ","Bandana"},
	{0x1541,"$item_body_sash                        ","Body sash"},
	{0x1544,"$item_skullcap                         ","Skullcap"},
	//Masks                                         
	{0x1547,"$item_deer_mask                        ","Deer mask"},
	{0x1545,"$item_bear_mask                        ","Bear mask"},
	{0x1F0B,"$item_orc_helm                         ","Orc helm"},
	{0x141C,"$item_orc_mask                         ","Orc mask"},
	{0x1549,"$item_tribal_mask                      ","Tribal mask"},
	{0x154B,"$item_tribal_mask_1                    ","Voodoo mask"},
	{0x1546,"$item_polar_bear_mask                  ","Polar bear mask"},
	
	//Red Rug
	{0x0AA9,"$item_rug1_1                           ","Red Rug"},
	{0x0AAA,"$item_rug1_2                           ","Red Rug"},
	{0x0AAB,"$item_rug1_3                           ","Red Rug"},
	{0x0AAC,"$item_rug1_4                           ","Red Rug"},
	{0x0AAD,"$item_rug1_5                           ","Red Rug"},
	{0x0AAE,"$item_rug1_6                           ","Red Rug"},
	{0x0AAF,"$item_rug1_7                           ","Red Rug"},
	{0x0AB0,"$item_rug1_8                           ","Red Rug"},
	{0x0AB1,"$item_rug1_9                           ","Red Rug"},
	{0x0AB2,"$item_rug1_10                          ","Red Rug"},
	//Greenish Rug
	{0x0AB3,"$item_rug2_1                           ","Greenish Rug"},
	{0x0AB4,"$item_rug2_2                           ","Greenish Rug"},
	{0x0AB5,"$item_rug2_3                           ","Greenish Rug"},
	{0x0AB6,"$item_rug2_4                           ","Greenish Rug"},
	{0x0AB7,"$item_rug2_5                           ","Greenish Rug"},
	{0x0AB8,"$item_rug2_6                           ","Greenish Rug"},
	{0x0AB9,"$item_rug2_7                           ","Greenish Rug"},
	{0x0ABA,"$item_rug2_8                           ","Greenish Rug"},
	{0x0ABB,"$item_rug2_9                           ","Greenish Rug"},
	{0x0ABC,"$item_rug2_10                          ","Greenish Rug"},
	//Fancy Blue Rug
	{0x0ABD,"$item_carpet1_1                        ","Fancy Blue Rug"},
	{0x0ABE,"$item_carpet1_2                        ","Fancy Blue Rug"},
	{0x0ABF,"$item_carpet1_3                        ","Fancy Blue Rug"},
	{0x0AC0,"$item_carpet1_4                        ","Fancy Blue Rug"},
	{0x0AC1,"$item_carpet1_5                        ","Fancy Blue Rug"},
	{0x0AC2,"$item_carpet1_6                        ","Fancy Blue Rug"},
	{0x0AC3,"$item_carpet1_7                        ","Fancy Blue Rug"},
	{0x0AC4,"$item_carpet1_8                        ","Fancy Blue Rug"},
	{0x0AC5,"$item_carpet1_9                        ","Fancy Blue Rug"},
	{0x0AF6,"$item_carpet1_10                       ","Fancy Blue Rug"},
	{0x0AF7,"$item_carpet1_11                       ","Fancy Blue Rug"},
	{0x0AF8,"$item_carpet1_12                       ","Fancy Blue Rug"},
	{0x0AF9,"$item_carpet1_13                       ","Fancy Blue Rug"},
	
	//Fancy Red Rug
	{0x0AC6,"$item_carpet2_1                        ","Fancy Red Rug"},
	{0x0AC7,"$item_carpet2_2                        ","Fancy Red Rug"},
	{0x0AC8,"$item_carpet2_3                        ","Fancy Red Rug"},
	{0x0AC9,"$item_carpet2_4                        ","Fancy Red Rug"},
	{0x0ACA,"$item_carpet2_5                        ","Fancy Red Rug"},
	{0x0ACB,"$item_carpet2_6                        ","Fancy Red Rug"},
	{0x0ACC,"$item_carpet2_7                        ","Fancy Red Rug"},
	{0x0ACD,"$item_carpet2_8                        ","Fancy Red Rug"},
	{0x0ACE,"$item_carpet2_9                        ","Fancy Red Rug"},
	{0x0ACF,"$item_carpet2_10                       ","Fancy Red Rug"},
	{0x0AD0,"$item_carpet2_11                       ","Fancy Red Rug"},
	//Fancy Blue/Gold Rug
	{0x0AD1,"$item_carpet3_1                        ","Fancy Blue/Gold Rug"},
	{0x0AD2,"$item_carpet3_2                        ","Fancy Blue/Gold Rug"},
	{0x0AD3,"$item_carpet3_3                        ","Fancy Blue/Gold Rug"},
	{0x0AD4,"$item_carpet3_4                        ","Fancy Blue/Gold Rug"},
	{0x0AD5,"$item_carpet3_5                        ","Fancy Blue/Gold Rug"},
	{0x0AD6,"$item_carpet3_6                        ","Fancy Blue/Gold Rug"},
	{0x0AD7,"$item_carpet3_7                        ","Fancy Blue/Gold Rug"},
	{0x0AD8,"$item_carpet3_8                        ","Fancy Blue/Gold Rug"},
	{0x0AD9,"$item_carpet3_9                        ","Fancy Blue/Gold Rug"},
	//Fancy Golden Rug
	{0x0ADA,"$item_carpet4_1                        ","Fancy Golden Rug"},
	{0x0ADB,"$item_carpet4_2                        ","Fancy Golden Rug"},
	{0x0ADC,"$item_carpet4_3                        ","Fancy Golden Rug"},
	{0x0ADD,"$item_carpet4_4                        ","Fancy Golden Rug"},
	{0x0ADE,"$item_carpet4_5                        ","Fancy Golden Rug"},
	{0x0ADF,"$item_carpet4_6                        ","Fancy Golden Rug"},
	{0x0AE0,"$item_carpet4_7                        ","Fancy Golden Rug"},
	{0x0AE1,"$item_carpet4_8                        ","Fancy Golden Rug"},
	{0x0AE2,"$item_carpet4_9                        ","Fancy Golden Rug"},
	//Fancy Pink Rug
	{0x0AE3,"$item_carpet5_1                        ","Fancy Pink Rug"},
	{0x0AE4,"$item_carpet5_2                        ","Fancy Pink Rug"},
	{0x0AE5,"$item_carpet5_3                        ","Fancy Pink Rug"},
	{0x0AE6,"$item_carpet5_4                        ","Fancy Pink Rug"},
	{0x0AE7,"$item_carpet5_5                        ","Fancy Pink Rug"},
	{0x0AE8,"$item_carpet5_6                        ","Fancy Pink Rug"},
	{0x0AE9,"$item_carpet5_7                        ","Fancy Pink Rug"},
	{0x0AEA,"$item_carpet5_8                        ","Fancy Pink Rug"},
	{0x0AEB,"$item_carpet5_9                        ","Fancy Pink Rug"},
	//Fancy Pink & Blue Rug
	{0x0AEC,"$item_carpet6_1                        ","Fancy Pink & Blue Rug"},
	{0x0AED,"$item_carpet6_2                        ","Fancy Pink & Blue Rug"},
	{0x0AEE,"$item_carpet6_3                        ","Fancy Pink & Blue Rug"},
	{0x0AEF,"$item_carpet6_4                        ","Fancy Pink & Blue Rug"},
	{0x0AF0,"$item_carpet6_5                        ","Fancy Pink & Blue Rug"},
	{0x0AF1,"$item_carpet6_6                        ","Fancy Pink & Blue Rug"},
	{0x0AF2,"$item_carpet6_7                        ","Fancy Pink & Blue Rug"},
	{0x0AF3,"$item_carpet6_8                        ","Fancy Pink & Blue Rug"},
	{0x0AF4,"$item_carpet6_9                        ","Fancy Pink & Blue Rug"},
	{0x0AF5,"$item_carpet6_10                       ","Fancy Pink & Blue Rug"},
	{0x0AFA,"$item_carpet6_11                       ","Fancy Pink & Blue Rug"},
	
	//jewels
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
	{0x1085,"$item_necklace1                        ","Necklace"},
	{0x1088,"$item_necklace2                        ","Necklace"},
	{0x1089,"$item_necklace3                        ","Necklace"},
	{0x108A,"$item_ring                             ","Ring"},
	//Cut Gems
	{0x0F25,"$item_pieces_of_amber                  ","Amber"},
	{0x0F16,"$item_amethysts1                       ","Amethyst"},
	{0x0F17,"$item_amethysts2                       ","Amethyst"},
	{0x0F22,"$item_amethysts3                       ","Amethyst"},
	{0x0F2E,"$item_amethysts4                       ","Amethyst"},
	{0x0F15,"$item_citrines1                        ","Citrine"},
	{0x0F23,"$item_citrines2                        ","Citrine"},
	{0x0F24,"$item_citrines3                        ","Citrine"},
	{0x0F2C,"$item_citrines4                        ","Citrine"},
	{0x0F27,"$item_diamonds1                        ","Diamond"},
	{0x0F28,"$item_diamonds2                        ","Diamond"},
	{0x0F29,"$item_diamonds3                        ","Diamond"},
	{0x0F30,"$item_diamonds4                        ","Diamond"},
	{0x0F26,"$item_diamonds5                        ","Diamond"},
	{0x0F10,"$item_emeralds1                        ","Emerald"},
	{0x0F2F,"$item_emeralds2                        ","Emerald"},
	{0x0F13,"$item_rubies1                          ","Ruby"},
	{0x0F14,"$item_rubies2                          ","Ruby"},
	{0x0F1A,"$item_rubies3                          ","Ruby"},
	{0x0F1C,"$item_rubies4                          ","Ruby"},
	{0x0F1D,"$item_rubies5                          ","Ruby"},
	{0x0F2A,"$item_rubies6                          ","Ruby"},
	{0x0F2B,"$item_rubies7                          ","Ruby"},
	{0x0F11,"$item_sapphires1                       ","Sapphire"},
	{0x0F12,"$item_sapphires2                       ","Sapphire"},
	{0x0F19,"$item_sapphires3                       ","Sapphire"},
	{0x0F1F,"$item_sapphires4                       ","Sapphire"},
	{0x0F0F,"$item_star_sapphires1                  ","Sapphire Star"},
	{0x0F1B,"$item_star_sapphires2                  ","Sapphire Star"},
	{0x0F21,"$item_star_sapphires3                  ","Sapphire Star"},
	{0x0F18,"$item_tourmalines1                     ","Tourmaline"},
	{0x0F1E,"$item_tourmalines2                     ","Tourmaline"},
	{0x0F20,"$item_tourmalines3                     ","Tourmaline"},
	{0x0F2D,"$item_tourmalines4                     ","Tourmaline"},
	
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
	{0x1870,"$item_gem_of_immortality               ","Gem of Immortality"},
	
	//Roadsigns
	{0x1297,"$item_road_sign1_1                     ","Roadsign"},
	{0x1299,"$item_road_sign2_1                     ","Roadsign"},
	{0x129B,"$item_road_sign3_1                     ","Roadsign"},
	{0x129D,"$item_road_sign4_1                     ","Roadsign"},
	{0x1296,"$item_signpost                         ","Signpost"},
	//Shop Signs 1
	{0x0B95,"$item_library_sign_1                   ","Library"},
	{0x0BA3,"$item_bakery_sign_1                    ","Bakery"},
	{0x0BA5,"$item_tailor_sign_1                    ","Tailor"},
	{0x0BA7,"$item_tinker_sign_1                    ","Tinker"},
	{0x0BA9,"$item_butcher_sign_1                   ","Butcher"},
	{0x0BAB,"$item_healer_sign_1                    ","Healer"},
	//Shop sign_1s 2
	{0x0BAD,"$item_magic_shop_sign_1                ","Magic"},
	{0x0BAF,"$item_carpenter_sign_1                 ","Carpenter"},
	{0x0BB1,"$item_shipwright_sign_1                ","Shipwright"},
	{0x0BB3,"$item_inn_sign_1                       ","Inn"},
	{0x0BB5,"$item_harbor_master_sign_1             ","Harbor Master"},
	{0x0BB7,"$item_stables_sign_1                   ","Stables"},
	{0x0BB9,"$item_barber_sign_1                    ","Barber"},
	//Shop sign_1s 3
	{0x0BBB,"$item_musician_sign_1                  ","Mucician"},
	{0x0BBD,"$item_archer_sign_1                    ","Archery"},
	{0x0BBF,"$item_blacksmith_sign_1                ","Blacksmith"},
	{0x0BC1,"$item_jewler_sign_1                    ","Jewler"},
	{0x0BC3,"$item_tavern_sign_1                    ","Tavern"},
	{0x0BC5,"$item_alchemist_sign_1                 ","Alchemist"},
	{0x0BC7,"$item_armorer_sign_1                   ","Armorer"},
	//Shop sign_1s 4
	{0x0BC9,"$item_artist_sign_1                    ","Artist"},
	{0x0BCB,"$item_provisioner_sign_1                    ","Provisioner"},
	{0x0BCD,"$item_bowyer_sign_1                    ","Bowyer"},
	{0x0C0B,"$item_bank_sign_1                      ","Bank"},
	{0x0C0D,"$item_theater_sign_1                   ","Theater"},
	{0x0C43,"$item_beekeeper_sign_1                 ","Beekeeper"},
	//Misc sign_1s
	{0x0BCF,"$item_wooden_sign_1                    ","Wooden sign"},
	{0x0BD1,"$item_brass_sign_1                     ","Brass sign"},
	{0x0BD1,"$item_brass_sign_1                     ","Plain"},
	{0x0BD2,"$item_brass_sign_1                     ","Plain"},
	{0x1F29,"$item_sign_1                           ","sign"},
	//Guild sign_1s 1
	{0x0BD3,"$item_armaments_guild_sign_1           ","Armaments "},
	{0x0BD5,"$item_armorers_guild_sign_1            ","Armorers "},
	{0x0BD7,"$item_blacksmiths_guild_sign_1         ","Blacksmiths "},
	{0x0BD9,"$item_weapons_guild_sign_1             ","Weapons "},
	{0x0BDB,"$item_bardic_guild_sign_1              ","Bardic "},
	{0x0BDD,"$item_barders_guild_sign_1             ","Barders "},
	{0x0BDF,"$item_provisioners_guild_sign_1        ","Provisioners "},
	// sign_1s 2
	{0x0BE1,"$item_traders_guild_sign_1             ","Traders "},
	{0x0BE3,"$item_cooks_guild_sign_1               ","Cooks "},
	{0x0BE5,"$item_healers_guild_sign_1             ","Healers "},
	{0x0BE7,"$item_mages_guild_sign_1               ","Mages "},
	{0x0BE9,"$item_sorcerers_guild_sign_1           ","Sorcerers "},
	{0x0BEB,"$item_illusionists_guild_sign_1        ","Illusionists "},
	{0x0BED,"$item_miners_guild_sign_1              ","Miners "},
	// sign_1s 3
	{0x0BEF,"$item_archers_guild_sign_1             ","Archers "},
	{0x0BF1,"$item_seamans_guild_sign_1             ","Seamans "},
	{0x0BF3,"$item_fishermans_guild_sign_1          ","Fishermans "},
	{0x0BF5,"$item_sailors_guild_sign_1             ","Sailors "},
	{0x0BF7,"$item_shipwrights_guild_sign_1         ","Shipwrights "},
	{0x0BF9,"$item_tailors_guild_sign_1             ","Tailors "},
	{0x0BFB,"$item_thieves_guild_sign_1             ","Thieves "},
	// sign_1s 4
	{0x0BFD,"$item_rouges_guild_sign_1              ","Rouges "},
	{0x0BFF,"$item_assassins_guild_sign_1           ","Assassins "},
	{0x0C01,"$item_tinkers_guild_sign_1             ","Tinkers "},
	{0x0C03,"$item_warriors_guild_sign_1            ","Warriors "},
	{0x0C05,"$item_cavalry_guild_sign_1             ","Cavalry "},
	{0x0C07,"$item_fighters_guild_sign_1            ","Fighters "},
	{0x0C09,"$item_merchants_guild_sign_1           ","Merchants "},
	
	//Misc
	{0x0B3F,"counter1_1                             ","counter"},
	{0x0B3D,"counter1_2                             ","counter"},
	{0x0B40,"counter2_1                             ","counter"},
	{0x0B3e,"counter2_2                             ","counter"},
	{0x0A2C,"chest_of_drawers1_1                    ","chest of drawers"},
	{0x0A34,"chest_of_drawers1_2                    ","chest of drawers"},
	{0x0A30,"chest_of_drawers2_2                    ","fancy chest of drawers"},
	{0x0A38,"chest_of_drawers2_1                    ","fancy chest of drawers"},
	{0x0A97,"bookcase1_1                            ","bookcase"},
	{0x0A98,"bookcase1_2                            ","bookcase"},
	{0x0A9B,"bookcase1_3                            ","bookcase"},
	{0x0A99,"bookcase2_1                            ","bookcase"},
	{0x0A9A,"bookcase2_2                            ","bookcase"},
	{0x0A9C,"bookcase2_3                            ","bookcase"},
	{0x0A9D,"wooden_shelf1                          ","bookcase"},
	{0x0A9E,"wooden_shelf2                          ","bookcase"},
	{0x0a3c,"dresser1_2                             ","dresser"},
	{0x0a3d,"dresser1_1                             ","dresser"},
	{0x0a44,"dresser2_1                             ","dresser"},
	{0x0a45,"dresser2_2                             ","dresser"},
	{0x0A4D,"armoire1_1                             ","fancy armorie"},
	{0x0A51,"armoire1_2                             ","fancy armoire"},
	{0x0A4F,"armoire2_1                             ","armoire"},
	{0x0A53,"armoire2_2                             ","armoire"},
	
	//tables
	{0x0B4a,"writing_desk_1                         ","writing desk"},
	{0x0B4b,"writing_desk_2                         ","writing desk"},
	{0x0B4c,"writing_desk_3                         ","writing desk"},
	{0x0B49,"writing_desk_4                         ","writing desk"},
	{0x0B6E,"table_A1_1                             ","table"},
	{0x0B6F,"table_A1_2                             ","table"},
	{0x0B82,"table_A2_1                             ","table"},
	{0x0B81,"table_A2_2                             ","table"},
	{0x0B70,"table_B1_1                             ","table"},
	{0x0B71,"table_B1_2                             ","table"},
	{0x0B72,"table_B1_3                             ","table"},
	{0x0B73,"table_B1_4                             ","table"},
	{0x0B74,"table_B1_5                             ","table"},
	{0x0B83,"table_B2_1                             ","table"},
	{0x0B84,"table_B2_2                             ","table"},
	{0x0B85,"table_B2_3                             ","table"},
	{0x0B86,"table_B2_4                             ","table"},
	{0x0B87,"table_B2_5                             ","table"},
	{0x0B75,"table_C1_1                             ","table"},
	{0x0B76,"table_C1_2                             ","table"},
	{0x0B89,"table_C2_1                             ","table"},
	{0x0B88,"table_C2_2                             ","table"},
	{0x0B77,"table_D1_1                             ","table"},
	{0x0B78,"table_D1_2                             ","table"},
	{0x0B79,"table_D1_3                             ","table"},
	{0x0B7A,"table_D1_4                             ","table"},
	{0x0B7B,"table_D1_5                             ","table"},
	{0x0B8A,"table_D2_1                             ","table"},
	{0x0B8B ,"table_D2_2                             ","table"},
	{0x0B8C ,"table_D2_3                             ","table"},
	{0x0B8D ,"table_D2_4                             ","table"},
	{0x0B8E ,"table_D2_5                             ","table"},
	{0x0B7C ,"table_E1                               ","Table"},
	{0x0B8F ,"table_E2                               ","table"},
	{0x0b7d ,"table_F1                               ","table"},
	{0x0B90 ,"table_F2                               ","table"},
	{0x0B34 ,"table_G1_1                             ","table"},
	{0x0B37 ,"table_G1_2                             ","table"},
	{0x0B35 ,"table_G2_1                             ","table"},
	{0x0B38 ,"table_G2_2                             ","table"},
	{0x0B6B ,"table_H1_1                             ","table"},
	{0x0B6D ,"table_H1_2                             ","table"},
	{0x0B6C ,"table_H1_3                             ","table"},
	{0x0B7F ,"table_H2_1                             ","table"},
	{0x0B80 ,"table_H2_2                             ","table"},
	{0x0B7E ,"table_H2_3                             ","table"},
	{0x118b ,"table_I                                ","table"},
	{0x118c ,"table_J                                ","table"},
	{0x118d ,"table_K                                ","table"},
	{0x118e ,"table_L                                ","table"},
	{0x118f ,"table_M1_1                             ","table"},
	{0x1190 ,"table_M1_2                             ","table"},
	{0x1191 ,"table_M2_1                             ","table"},
	{0x1192 ,"table_M2_2                             ","table"},
	
	
	//chairs
	{0x0B32 ,"throne1                                ","throne"},
	{0x0B33 ,"throne2                                ","throne"},
	{0x0B2E ,"wooden_chair1_1                        ","wooden chair"},
	{0x0B2F ,"wooden_chair1_2                        ","wooden chair"},
	{0x0B30 ,"wooden_chair1_3                        ","wooden chair"},
	{0x0B31 ,"wooden_chair1_4                        ","wooden chair"},
	{0x0B56 ,"wooden_chair2_1                        ","wooden chair"},
	{0x0B57 ,"wooden_chair2_2                        ","wooden chair"},
	{0x0B58 ,"wooden_chair2_3                        ","wooden chair"},
	{0x0B59 ,"wooden_chair2_4                        ","wooden chair"},
	{0x0B4E ,"fancy_chair1_1                         ","fancy chair"},
	{0x0B4F ,"fancy_chair1_2                         ","fancy chair"},
	{0x0B50 ,"fancy_chair1_3                         ","fancy chair"},
	{0x0B51 ,"fancy_chair1_4                         ","fancy chair"},
	{0x0B52 ,"fancy_chair2_1                         ","fancy chair"},
	{0x0B53 ,"fancy_chair2_2                         ","fancy chair"},
	{0x0B54 ,"fancy_chair2_3                         ","fancy chair"},
	{0x0B55 ,"fancy_chair2_4                         ","fancy chair"},
	{0x0B5A ,"straw_chair1_1                         ","straw chair"},
	{0x0B5B ,"straw_chair1_2                         ","straw chair"},
	{0x0B5C ,"straw_chair1_3                         ","straw chair"},
	{0x0B5D ,"straw_chair1_4                         ","straw chair"},
	{0x0A2A ,"stool1                                 ","stool"},
	{0x0A2B ,"stool2                                 ","stool"},
	{0x0B5F ,"bench_A1_1                             ","bench"},
	{0x0B61 ,"bench_A1_2                             ","bench"},
	{0x0B60 ,"bench_A1_3                             ","bench"},
	{0x0B66 ,"bench_A2_2                             ","bench"},
	{0x0B67 ,"bench_A2_3                             ","bench"},
	{0x0B65 ,"bench_A2_1                             ","bench"},
	{0x0B62 ,"bench_B1_1                             ","bench"},
	{0x0B64 ,"bench_B1_2                             ","bench"},
	{0x0B63 ,"bench_B1_3                             ","bench"},
	{0x0B69 ,"bench_B2_1                             ","bench"},
	{0x0B6A ,"bench_B2_2                             ","bench"},
	{0x0B68 ,"bench_B2_3                             ","bench"},
	{0x0B92 ,"bench_C1_1                             ","bench"},
	{0x0B91 ,"bench_C1_2                             ","bench"},
	{0x0B93 ,"bench_C2_1                             ","bench"},
	{0x0B94 ,"bench_C2_2                             ","bench"},
	{0x0B2C ,"wooden_bench_D1                        ","wooden bench"},
	{0x0B2D ,"wooden_bench_D2                        ","wooden bench"},
	
	//beds
	{0x0a5d ,"bed_headboard_A1_1                     ","bed"},
	{0x0a69 ,"bed_headboard_A1_2                     ","bed"},
	{0x0a6a ,"bed_headboard_A1_3                     ","bed"},
	{0x0a60 ,"bed_headboard_A1_4                     ","bed"},
	{0x0a62 ,"bed_feet_A1_1                          ","bed"},
	{0x0a6b ,"bed_feet_A1_2                          ","bed"},
	{0x0a61 ,"bed_feet_A1_3                          ","bed"},
	{0x0a63 ,"bed_headboard_A2_1                     ","bed"},
	{0x0a66 ,"bed_headboard_A2_2                     ","bed"},
	{0x0a67 ,"bed_headboard_A2_3                     ","bed"},
	{0x0a5e ,"bed_headboard_A2_4                     ","bed"},
	{0x0a5c ,"bed_feet_A2_1                          ","bed"},
	{0x0a68 ,"bed_feet_A2_2                          ","bed"},
	{0x0a5f ,"bed_feet_A2_3                          ","bed"},
	
	//Big beds
	{0x0a70 ,"bigbed_headleft_A1_1                   ","bed"},
	{0x0a84 ,"bigbed_headleft_A1_2                   ","bed"},
	{0x0a7a ,"bigbed_headleft_A1_3                   ","bed"},
	{0x0a7c ,"bigbed_headleft_A1_4                   ","bed"},
	{0x0a90 ,"bigbed_headleft_A1_5                   ","bed"},
	{0x0a8e ,"bigbed_headleft_A1_6                   ","bed"},
	{0x0a71 ,"bigbed_feetleft_A1_1                   ","bed"},
	{0x0a86 ,"bigbed_feetleft_A1_2                   ","bed"},
	{0x0a78 ,"bigbed_feetleft_A1_3                   ","bed"},
	{0x0a8c ,"bigbed_feetleft_A1_4                   ","bed"},
	{0x0a72 ,"bigbed_feetright_A1_1                  ","bed"},
	{0x0a87 ,"bigbed_feetright_A1_2                  ","bed"},
	{0x0a79 ,"bigbed_feetright_A1_3                  ","bed"},
	{0x0a8d ,"bigbed_feetright_A1_4                  ","bed"},
	{0x0a73 ,"bigbed_headright_A1_1                  ","bed"},
	{0x0a85 ,"bigbed_headright_A1_2                  ","bed"},
	{0x0a7b ,"bigbed_headright_A1_3                  ","bed"},
	{0x0a7d ,"bigbed_headright_A1_4                  ","bed"},
	{0x0a91 ,"bigbed_headright_A1_5                  ","bed"},
	{0x0a8f ,"bigbed_headright_A1_6                  ","bed"},
	{0x0a77 ,"bigbed_headleft_A2_1                   ","bed"},
	{0x0a89 ,"bigbed_headleft_A2_2                   ","bed"},
	{0x0a80 ,"bigbed_headleft_A2_3                   ","bed"},
	{0x0a83 ,"bigbed_headleft_A2_4                   ","bed"},
	{0x0db3 ,"bigbed_headleft_A2_5                   ","bed"},
	{0x0db5 ,"bigbed_headleft_A2_6                   ","bed"},
	{0x0a76 ,"bigbed_feetleft_A2_1                   ","bed"},
	{0x0a8b ,"bigbed_feetleft_A2_2                   ","bed"},
	{0x0a7f ,"bigbed_feetleft_A2_3                   ","bed"},
	{0x0db1 ,"bigbed_feetleft_A2_4                   ","bed"},
	{0x0a71 ,"bigbed_feetright_A2_1                  ","bed"},
	{0x0a8a ,"bigbed_feetright_A2_2                  ","bed"},
	{0x0a7e ,"bigbed_feetright_A2_3                  ","bed"},
	{0x0db0 ,"bigbed_feetright_A2_4                  ","bed"},
	{0x0a74 ,"bigbed_headright_A2_1                  ","bed"},
	{0x0a88 ,"bigbed_headright_A2_2                  ","bed"},
	{0x0a81 ,"bigbed_headright_A2_3                  ","bed"},
	{0x0a82 ,"bigbed_headright_A2_4                  ","bed"},
	{0x0db2 ,"bigbed_headright_A2_5                  ","bed"},
	{0x0db4 ,"bigbed_headright_A2_6                  ","bed"},

	//carpenter
	{0x1BD7,"$item_boards                           ","board"},
	{0x1BE0,"$item_logs                             ","log"},
	{0x0F43,"$item_hatchet                          ","hatchet"},   
	{0x0F44,"$item_hatchet2                         ","hatchet"},
	{0x1026,"$item_chisel                           ","chisel"},
	{0x1027,"$item_chisel2                          ","chisel"},
	{0x1028,"$item_dovetail_saw                     ","dovetail saw"},
	{0x1029,"$item_dovetail_saw2                    ","dovetail saw"},
	{0x102A,"$item_hammer                           ","hammer"},
	{0x102B,"$item_hammer2                          ","hammer"},
	{0x102C,"$item_moulding_planes                  ","mould. planes"},
	{0x102d,"$item_moulding_planes2                 ","mould. planes"},
	{0x102E,"$item_nails                            ","nails"},
	{0x102f,"$item_nails2                           ","nails"},
	{0x1030,"$item_jointing_plane                   ","joint. plane"},
	{0x1031,"$item_jointing_plane2                  ","joint. plane"},
	{0x1032,"$item_smoothing_plane                  ","smooth. plane"},
	{0x1033,"$item_smoothing_plane2                 ","smooth. plane"},
	{0x1034,"$item_saw                              ","saw"},
	{0x1035,"$item_saw2                             ","saw"},
	{0x10E4,"$item_draw_knife                       ","knife"},
	{0x10E5,"$item_froe                             ","froe"},
	{0x10E6,"$item_inshave                          ","inshave"},
	{0x10E7,"$item_scorp                            ","scorp"},
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
	{0x14e0,"$item_bucket                           ","bucket"},
	
	//Tailor
	{0x0FA9,"$item_dyes                             ","dyes"},
	{0x0FAB,"$item_dying_tub                        ","a dying tub"},
	{0x0F9D,"$item_sewing_kit                       ","sewing kit"},
	{0x1766,"$item_cut_cloth                        ","cut cloth"},
	{0x0F9E,"$item_scissors                         ","scissors"},
	{0x101d,"$item_spinning_wheel1                  ","spinning wheel"},
	{0x10A4,"$item_spinning_wheel2                  ","spinning wheel"},
	{0x10A5,"$item_spinning_wheel3                  ","spinning wheel"},
	{0x0DF8,"$item_piles_of_wool_1                  ","piles of wool"},
	{0x0E1D,"$item_balls_of_yarn1                   ","balls of yarn"},
	{0x0E1E,"$item_balls_of_yarn2                   ","balls of yarn"},
	{0x0E1F,"$item_balls_of_yarn3                   ","balls of yarn"},
	{0x0DF9,"$item_bales_of_cotton                  ","bales of cotton"},
	{0x0FA0,"$item_spools_of_thread_1               ","spools of thread"},
	{0x0EC6,"$item_dress_form                       ","dress form"},
	
	//Blacksmith
	{0x0FAF,"$item_anvil_1                          ",""},
	{0x0FB0,"$item_anvil_2                          ",""},
	{0x197A,"$item_bellows                          ",""},
	{0x0FB1,"$item_forge1                           ",""},
	{0x197A,"$item_forge2_1_1                       ",""},
	{0x197E,"$item_forge2_1_2                       ",""},
	{0x19A6,"$item_forge2_1_3                       ",""},
	{0x19A2,"$item_forge2_1_4                       ",""},
	{0x1982,"$item_forge2_1_5                       ",""},
	{0x1986,"$item_forge2_2_1                       ",""},
	{0x198A,"$item_forge2_2_2                       ",""},
	{0x199A,"$item_forge2_2_3                       ",""},
	{0x1996,"$item_forge2_2_4                       ",""},
	{0x198E,"$item_forge2_2_5                       ",""},
	{0x1986,"$item_bellows_2                        ",""},
	{0x0F39,"$item_shovel                           ",""},
	{0x0F39,"$item_tongs                            ",""},
	{0x1BF2,"$item_iron_ingots                      ",""},
	
	//Musician
	{0x0E9C,"$item_drum                             ","drum"},
	{0x0E9D,"$item_tambourine1                      ","tambourine"},
	{0x0E9E,"$item_tambourine2                      ","tambourine"},
	{0x0EB1,"$item_standing_harp                    ","stand. harp"},
	{0x0EB2,"$item_lap_harp                         ","lap harp"},
	{0x0EB3,"$item_lute_1                           ","lute"},
	{0x0EB4,"$item_lute_2                           ","lute"},
	
	//Thief
	{0x14FB,"$item_lockpicks                        ","lockpicks"},
	
	//Fisher
	{0x0DBF,"$item_fishing_pole                     ","Fishing Pole"},
	
	//Tinker
	{0x104F,"$item_clock_parts                      ","clock parts"},
	{0x1051,"$item_axles_with_gears                 ","axles/gears"},
	{0x1053,"$item_gears                            ","gears"},
	{0x1055,"$item_hinges                           ","hinges"},
	{0x1059,"$item_sextant_parts                    ","sextant parts"},
	{0x105B,"$item_axles                            ","axles"},
	{0x105D,"$item_springs                          ","springs"},
	{0x1EBC,"$item_tinkers_tools                    ","tools"},
	{0x104F,"$item_clock                            ","clock"},
	{0x104D,"$item_clock_frames                     ","clock frame"},
	
	//Bowyer
	{0x100A,"$item_archery_butte_1                  ","butte"},
	{0x100B,"$item_archery_butte_2                  ","butte"},
	{0x1020,"$item_feathers_1                       ","feathers"},
	{0x1021,"$item_feathers_2                       ","feathers"},
	{0x1022,"$item_arrow_fletching_1                ","fletching"},
	{0x1023,"$item_arrow_fletching_2                ","fletching"},
	{0x1024,"$item_arrow_shafts_1                   ","shafts"},
	{0x1025,"$item_arrow_shafts_2                   ","shafts"},
	{0x0F3F,"$item_arrow                            ","arrow"},
	{0x1BFB,"$item_crossbow_bolt                    ","bolt"},

	//Spawners
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

/*
#define NUM_DEEDS 48
new __deeds[NUM_DEEDS][additemEntry]
=
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
	{INVALID,"$item_forge_deed                     ","a forge deed" },
	{INVALID,"$item_anvil_1_deed                     ","an anvil deed (facing south)" },
	{INVALID,"$item_anvil_2_deed                     ","an anvil deed (facing east)" },
	{INVALID,"$item_spinning_wheel_deed_facing_south_","a spinning wheel deed (facing south)" },
	{INVALID,"$item_archery_butte_deed_facing_east_  ","an archery butte deed (facing east)" },
	{INVALID,"$item_archery_butte_deed_facing_south_ ","an archery butte deed (facing south)" },
	{INVALID,"$item_training_dummy_deed_facing_south_","a training dummy deed (facing south)" },
	{INVALID,"$item_training_dummy_deed_facing_east_ ","a training dummy deed (facing east)" },
	{INVALID,"$item_pickpocket_dip_deed_facing_south_","a pickpocket dip deed (facing south)" },
	{INVALID,"$item_pickpocket_dip_deed_facing_east_ ","a pickpocket dip deed (facing east)" },
	{INVALID,"$item_pentagram_deed                     ","pentagram deed" },
	{INVALID,"$item_cannon_deed                      ","a cannon deed" },
	{INVALID,"$item_large_forge_facing_south_deed    ","a large forge facing south deed" },
	{INVALID,"$item_large_forge_facing_east_deed     ","a large forge facing east deed" },
	{INVALID,"$item_skull_candle_deed                ","a skull candle deed" }
}
*/
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

/*! }@ */