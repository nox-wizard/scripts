// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard Scripts (override.sma/amx)                               ||
// || Maintained by Sparhawk and Luxor                                    ||
// || Last Update 2002-09-11                                              ||
// || -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- ||
// || This file should contain only includes to your own scripts :)       ||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

/*! \mainpage Nox Wizard Documentation
 *
 * \section intro Introduction
 * \include docs/license.sma
 * \include docs/installation.sma
 * \include docs/code/reference.sma
 *
 * Nox Wizard is an Ultima Online Emulator ect ect
 *
 * <br>
 * <br>
 *
 * This manual is divided into three parts, each of which is divided into several sections.
 *
 * The first part forms a user manual:
 *
 * \section user User
 * <UL>
 * 	<LI> \ref p_installation
 * 	<LI> \ref p_license
 * </UL>
 * <br>
 * The second part forms a reference manual for scripter:
 *
 * \section script Script
 * <UL>
 *  <LI> \ref p_script_dummies
 * 	<LI> \ref p_small
 * 	<LI> \ref XSS
 * </UL>
 *
 * The third part provides information for developers:
 *
 * \section p_source Source
 * <UL>
 * 	<LI> \ref p_reference
 * </UL>
 * <BR><BR>
 */

//
// Include NoX-Wizard small constants
//
#include "small-scripts/calendar/constant.sma"
#include "small-scripts/character/constant.sma"
#include "small-scripts/effects/constant.sma"
#include "small-scripts/event/constant.sma"
#include "small-scripts/guild/constant.sma"
#include "small-scripts/item/constant.sma"
#include "small-scripts/menu/constant.sma"
#include "small-scripts/misc/constant.sma"
#include "small-scripts/skills/constant.sma"
#include "small-scripts/timer/constant.sma"
#include "small-scripts/variable/constant.sma"
#include "small-scripts/race/constant.sma"
//
// Include the NoX-Wizard small api
//
#include "small-scripts/calendar/calendar.api"
#include "small-scripts/character/character.api"
#include "small-scripts/kernel/core.api"
#include "small-scripts/direct/direct.api"
#include "small-scripts/effects/effects.api"
#include "small-scripts/event/trigger.api"
#include "small-scripts/file/file.api"
#include "small-scripts/float/float.api"
#include "small-scripts/guild/guild.api"
#include "small-scripts/item/item.api"
#include "small-scripts/item/itemId.api"
#include "small-scripts/log/log.api"
#include "small-scripts/magic/magic.api"
#include "small-scripts/map/map.api"
#include "small-scripts/menu/mnu.api"
#include "small-scripts/menu/menu.api"
#include "small-scripts/misc/misc.api"
#include "small-scripts/network/network.api"
#include "small-scripts/region/region.api"
#include "small-scripts/set/set.api"
#include "small-scripts/string/string.api"
#include "small-scripts/target/target.api"
#include "small-scripts/time/time.api"
#include "small-scripts/timer/timer.api"
#include "small-scripts/variable/variable.api"
#include "small-scripts/race/race.api"
//
// Include the NoX-Wizard small scripts
//
#include "small-scripts/include/nxw_lib"
#include "small-scripts/calendar/calendar.sma"
#include "small-scripts/skills/skills.sma"
#include "small-scripts/misc/default.sma"
#include "small-scripts/item/potiondelay.sma"
//#include "small-scripts/gumps/gumps.sma"
#include "small-scripts/commands/commands.sma"
#include "small-scripts/guild/guildstone.sma"
#include "small-scripts/check/check.sma"
#include "small-scripts/skills/misc/scissors.sma"
#include "small-scripts/race/menu/menu.sma"
//
// Include the Shard's script
//
#include "small-scripts/myshard.sma"




