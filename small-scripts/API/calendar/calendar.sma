#if defined _nxw_calendar_sma_
    #endinput
#endif
#define _nxw_calendar_sma_

/** \addtogroup script_API_calendar
 *  @{
 */


/*!
\fn cal_getYear()
\brief get current game year
\author Sparhawk
\since 0.54b
\return current game year
*/
stock cal_getYear()
{
    return cal_getProperty( CALP_YEAR, _);
}

/*!
\fn cal_getMonth()
\brief get current game month
\author Sparhawk
\since 0.54b
\return current game month
*/
stock cal_getMonth()
{
    return cal_getProperty( CALP_MONTH, _);
}

/*!
\fn cal_getNMonth(const thismonth)
\brief get number of next game month
\author Sparhawk
\since 0.54b
\return number of next game month or -1 if thismonth parameter is out of range (error)
\param thismonth monthnumber to equate next month number from ( 0 denotes current month )
*/
stock cal_getNMonth(const thismonth)
{
    new maxmonth = cal_getMonthMax();
    if (thismonth < 0 || thismonth > maxmonth )
        return -1;
    if (thismonth == 0)
        thismonth = cal_getCMonth();
    if (thismonth == maxmonth)
        return 1;
    else
        return thismonth + 1;
}

/*!
\fn cal_getPMonth(const thismonth)
\brief get number of previous game month
\author Sparhawk
\since 0.54b
\return number of previous game month or -1 if thismonth parameter is out of range (error)
\param thismonth monthnumber to equate next month number from ( 0 denotes current month )
*/
stock cal_getPMonth(const thismonth)
{
    new maxmonth = cal_getMonthMax();
    if (thismonth < 0 || thismonth > maxmonth )
        return -1;
    if (thismonth == 0)
        thismonth = cal_getCMonth();
    if (thismonth == 1)
        return maxmonth;
    else
        return thismonth - 1;
}

/*!
\fn cal_getMonthName(const month, monthname[])
\brief get name of month by number of month
\author Sparhawk
\since 0.54b
\return length of monthname
\param month monthnumber ( 0 denotes current month )
\param monthname the name
\note when using unpacked strings arraysize in declaration should be at least 50 while when using packed strings arraysize should be at least 13
\note month > maximum months defined is reset to maximum month internally
\note month < 0 is reset to 1 internally
*/
stock cal_getMonthName(const month, monthname[])
{
    return cal_getProperty( CALP_MONTHNAME, month, monthname);
}

/*!
\fn cal_getMonthMax()
\brief get number of months in game year
\author Sparhawk
\since 0.54b
\return number of months in game year
*/
stock cal_getMonthMax()
{
    return cal_getProperty( CALP_MONTHMAX, _);
}

/*!
\fn cal_getDay()
\brief get number of current game day
\author Sparhawk
\since 0.54b
\return number of current game day
*/
stock cal_getDay()
{
    return cal_getProperty( CALP_DAY, _);
}

/*!
\fn cal_getWeekday()
\brief get number of current game weekday
\author Sparhawk
\since 0.54b
\return number of current game weekday
*/
stock cal_getWeekday()
{
    return cal_getProperty( CALP_WEEKDAY, _);
}

/*!
\fn cal_getWeekdayName(const weekday, weekdayname[])
\brief get name of weekday by weekday number
\author Sparhawk
\since 0.54b
\return length of weekdayname
\param weekday weekday number ( 0 means current weekday )
\param weekdayname name of weekday
\note weekday < 0 is reset to 1 internally
\note weekday > maximum weekdays defined is reset to maximum weekday internally
\note weekdayname is empty string if not found or no name defined for weekday
\note when using unpacked strings arraysize in declaration should be at least 50 while when using packed strings arraysize should be at least 13
*/
stock cal_getWeekdayName(const weekday, weekdayname[])
{
    return cal_getProperty( CALP_WEEKDAYNAME, weekday, weekdayname);
}

/*!
\fn cal_getWeekdayMax()
\brief get number of weekdays
\author Sparhawk
\since 0.54b
\return number of weekdays
*/
stock cal_getWeekdayMax()
{
    return cal_getProperty( CALP_MAXWEEKDAY, _);
}

/*!
\fn cal_getNWeekday(const thisweekday)
\brief get next game weekday
\author Sparhawk
\since 0.54b
\return next game weekday number or -1 if thisweekday parameter is out of range (error)
\param thisweekday weekday number to equate next weekday number from ( 0 denotes current weekday )
*/
stock cal_getNWeekday(const thisweekday)
{
    new maxweekday = cal_getWeekdayMax();
    if (thisweekday < 0 || thisweekday > maxweekday )
        return -1;
    if (thisweekday == 0)
        thisweekday = cal_getCWeekday();
    if (thisweekday == maxweekday)
        return 1;
    else
        return thisweekday + 1;
}

/*!
\fn cal_getPWeekday(const thisweekday)
\brief get previous game weekday
\author Sparhawk
\since 0.54b
\return weekday number to equate previous weekday number from or -1 if thisweekday parameter is out of range (error)
\param thisweekday weekday number to equate next weekday number from ( 0 denotes current weekday )
*/
stock cal_getPWeekday(const thisweekday)
{
    new maxweekday = cal_getWeekdayMax();
    if (thisweekday < 0 || thisweekday > maxweekday )
        return -1;
    if (thisweekday == 0)
        thisweekday = cal_getCWeekday();
    if (thisweekday == 1)
        return maxweekday;
    else
        return thisweekday - 1;
}

/*!
\fn cal_getHour()
\brief get current game hour
\author Sparhawk
\since 0.54b
\return current game hour
*/
stock cal_getHour()
{
    return cal_getProperty( CALP_HOUR, _);
}

/*!
\fn cal_getMin()
\brief get current game minute
\author Sparhawk
\since 0.54b
\return current game minute
*/
stock cal_getMin()
{
    return cal_getProperty( CALP_MINUTE, _);
}

/*!
\fn cal_getTime(time[])
\brief get current game time (hour and minute)
\author Sparhawk
\since 0.54b
\return none
\param time array of cell[2] cell[0] = hour, cell[1] = minute
*/
stock cal_getTime(time[])
{
    time[0] = cal_getProperty( CALP_HOUR, _);
    time[1] = cal_getProperty( CALP_MINUTE, _);
}

/*!
\fn cal_getDawnHour(const month)
\brief get dawhour for a given month number
\author Sparhawk
\since 0.54b
\return dawnhour
\param month this month
*/
stock cal_getDawnHour(const month)
{
    return cal_getProperty( CALP_DAWHOUR, month);
}

/*!
\fn cal_getDawnMin(const month)
\brief get dawnminute for a given month number
\author Sparhawk
\since 0.54b
\return dawnminute
\param month this month
*/
stock cal_getDawnMin(const month)
{
    return cal_getProperty( CALP_DAWNMINUTE, month);
}

/*!
\fn cal_getDawnTime(const month, time[])
\brief get dawnminute for a given month number
\author Sparhawk
\since 0.54b
\return time array of cell[2] cell[0] = hour, cell[1] = minute
\param month this month
*/
stock cal_getDawnTime(const month, time[])
{
    time[0] = cal_getProperty( CALP_DAWNHOUR, month);
    time[1] = cal_getProperty( CALP_DAWNMINUTE, month);
}

/*!
\fn cal_getSunsetHour(month)
\brief get sunset hour for a given month number
\author Sparhawk
\since 0.54b
\return sunsethour or -1 if month out of range
\param month this month
*/
stock cal_getSunsetHour(month)
{
    return cal_getProperty( CALP_SUNSETHOUR, month);
}

/*!
\fn cal_getSunsetMin(month)
\brief get minute sun sets for a given month number
\author Sparhawk
\since 0.54b
\return sunset minute or -1 if month out of range
\param month this month
*/
stock cal_getSunsetMin(month)
{
    return cal_getProperty( CALP_SUNSETMINUTE, month);
}

/*!
\fn cal_getSunsetTime(const month, time[])
\brief get sunset time (hour and minute) for a given month
\author Sparhawk
\since 0.54b
\return time array of cell[2] cell[0] = hour, cell[1] = minute
\param month this month
*/
stock cal_getSunsetTime(const month, time[])
{
    time[0] = cal_getProperty( CALP_SUNSETHOUR, month);
    time[1] = cal_getProperty( CALP_SUNSETMINUTE, month);
}

/*!
\fn cal_getSeason(const month)
\brief get season for a given month number
\author Sparhawk
\since 0.54b
\return season number or -1 if month out of range
\param month this month
*/
stock cal_getSeason(const month)
{
    return cal_getProperty( CALP_SEASON, month);
}

/** @} */ // end of script_API_calendar