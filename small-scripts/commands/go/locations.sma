/*!
\defgroup script_commands_go_locations locations
\ingroup script_commands_go
@{
*/

//new __locationsFile[] = "scripts/location.xss";

enum locationStruct
{
	__locX,
	__locY,
	__locZ,
	__locName: 50
}      

#define NUM_LOCATIONS 144
new __locations[NUM_LOCATIONS][locationStruct] =
{
	// **************
	// GM locations
	// **************
	{5276	,1164	,0	,"Jail Cell 1"},
	{5286	,1164	,0	,"Jail Cell 2"},
	{5296	,1164	,0	,"Jail Cell 3"},
	{5306	,1164	,0	,"Jail Cell 4"},
	{5276	,1174	,0	,"Jail Cell 5"},
	{5286	,1174	,0	,"Jail Cell 6"},
	{5296	,1174	,0	,"Jail Cell 7"},
	{5306	,1174	,0	,"Jail Cell 8"},
	{5283	,1184	,0	,"Jail Cell 9"},
	{5304	,1184	,0	,"Jail Cell 10"},
	{5691	,1501	,0	,"Help Desk of Hell"},
	{5681	,1497	,0	,"Help Room Backdoor"},
	{5445	,1153	,0	,"Green Acres"},
	{0	,0	,0	,"Error Spawn Location"},

	// **************
	// Town Locations
	// **************
	{1323	,1624	,55	,"Britain - Lord British's Throne"},
	{1533	,1415	,56	,"Britain - Blackthorne's Castle"},
	{1475	,1645	,20	,"Britain - Center"},
	{1401	,1625	,28	,"Britain - Lord British Castle Entrance"},
	{1523	,1456	,15	,"Britain - Blackthorn Castle Entrance"},
	{1662	,1572	,5	,"Britain - Suburbs"},
	{1614	,1641	,35	,"Britain - Park"},
	{1228	,1705	,0	,"Britain - Farmlands"},
	{1384	,1497	,10	,"Graveyard"},
	{2736	,2166	,0	,"Bucca - Docks"},
	{2667	,2084	,5	,"Bucca - Bathhouse"},
	{2691	,2233	,2	,"Bucca - Pirate's Plunder Tavern"},
	{2667	,2069	,236	,"Hidden Caves"},
	{2285	,1209	,0	,"Cove - Gates"},
	{2218	,1116	,19	,"Guard Post"},
	{2171	,1332	,0	,"Orc Fort"},
	{2443	,1123	,5	,"Cemetary"},

	//Jhelom
	{1414	,3816	,0	,"Jhelom - Main Island"},
	{1398	,3742	,235	,"Jhelom - Fighting Pit"},
	{1492	,3696	,0	,"Jhelom - East Docks"},
	{1296	,3719	,0	,"Jhelom - Cemetary"},
	{1124	,3623	,5	,"Jhelom - Medium Island"},
	{1466	,4015	,5	,"Jhelom - Small Island"},

	//Magincia
	{3675	,2259	,20	,"Magincia - Docks"},
	{3792	,2248	,20	,"Magincia - Parliament"},
	{3719	,2063	,25	,"Magincia - Park"},

	//MInoc
	{2475	,417	,15	,"Minoc - North"},
	{2526	,583	,0	,"Minoc - South"},
	{2540	,651	,0	,"Minoc - Gypsy Camp"},
	{2539	,501	,30	,"Minoc - Bridge"},
	{2583	,528	,15	,"Minoc - Mining Camp"},

	//Moonglow
	{4442	,1122	,5	,"Moonglow - Center"},
	{4406	,1045	,5	,"Moonglow - Docks"},
	{4707	,1124	,0	,"Moonglow - Telescope"},
	{4549	,1378	,8	,"Moonglow - Zoo"},
	{4546	,1338	,8	,"Moonglow - Cemetary"},

	//Nujel'm
	{3803	,1279	,5	,"Nujel'm - Docks"},
	{3698	,1279	,20	,"Nujel'm - Palace"},
	{3668	,1116	,0	,"Nujel'm - North"},
	{3755	,1227	,0	,"Nujel'm - East"},
	{3572	,1211	,0	,"Nujel'm - West"},
	{3728	,1360	,5	,"Nujel'm - Chess board"},
	{3536	,1156	,20	,"Nujel'm - Cemetary"},

	//Guard post
	{3650	,2653	,0	,"Guard post - Docks"},
	{3650	,2516	,0	,"Guard post - North"},
	{3722	,2647	,20	,"Guard post - Farmlands"},

	//Serpent's hold
	{3023	,3417	,15	,"Serpent's - North"},
	{2945	,3393	,15	,"Serpent's - West Docks"},
	{2906	,3505	,10	,"Serpent's - South"},
	{3011	,3526	,15	,"Serpent's - South Guardpost"},

	//Skara brae
	{639	,2236	,0	,"Skara brae - West Docks"},
	{601	,2171	,0	,"Skara brae - West"},
	{716	,2233	,253	,"Skara brae - East Docks"},
	{899	,2381	,0	,"Skara brae - South"},
	{746	,2165	,0	,"Skara brae - North"},
	{811	,2243	,0	,"Skara brae - East"},

	//Trinsic
	{1927	,2779	,0	,"Trinsic - Center"},
	{1832	,2779	,0	,"Trinsic - West Gate"},
	{2000	,2930	,0	,"Trinsic - South Gate"},
	{1894	,2666	,0	,"Trinsic - North"},
	{1891	,2850	,20	,"Trinsic - South"},
	{2071	,2855	,253	,"Trinsic - East Docks"},
	{2108	,2793	,2	,"Trinsic - Island Park"},

	//Vesper
	{2882	,788	,0	,"Vesper - Center"},
	{3013	,828	,253	,"Vesper - Docks"},
	{2907	,603	,0	,"Vesper - North"},
	{276	,981	,0	,"Vesper - East"},
	{2786	,867	,0	,"Vesper - Grave Yard"},

	//Wind
	{1362	,896	,0	,"Wind - Outside Entrance"},
	{5166	,244	,15	,"Wind - Caves"},
	{5223	,189	,5	,"Wind - South"},
	{5336	,88	,25	,"Wind - East"},
	{5180	,90	,26	,"Wind - West"},
	{5211	,22	,15	,"Wind - Park"},
	{535	,992	,0	,"Wind - Center"},

	{635	,860	,0	,"Empath Abbey"},
	{354	,836	,20	,"Courts & Prisons"},
	{313	,787	,230	,"Hidden Cave"},
	{724	,1138	,0	,"Cemetary"},
	{633	,1499	,0	,"Orc Fort"},

	// *******
	// Shrines
	// *******
	{1456	,854	,0	,"Srine - Chaos"},
	{1856	,872	,255	,"Srine - Compassion"},
	{4217	,564	,35	,"Srine - Honesty"},
	{1730	,3528	,0	,"Srine - Honor"},
	{4276	,3699	,0	,"Srine - Humility"},
	{1301	,639	,15	,"Srine - Justice"},
	{3355	,299	,9	,"Srine - Sacrifice"},
	{1589	,2485	,5	,"Srine - Spirituality"},
	{2496	,3932	,0	,"Srine - Valor"},

	// ********
	// Dungeons
	// ********

	//Covetous
	{2499	,919	,0	,"Covetous - Outside Entrance"},
	{5456	,1863	,0	,"Covetous - Level 1"},
	{5614	,1997	,0	,"Covetous - Level 2"},
	{5579	,1924	,0	,"Covetous - Level 3"},
	{5467	,1805	,5	,"Covetous - Lake Room"},
	{5552	,1807	,0	,"Covetous - Torture Rooms"},

	{4111	,432	,5	,"Outside Entrance"},
	{5188	,638	,0	,"Level 1"},
	{5305	,533	,2	,"Level 2"},
	{5137	,650	,5	,"Level 3"},
	{5306	,652	,2	,"Level 4"},

	//Despise
	{1298	,1080	,0	,"Despise - Outside Entrance"},
	{5587	,631	,30	,"Despise - Entryway"},
	{5501	,570	,59	,"Despise - Level 1 *UP*"},
	{5519	,673	,20	,"Despise - Level 2 *DOWN*"},
	{5407	,859	,45	,"Despise - Level 3"},

	//Destard
	{1176	,2637	,0	,"Destard - Outside Entrance"},
	{5243	,1006	,0	,"Destard - Level 1"},
	{5143	,801	,5	,"Destard - Level 2"},
	{5137	,986	,5	,"Destard - Level 3"},

	{4721	,3822	,0	,"Outside Entrance"},
	{5905	,20	,46	,"Level 1"},
	{5976	,169	,0	,"Level 2"},
	{6083	,145	,236	,"Level 3"},
	{6059	,89	,24	,"Level 4"},

	{514	,1561	,0	,"Outside Entrance"},
	{5395	,126	,0	,"Level 1"},
	{5515	,11	,5	,"Level 2"},
	{5514	,148	,25	,"Level 3"},
	{5875	,20	,251	,"Level 4"},

	//Wrong
	{2043	,238	,10	,"Wrong - Outside Entrance"},
	{5825	,630	,0	,"Wrong - Level 1"},
	{5690	,569	,25	,"Wrong - Level 2"},
	{5703	,639	,0	,"Wrong - Level 3"},

	{4596	,3630	,30	,"Hythloth Firepit"},
	{885	,1682	,0	,"Yew/Britain Brigand Camp"},
	{972	,768	,0	,"Yew Fort of the Damned"},
	// **********
	// Lost Lands
	// **********
	{6032	,1499	,27	,"Britain Sewers"},
	{5736	,3196	,11	,"Papua - mage shop"},
	{5219	,4028	,37	,"Delucia center"},
	{1998	,81	,5	,"Ice Dungeon"}
}
