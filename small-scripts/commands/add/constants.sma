enum additemEntry
{
	__ID,
	__name: 40
};

#define XSS_DEF_L 50


#define NUM_MAGICAL_ITEMS 4
new magicalItems[NUM_MAGICAL_ITEMS][additemEntry] =
{
	{0x1F14,"Recall rune"}, 
	{0x0EFA,"Spellbook"}, 
	{0x0E34,"Blank scrolls"}, 
	{0x1F6D,"all-spell scroll"} 
}

new magicalItemsDefs[NUM_MAGICAL_ITEMS][XSS_DEF_L] =
{
	"$item_a_recall_rune",
	"$item_a_spellbook",
	"$item_blank_scrolls",
	"$item_all-spell_scroll"
}

#define NUM_REAGENTS 8
new __reagents[NUM_REAGENTS][additemEntry] =
{
	{0x0F7A,"Black Pearl"},
	{0x0F7B,"Blood Moss"},
	{0x0F84,"Garlic"},
	{0x0F85,"Ginseng"},
	{0x0F86,"Mandrake Root"},
	{0x0F88,"Nightshade"},
	{0x0F8C,"Sulfurous Ash"},
	{0x0F8D,"Spiders Silk"}
}

new __reagentsDefs[NUM_REAGENTS][50] =
{
	"$item_black_pearl",
	"$item_bloodmoss",
	"$item_garlic",
	"$item_ginseng",
	"$item_mandrake_root",
	"$item_nightshade",
	"$item_sulfurous_ash",
	"$item_spiders_silk"
}

#define NUM_REAGENTS2 18
new __reagents2[NUM_REAGENTS2][additemEntry] =
{
	{0x0F78,"Bat Wing"},
	{0x0F79,"Blackmoor"},
	{0x0F7C,"Bloodspawn"},
	{0x0F7D,"Vial of Blood"},
	{0x0F7E,"Bone"},
	{0x0F7F,"Brimstone"},
	{0x0F80,"Daemon Bone"},
	{0x0F81,"Fertile Dirt"},
	{0x0F82,"Dragon Blood"},
	{0x0F83,"Executioner's Cap"},
	{0x0F87,"Eye of Newt"},
	{0x0F89,"Obsidian"},
	{0x0F8A,"Pig Iron"},
	{0x0F8B,"Pumice"},
	{0x0F8E,"Serpent Scales"},
	{0x0F8F,"Volcanic Ash"},
	{0x0F90,"Dead Wood"},
	{0x0F91,"Worms Heart"}
}   

new __reagents2Defs[NUM_REAGENTS2][50] =
{
	"$item_batwing",
	"$item_blackmoor",
	"$item_bloodspawn",
	"$item_vial_of_blood",
	"$item_bone",
	"$item_brimstone",
	"$item_daemon_bone",
	"$item_fertile_dirt",
	"$item_dragon_blood",
	"$item_executioners_cap",
	"$item_eye_of_newt",
	"$item_obsidian",
	"$item_pig_iron",
	"$item_pumice",
	"$item_serpents_scale",
	"$item_volcanic_ash",
	"$item_dead_wood",
	"$item_wyrms_heart"
}	



#define NUM_BOTTLES 13
new __bottles[NUM_BOTTLES][additemEntry] =
{
	{0x0E9B,"Mortar And Pestal"},
	{0x0F0E,"Bottle"},
	{0x0E24,"a empty vial"},
	{0x0E25,"Bottle"},
	{0x0E26,"Bottle"},
	{0x0E27,"Bottle"},
	{0x0E28,"Bottle"},
	{0x0E29,"Bottle"},
	{0x0E2A,"Bottle"},
	{0x0E2B,"Bottle"},
	{0x0E2C,"Bottle"},
	{0x0EFB,"Bottle"},
	{0x0EFC,"Bottle"}
}
	
    
new __bottlesDefs[NUM_BOTTLES][50] =
{
	"$item_mortar_and_pestal",
	"$item_bottle_A",
	"$item_empty_vials",
	"$item_bottle",
	"$item_bottle_1",
	"$item_bottle_2",
	"$item_bottle_3",
	"$item_bottle_4",
	"$item_bottle_5",
	"$item_bottle_6",
	"$item_bottle_7",
	"$item_bottle_8",
	"$item_bottle_9"
}


#define NUM_POTIONS 12
new __potions[NUM_POTIONS][additemEntry] = 
{
	{0x0E9B,"Mortar And Pestal"},
	{0x0F06,"Night Sight Potion"},
	{0x0F07,"Cure_Potion"},
	{0x0F08,"Agility Potion"},
	{0x0F09,"Strength Potion"},
	{0x0F0A,"Poison Potion"},
	{0x0F0B,"Resurrection Potion"},
	{0x0F0C,"Lesser Heal Potion"},
	{0x0F0C,"Greater Heal Potion"},
	{0x0F0D,"Lesser Explosion Potion"},
	{0x0F0D,"Explosion Potion"},
	{0x0F0D,"Greater Explosion Potion"}
}

new __potionsDefs[NUM_POTIONS][50] =
{
	"$item_mortar_and_pestal",
	"$item_night_sight_potion",
	"$item_cure_potion",
	"$item_agility_potion",
	"$item_strength_potion",
	"$item_poison_potion",
	"$item_energy_potion",
	"$item_lesser_heal_potion",
	"$item_greater_heal_potion",
	"$item_lesser_explosion_potion",
	"$item_explosion_potion",
	"$item_greater_explosion_potion"
}


#define NUM_WANDS 9
new __wands[NUM_WANDS][additemEntry] =
{
	{0x0DF2,"Greater Heal Wand 20 charges"},
	{0x0DF3,"Summon Daemon Wand 5 charges"},
	{0x0DF4,"Magic Arrow Wand 100 charges"},
	{0x0DF5,"Resurrect Wand 1 charge"},
	{0x0F5C,"Fireball Mace 5000 charges"},
	{0x0F5C,"greater healing wand"},
	{0x0F5C,"energy vortex wand"},
	{0x0F5C,"magic arrow wand"},
	{0x0F5C,"ressurection wand"}
}

new __wandsDefs[NUM_WANDS][50] =
{
	"$item_a_wand_of_greater_heal",
	"$item_a_wand_of_summon_daemon",
	"$item_a_wand_of_healing",
	"$item_a_wand_of_resurrection",
	"$item_fire_mace",
	"$item_a_wand_of_greater_healing",
	"$item_a_wand_of_energy_vortex",
	"$item_a_wand_of_magic_arrow",
	"$item_a_wand_of_ressurection"
}

#define NUM_GATES 3
new __gates[NUM_GATES][additemEntry] =
{
	{0x0F6C,"A Blue Moongate"},
	{0x0DDA,"A Red Moongate"},
	{0x1FD4,"A Black Moongate"}
}

new __gatesDefs[NUM_GATES][50] =
{
	"$item_a_blue_moongate",
	"$item_a_red_moongate",
	"$item_a_black_moongate"
}

#define NUM_SCROLLS1 8
new __scrolls1[NUM_SCROLLS1][additemEntry] = 
{
	{0x1F2D,"Reactive Armor Scroll"},
	{0x1F2E,"Clumsy Scroll"},
	{0x1F2F,"Create Food Scroll"},
	{0x1F30,"Feeblemind Scroll"},
	{0x1F31,"Heal Scroll"},
	{0x1F32,"Magic Arrow Scroll"},
	{0x1F33,"Night Sight Scroll"},
	{0x1F34,"Weaken Scroll"}
}   


#define NUM_SCROLLS2 8
new __scrolls2[ NUM_SCROLLS2][additemEntry] =
{
	{0x1F35,"Agility Scroll"},
	{0x1F36,"Cunning Scroll"},
	{0x1F37,"Cure Scroll"},
	{0x1F38,"Harm Scroll"},
	{0x1F39,"Magic TraP_Scroll"},
	{0x1F3A,"Magic UntraP_Scroll"},
	{0x1F3B,"Protection Scroll"},
	{0x1F3C,"Strength Scroll"}
}

#define NUM_SCROLLS3 8
new __scrolls3[ NUM_SCROLLS3][additemEntry] =
{
	{0x1F3D,"Bless Scroll"},
	{0x1F3E,"Fireball Scroll"},
	{0x1F3F,"Magic Lock Scroll"},
	{0x1F40,"Poison Scroll"},
	{0x1F41,"Telekinesis Scroll"},
	{0x1F42,"Teleport Scroll"},
	{0x1F43,"Unlock Scroll"},
	{0x1F44,"Wall of Stone Scroll"}
}

#define NUM_SCROLLS4 8
new __scrolls4[ NUM_SCROLLS4][additemEntry] =
{
	{0x1F45,"Archcure Scroll"},
	{0x1F46,"Arch Protection Scroll"},
	{0x1F47,"Curse Scroll"},
	{0x1F48,"Fire Field Scroll"},
	{0x1F49,"Greater Heal Scroll"},
	{0x1F4A,"Lightning Scroll"},
	{0x1F4B,"ManaDrain Scroll"},
	{0x1F4C,"Recall Scroll"}
}

#define NUM_SCROLLS5 8
new __scrolls5[ NUM_SCROLLS5][additemEntry] =
{
	{0x1F4D,"Blade Spirits Scroll"},
	{0x1F4E,"Dispel Field Scroll"},
	{0x1F4F,"Incognito Scroll"},
	{0x1F50,"Magic Reflection Scroll"},
	{0x1F51,"Mind Blast Scroll"},
	{0x1F52,"Paralyze Scroll"},
	{0x1F53,"Poison Field Scroll"},
	{0x1F54,"Summon Creature Scroll"}
}

#define NUM_SCROLLS6 8
new __scrolls6[ NUM_SCROLLS6][additemEntry] =
{
	{0x1F55,"Dispel Scroll"},
	{0x1F56,"Energy Bolt Scroll"},
	{0x1F57,"Explosion Scroll"},
	{0x1F58,"Invisibility Scroll"},
	{0x1F59,"Mark Scroll"},
	{0x1F5A,"Mass Curse Scroll"},
	{0x1F5B,"Paralyze Field Scroll"},
	{0x1F5C,"Reveal Scroll"}
}

#define NUM_SCROLLS7 8
new __scrolls7[ NUM_SCROLLS7][additemEntry] =
{
	{0x1F5D,"Chain Lightning Scroll"},
	{0x1F5E,"Energy Field Scroll"},
	{0x1F5F,"Flamestrike Scroll"},
	{0x1F60,"Gate Travel Scroll"},
	{0x1F61,"Mana Vampire Scroll"},
	{0x1F62,"Mass Dispel Scroll"},
	{0x1F63,"Meteor Storm Scroll"},
	{0x1F64,"Polymorph Scroll"}
}

#define NUM_SCROLLS8 8
new __scrolls8[ NUM_SCROLLS8][additemEntry] =
{
	{0x1F65,"Earthquake Scroll"},
	{0x1F66,"Energy Vortex Scroll"},
	{0x1F67,"Resurrection Scroll"},
	{0x1F68,"Summon Air Elemental Scroll"},
	{0x1F69,"Summon Daemon Scroll"},
	{0x1F6A,"Summon Earth Elemental Scroll"},
	{0x1F6B,"Summon Fire Elemental Scroll"},
	{0x1F6C,"Summon Water Elemental Scroll"}
}

new __scrolls1Defs[NUM_SCROLLS1][50] =
{
	"$item_a_reactive_armor_scroll",
	"$item_a_clumsy_scroll",
	"$item_a_create_food_scroll",
	"$item_a_feeblemind_scroll",
	"$item_a_heal_scroll",
	"$item_magic_arrow_scroll",
	"$item_a_night_sight_scroll",
	"$item_a_weaken_scroll"
}  

new __scrolls2Defs[NUM_SCROLLS2][50] =
{
	"$item_a_agility_scroll",
	"$item_a_cunning_scroll",
	"$item_a_cure_scroll",
	"$item_a_harm_scroll",
	"$item_magic_trap_scroll",
	"$item_magic_untrap_scroll",
	"$item_a_protection_scroll",
	"$item_a_strength_scroll"
}

new __scrolls3Defs[NUM_SCROLLS3][50] =
{
	"$item_a_bless_scroll",
	"$item_a_fireball_scroll",
	"$item_magic_lock_scroll",
	"$item_a_poison_scroll",
	"$item_a_telekinesis_scroll",
	"$item_a_teleport_scroll",
	"$item_an_unlock_scroll",
	"$item_a_wall_of_stone_scroll"
}

new __scrolls4Defs[NUM_SCROLLS4][50] =
{
	"$item_an_archcure_scroll",
	"$item_an_arch_protection_scroll",
	"$item_a_curse_scroll",
	"$item_a_fire_field_scroll",
	"$item_a_greater_heal_scroll",
	"$item_a_lightning_scroll",
	"$item_a_mana_drain_scroll",
	"$item_a_recall_scroll"
}

new __scrolls5Defs[NUM_SCROLLS5][50] =
{
	"$item_a_blade_spirits_scroll",
	"$item_a_dispel_field_scroll",
	"$item_an_incognito_scroll",
	"$item_magic_reflection_scroll",
	"$item_a_mind_blast_scroll",
	"$item_a_paralyze_scroll",
	"$item_a_poison_field_scroll",
	"$item_a_summon_creature_scroll"
}

new __scrolls6Defs[NUM_SCROLLS6][50] =
{
	"$item_a_dispel_scroll",
	"$item_an_energy_bolt_scroll",
	"$item_an_explosion_scroll",
	"$item_an_invisibility_scroll",
	"$item_a_mark_scroll",
	"$item_a_mass_curse_scroll",
	"$item_a_paralyze_field_scroll",
	"$item_a_reveal_scroll"
}

new __scrolls7Defs[NUM_SCROLLS7][50] =
{
	"$item_a_chain_lightning_scroll",
	"$item_an_energy_field_scroll",
	"$item_a_flamestrike_scroll",
	"$item_a_gate_travel_scroll",
	"$item_a_mana_vampire_scroll",
	"$item_a_mass_dispel_scroll",
	"$item_a_meteor_swarm_scroll",
	"$item_a_polymorph_scroll"
}

new __scrolls8Defs[NUM_SCROLLS8][50] =
{
	"$item_a_earthquake_scroll",
	"$item_a_energy_vortex_scroll",
	"$item_a_resurrection_scroll",
	"$item_a_summon_air_elemental_scroll",
	"$item_a_summon_daemon_scroll",
	"$item_a_summon_earth_elemental_scroll",
	"$item_a_summon_fire_elemental_scroll",
	"$item_a_summon_water_elemental_scroll"
}
     