//use _SplitAndFlip to flip (turn) an item or to split it (changing a picture pile of bottles into another for example)

public _SplitAndFlip(const itm, const chr)
{
	//printf("item is %d and at: %d, %d^n", itm,itmx,itmy);
	//check if character can move the item
	//ratio = -1: item too far
	//ratio = 0: item too heavy
	//ratio > 10: item can be moved
	new ratio = chr_canMoveItem(chr,itm,true);
	if(ratio >= 10)
		itm_flip(itm);
}