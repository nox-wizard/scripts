new chr_x[512];  
new chr_y[512];  
//new chr_z;  
 
public __meditation(const c)  
 {  
printf("Med status %d^n",chr_getProperty(c,CP_MEDITATING));  
 
if ( chr_getProperty(c,CP_WAR)==1 )  
 {  
      chr_message( c, _,msg_sk_meditDef[0]);  
      return;  
 }  
 
if ( chr_getProperty(c,CP_CASTING)==1 )  
 {  
      chr_message( c, _,msg_sk_meditDef[1]);  
      return;  
 }  
 
 
if ( chr_getProperty(c,CP_WEIGHT) > ( chr_getStr(c)*3+chr_getDex(c)*3) )  
 {  
      chr_message( c, _,msg_sk_meditDef[2]);  
      return;  
 }  
 
 
//printf ("%d %d ^n",chr_getItemOnLayer(c, 0x01) ,chr_getItemOnLayer(c, 0x02));  
 
//Not working due to bug in chr_getItemOnLayer  
//if (chr_getItemOnLayer(c, 0x01) ||   chr_getItemOnLayer(c, 0x02))  
// {  
//      chr_message( c, _,msg_sk_meditDef[3]);  
//      return;  
// }  
 
 
 
if ( chr_getProperty(c,CP_MEDITATING)==1 )  
 {  
      chr_message( c, _,msg_sk_meditDef[4]);  
      return;  
 }  
 
if (chr_checkSkill(c,46,0,1000,1))  
 {  
      chr_x[c] = chr_getProperty(c, CP_POSITION, CP2_X);  
      chr_y[c] = chr_getProperty(c, CP_POSITION, CP2_Y);  
      chr_setProperty(c,CP_MEDITATING,_,1);  
      chr_sound(c, 0x00f9);  
      chr_emoteAll(c,msg_sk_meditDef[5]);  
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
                  chr_message( c, _,msg_sk_meditDef[6]);  
                  return;  
             }  
 
            if (chr_y[c] != chr_getProperty(c, CP_POSITION, CP2_Y))  
             {  
                  chr_message( c, _,msg_sk_meditDef[6]);  
                  return;  
             }  
 
            if (random(10) > 5)  
             {  
                  chr_emoteAll(c,msg_sk_meditDef[5]);  
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
                  chr_emoteAll(c,msg_sk_meditDef[7]);  
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
            chr_emoteAll(c,msg_sk_meditDef[7]);  
            chr_setProperty(c,CP_MEDITATING,_,0);  
            return;  
       }  
 }  
 
 }  
