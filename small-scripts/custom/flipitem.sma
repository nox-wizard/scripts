//use _SplitAndFlip to flip (turn) an item or to split it (changing a picture pile of bottles into another for example)

public _SplitAndFlip(const itm, const chr)
{
	new itmx = itm_getProperty(itm, IP_POSITION, IP2_X); // Ausgabe der
	new itmy = itm_getProperty(itm, IP_POSITION, IP2_Y); // Char und der Item Position
	new itmz = itm_getProperty(itm, IP_POSITION, IP2_Z);
	
	printf("item is %d and at: %d, %d^n", itm,itmx,itmy);
	//check if character can move the item
	//ratio = -1: item too far
	//ratio = 0: item too heavy
	//ratio > 10: item can be moved
	new ratio = chr_canMoveItem(chr,itm,true);
	if(ratio >= 10)
		itm_flip(itm);
}