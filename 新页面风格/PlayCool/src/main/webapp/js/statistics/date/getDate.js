/**
 * 获取某周、某月、下月、某季度的开始日期、结束日期及判断日期第几周
 */
// 格式化日期：yyyy-MM-dd
function formatDate(date) {
var myyear = date.getFullYear();
var mymonth = date.getMonth()+1;
var myweekday = date.getDate();

 if(mymonth < 10){
 mymonth = "0" + mymonth;   
}
  if(myweekday < 10){   
    myweekday = "0" + myweekday;   
  }   
  return (myyear+"-"+mymonth + "-" + myweekday);    
}    
   
// 获得某月的天数(月份为实际值-1)
function getMonthDays(paraYear,paraMonth){
	paraYear = parseInt(paraYear);
	paraMonth = parseInt(paraMonth);
  var monthStartDate = new Date(paraYear, paraMonth, 1);    
  var monthEndDate = new Date(paraYear, paraMonth + 1, 1);    
  var  days  =  (monthEndDate  -  monthStartDate)/(1000  *  60  *  60  *  24);    
  return  days;    
}    
   
// 获得某月的开始日期(月份为实际值)
function getMonthStartDateIdx(paraYear,paraMonth){ 
	paraYear = parseInt(paraYear);
	paraMonth = parseInt(paraMonth)-1;
  var monthStartDate = new Date(paraYear, paraMonth, 1);    
  return formatDate(monthStartDate);   
}   
   
// 获得某月的结束日期(月份为实际值)
function getMonthEndDateIdx(paraYear,paraMonth){ 
	paraYear = parseInt(paraYear);
	paraMonth = parseInt(paraMonth)-1;
  var monthEndDate = new Date(paraYear,paraMonth, getMonthDays(paraYear,paraMonth));    
  return formatDate(monthEndDate);   
}  
//获取某年某周的开始日期
function getBeginDateOfWeek(paraYear, weekIndex){
	paraYear = parseInt(paraYear);
	weekIndex = parseInt(weekIndex);
  var firstDay = GetFirstWeekBegDay(paraYear);
  // 7*24*3600000 是一星期的时间毫秒数,(JS中的日期精确到毫秒)
  var time=(weekIndex-2)*7*24*3600000;
  var beginDay = firstDay;
  // 为日期对象 date 重新设置成时间 time
  beginDay.setTime(firstDay.valueOf()+time);
  return formatDate(beginDay);
}
  // 获取某年某周的结束日期
function getEndDateOfWeek(paraYear, weekIndex){
	paraYear = parseInt(paraYear);
	weekIndex = parseInt(weekIndex);
  var firstDay = GetFirstWeekBegDay(paraYear);
  // 7*24*3600000 是一星期的时间毫秒数,(JS中的日期精确到毫秒)
  var time=(weekIndex-2)*7*24*3600000;
  var weekTime = 6*24*3600000;
  var endDay = firstDay;
  // 为日期对象 date 重新设置成时间 time
  endDay.setTime(firstDay.valueOf()+weekTime+time);
  return formatDate(endDay);
}
  // 获取某年的第一天
function GetFirstWeekBegDay(year) {
	year = parseInt(year);
  var tempdate = new Date(year, 0, 1);
  var temp = tempdate.getDay();
  if (temp == 1){
    return tempdate;
  }
  temp = temp == 0 ? 7 : temp;
  tempdate = tempdate.setDate(tempdate.getDate() + (8 - temp));
  return new Date(tempdate); 
}

//获得当前是一年的第几周
function theWeek() {
    var totalDays = 0;
    now = new Date();
    years = now.getYear();
    
    var d = new Date(now.getFullYear(),0,1);
    
    if (years < 1000)
        years += 1900;
    var days = new Array(12);
    days[0] = 31 + d.getDay() - 1;
    days[2] = 31;
    days[3] = 30;
    days[4] = 31;
    days[5] = 30;
    days[6] = 31;
    days[7] = 31;
    days[8] = 30;
    days[9] = 31;
    days[10] = 30;
    days[11] = 31;
     
    //判断是否为闰年，针对2月的天数进行计算
    if (Math.round(now.getYear() / 4) == now.getYear() / 4) {
        days[1] = 29;
    } else {
        days[1] = 28;
    }
 
    if (now.getMonth() == 0) {//第一个月
    	if(d.getDay() != 1) {//1月1日不是周一
    		totalDays = totalDays + now.getDate() + d.getDay() - 1;   		
    	} else {
    		totalDays = totalDays + now.getDate();	
    	}	
    } else {
        var curMonth = now.getMonth();
        for (var count = 1; count <= curMonth; count++) {
            totalDays = totalDays + days[count - 1];
        }
        
        //12月有最后几天计入下一年的第一周
        if(curMonth == 11) {
        	var nextYear = new Date(now.getFullYear()+1,0,1);
        	var nextDay = nextYear.getDay();
        	if(nextDay != 1 && (now.getDate() + nextDay -1) > 31) {
        		return "nextYear";
        	}
        }
        
        totalDays = totalDays + now.getDate();
    }
    //得到第几周
    var week = Math.ceil(totalDays / 7);
    return week;
}



//获得某周的开始日期
function getWeekStartDate(paraYear,paraMonth,paraDay,paraDayOfWeek) {    
  var weekStartDate = new Date(paraYear, paraMonth, paraDay + 1 - paraDayOfWeek);    
  return formatDate(weekStartDate);   
}    
   
// 获得某周的结束日期
function getWeekEndDate(paraYear,paraMonth,paraDay,paraDayOfWeek) {    
  var weekEndDate = new Date(paraYear, paraMonth, paraDay + (7 - paraDayOfWeek));    
  return formatDate(weekEndDate);   
}
// 获取日期为某年的第几周
function GetWeekIndex(dateobj) {
  var firstDay = GetFirstWeekBegDay(dateobj.getFullYear());
  if (dateobj < firstDay) {
   firstDay = GetFirstWeekBegDay(dateobj.getFullYear() - 1);
  }
  d = Math.floor((dateobj.valueOf() - firstDay.valueOf()) / 86400000);
  return Math.floor(d / 7) + 1; 
}
// 获得上月开始时间(月份为实际值-1)
function getLastMonthStartDate(paraYear, lastMonth){
  var lastMonthStartDate = new Date(paraYear, lastMonth, 1);  
  return formatDate(lastMonthStartDate);   
}  

// 获得上月结束时间(月份为实际值-1)
function getLastMonthEndDate(paraYear, lastMonth, lastMonth){ 
  var lastMonthEndDate = new Date(paraYear, lastMonth, getMonthDays(lastMonth));  
  return formatDate(lastMonthEndDate);   
}  
   
// 获得某季度的开始日期
function getQuarterStartDate(paraYear,paraSeason){   
  switch (paraSeason){   
    case '1' : return paraYear+"-01-01";
    case '2' : return paraYear+"-04-01";
    case '3' : return paraYear+"-07-01";
    case '4' : return paraYear+"-10-01";
  }
}   
   
// 获得某季度的结束日期
function getQuarterEndDate(paraYear,paraSeason){   
  switch (paraSeason){   
  case '1' : return paraYear+"-03-31";
  case '2' : return paraYear+"-06-30";
  case '3' : return paraYear+"-09-30";
  case '4' : return paraYear+"-12-31";
  }  
}
