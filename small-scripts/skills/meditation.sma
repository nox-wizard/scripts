new chr_x[512];  
new chr_y[512];  
//new chr_z;  
#define REGEN_RATE 4;  
 
public __meditation(const c)  
 {  
printf("Med status %d^n",chr_getProperty(c,CP_MEDITATING));  
 
if ( chr_getProperty(c,CP_WAR)==1 )  
 {  
      chr_message( c, _,"You are in war mode!");  
      return;  
 }  
 
if ( chr_getProperty(c,CP_CASTING)==1 )  
 {  
      chr_message( c, _,"You are casting spell!");  
      return;  
 }  
 
 
if ( chr_getProperty(c,CP_WEIGHT) > ( chr_getStr(c)*3+chr_getDex(c)*3) )  
 {  
      chr_message( c, _,"You are carring too much!");  
      return;  
 }  
 
 
//printf ("%d %d ^n",chr_getItemOnLayer(c, 0x01) ,chr_getItemOnLayer(c, 0x02));  
 
//Not working due to bug in chr_getItemOnLayer  
//if (chr_getItemOnLayer(c, 0x01) ||   chr_getItemOnLayer(c, 0x02))  
// {  
//      chr_message( c, _,"Your hands must be free!");  
//      return;  
// }  
 
 
 
if ( chr_getProperty(c,CP_MEDITATING)==1 )  
 {  
      chr_message( c, _,"You are already meditating!");  
      return;  
 }  
 
if (chr_checkSkill(c,46,0,1000,1))  
 {  
      chr_x[c] = chr_getProperty(c, CP_POSITION, CP2_X);  
      chr_y[c] = chr_getProperty(c, CP_POSITION, CP2_Y);  
      chr_setProperty(c,CP_MEDITATING,_,1);  
      chr_sound(c, 0x00f9);  
      chr_speech(NPC_EMOTE_ALL,-1,c,"*Meditating*",0);  
      tempfx_activate(_, c,c,0,REGEN_RATE, funcidx("meditation_cal"));  
 }  
 
 }  
 
public meditation_cal(const c, const dest, const power, const mode)  
 {
if (mode == TFXM_END)  
 {  
      if (chr_getProperty(c,CP_MEDITATING))  
       {  
            if (chr_x[c] != chr_getProperty(c, CP_POSITION, CP2_X))  
             {  
                  chr_message( c, _,"You lost your concentration");  
                  return;  
             }  
 
            if (chr_y[c] != chr_getProperty(c, CP_POSITION, CP2_Y))  
             {  
                  chr_message( c, _,"You lost your concentration");  
                  return;  
             }  
 
            if (random(10) > 5)  
             {  
                  chr_speech(NPC_EMOTE_ALL,-1,c,"*Meditating*",0);  
             }  
 
            new act_mana = chr_getMana(c);  
            new bonus =   chr_getProperty(c,CP_SKILL,46)/100;  
 
            if (bonus*100 > chr_getProperty(c,CP_SKILL,46))  
             {  
                  bonus--;  
             }  
            new sub_bonus = (bonus+1)*100-chr_getProperty(c,CP_SKILL,46);  
            if (random(100) < sub_bonus)  
             {  
                  sub_bonus = 1;  
             }  
            else  
             {  
                  sub_bonus = 0;  
             }  
//         printf("%d %d",bonus, sub_bonus);  
            act_mana = act_mana + bonus + sub_bonus;  
            if (act_mana > chr_getInt(c))  
             {  
                  chr_setMana(c,chr_getInt(c));  
                  chr_speech(NPC_EMOTE_ALL,-1,c,"*Stops meditating*",0);  
                  chr_setProperty(c,CP_MEDITATING,_,0);  
                  return;  
             }  
            chr_setMana(c,act_mana);  
            if (chr_checkSkill(c,46,0,1000,0))  
             {  
                  tempfx_activate(_, c,c,0,REGEN_RATE, funcidx("meditation_cal"));  
             }  
       }  
      else  
       {  
            chr_speech(NPC_EMOTE_ALL,-1,c,"*Stops meditating*",0);  
            chr_setProperty(c,CP_MEDITATING,_,0);  
            return;  
       }  
 }  
 
 }  
