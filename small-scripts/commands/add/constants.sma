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
                                                        
                                                        
                                                        
                                                        
#define NUM_BOTTLES 13                                  
new __bottles[NUM_BOTTLES][additemEntry] =              
{                                                       
	{0x0E9B,"$item_mortar_and_pestal                ","Mortar And Pestal"},
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
