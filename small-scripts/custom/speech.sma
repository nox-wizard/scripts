
public bla_char(const c)
{
new speech[20];
chr_getProperty(c, CP_STR_SPEECHWORD, 0, speech );
printf("speech1: %s", speech);
if( !strcmp( speech, "+" ) )
{
CHI_CommandMgt(c);
bypass();
}
}

public CHI_CommandMgt(const c)
{
printf("speech2");
new speech[150];
new command[30];
new parameter[120];
chr_getProperty(c, CP_STR_SPEECH, 0, speech);   //get speech
speech[0]=' ';   //remove command character
ltrim(speech);   //remove triming spaces
str2Token(speech, command, 0, parameter, 0);
str2upper(command);
trim(parameter);
if( !strcmp(command, "HUNGER") ) //to make sure: was said HUNGER?
{
_hunger(c); //a command that takes no param
bypass();
}
else if( !strcmp(command, "LANG") ) //to make sure: was said  LANG?
{
_racelang(c); //a command that takes no param
bypass();
}
else if( !strcmp(command, "TWEAK") ) //to make sure: was said  EDIT?
{
command_tweak(c); //a command that takes no param
bypass();
}
else if( !strcmp(command, "POLY") ) //to make sure: was said  POLY?
{
command_polymorph(c); //a command that takes no param
bypass();
}
}

public _hunger (const c) 
{ 
new hunger = chr_getLocalIntVar(c, 1002);//Hungervalue
new thirst = chr_getLocalIntVar(c, 1003);//thirst value

switch(hunger)
        {
        case 0..1: chr_message( c, _, "You must eat something immediatelly or you will die in 1 minute!");
        case 2..11: chr_message( c, _, "You must eat something very very fast or you will die from hunger!");
        case 12..21: chr_message( c, _, "You are extremly hungry!");
        case 22..31: chr_message( c, _, "You are very hungry and start feeling dizzy!");
        case 32..41: chr_message( c, _, "You are really hungry and your stomache growls loudly!");
        case 42..51: chr_message( c, _, "You stomach starts growling by hunger!");
        case 52..61: chr_message( c, _, "You are bit hungry.");
        case 62..71: chr_message( c, _, "You could have something to eat.");
        case 72..81: chr_message( c, _, "You feel satisfied.");
        case 82..91: chr_message( c, _, "You are well fed.");
        case 92..100: chr_message( c, _, "You are absolutly stuffed.");
        default: 
               {
               chr_message( c, _, "You die from starving too long!");
               }
        }

switch(thirst)
      {
      case 0..1: chr_message( c, _, "And you must drink something immediatelly or you will die in 1 minute!^n");
      case 2..11: chr_message( c, _, "And you must drink something very very fast or you will die from thirst!^n");
      case 12..21: chr_message( c, _, "And you are extremly thirsty!^n");
      case 22..31: chr_message( c, _, "And you are very thirsty and start feeling dizzy!^n");
      case 32..41: chr_message( c, _, "And you are really hungry and your tongue sticks in your mouth!^n");
      case 42..51: chr_message( c, _, "And your tongue starts becoming sticky by thirst!^n");
      case 52..61: chr_message( c, _, "And you are bit thirsty.^n");
      case 62..71: chr_message( c, _, "And you could have something to drink.^n");
      case 72..81: chr_message( c, _, "And you don't need to drink anything.^n");
      case 82..91: chr_message( c, _, "And you feel absolutely no thirst.^n");
      case 92..100: chr_message( c, _, "And your belly is filled with liquid.^n");
      default: 
             {
             chr_message( c, _, "And you die from being thirsty too long!^n");
             }
      }
} 

public _racelang(const source)
{
      new c = source;
      new race = chr_getProperty(c, CP_NPCRACE ); 
      new name[50] ;  
      chr_getProperty(c, CP_STR_NAME, _ ,name);
      new str[200] ;  
      chr_getProperty(c, CP_STR_SPEECH, _ ,str);
      
//position of player  
 
      new ch_x = chr_getProperty(c, CP_POSITION, CP2_X);  
      new ch_y = chr_getProperty(c, CP_POSITION, CP2_Y);  
 
//get the chars in range.  
 
      new in_range = set_create(); 
      set_addOnPlNearXY( in_range,ch_x,ch_y,10 );    
 
      while(set_size(in_range)>0)  
       {  
            new near_cc = set_getChar(in_range); 
            if (near_cc)  
             {  
                  new textbuff[50];
                  if ((chr_getProperty(c, CP_NPCRACE ) == race) || ( random(80) < chr_getInt(near_cc)))  
                   {  
                   //str[5] cuts ".lang" from the begining
                        chr_message( c, _,"Ihr versteht wie %s sagt: %s",name,str[5]);  
                   }
                   else 
                   {
                   	chr_speech(NPC_TALK_RUNIC ,-1,c, "bla");
                        chr_message( c, _," %s sagt etwas, in einer unbekannten Sprache.",name);
                   }
             }  
       }
        set_delete(in_range); 
 }  

/*public taubemachen(source)
{
	new c = source;
        new taube = itm_spawnBackpack(s, 70000 );
        //Containerserial des Items ermitteln
        new contser = itm_getProperty(source, IP_CONTAINERSERIAL, 4)<<24+itm_getProperty(source, IP_CONTAINERSERIAL, 3)<<16+itm_getProperty(source, IP_CONTAINERSERIAL, 2)<<8+itm_getProperty(source, IP_CONTAINERSERIAL, 1);
        // auf Item-MoreB speichern
        itm_setProperty(itm_getDualByteProperty(taube, IP_ID), IP_MOREB, 4, contser>>24);
        itm_setProperty(itm_getDualByteProperty(taube, IP_ID), IP_MOREB, 3, contser>>16&0xFF);
        itm_setProperty(itm_getDualByteProperty(taube, IP_ID), IP_MOREB, 2, contser>>8&0xFF);
        itm_setProperty(itm_getDualByteProperty(taube, IP_ID), IP_MOREB, 4, contser&0xFF);
        //Charname ermitteln
        new name[50];
        chr_getProperty(c, CP_STR_NAME,0,name);
        //itemname setzen (Brieftaube an ...)
        
        itm_setProperty(70000, IP_STR_NAME, _, "Brieftaube an %s", name ); 
        //itm_setContSerial(const item, const serial);
}
*/
                           