enum
{ 
	CRP_START_X = 0,
	CRP_START_Y,
	CRP_MAX_X,
	CRP_MAX_Y,
	CRP_CURRENT_X,
	CRP_CURRENT_Y,
	CRP_INTERLINE,
	CRP_TAB,
	CRP_GRID_X,
	CRP_GRID_Y,
	CRP_COUNT
}

enum
{
	INTERLINE_SINGLE = 10,
	INTERLINE_DOUBLE = 20,
	INTERLINE_TRIPLE= 30,
}

static crp[CRP_COUNT] =
{
	0,
	0,
	640,
	480,
	0,
	0,
	10,
	10,
	7,
	18	
};

stock cursor_restoreDefaults()
{
	crp[2] = 640;
	crp[3] = 480;
	crp[6] = crp[7] = 10;
	crp[8] = 7;
	crp[9] = 18;
}

stock cursor_setProperty(prop,val)
{
	crp[prop] = val;
}

stock cursor_getProperty(prop)
{
	return crp[prop];
}

stock cursor_x()
{
	return crp[CRP_CURRENT_X];	
}

stock cursor_y()
{
	return crp[CRP_CURRENT_Y];	
}


stock cursor_reset()
{
	crp[CRP_CURRENT_X] = crp[CRP_START_X];
	crp[CRP_CURRENT_Y] = crp[CRP_START_Y];
}

stock cursor_back()
{
	crp[CRP_CURRENT_X] = crp[CRP_START_X];
}

stock cursor_top()
{
	crp[CRP_CURRENT_Y] = crp[CRP_START_Y];
}

stock cursor_bottom()
{
	crp[CRP_CURRENT_Y] = crp[CRP_MAX_Y];
}

stock cursor_eol()
{
	crp[CRP_CURRENT_X] = crp[CRP_MAX_X];
}

stock cursor_newline(...)
{
	new n = 1;
	if(numargs()) n = getarg(0);
	crp[CRP_CURRENT_X] = crp[CRP_START_X]; 
	cursor_down(n);
	return cursor_isOutOfBounds();
}

stock cursor_move(dx,dy)
{
	crp[CRP_CURRENT_X] += dx;
	crp[CRP_CURRENT_Y] += dy;
	return cursor_isOutOfBounds();
}

stock cursor_goto(newX,newY)
{
	crp[CRP_CURRENT_X] = newX;
	crp[CRP_CURRENT_Y] = newY;
	return cursor_isOutOfBounds();
}

stock cursor_right(...)
{
	new n = 1;
	if(numargs()) n = getarg(0);
	crp[CRP_CURRENT_X] += n*crp[CRP_GRID_X];
	return cursor_isOutOfBounds();
}

stock cursor_down(...)
{
	new n = 1;
	if(numargs()) n = getarg(0);
	crp[CRP_CURRENT_Y] += n*(crp[CRP_INTERLINE]*crp[CRP_GRID_Y])/10;
	return cursor_isOutOfBounds();
}

stock cursor_up(...)
{
	new n = 1;
	if(numargs()) n = getarg(0);
	crp[CRP_CURRENT_Y] -= n*(crp[CRP_INTERLINE]*crp[CRP_GRID_Y])/10;
	return cursor_isOutOfBounds();
}

stock cursor_left(...)
{
	new n = 1;
	if(numargs()) n = getarg(0);
	crp[CRP_CURRENT_X] -= n*crp[CRP_GRID_X];
	return cursor_isOutOfBounds();
}

stock cursor_tab(...)
{
	new n = 1;
	if(numargs()) n = getarg(0);
	new tab = crp[CRP_TAB];
	new ntabs = (crp[CRP_CURRENT_X] - crp[CRP_START_X])/crp[CRP_GRID_X]/crp[CRP_TAB];
	crp[CRP_CURRENT_X] = crp[CRP_START_X] + n*(ntabs + 1)*tab*crp[CRP_GRID_X]
	return cursor_isOutOfBounds();
}

stock cursor_backtab()
{
	new n = 1;
	if(numargs()) n = getarg(0);
	return cursor_tab(-1*n);
}

stock cursor_isOutOfBounds()
{
	if(crp[CRP_CURRENT_X] < crp[CRP_START_X] ||
	crp[CRP_CURRENT_Y] < crp[CRP_START_Y] ||
	crp[CRP_CURRENT_X] > crp[CRP_MAX_X] ||
	crp[CRP_CURRENT_Y] > crp[CRP_MAX_Y])
	return 1;
	return 0;
}