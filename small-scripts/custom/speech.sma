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
                           