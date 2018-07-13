package util;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.Locale;

public class DateUtils {
    public static final long DEFAULT_DATE = -5364691200000L;

    public static final String DATE_YYYYMM_PATTERN = "yyyyMM";
    public static final String DATE_YEAR_MONTH_PATTERN = "yyyy-MM";
    public static final String DATE_YEAR_PATTERN = "yyyy";
    public static final String DATE_PATTERN = "yyyy-MM-dd";
    public static final String DATE_TIME_PATTERN = "yyyy-MM-dd HH:mm:ss";
    public static final String DATE_SHORTTIME_PATTERN = "yyyy-MM-dd HH:mm";
    public static final String DATE_PATTERN_2 = "yyyy/MM/dd";
    public static final String DATE_POINT_PATTERN = "yyyy.MM.dd";
    public static final String DATE_POINT2_PATTERN = "yyyy.MM";
    public static final String DATE_YYYYMMDDHHmm="yyyy年MM月dd日 HH:mm";

    public static final String OUTPUT_LOG_DATE_TIME_PATTERN ="[yyyy/MM/dd HH:mm:ss]";

    public static final long TIME_OF_A_DAY = 24 * 60 * 60 * 1000;

    public static final long TIME_OF_A_HOUR = 60 * 60 * 1000;


    /**
     * 获得输出日志的时间。格式：[yyyy/MM/dd HH:mm:ss]
     *
     * @return 输出日志的时间字符串
     */
    public static String getOutputLogTime() {
        return new SimpleDateFormat(OUTPUT_LOG_DATE_TIME_PATTERN).format(new Date());
    }

    public static Timestamp getCurrentTimestamp() {
        return new Timestamp(System.currentTimeMillis());
    }

    
    public static Date string2Date(String dateString, String pattern) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        Date date = sdf.parse(dateString);
        return date;
    }

    
    public static String timestamp2String(String format, Date time) {
        if (format == null) {
            format = DATE_PATTERN;
        }
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(format);

        if (time == null) {
            return null;
        }
        return formatter.format(time);
    }

    
    public static Date string2Month(String dateString) throws ParseException {
        Date date = new SimpleDateFormat(DATE_YEAR_MONTH_PATTERN).parse(dateString);
        return date;
    }
    
    
    public static Date string2Date(String dateString) throws ParseException {
        Date date = DateFormat.getDateInstance(DateFormat.MEDIUM, Locale.CHINA).parse(dateString);
        return date;
    }

    
    public static Date string2DateTime(String dateString) throws ParseException {
        Date date = DateFormat.getDateTimeInstance(DateFormat.MEDIUM, DateFormat.MEDIUM, Locale.CHINA)
                .parse(dateString);
        return date;
    }

    
    public static String getCurrentTime() {
        return getTimeFromTimestamp(getCurrentTimestamp());
    }

    
    public static String getTimeFromTimestamp(Date timestamp) {
        return timestamp2String(DATE_TIME_PATTERN, timestamp);
    }

    
    public static String getCurrentDate() {
        return getDateFromTimestamp(getCurrentTimestamp());
    }

    
    public static String getDateFromTimestamp(Date timestamp) {
        return timestamp2String(DATE_PATTERN, timestamp);
    }
    
    
    public static String getDateFromMonthstamp(Date timestamp) {
        return timestamp2String(DATE_YEAR_MONTH_PATTERN, timestamp);
    }

    
    public static String getDateFromShortTimestamp(Date timestamp) {
        return timestamp2String(DATE_SHORTTIME_PATTERN, timestamp);
    }

    
    public static String getDateFromMillisecond(Long s) {
        return timestamp2String(DATE_PATTERN, new Date(s));
    }

    
    public static String getDateTimeFromTimestamp(Date timestamp) {
        return timestamp2String(DATE_TIME_PATTERN, timestamp);
    }

    
    public static String getDateTimeFromMillisecond(Long s) {
        return timestamp2String(DATE_TIME_PATTERN, new Date(s));
    }
    
    
    public static boolean validateDayIsToday(Date timestamp) {
        return timestamp2String(DATE_PATTERN, timestamp).equals(timestamp2String(DATE_PATTERN, new Date()));
    }
    
    
    public static boolean afterAll(String time1, String time2) throws ParseException {
        
        Locale locale;
        locale = Locale.ENGLISH;
        
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", locale);
            Date date1 = sdf.parse(time1);
            Date date2 = sdf.parse(time2);
            return date1.after(date2);
        } catch (ParseException e) {

        }
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm", locale);
            Date date1 = sdf.parse(time1);
            Date date2 = sdf.parse(time2);
            return date1.after(date2);
        } catch (ParseException e1) {

        }
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", locale);
            Date date1 = sdf.parse(time1);
            Date date2 = sdf.parse(time2);
            return date1.after(date2);
        } catch (ParseException e2) {

        }
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM", locale);
            Date date1 = sdf.parse(time1);
            Date date2 = sdf.parse(time2);
            return date1.after(date2);
        } catch (ParseException e3) {

        }
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy", locale);
            Date date1 = sdf.parse(time1);
            Date date2 = sdf.parse(time2);
            return date1.after(date2);
        } catch (ParseException e3) {

        }
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy", locale);
            Date date1 = sdf.parse(time1);
            Date date2 = sdf.parse(time2);
            return date1.after(date2);
        } catch (Exception e4) {

        }
        throw new IllegalArgumentException("参数非法:" + time1);
    }
    
    
    public static boolean after(String time1, String time2) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat(DATE_TIME_PATTERN);
        Date date1 = dateFormat.parse(time1);
        Date date2 = dateFormat.parse(time2);
        return date1.after(date2);
    }
    
    
    public static boolean after(Date date1, Date date2) throws ParseException {
        return date1.after(date2);
    }

    
    public static boolean before(String time1, String time2) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat(DATE_TIME_PATTERN);
        Date date1 = dateFormat.parse(time1);
        Date date2 = dateFormat.parse(time2);
        return date1.before(date2);
    }
    
    
    public static boolean before(Date date1, Date date2) throws ParseException {
        return date1.before(date2);
    }

    
    public static boolean beforeTime(String time1, String time2) throws ParseException {
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.MEDIUM, DateFormat.MEDIUM, Locale.CHINA);
        Date date1 = dateFormat.parse(time1);
        Date date2 = dateFormat.parse(time2);
        return date1.before(date2);
    }

    
    public static boolean between(String midDate, String startDate, String endDate) throws ParseException {
        boolean rt = false;
        if (!(before(midDate, startDate)) && !after(midDate, endDate)) {
            rt = true;
        }
        return rt;
    }
    
    
    
    public static boolean between(Date midDate, Date startDate, Date endDate) throws ParseException {
        boolean rt = false;
        if (!(before(midDate, startDate)) && !after(midDate, endDate)) {
            rt = true;
        }
        return rt;
    }

    
    public static boolean equals(String time1, String time2) throws ParseException {
        DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.MEDIUM, Locale.CHINA);
        Date date1 = dateFormat.parse(time1);
        Date date2 = dateFormat.parse(time2);
        return date1.equals(date2);
    }

    
    public static int compareDate(String time1, String time2) throws ParseException {
        DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.MEDIUM, Locale.CHINA);
        Date date1 = dateFormat.parse(time1);
        Date date2 = dateFormat.parse(time2);
        long quot;
        quot = date1.getTime() - date2.getTime();
        quot = quot / 1000 / 60 / 60 / 24;
        int day = new Long(quot).intValue();
        return day;
    }

    
    public static String addDaysToDate(String date, int addDays) throws ParseException {
        DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.MEDIUM, Locale.CHINA);
        Date oldDate = dateFormat.parse(date);
        long t1 = oldDate.getTime();
        return getDateFromTimestamp(new Timestamp(t1 + addDays * TIME_OF_A_DAY));
    }
    
    public static String addDaysToDateSecond(String date, int addDays) throws ParseException {
        DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.MEDIUM, Locale.CHINA);
        Date oldDate = dateFormat.parse(date);
        long t1 = oldDate.getTime();
        return getDateTimeFromTimestamp(new Timestamp(t1 + addDays * TIME_OF_A_DAY));
    }

    
    public static Date addDaysToDate(Date date, int addDays){
        long t1 = date.getTime();
        return new Timestamp(t1 + addDays * TIME_OF_A_DAY);
    }
    

    
    public static String addHoursToHour(Date date, int addHours) throws ParseException {
        long t1 = date.getTime();
        return getDateTimeFromTimestamp(new Timestamp(t1 + addHours * TIME_OF_A_HOUR));
    }

    
    public static String addDaysToDateTime(String date, int addDays) throws ParseException {
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.MEDIUM, DateFormat.MEDIUM, Locale.CHINA);
        Date oldDate = dateFormat.parse(date);
        long t1 = oldDate.getTime();
        return getDateTimeFromTimestamp(new Timestamp(t1 + addDays * TIME_OF_A_DAY));
    }

    
    public static String addMonthsToDate(String date, int addMonths) throws ParseException {
        DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.MEDIUM, Locale.CHINA);
        Date oldDate = dateFormat.parse(date);

        Calendar c = Calendar.getInstance();
        c.setTime(oldDate);
        c.add(Calendar.MONTH, addMonths);
        return fullfillDateTime(DateFormat.getDateInstance(DateFormat.MEDIUM, Locale.CHINA).format(c.getTime()));
    }

    
    public static String addMonthsToDateTime(String date, int addMonths) throws ParseException {
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.MEDIUM, DateFormat.MEDIUM, Locale.CHINA);
        Date oldDate = dateFormat.parse(date);

        Calendar c = Calendar.getInstance();
        c.setTime(oldDate);
        c.add(Calendar.MONTH, addMonths);
        return fullDateTime(DateFormat.getDateTimeInstance(DateFormat.MEDIUM, DateFormat.MEDIUM, Locale.CHINA).format(
                c.getTime()));
    }

    
    public static String addDaysToDateAccordingGivenCalendar(String date, int addDays, Collection<String> holidays)
            throws ParseException {
        String result = date;

        if (addDays > 0) {
            for (int i = 0; i < addDays; i++) {
                result = getNextWorkday(result, holidays);
            }
        } else if (addDays < 0) {
            for (int i = 0; i > addDays; i--) {
                result = getLastWorkday(result, holidays);
            }
        }

        return result;
    }

    
    public static String getNextWorkday(String today, Collection<String> holidays) throws ParseException {
        String next = today;
        for (;;) {
            next = addDaysToDate(next, 1);
            if (!isHoliday(next, holidays)) {
                return next;
            }
        }
    }

    
    public static String getLastWorkday(String today, Collection<String> holidays) throws ParseException {
        String last = today;
        for (;;) {
            last = addDaysToDate(last, -1);
            if (!isHoliday(last, holidays)) {
                return last;
            }
        }
    }

    
    public static String getEndDate(String startDate, int workDates, Collection<String> holidays) throws ParseException {
        return addDaysToDateAccordingGivenCalendar(startDate, workDates - 1, holidays);
    }

    
    public static int getDelay(String oldDate, String newDate, Collection<String> holidays) throws ParseException {
        int workDates = getWorkdates(oldDate, newDate, holidays);
        return (workDates > 0) ? workDates - 1 : ((workDates < 0) ? workDates + 1 : 0);
    }

    
    public static boolean isHoliday(String date, Collection<String> holidays) {
        return holidays.contains(date);
    }

    
    public static int getWorkdates(String startDate, String endDate, Collection<String> holidays) throws ParseException {
        if (equals(startDate, endDate)) {
            return 1;
        }

        boolean asc = before(startDate, endDate);
        String temp = startDate;
        int result = 0;
        for (;;) {
            if (asc) {
                result++;
            } else {
                result--;
            }
            temp = asc ? getNextWorkday(temp, holidays) : getLastWorkday(temp, holidays);

            if ((asc && after(temp, endDate)) || (!asc && before(temp, endDate))) {
                return result;
            }
        }
    }

    
    public static String fullfillDateTime(String date) throws ParseException {
        DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.MEDIUM, Locale.CHINA);
        Date oldDate = dateFormat.parse(date);
        long t = oldDate.getTime();
        return getDateFromTimestamp(new Timestamp(t));
    }

    
    public static String fullDateTime(String date) throws ParseException {
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.MEDIUM, DateFormat.MEDIUM, Locale.CHINA);
        Date oldDate = dateFormat.parse(date);
        long t = oldDate.getTime();
        return getDateTimeFromTimestamp(new Timestamp(t));
    }

    
    public static String getWeekRange(String date) throws ParseException {
        return getWeekRange(string2Date(date));
    }

    
    public static String getWeekRange(Date date) {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
        /*
         * 日期从周一到周日 Date monday = (Date) date.clone(); monday.setTime(monday.getTime() - TIME_OF_A_DAY *
         * (dayOfWeek-1-1)); Date sunday = (Date) date.clone(); sunday.setTime(sunday.getTime() + TIME_OF_A_DAY *
         * (7-dayOfWeek+1)); return getDateFromTimestamp(monday) + " ~ " + getDateFromTimestamp(sunday);
         */
        Date sunday = (Date) date.clone();
        sunday.setTime(sunday.getTime() - TIME_OF_A_DAY * (dayOfWeek - 1));
        Date saturday = (Date) date.clone();
        saturday.setTime(saturday.getTime() + TIME_OF_A_DAY * (7 - dayOfWeek));

        return getDateFromTimestamp(sunday) + " ~ " + getDateFromTimestamp(saturday);

    }

    
    public static String getWeekRange() {
        return getWeekRange(new Date());
    }

    
    public static int getWeekOfYear(String date) throws ParseException {
        return getWeekOfYear(string2Date(date));
    }

    
    public static int getWeekOfYear(Date date) {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        return c.get(Calendar.WEEK_OF_YEAR);
    }

    
    public static int getWeekOfYear() {
        return getWeekOfYear(new Date());
    }

    
    public static int getDayOfMonth(String date) throws ParseException {
        DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.MEDIUM, Locale.CHINA);
        Date oldDate;
        oldDate = dateFormat.parse(date);
        Calendar c = Calendar.getInstance();
        c.setTime(oldDate);
        return c.get(Calendar.DAY_OF_MONTH);

    }

    public static String getWeekStart() {
        return getWeekStart(getWeekRange());
    }

    public static String getWeekStart(Date date) {
        return getWeekStart(getWeekRange(date));
    }

    public static String getWeekStart(String weekRange) {
        return weekRange.split("\\s~\\s")[0];
    }

    public static String getWeekEnd() {
        return getWeekEnd(getWeekRange());
    }

    public static String getWeekEnd(Date date) {
        return getWeekEnd(getWeekRange(date));
    }

    public static String getWeekEnd(String weekRange) {
        return weekRange.split("\\s~\\s")[1];
    }

    
    public static String convertSecondTohhMMss(Long sec) throws ParseException {
        StringBuffer timeStr = new StringBuffer();
        int h = (int) (sec / (60 * 60));// 小时
        int minTemp = (int) (sec % (60 * 60));
        int m = (int) minTemp / 60;// 分
        int s = (int) (minTemp % 60);// 秒

        timeStr.append(h < 10 ? "0" + h : h).append(":").append(m < 10 ? "0" + m : m).append(":")
                .append(s < 10 ? "0" + s : s);
        return timeStr.toString();
    }

    
    public static String reformatDate(String date, String oldFormat, String newFormat) throws ParseException {
        DateFormat format = new SimpleDateFormat(oldFormat);
        Date d = format.parse(date);
        return format.format(d);
    }

    public static Timestamp toDateTime(String arg) {
        Locale locale;
        Timestamp ret;
        locale = Locale.ENGLISH;
        if (arg == null || "".equals(arg))
            return null;
        ret = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", locale);
            ret = new Timestamp(sdf.parse(arg).getTime());
            return ret;
        } catch (ParseException e) {

        }
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm", locale);
            ret = new Timestamp(sdf.parse(arg).getTime());
            return ret;
        } catch (ParseException e1) {

        }
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", locale);
            ret = new Timestamp(sdf.parse(arg).getTime());
            return ret;
        } catch (ParseException e2) {

        }
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM", locale);
            ret = new Timestamp(sdf.parse(arg).getTime());
            return ret;
        } catch (ParseException e3) {

        }

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy", locale);
            return new Timestamp(sdf.parse(arg).getTime());
        } catch (Exception e4) {

        }
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy.M", locale);
            ret = new Timestamp(sdf.parse(arg).getTime());
            return ret;
        } catch (ParseException e5) {

        }
        throw new IllegalArgumentException("参数非法:" + arg);
    }

    public static Timestamp toDateTime(String arg, boolean defaultValue) {
        Timestamp ret;
        if (!defaultValue)
            return toDateTime(arg);
        if (arg == null || "".equals(arg))
            return new Timestamp(System.currentTimeMillis());
        ret = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            ret = new Timestamp(sdf.parse(arg).getTime());
            return ret;
        } catch (ParseException e) {

        }
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            ret = new Timestamp(sdf.parse(arg).getTime());
            return ret;
        } catch (ParseException e1) {

        }
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            ret = new Timestamp(sdf.parse(arg).getTime());
            return ret;
        } catch (ParseException e2) {

        }
        return new Timestamp(System.currentTimeMillis());
    }

    public static Date toDate(String arg) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            return sdf.parse(arg);
        } catch (ParseException e) {

        }
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            return sdf.parse(arg);
        } catch (ParseException e1) {

        }
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            return sdf.parse(arg);
        } catch (ParseException e2) {

        }
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
            return sdf.parse(arg);
        } catch (ParseException e2) {

        }
        return new Date();
    }

    public static String toDateFormat(Timestamp datetime) {
        return toDateFormat(datetime, null);
    }

    public static String toDateFormat(Date datetime) {
        return toDateFormat(datetime, null);
    }

    public static String toDateFormat(Timestamp datetime, String pattern) {
        SimpleDateFormat sdf = null;
        if (datetime == null)
            return null;
        try {
            if (pattern == null) {
                pattern = "yyyy-MM-dd HH:ss";
            }
            sdf = new SimpleDateFormat(pattern);
        } catch (Exception e) {
            sdf = new SimpleDateFormat("yyyy-MM-dd HH:ss");
        }
        return sdf.format(datetime);
    }

    public static String toDateFormat(Date datetime, String pattern) {
        SimpleDateFormat sdf = null;
        if (datetime == null)
            return null;
        try {
            if (pattern == null)
                pattern = "yyyy-MM-dd HH:ss";

            sdf = new SimpleDateFormat(pattern);
        } catch (Exception e) {
            sdf = new SimpleDateFormat("yyyy-MM-dd HH:ss");
        }
        return sdf.format(datetime);
    }

    public static Date getDefaultDate() {
        return new Date(0);
    }

    public static Date getDayDate(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        return cal.getTime();
    }

    
    public static Date getTodayLast(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY, 23);
        cal.set(Calendar.MINUTE, 59);
        cal.set(Calendar.SECOND, 59);
        cal.set(Calendar.MILLISECOND, 999);
        return cal.getTime();
    }
    
    
    public static Date getToday23(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY, 23);
        cal.set(Calendar.MINUTE, 00);
        cal.set(Calendar.SECOND, 00);
        cal.set(Calendar.MILLISECOND, 999);
        return cal.getTime();
    }

    
    public static Date getToday() {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        return cal.getTime();
    }

    
    public static int getAgeByBirthday(Date birthday) {
        Calendar cal = Calendar.getInstance();

        if (cal.before(birthday)) {
            throw new IllegalArgumentException("The birthDay is before Now.It's unbelievable!");
        }

        int yearNow = cal.get(Calendar.YEAR);
        int monthNow = cal.get(Calendar.MONTH) + 1;
        int dayOfMonthNow = cal.get(Calendar.DAY_OF_MONTH);

        cal.setTime(birthday);
        int yearBirth = cal.get(Calendar.YEAR);
        int monthBirth = cal.get(Calendar.MONTH) + 1;
        int dayOfMonthBirth = cal.get(Calendar.DAY_OF_MONTH);

        int age = yearNow - yearBirth;

        if (monthNow <= monthBirth) {
            if (monthNow == monthBirth) {
                // monthNow==monthBirth
                if (dayOfMonthNow < dayOfMonthBirth) {
                    age--;
                }
            } else {
                // monthNow>monthBirth
                age--;
            }
        }
        return age;
    }

    
    public static String getDateTimeInstanceFull(Date date) {
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.FULL, DateFormat.FULL);
        return dateFormat.format(date);
    }

    
    public static String getDateTimeInstanceShort(Date date) {
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT);
        return dateFormat.format(date);
    }

    public static String getDateTimeInstanceMEDIUM(Date date) {
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.MEDIUM, DateFormat.MEDIUM);
        return dateFormat.format(date);
    }

    
    public static String time2ChineseDate(Date date) {
        String formatDate = timestamp2String("yyyy年M月d日", date);
        String hour = timestamp2String("H", date);
        Integer hourInt = Integer.parseInt(hour);
        String str = "";
        if (hourInt > 12) {
            str = "下午" + (hourInt - 12);
        } else {
            str = "上午" + hourInt;
        }
        return formatDate + " " + str + timestamp2String(":mm", date);
    }
    
    public static String[] time2ChineseStrs(Date date) {
        String formatDate = timestamp2String("yyyy年M月d日", date);
        String hour = timestamp2String("H", date);
        Integer hourInt = Integer.parseInt(hour);
        String str = "";
        if (hourInt > 12) {
            str = "下午";
            hourInt=hourInt - 12;
        } else {
            str = "上午";
        }
        String [] strs=new String[3];
        strs[0]=hourInt+""+timestamp2String(":mm", date);
        strs[1]=str;
        strs[2]=formatDate;
        return strs;
    }
    
    public static String time2ChineseDateFormat(Date date) {
        String formatDate = timestamp2String("yyyy年M月d号", date);
        String hour = timestamp2String("H", date);
        Integer hourInt = Integer.parseInt(hour);
        String str = "";
        if (hourInt > 12) {
            str = "下午" + (hourInt - 12);
        } else {
            str = "上午" + hourInt;
        }
        return formatDate + " " + str + timestamp2String(":mm分", date);
    }
    
    
    public static String time3ChineseDateFormat(Date date) {
        return timestamp2String("yyyy年M月d日", date);
    }
    
    public static long calculationIntervalDay(Date date) {
        long time = date.getTime();
        long current = (new Date()).getTime();
        return (current - time) / (1000 * 60 * 60 * 24);
    }
    
    
    public static Long getDaysBetween(Date startDate, Date endDate) {  
        Calendar fromCalendar = Calendar.getInstance();  
        fromCalendar.setTime(startDate);  
        fromCalendar.set(Calendar.HOUR_OF_DAY, 0);  
        fromCalendar.set(Calendar.MINUTE, 0);  
        fromCalendar.set(Calendar.SECOND, 0);  
        fromCalendar.set(Calendar.MILLISECOND, 0);  
  
        Calendar toCalendar = Calendar.getInstance();  
        toCalendar.setTime(endDate);  
        toCalendar.set(Calendar.HOUR_OF_DAY, 0);  
        toCalendar.set(Calendar.MINUTE, 0);  
        toCalendar.set(Calendar.SECOND, 0);  
        toCalendar.set(Calendar.MILLISECOND, 0);  
  
        return (toCalendar.getTime().getTime() - fromCalendar.getTime().getTime()) / (1000 * 60 * 60 * 24);  
    } 
    
    public static Date addSeconds(Date date, int amount) {
        if (date == null) {
            throw new IllegalArgumentException("The date must not be null");
        }
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(Calendar.SECOND, amount);
        return c.getTime();
    }

    
    public static String showBeInterviewDateFormat(Date date) {

        String[] weekDays = { "周日", "周一", "周二", "周三", "周四", "周五", "周六" };
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);

        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
        if (w < 0) {
            w = 0;
        }

        SimpleDateFormat dateFm = new SimpleDateFormat("yyyy-MM-dd");

        SimpleDateFormat dateFm1 = new SimpleDateFormat("HH:mm");

        return new StringBuilder().append(dateFm.format(date)).append(" ").append(weekDays[w]).append(" ")
                .append(dateFm1.format(date)).toString();
    }

    public static void main(String[] args) {
/*    SimpleDateFormat dateFormat = new SimpleDateFormat(DATE_PATTERN);
    try {
        String dfString=dateFormat.format(new Date());
        Date date=dateFormat.parse(dfString);
        System.out.println(dfString);
        System.out.println(date);
//        System.out.println(dateFormat.parse("2014-01"));
//        System.out.println(afterAll("2014-10-23 21:10:01","2014-10-22 21:10:01"));
    } catch (ParseException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }*/
//    System.out.println(getTodayLast(addDaysToDate(new Date(), 1)));
//    System.out.println(Math.ceil(0.0 /10));
//    System.out.println(timestamp2String("yyyy年MM月dd日 HH:mm",new Date()));
    System.out.println(time2ChineseDateFormat(new Date()));
}
}
