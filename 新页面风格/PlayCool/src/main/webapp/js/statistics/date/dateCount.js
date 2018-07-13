/**
 * 日期计算及快速获取周、月、季起始日
 */ 
 var now = new Date();                                                //当前日期
 var nowDayOfWeek = (now.getDay() == 0) ? 7 : now.getDay() - 1;       //今天是本周的第几天。周一=0，周日=6
 var nowDay = now.getDate();                                          //当前日
 var nowMonth = now.getMonth();                                       //当前月值（1月=0，12月=11）
 var nowMonReal = now.getMonth() + 1;                                 //当前月实际数字
 var nowYear = now.getFullYear();                                     //当前年
 //得到当前日期季度值
 function getSeasonValue() {
	 if(nowMonth>=0&&nowMonth<=2) {
		 return 1;
	 } else if (nowMonth>=3&&nowMonth<=5) {
		 return 2;
	 }else if (nowMonth>=6&&nowMonth<=8) {
		 return 3;
	 }else if (nowMonth>=9&&nowMonth<=11) {
		 return 4;
	 }
 }

 //得到当前日期属于上半年还是下半年，上半年返回1，下半年返回2
 function getDownOrUp() {
	 if(nowMonth<6) {
		 return 1;
	 }else {
		 return 2;
	 }
 }
 //日期+天
 function AddDays(d, n) {
     var t = new Date(d);//复制并操作新对象，避免改动原对象
     t.setDate(t.getDate() + n);
     return t;
 }
 
 //日期+月。日对日，若目标月份不存在该日期，则置为最后一日
 function AddMonths(d, n) {
     var t = new Date(d);
     t.setMonth(t.getMonth() + n);
     if (t.getDate() != d.getDate()) { t.setDate(0); }
     return t;
 }
 
 //日期+年。月对月日对日，若目标年月不存在该日期，则置为最后一日
 function AddYears(d, n) {
     var t = new Date(d);
     t.setFullYear(t.getFullYear() + n);
     if (t.getDate() != d.getDate()) { t.setDate(0); }
     return t;
 }
 
 //获得本季度的开始月份
 function getQuarterStartMonth() {
     if (nowMonth <= 2) { return 0; }
     else if (nowMonth <= 5) { return 3; }
     else if (nowMonth <= 8) { return 6; }
     else { return 9; }
 }
 
 //周一
 function getWeekStartDate() {
     return AddDays(now, -nowDayOfWeek);
 }
 
 //周日。本周一+6天
 function getWeekEndDate() {
     return AddDays(getWeekStartDate(), 6);
 }
 
 //月初
 function getMonthStartDate() {
     return new Date(nowYear, nowMonth, 1);
 }
 
 //月末。下月初-1天
 function getMonthEndDate() {
     return AddDays(AddMonths(getMonthStartDate(), 1), -1);
 }
 
 //季度初
 function getQuarterStartDate() {
     return new Date(nowYear, getQuarterStartMonth(), 1);
 }
 
 //季度末。下季初-1天
 function getQuarterEndDate() {
     return AddDays(AddMonths(getQuarterStartDate(), 3), -1);
 }
 
//日期格式化
 Date.prototype.format = function(format){ 
 	var o = { 
 		"M+" : this.getMonth()+1, //month 
 		"d+" : this.getDate(), //day 
 		"h+" : this.getHours(), //hour 
 		"m+" : this.getMinutes(), //minute 
 		"s+" : this.getSeconds(), //second 
 		"q+" : Math.floor((this.getMonth()+3)/3), //quarter 
 		"S" : this.getMilliseconds() //millisecond 
 	} ;

 	if(/(y+)/.test(format)) { 
 		format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
 	} 

 	for(var k in o) { 
 		if(new RegExp("("+ k +")").test(format)) { 
 			format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
 		} 
 	} 
 	return format; 
 };