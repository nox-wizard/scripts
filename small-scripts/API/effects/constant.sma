// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// || NoX-Wizard	: Embedded Small Scripts			||
// || Maintained by	: Luxor, Sparhawk				||
// || Last Update	: 06-apr-2003					||
// || Designed for NXW 	: 0.82						||
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#if defined _nxw_effects_constants_
  #endinput
#endif
#define _nxw_effects_constants_

/*!* \defgroup script_API_tempfx_constants Constants
 *  \ingroup script_API_tempfx
 *  @{
 */

/*!
"more" parameter use:<br>
<b>more1:</b> - <br>
<b>more2:</b> - <br>
<b>more3:</b> - <br>
*/
const TFX_SPELL_PARALYZE =  1;    //!< paralyze effect        

/*!
"more" parameter use:<br>
<b>more1:</b> - <br>
<b>more2:</b> - <br>
<b>more3:</b> - <br>
*/
const TFX_SPELL_LIGHT = 2;        //!< light effect

/*!
"more" parameter use:<br>
<b>more1:</b> dex malus<br>
<b>more2:</b> - <br>
<b>more3:</b> - <br>
*/
const TFX_SPELL_CLUMSY = 3;       //!< clumsy spell efect

/*!
"more" parameter use:<br>
<b>more1:</b> int malus<br>
<b>more2:</b> - <br>
<b>more3:</b> - <br>
*/
const TFX_SPELL_FEEBLEMIND = 4;   //!< feeblemind spell effect   
                               
/*!                               
"more" parameter use:<br>                               
<b>more1:</b> str malus                               
<b>more2:</b> - <br>                              
<b>more3:</b> - <br>                             
*/                               
const TFX_SPELL_WEAKEN = 5;       //!< weaken spell effect       
                               
/*!                               
"more" parameter use:<br>                               
<b>more1:</b> dex/stam bonus                               
<b>more2:</b> - <br>                              
<b>more3:</b> - <br>                              
*/                               
const TFX_SPELL_AGILITY = 6;      //!< dex bonus                 
                               
/*!                               
"more" parameter use:<br>                               
<b>more1:</b> int/mana bonus                               
<b>more2:</b> - <br>                           
<b>more3:</b> - <br>                              
*/                               
const TFX_SPELL_CUNNING = 7;      //!< cunning spell effect      
                               
/*!                               
"more" parameter use:<br>                               
<b>more1:</b> str bonus                               
<b>more2:</b> - <br>                              
<b>more3:</b> - <br>                              
*/                               
const TFX_SPELL_STRENGHT = 8;     //!< str bonus                 
                               
/*!                               
"more" parameter use:<br>                               
<b>more1:</b> ? <br>                       
<b>more2:</b> duration<br>                               
<b>more3:</b> - <br>                              
*/                               
const TFX_ALCHEMY_GRIND = 9;      //!< gringing effect with sound

/*!
"more" parameter use:<br>
<b>more1:</b> potion type <br>
<b>more2:</b> potion subtype<br>
<b>more3:</b> - <br>

Potion table
<TABLE>
<TR><TD> POTION </TD><TD> TYPE </TD><TD>SUBTYPE = 1</TD><TD>SUBTYPE = 2</TD><TD>SUBTYPE = 3</TD><TD>SUBTYPE = 4</TD></TR>
<TR><TD>agility </TD><TD> 1 </TD><TD> normal       </TD><TD> greater  </TD><TD>   - <br>      </TD><TD>      - <br>    </TD></TR>
<TR><TD>cure    </TD><TD> 2 </TD><TD> lesser       </TD><TD> normal   </TD><TD>   - <br>      </TD><TD>      - <br>    </TD></TR> 
<TR><TD>explosion </TD><TD> 3 </TD><TD> lesser     </TD><TD> normal   </TD><TD> greater   </TD><TD>      - <br>    </TD></TR> 
<TR><TD>heal    </TD><TD> 4 </TD><TD> lesser       </TD><TD> normal   </TD><TD> greater   </TD><TD>      - <br>    </TD></TR> 
<TR><TD>night sight</TD><TD> 5 </TD><TD> - <br>        </TD><TD>   - <br>     </TD><TD>    - <br>     </TD><TD>      - <br>    </TD></TR> 
<TR><TD>poison  </TD><TD> 6 </TD><TD> lesser       </TD><TD> normal   </TD><TD> greater   </TD><TD>    deadly  </TD></TR>
<TR><TD>refresh </TD><TD> 7 </TD><TD> normal       </TD><TD> total    </TD><TD>    - <br>     </TD><TD>      - <br>    </TD></TR> 
<TR><TD>strenght </TD><TD> 8 </TD><TD> normal      </TD><TD> greater  </TD><TD>    - <br>     </TD><TD>      - <br>    </TD></TR> 
</TABLE>
*/
const TFX_ALCHEMY_END = 10;       //!< end grinding               
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> str/hp bonus <br>                               
<b>more2:</b> dex/stam bonus<br>                               
<b>more3:</b> int/mana bonus<br>                               
*/                                
const TFX_SPELL_BLESS = 11;       //!< bless spell effect         
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> str malus <br>                               
<b>more2:</b> dex malus <br>                               
<b>more3:</b> int malus <br>                               
*/                                
const TFX_SPELL_CURSE = 12;       //!< curse spell effect         
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> - <br>                               
<b>more2:</b> - <br>                               
<b>more3:</b> - <br>                               
*/                                
const TFX_AUTODOOR = 13;          //!< automatic door closing     
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> - <br>                               
<b>more2:</b> - <br>                               
<b>more3:</b> - <br>                               
*/                                
const TFX_TRAINDUMMY = 14;        //!< training dummy effect      
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> - <br>                               
<b>more2:</b> - <br>                               
<b>more3:</b> - <br>                               
*/                                
const TFX_SPELL_REACTARMOR = 15;  //!< reactive armor spell effect
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> - <br>                               
<b>more2:</b> duration <br>                               
<b>more3:</b> ? <br>                               
*/                                
const TFX_EXPLOTIONMSG = 16;      //!< ??                         
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> - <br>                               
<b>more2:</b> - <br>                               
<b>more3:</b> - <br>                               
*/                                
const TFX_EXPLOTIONEXP = 17;      //!< ??                         
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> bodyID <br>                               
<b>more2:</b> - <br>                               
<b>more3:</b> - <br>                               
*/                                
const TFX_SPELL_POLYMORPH = 18;   //!< polymorph effect           
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> - <br>                               
<b>more2:</b> - <br>                               
<b>more3:</b> - <br>                               
*/                                
const TFX_SPELL_INCOGNITO = 19;   //!< incognito effect           
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> - <br>                               
<b>more2:</b> - <br>                               
<b>more3:</b> - <br>                               
*/                                
const TFX_LSD = 20;               //!< lsd effect                 
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> - <br>                               
<b>more2:</b> - <br>                               
<b>more3:</b> - <br>                               
*/                                
const TFX_SPELL_PROTECTION = 21;  //!< protectionspell effect     
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> - <br>                               
<b>more2:</b> - <br>                               
<b>more3:</b> - <br>                               
*/                                
const TFX_HEALING_HEAL = 22;      //!< heal effect                
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> - <br>                               
<b>more2:</b> - <br>                               
<b>more3:</b> - <br>                               
*/                                
const TFX_HEALING_RESURRECT = 23; //!< resurrect effect           
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> - <br>                               
<b>more2:</b> - <br>                               
<b>more3:</b> - <br>                               
*/                                
const TFX_HEALING_CURE = 24;      //!< cure effect                
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> - <br>                               
<b>more2:</b> - <br>                               
<b>more3:</b> - <br>                               
*/                                
const TFX_POTION_DELAY = 25;      //!< potion delay               
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> duration <br>                               
<b>more2:</b> - <br>                               
<b>more3:</b> - <br>                               
*/                                
const TFX_GM_HIDING = 33;         //!< GM hiding                  
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> duration <br>                               
<b>more2:</b> - <br>                               
<b>more3:</b> - <br>                               
*/                                
const TFX_GM_UNHIDING = 34;       //!< GM unhiding                
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> ho healed <br>                               
<b>more2:</b> ? <br>                               
<b>more3:</b> duration <br>                               
*/                                
const TFX_HEALING_DELAYHEAL = 35; //!< ??                         
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> - <br>                               
<b>more2:</b> - <br>                               
<b>more3:</b> - <br>                               
*/                                
const TFX_COMBAT_PARALYZE = 44;   //!< paralyze                   
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> - <br>                               
<b>more2:</b> - <br>                               
<b>more3:</b> - <br>                               
*/                                
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> int malus <br>                               
<b>more2:</b> - <br>                               
<b>more3:</b> - <br>                               
*/                                
const TFX_COMBAT_CONCUSSION = 45; //!< concussion effect          
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> more1 <br>                               
<b>more2:</b> more2 <br>                               
<b>more3:</b> more3 <br>                               
*/                                
const TFX_AMXCUSTOM = 121;        //!< custom tempfx              
                                
/*!                                
"more" parameter use:<br>                                
<b>more1:</b> - <br>                               
<b>more2:</b> - <br>                               
<b>more3:</b> - <br>                               
*/                                
const TFX_GREY = 122;             //!< grey timer                 

const TFXM_START = 0;
const TFXM_END = 1;
const TFXM_ON = 2;
const TFXM_OFF = 3;
const TFXM_REVERSE = 4;

/*!* @} */ // end of script_const_trigger
