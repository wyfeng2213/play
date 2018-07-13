package util;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;




public class DateTimeUtils {
	
	
    
    private SimpleDateFormat dateTimeFormat = null;
    
    private SimpleDateFormat dateFormat = null;
    
    private SimpleDateFormat timeFormat = null;
    
    public static ParsePosition parsePos = null;
    
    private static final int TYPE_DATE_TIME = 1;
    
    private static final int TYPE_DATE = 2;
    
    private static final int TYPE_TIME = 3;

    private static final String errPreFix = "com.wondertek.contract.util.TimeTool.";

    
    private DateTimeUtils(int type) {
        if (type == TYPE_DATE_TIME) {
            dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        } else if (type == TYPE_DATE) {
            dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        } else if (type == TYPE_TIME) {
            timeFormat = new SimpleDateFormat("HH:mm:ss");
        } else {
            throw new IllegalArgumentException(errPreFix + "type error:type = "
                                               + type);
        }
        parsePos = new ParsePosition(0);
    }

    
    public static int getTimeNow(){
		int now=0;
		Long tmpNow=new Long(System.currentTimeMillis())/1000;
		now =tmpNow.intValue();
		return now;
	}
    
    
    public static String getYearMonthStr(String year, String month) {
        int intMonth = Integer.parseInt(month) + 1;
        return year + "-" + (intMonth < 10 ? "0" + intMonth : "" + intMonth);
    }

    
    public static Calendar getCalenarDate() {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        return calendar;
    }

    
    public static boolean before(int[] yearMonth01, int[] yearMonth02) {
        return yearMonth01[0] < yearMonth02[0]
            || yearMonth01[0] == yearMonth02[0] && yearMonth01[1] < yearMonth02[1];
    }

    
    public static boolean after(int[] yearMonth01, int[] yearMonth02) {
        return yearMonth01[0] > yearMonth02[0]
            || yearMonth01[0] == yearMonth02[0] && yearMonth01[1] > yearMonth02[1];
    }

    
    public static boolean equals(int[] yearMonth01, int[] yearMonth02) {
        return yearMonth01[0] == yearMonth02[0] && yearMonth01[1] == yearMonth02[1];
    }

    
    public static boolean equalsYearMonthDay(Calendar calendar01, Calendar calendar02) {
        return calendar01.get(Calendar.YEAR) == calendar02.get(Calendar.YEAR)
            && calendar01.get(Calendar.MONTH) == calendar02.get(Calendar.MONTH)
            && calendar01.get(Calendar.DAY_OF_MONTH) == calendar02.get(Calendar.DAY_OF_MONTH);
    }

    
    public static String getWeekShow(int week) {
        if (week < 1 || week > 7) {
            return null;
        }
        String[] WEEK = {
            "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"
        };
        return WEEK[week - 1];
    }

    
    public static void addMonth(int[] yearMonth, int amount) {
        int year = yearMonth[0];
        int month = yearMonth[1];
        if (month < 0 || month > 11) {
            throw new IllegalArgumentException(
                errPreFix +"addMonth month is invaid:month = " + month);
        }
        year += amount / 12;
        month += amount % 12;
        if (month < 0) {
            month += 12;
            year--;
        } else if (month > 11) {
            month -= 12;
            year++;
        }
        yearMonth[0] = year;
        yearMonth[1] = month;
    }

    
    public static int diffOfDay(Calendar calendar1, Calendar calendar2) {
        long time = diffOfMillis(calendar1, calendar2);
        return (int)(time / (1000 * 60 * 60 * 24));
    }
    
      
    public static int daysBetween(Date date1,Date date2)  
    {  
        Calendar cal = Calendar.getInstance();  
        cal.setTime(date1);  
        long time1 = cal.getTimeInMillis();               
        cal.setTime(date2);  
        long time2 = cal.getTimeInMillis();       
        long between_days=(time2-time1)/(1000*3600*24);  
          
       return Integer.parseInt(String.valueOf(between_days));         
    }  
    
    public static int hoursBetween(Date date1,Date date2)  
    {  
        Calendar cal = Calendar.getInstance();  
        cal.setTime(date1);  
        long time1 = cal.getTimeInMillis();               
        cal.setTime(date2);  
        long time2 = cal.getTimeInMillis();       
        long between=(time2-time1)/(1000*3600);  
          
       return Integer.parseInt(String.valueOf(between));         
    }  
    
    public static int minsBetween(Date date1,Date date2)  
    {  
        Calendar cal = Calendar.getInstance();  
        cal.setTime(date1);  
        long time1 = cal.getTimeInMillis();               
        cal.setTime(date2);  
        long time2 = cal.getTimeInMillis();       
        long between=(time2-time1)/(1000*60);  
          
       return Integer.parseInt(String.valueOf(between));         
    }  

    
    public static int diffOfField(Calendar calendar1, Calendar calendar2, int field) {
        return Math.abs(calendar1.get(field) - calendar2.get(field));
    }

    
    public static long diffOfMillis(Calendar calendar1, Calendar calendar2) {
        return Math.abs(calendar1.getTimeInMillis() - calendar2.getTimeInMillis());
    }

    
    public static String longToStrDateTime(long time) {
        return dateToStrDateTime(new Date(time));
    }

    
    public static Date longToDateTime(long time) {
        return new Date(time);
    }
    
    
    
    public static Calendar longToCalendar(long time) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(time);
        return calendar;
    }

    
    public static long strDateTimeToLong(String str) {
        return strDateTimeToDate(str).getTime();
    }

    
    public static long calendarToLong(Calendar calendar) {
        if (calendar == null) {
            return -1;
        }
        return calendar.getTimeInMillis();
    }

    
    public static String getDateTime() {
        return dateToStrDateTime(new Date());
    }

    
    public static String getDate() {
        return dateToStrDate(new Date());
    }

    
    public static String getTime() {
        return dateToStrTime(new Date());
    }

    
    public static Date strDateTimeToDate(String str) {
        if (str == null || str.trim().length() == 0) {
            return null;
        }
        if (str.length() == 10) {
            str += " 00:00:00";
        }
        if (str.length() == 16) {
        	str += ":00";
        }

        Date date = new DateTimeUtils(TYPE_DATE_TIME).dateTimeFormat.parse(str, parsePos);
        return date;
    }

    
    public static Calendar strDateTimeToCalendar(String str) {
        Calendar calendar = Calendar.getInstance();
        Date date = strDateTimeToDate(str);
        if (date == null) {
            return null;
        }
        calendar.setTime(date);
        return calendar;
    }

    
    public static Calendar strToCalendar(String str) {
        return strDateTimeToCalendar(str);
    }

    
    public static Date strDateToDate(String str) {
        if (str == null || str.trim().length() == 0) {
            return null;
        }
        if (str.length() == 7) {
            str += "-01 00:00:00";
        }
        Date date = new DateTimeUtils(TYPE_DATE).dateFormat.parse(str, parsePos);
        return date;
    }

    
    public static Calendar strDateToCalendar(String str) {
        Calendar calendar = Calendar.getInstance();
        Date date = strDateToDate(str);
        if (date == null) {
            return null;
        }
        calendar.setTime(date);
        return calendar;
    }

    
    public static String dateToStrDateTime(Date date) {
        if (date == null) {
            return null;
        }
        String str = new DateTimeUtils(TYPE_DATE_TIME).dateTimeFormat.format(date);
        return str;
    }

    
    public static String calendarToStrDateTime(Calendar calendar) {
        if (calendar == null) {
            return null;
        }
        return dateToStrDateTime(calendar.getTime());
    }

    
    public static String dateToStrDate(Date date) {
        if (date == null) {
            return null;
        }
        String str = new DateTimeUtils(TYPE_DATE).dateFormat.format(date);
        return str;
    }

    
    public static String calendarToStrDate(Calendar calendar) {
        if (calendar == null) {
            return null;
        }
        return dateToStrDate(calendar.getTime());
    }

    
    public static String dateToStrTime(Date date) {
        if (date == null) {
            return null;
        }
        String str = new DateTimeUtils(TYPE_TIME).timeFormat.format(date);
        return str;
    }

    
    public static Long dateToLongTime(Date date) {
        if (date == null) {
            return null;
        }
        return date.getTime();
    }
    
    
    public static String calendarToStrTime(Calendar calendar) {
        if (calendar == null) {
            return null;
        }
        return dateToStrTime(calendar.getTime());
    }

    
    public static boolean equalsMonth(Date date1 , Date date2) {
    	Calendar cal1 = Calendar.getInstance();
    	cal1.setTime(date1);
    	Calendar cal2 = Calendar.getInstance();
    	cal2.setTime(date2);
        return cal1.get(Calendar.MONTH) == cal2.get(Calendar.MONTH);
    }

    
    public static int monthsDayNum(Date date){
    	Calendar cal = Calendar.getInstance();
 	    cal.setTime(date);
 	    return cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    }

    
    public static int dayOfMonth(Date date){
    	Calendar cal = Calendar.getInstance();
 	    cal.setTime(date);
 	    return cal.get(Calendar.DAY_OF_MONTH);
    }

    
    public static Date dayIndexOfMonth(Date date, int index){
    	Calendar cal = Calendar.getInstance();
 	    cal.setTime(date);
 	    cal.set(Calendar.DAY_OF_MONTH, index);
 	    return cal.getTime();
    }

    
    public static Date firstDayOfMonth(Date date){
    	Calendar cal = Calendar.getInstance();
 	    cal.setTime(date);
 	    cal.set(Calendar.DAY_OF_MONTH, 1);
 	    return cal.getTime();
    }

    
    public static Date lastDayOfMonth(Date date){
    	Calendar cal = Calendar.getInstance();
 	    cal.setTime(date);
 	    //cal.set(Calendar.DAY_OF_MONTH, -1); 这种方式是有问题 2013-07-28 当获取最后一天时候会拿到的是2013-06-29
 	    int dayNum = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
 	    cal.set(Calendar.DAY_OF_MONTH, dayNum);
 	    return cal.getTime();
    }

    
    public static int diffLastMonth(Date date){
    	Calendar cal = Calendar.getInstance();
 	    cal.setTime(date);
 	    return cal.get(Calendar.DAY_OF_WEEK) - 1;
    }

    
    /*public static int weeksDayNumOfMonth(Date date){
    	Calendar cal = Calendar.getInstance();
 	    cal.setTime(date);
 	    return 7 - cal.get(Calendar.DAY_OF_WEEK) + 1;
    }*/

    
    public static int weekNumOfMonth(Date date){
    	Calendar cal = Calendar.getInstance();
 	    cal.setTime(date);
 	    return cal.getActualMaximum(Calendar.WEEK_OF_MONTH);
    }

    
    public static Date weekFirstDay(Date date, int week, int day){
    	Calendar cal = Calendar.getInstance();
 	    cal.setTime(date);
 	    cal.set(Calendar.WEEK_OF_MONTH, week);
 	    cal.set(Calendar.DAY_OF_WEEK, day);
 	    return cal.getTime();
    }
    
    
    public static int dayOfWeek(Date date){
    	Calendar cal = Calendar.getInstance();
 	    cal.setTime(date);
 	    return cal.get(Calendar.DAY_OF_WEEK);
    }


    /*public static void main(String[] args){
    	Calendar cal = Calendar.getInstance();
    	System.out.println(Tool.formatDateDay(firstDayOfMonth(cal.getTime())));
    }*/
}