
/*
\fn __charLogout(const chr)
\param chr: the character who is logging out
\brief handles login stuff

Use this function to call a script at character logout, do not put code in the function but call
an extern function
*/

public __charLogout(const chr)
{
	removeOnlineStaff(chr);
	if(tempfx_isActive( chr, _, funcidx("hungertimer"))) //stop hunger timer, else our whole server population dies while being logged off ... :P
		tempfx_delete( chr, _, false, funcidx("hungertimer"));
}
