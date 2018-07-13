(function($){
$.extend({
ms_DatePicker: function (options,defaultYear,defaultMonth,defaultWeek,defaultDay) {
            var defaults = {
                YearSelector: "#sel_year",
                MonthSelector: "#sel_month",
                WeekSelector: "#sel_week",
                DaySelector: "#sel_day",
                FirstText: "--",
                FirstValue: 0
            };
            var opts = $.extend({}, defaults, options);
            var $YearSelector = $(opts.YearSelector);
            var $MonthSelector = $(opts.MonthSelector);
            var $WeekSelector = $(opts.WeekSelector);
            var $DaySelector = $(opts.DaySelector);
            var FirstText = opts.FirstText;
            var FirstValue = opts.FirstValue;

            // 初始化
            var str = "<option value=\"" + FirstValue + "\">" + FirstText + "</option>";
           /* $YearSelector.html(str);
            $MonthSelector.html(str);
            $DaySelector.html(str);*/

            // 年份列表
            var yearNow = new Date().getFullYear();
            for (var i = yearNow; i >= 1900; i--) {
            	var yearStr = "";
            	if(i == defaultYear - 1 && yearNow < defaultYear) {
        			yearStr = "<option selected='selected' value=\"" + defaultYear + "\">" + defaultYear + "</option>"
        				+ "<option value=\"" + i + "\">" + i + "</option>";
        		} else if(i == defaultYear) {
            		yearStr = "<option selected='selected' value=\"" + i + "\">" + i + "</option>";
            	} else {
            		yearStr = "<option value=\"" + i + "\">" + i + "</option>";
            	}
                $YearSelector.append(yearStr);
            }

            // 月份列表
            for (var i = 1; i <= 12; i++) {
            	var monthStr = "";
            	if(i == defaultMonth) {
            		monthStr = "<option selected='selected' value=\"" + i + "\">" + i + "</option>";
            	} else {
            		monthStr = "<option value=\"" + i + "\">" + i + "</option>";
            	}
                $MonthSelector.append(monthStr);
            }

            // 默认当前周
            for (var i = 1; i <= defaultWeek; i++) {
    			var weekStr = "";
    			if(i == defaultWeek) {
    				weekStr = "<option selected='selected' value=\"" + i + "\">第" + i + "周</option>";
    			} else {
    				weekStr = "<option value=\"" + i + "\">第" + i + "周</option>";
    			}
    			$WeekSelector.append(weekStr);
    		}
            
            // 周列表
            function BuildWeek() {
            	if ($YearSelector.val() != '' && $YearSelector.val() != 0 ) {
            		var year = parseInt($YearSelector.val());
            		$WeekSelector.children().remove();
            		
            		if(year == defaultYear) { //选择当前年份
            			for (var i = 1; i <= defaultWeek; i++) {
                			var weekStr = "";
                			if(i == defaultWeek) {
                				weekStr = "<option selected='selected' value=\"" + i + "\">第" + i + "周</option>";
                			} else {
                				weekStr = "<option value=\"" + i + "\">第" + i + "周</option>";
                			}
                			$WeekSelector.append(weekStr);
            			}
        			} else { //非当前年份
        				for (var i = 1; i <= getNumOfWeeks(year); i++) {
                			var weekStr = "";
                			if(i == 1) {
                				weekStr = "<option selected='selected' value=\"" + i + "\">第" + i + "周</option>";
                			} else {
                				weekStr = "<option value=\"" + i + "\">第" + i + "周</option>";
                			}
                			$WeekSelector.append(weekStr);
        				}
        			}
            	}
            }
            
            //获得一年的周数
            function getNumOfWeeks(year){
	   			var d=new Date(year,0,1);
	   			var yt=( ( year%4==0 && year%100!=0) || year%400==0)? 366:365; 
	   			return Math.ceil((yt-d.getDay())/7);
	   		}
            
            // 日列表(仅当选择了年月)
            function BuildDay() {
                if ($YearSelector.val() == 0 || $MonthSelector.val() == 0) {
                    // 未选择年份或者月份
                    //$DaySelector.html(str);
                } else {
                    $DaySelector.html(str);
                    var year = parseInt($YearSelector.val());
                    var month = parseInt($MonthSelector.val());
                    var dayCount = 0;
                    switch (month) {
                        case 1:
                        case 3:
                        case 5:
                        case 7:
                        case 8:
                        case 10:
                        case 12:
                            dayCount = 31;
                            break;
                        case 4:
                        case 6:
                        case 9:
                        case 11:
                            dayCount = 30;
                            break;
                        case 2:
                            dayCount = 28;
                            if ((year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)) {
                                dayCount = 29;
                            }
                            break;
                        default:
                            break;
                    }

                    for (var i = 1; i <= dayCount; i++) {
                    	var dayStr = "";
                    	if(i == defaultDay) {
                    		dayStr = "<option selected='selected' value=\"" + i + "\">" + i + "</option>";
                    	}else {
                    		dayStr = "<option value=\"" + i + "\">" + i + "</option>";
                    	}
                        $DaySelector.append(dayStr);
                    }
                }
            }
            
            
            $MonthSelector.change(function () {
                BuildDay();
            });
            $YearSelector.change(function () {
                BuildDay();
                BuildWeek();
            });
        } // End ms_DatePicker
});
})(jQuery);