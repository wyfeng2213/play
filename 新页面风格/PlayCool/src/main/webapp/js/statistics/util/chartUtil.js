/**
 * description: 创建图表
 * 
 * @param container
 *            图表容器 div id
 * @param title
 *            图表标题 String
 * @param subtitle
 *            副标题 String
 * @param yTitle
 *            Y轴标题 String
 * @param dataLabels
 *            是否显示数据标签 Boolean
 * @param defaultSeriesType
 *            图表类型 (line, spline, area, areaspline, column, bar, pie , scatter)
 * @param categories
 *            X轴序列 []
 * @param series
 *            数据 [{name:"",data:[]},{}]
 * @author: jing.huang
 * @date: 2014年4月23日
 */
function createChart(chartContainer,title, subtitle, yTitle, dataLabels, defaultSeriesType,
		categories, series) { 
	var chart = new Highcharts.Chart({
		chart : {
			renderTo : chartContainer,
			defaultSeriesType : defaultSeriesType,
			marginRight : 130,
			marginBottom : 50
			//margin: [0,0,0,0]
		},
		title : {
			text : title,
			x : -20
		},
		subtitle : {
			text : subtitle,
			x : -20
		},
		xAxis : {
			categories : categories
		},
		yAxis : {
			title : {
				text : yTitle
			},
			plotLines : [ {
				value : 0,
				width : 1,
				color : '#808080'
			} ]
		},
		tooltip : {
			formatter : function() {
				return '<b>' + this.series.name + '</b><br/>' + this.x + ': '
						+ this.y+'个';
			}
		},
		legend : {
			layout : 'vertical',
			align : 'right',
			verticalAlign : 'top',
			x : -10,
			y : 100,
			borderWidth : 0
		},
		series : series,
		credits : {
			enabled: false
			/*href : 'http://www.jshuabo.com',
			text : 'jshuabo.com'*/
		},
		plotOptions : {
			enable : true,
			allowPointSelect : true,
			column : {
				dataLabels : {
					enabled : dataLabels
				// 是否显示数据标签
				}
			}
		}
	});
}

/**
 * description: 创建图表
 * 
 * @param container
 *            图表容器 div id
 * @param title
 *            图表标题 String
 * @param subtitle
 *            副标题 String
 * @param defaultSeriesType
 *            图表类型 pie (line, spline, area, areaspline, column, bar, pie , scatter)
 * @param series
 *            数据 [{name:"",data:[]},{}]
 * @author: yunlei.hua
 * @date: 2015年2月5日
 */
function createPieChart(chartContainer,title, subtitle, defaultSeriesType, series) { 
	var chart = new Highcharts.Chart({
        chart : {
			renderTo : chartContainer,
			type : defaultSeriesType,
			marginLeft : 30,
			marginBottom : 30,
			plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
		},
		colors: ['#90ed7d', '#7cb5ec'],
		title : {
			text : title,
			x : -20
		},
		subtitle : {
			text : subtitle,
			x : -20
		},
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    connectorColor: '#000000',
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series:series,
        credits : {
			enabled: false
		}
	});
}

/**
 * description: 
 * 			  创建图表对应的表格(横向)
 * @param containerName
 *            表格容器id名
 * @param width
 *            表格宽度
 * @param thead
 *            表头行数组：["","","",...]
 * @param tbody
 *            表格主体数据数组: [{name:"",data:["","",...]},{},...]
 * @param tableTag
 * 				表格左上角显示内容
 * @author: jing.huang
 * @date: 2014年4月25日
 */
function createTable(containerName,width, thead, tbody, tableTag) {
	// 创建一个表格对象
	var mytable = document.createElement("table");
	mytable.cellSpacing = "1px";
	// 创建一个表头对象
	var mythead = document.createElement("thead");
	for (var a = 0; a < 1; a++) {
		var myrow = document.createElement("tr");
		for (var b = 0; b < thead.length + 1; b++) {
			var mytd = document.createElement("td");
			if (b == 0) {
				if("undefined" != typeof tableTag) {
					mytd.innerHTML = tableTag;
				} else {
					mytd.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ";
				}
			} else {
				mytd.innerHTML = thead[b - 1];
			}
			mytd.style.cssText = "text-align:center;";
			myrow.appendChild(mytd);
		}
		mythead.appendChild(myrow);
	}
	// 创建一个表体对象
	var mytbody = document.createElement("tbody");
	for (var i = 0; i < tbody.length; i++) {
		var myrow = document.createElement("tr");
		for (var j = 0; j < thead.length + 1; j++) {
			var mytd;
			if (j == 0) {
				mytd = document.createElement("td");
				mytd.innerHTML = tbody[i].name;
				mytd.style.cssText = "text-align:center;background-color:#F3F3F3;font-weight:bold;";
			} else {
				mytd = document.createElement("td");
				mytd.innerHTML = tbody[i].data[j - 1];
				mytd.style.cssText = "text-align:center;background-color:#fff;";
				var aa = ""+tbody[i].data[j - 1];
				if(aa.substr(aa.length-1,1) == '%') {
					var num = parseFloat(aa);
					if(num >= 1) {
						mytd.style.cssText = "text-align:center;color:red;background-color:#fff;";
					}
				}
			}
			myrow.appendChild(mytd);
		}
		mytbody.appendChild(myrow);
	}
	// 创建一个表脚对象
	var mytfoot = document.createElement("tfoot");
	for (var c = 0; c < 1; c++) {
		var myrow = document.createElement("tr");
		for (var d = 0; d < 1; d++) {
			var mytd = document.createElement("td");
			mytd.innerHTML = "脚" + (d + 1);
			mytd.style.cssText = "text-align:center;";
			mytd.colSpan = "10";
			myrow.appendChild(mytd);
		}
		mytfoot.appendChild(myrow);
	}
	// 将表头追加到表格
	mytable.appendChild(mythead);
	// 将表体追加到表格
	mytable.appendChild(mytbody);
	// 将表脚追加到表格
	 mytable.appendChild(mytfoot);
	// 追加对象样式
	mythead.style.cssText = "background-color:#F3F3F3;font-size:14px; font-weight:600; width:"
			+ width + "px;";
	mytable.style.cssText = "background-color:#999; border:1px; width:" + width
			+ "px;";
	mytfoot.style.cssText = "background-color:#003; color:#FFF; font-size:14px; font-weight:600; width:"
			+ width + "px;";
	document.getElementById(containerName).appendChild(mytable);
}

/**
 * description: 
 * 			  创建图表对应的表格(纵向)
 * @param containerName
 *            表格容器id名
 * @param width
 *            表格宽度
 * @param thead
 *            表头行数组：["","","",...]
 * @param tbody
 *            表格主体数据数组: [{name:"",data:["","",...]},{},...]
 * @param tableTag
 * 				表格左上角显示内容
 * @author: jing.huang
 * @date: 2014年4月25日
 */
function createTablePortriat(containerName,width, thead, tbody, tableTag,warehouseName) {
	var ptable = document.createElement("table");
	ptable.cellSpacing = "1px";
	ptable.style.cssText = "";
	
	
	var pthead = document.createElement("thead");
	
	//创建标题行
	var titletr = document.createElement("tr");
	var titletd = document.createElement("td");
	titletd.innerHTML = "复核打包统计";
	titletd.colSpan = "3";
	titletd.style.cssText = "font-size: 25px;text-align:center;background-color:#fff;";
	titletr.appendChild(titletd);
	pthead.appendChild(titletr);
	
	//创建副标题行
	var ftitletr = document.createElement("tr");
	var ftitletd = document.createElement("td");
	var year = $('#mYear').val();
	var month = $('#mMonth').val();
	var week = $('#mWeek').val();
	var day = $('#queryDay').val();
	var weekBeginDate = $('#weekBeginDate').val();
	var weekEndDate = $('#weekEndDate').val();
	if(month != undefined){
		ftitletd.innerHTML = warehouseName + "   " + year + "年" + month + "月";
	}else if(week != undefined){
		ftitletd.innerHTML = warehouseName + "   " +year + "年第" + week + "周(" + weekBeginDate + " ~ " + weekEndDate + ")";
	}else {
		ftitletd.innerHTML = warehouseName + "   " + day;
	}
	
	
	
	ftitletd.colSpan = "3";
	ftitletd.style.cssText = "font-size: 12px;background-color:#fff;";
	ftitletr.appendChild(ftitletd);
	pthead.appendChild(ftitletr);
	
	//创建表头
	var tr = document.createElement("tr");
	var td = document.createElement("td");
	td.innerHTML = tableTag;
	tr.appendChild(td);
	td = document.createElement("td");
	td.innerHTML = tbody[0].name;
	tr.appendChild(td);
	pthead.appendChild(tr);
	td = document.createElement("td");
	td.innerHTML = tbody[1].name;
	tr.appendChild(td);
	pthead.appendChild(tr);
	
	var yData1 = tbody[0].data;
	var yData2 = tbody[1].data;
	
	var data = tbody[0].data;
	// 创建一个表体
	var ptbody = document.createElement("tbody");
	
	for (var i = 0; i < thead.length; i++) {
		var ttr = document.createElement("tr");
		var ttd = document.createElement("td");
		ttd.innerHTML = thead[i];
		ttd.style.cssText = "text-align:center;background-color:#fff;width:" + width + "px;";
		ttr.appendChild(ttd);
		ttd = document.createElement("td");
		ttd.innerHTML = yData1[i];
		ttd.style.cssText = "text-align:center;background-color:#fff;width:" + width + "px;";
		var aa = ""+data[i];
		if(aa.substr(aa.length-1,1) == '%') {
			var num = parseFloat(aa);
			if(num >= 1) {
				td.style.cssText = "text-align:center;color:red;background-color:#fff;width:" + width + "px;";
			}
		}
		ttr.appendChild(ttd);
		ttd = document.createElement("td");
		ttd.innerHTML = yData2[i];
		ttd.style.cssText = "text-align:center;background-color:#fff;width:" + width + "px;";
		aa = ""+data[i];
		if(aa.substr(aa.length-1,1) == '%') {
			num = parseFloat(aa);
			if(num >= 1) {
				td.style.cssText = "text-align:center;color:red;background-color:#fff;width:" + width + "px;";
			}
		}
		ttr.appendChild(ttd);
		ptbody.appendChild(ttr);
	}
	
	// 创建一个表脚对象
	var ptfoot = document.createElement("tfoot");
	for (var c = 0; c < 1; c++) {
		var frow = document.createElement("tr");
		for (var d = 0; d < 1; d++) {
			var ftd = document.createElement("td");
			ftd.innerHTML = "脚" + (d + 1);
			ftd.style.cssText = "text-align:center;";
			ftd.colSpan = "10";
			frow.appendChild(ftd);
		}
		ptfoot.appendChild(frow);
	}
	// 将表头追加到表格
	ptable.appendChild(pthead);
	// 将表体追加到表格
	ptable.appendChild(ptbody);
	// 将表脚追加到表格
	// mytable.appendChild(mytfoot);
	// 追加对象样式
	pthead.style.cssText = "background-color:#F3F3F3;font-size:14px; font-weight:600; width:"
			+ width + "px;text-align:center;";
	ptable.style.cssText = "background-color:#999; border:1px; width:" + width
			+ "px;";
    ptfoot.style.cssText = "background-color:#003; color:#FFF; font-size:14px; font-weight:600; width:"
			+ width + "px;";
	document.getElementById(containerName).appendChild(ptable);
	
}


/**
 * description: 
 * 			  创建图表对应的表格
 * @param containerName
 *            表格容器id名
 * @param width
 *            表格宽度
 * @param thead
 *            表头行数组：["","","",...]
 * @param tbody
 *            表格主体数据数组: [{name:"",data:["","",...]},{},...]
 * @param tableTag
 * 				表格左上角显示内容
 * @param warehouseName
 * 				表格副标题显示内容：当前仓库
 * @author: yunlei.hua
 * @date: 2015年1月16日
 */
function createTablePicking(containerName,width, thead, tbody, tableTag, warehouseName) {
	var ptable = document.createElement("table");
	ptable.cellSpacing = "1px";
	ptable.style.cssText = "";
	
	var pthead = document.createElement("thead");
	
	//创建标题行
	var titletr = document.createElement("tr");
	var titletd = document.createElement("td");
	titletd.innerHTML = "操作日志统计";
	titletd.colSpan = "5";
	titletd.style.cssText = "font-size: 25px;text-align:center;background-color:#fff;";
	titletr.appendChild(titletd);
	pthead.appendChild(titletr);
	
	//创建副标题行
	var ftitletr = document.createElement("tr");
	var ftitletd = document.createElement("td");
	var year = $('#mYear').val();
	var month = $('#mMonth').val();
	var week = $('#mWeek').val();
	var day = $('#queryDay').val();
	var weekBeginDate = $('#weekBeginDate').val();
	var weekEndDate = $('#weekEndDate').val();
	console.debug(weekBeginDate);
	
	if(month != undefined){
		ftitletd.innerHTML = warehouseName + "   " + year + "年" + month + "月";
	}else if(week != undefined){
		ftitletd.innerHTML = warehouseName + "   " +year + "年第" + week + "周(" + weekBeginDate + " ~ " + weekEndDate + ")";
	}else {
		ftitletd.innerHTML = warehouseName + "   " + day;
	}
	
	ftitletd.colSpan = "5";
	ftitletd.style.cssText = "font-size: 12px;background-color:#fff;";
	ftitletr.appendChild(ftitletd);
	pthead.appendChild(ftitletr);
	
	//创建表头
	var tr = document.createElement("tr");
	var td = document.createElement("td");
	td.innerHTML = tableTag;
	tr.appendChild(td);

	for(var m = 0;m < tbody.length;m++) {
		td = document.createElement("td");
		td.innerHTML = tbody[m].name;
		tr.appendChild(td);
	}
	pthead.appendChild(tr);
	
	// 创建一个表体
	var ptbody = document.createElement("tbody");
	for(var n = 0;n < thead.length;n++) {
		var ttr = document.createElement("tr");
		var ttd = document.createElement("td");
		ttd.innerHTML = thead[n];
		ttd.style.cssText = "text-align:center;background-color:#fff;width:" + width + "px;";
		ttr.appendChild(ttd);
		
		for (var i = 0; i < tbody.length; i++) {
			ttd = document.createElement("td");
			ttd.innerHTML = tbody[i].data[n];
			ttd.style.cssText = "text-align:center;background-color:#fff;width:" + width + "px;";
			var aa = ""+tbody[i].data[n];
			if(aa.substr(aa.length-1,1) == '%') {
				var num = parseFloat(aa);
				if(num >= 1) {
					td.style.cssText = "text-align:center;color:red;background-color:#fff;width:" + width + "px;";
				}
			}
			ttr.appendChild(ttd);
		}
		ptbody.appendChild(ttr);
	}
	
	// 创建一个表脚对象
	var ptfoot = document.createElement("tfoot");
	for (var c = 0; c < 1; c++) {
		var frow = document.createElement("tr");
		for (var d = 0; d < 1; d++) {
			var ftd = document.createElement("td");
			ftd.innerHTML = "脚" + (d + 1);
			ftd.style.cssText = "text-align:center;";
			ftd.colSpan = "10";
			frow.appendChild(ftd);
		}
		ptfoot.appendChild(frow);
	}
	// 将表头追加到表格
	ptable.appendChild(pthead);
	// 将表体追加到表格
	ptable.appendChild(ptbody);
	// 将表脚追加到表格
	// mytable.appendChild(mytfoot);
	// 追加对象样式
	pthead.style.cssText = "background-color:#F3F3F3;font-size:14px; font-weight:600; width:"
			+ width + "px;text-align:center;";
	ptable.style.cssText = "background-color:#999; border:1px; width:" + width
			+ "px;";
    ptfoot.style.cssText = "background-color:#003; color:#FFF; font-size:14px; font-weight:600; width:"
			+ width + "px;";
	document.getElementById(containerName).appendChild(ptable);
	
}

/**
 * description: 
 * 			  创建图表对应的表格(饼状图)
 * @param containerName
 *            表格容器id名
 * @param width
 *            表格宽度
 * @param tbody
 *            表格主体数据数组: [{name:"",data:["","",...]},{},...]
 * @param warehouseName
 * 				表格副标题显示内容：当前仓库
 * @author: yunlei.hua
 * @date: 2015年2月5日
 */
function createTableTypePie(containerName, width, tbody, warehouseName){
	var ptable = document.createElement("table");
	ptable.cellSpacing = "1px";
	ptable.style.cssText = "";
	
	var pthead = document.createElement("thead");
	
	//创建标题行
	var titletr = document.createElement("tr");
	var titletd = document.createElement("td");
	titletd.innerHTML = "当日作业完成情况";
	titletd.colSpan = "4";
	titletd.style.cssText = "font-size: 25px;text-align:center;background-color:#fff;";
	titletr.appendChild(titletd);
	pthead.appendChild(titletr);
	
	//创建副标题行
	var ftitletr = document.createElement("tr");
	var ftitletd = document.createElement("td");
	var year = $('#mYear').val();
	var month = $('#mMonth').val();
	var week = $('#mWeek').val();
	var day = $('#dayBeginDate').val();
	var weekBeginDate = $('#weekBeginDate').val();
	var weekEndDate = $('#weekEndDate').val();
	if(month != undefined){
		ftitletd.innerHTML = warehouseName + "   " + year + "年" + month + "月";
	}else if(week != undefined){
		ftitletd.innerHTML = warehouseName + "   " +year + "年第" + week + "周(" + weekBeginDate + " ~ " + weekEndDate + ")";
	}else {
		ftitletd.innerHTML = warehouseName + "   " + day;
	}
	
	ftitletd.colSpan = "4";
	ftitletd.style.cssText = "font-size: 12px;background-color:#fff;";
	ftitletr.appendChild(ftitletd);
	pthead.appendChild(ftitletr);
	
	// 创建一个表体
	var ptbody = document.createElement("tbody");
	
	for (var i = 0; i < tbody.length; i++) {
		if (i == 0 || (i > 0 && i % 2 != 0)) {
			var ttr = document.createElement("tr");
		}
		
		for (var j = 0; j < tbody[i].length; j++) {
			var ttd = document.createElement("td");
			ttd.innerHTML = tbody[i][j];
			if (i == 0 && j == 1) {
				ttd.colSpan = "3";
			}
			ttd.style.cssText = "text-align:center;background-color:#fff;width:" + width + "px;";
			ttr.appendChild(ttd);
		}
		if (i == 0 || i % 2 == 0) {
			ptbody.appendChild(ttr);
		}
	}
	
	// 创建一个表脚对象
	var ptfoot = document.createElement("tfoot");
	for (var c = 0; c < 1; c++) {
		var frow = document.createElement("tr");
		for (var d = 0; d < 1; d++) {
			var ftd = document.createElement("td");
			ftd.innerHTML = "脚" + (d + 1);
			ftd.style.cssText = "text-align:center;";
			ftd.colSpan = "10";
			frow.appendChild(ftd);
		}
		ptfoot.appendChild(frow);
	}
	// 将表头追加到表格
	ptable.appendChild(pthead);
	// 将表体追加到表格
	ptable.appendChild(ptbody);
	// 将表脚追加到表格
	// mytable.appendChild(mytfoot);
	// 追加对象样式
	pthead.style.cssText = "background-color:#F3F3F3;font-size:14px; font-weight:600; width:"
			+ width + "px;text-align:center;";
	ptable.style.cssText = "background-color:#999; border:1px; width:" + width
			+ "px;";
    ptfoot.style.cssText = "background-color:#003; color:#FFF; font-size:14px; font-weight:600; width:"
			+ width + "px;";
	document.getElementById(containerName).appendChild(ptable);
}

/**
 * description: 
 * 			  创建图表对应的表格(拣货人员拣货未完成订单)
 * @param containerName
 *            表格容器id名
 * @param width
 *            表格宽度
 * @param thead
 *            表头行数组：["","","",...]
 * @param tbody
 *            表格主体数据数组: [{name:"",data:["","",...]},{},...]
 * @param tableTag
 * 				表格左上角显示内容
 * @author: yunlei.hua
 * @date: 2015年2月6日
 */
function createTableUnPicked(containerName,width, thead, tbody, tableTag,warehouseName) {
	var ptable = document.createElement("table");
	ptable.cellSpacing = "1px";
	ptable.style.cssText = "";
	
	var pthead = document.createElement("thead");
	
	//创建标题行
	var titletr = document.createElement("tr");
	var titletd = document.createElement("td");
	titletd.innerHTML = "拣货人员拣货完成统计";
	titletd.colSpan = "2";
	titletd.style.cssText = "font-size: 25px;text-align:center;background-color:#fff;";
	titletr.appendChild(titletd);
	pthead.appendChild(titletr);
	
	//创建副标题行
	var ftitletr = document.createElement("tr");
	var ftitletd = document.createElement("td");
	var year = $('#mYear').val();
	var month = $('#mMonth').val();
	var week = $('#mWeek').val();
	var day = $('#dayBeginDate').val();
	var weekBeginDate = $('#weekBeginDate').val();
	var weekEndDate = $('#weekEndDate').val();
	if(month != undefined){
		ftitletd.innerHTML = warehouseName + "   " + year + "年" + month + "月";
	}else if(week != undefined){
		ftitletd.innerHTML = warehouseName + "   " +year + "年第" + week + "周(" + weekBeginDate + " ~ " + weekEndDate + ")";
	}else {
		ftitletd.innerHTML = warehouseName + "   " + day;
	}
	
	ftitletd.colSpan = "2";
	ftitletd.style.cssText = "font-size: 12px;background-color:#fff;";
	ftitletr.appendChild(ftitletd);
	pthead.appendChild(ftitletr);
	
	//创建表头
	var tr = document.createElement("tr");
	var td = document.createElement("td");
	td.innerHTML = tableTag;
	tr.appendChild(td);
	td = document.createElement("td");
	td.innerHTML = tbody[0].name;
	tr.appendChild(td);
	pthead.appendChild(tr);
	
	// 创建一个表体
	var ptbody = document.createElement("tbody");
	for (var i = 0; i < thead.length; i++) {
		var ttr = document.createElement("tr");
		var ttd = document.createElement("td");
		ttd.innerHTML = thead[i];
		ttd.style.cssText = "text-align:center;background-color:#fff;width:" + width + "px;";
		ttr.appendChild(ttd);
		ttd = document.createElement("td");
		ttd.innerHTML = tbody[0].data[i];
		ttd.style.cssText = "text-align:center;background-color:#fff;width:" + width + "px;";
		var aa = ""+tbody[0].data[i];
		if(aa.substr(aa.length-1,1) == '%') {
			var num = parseFloat(aa);
			if(num >= 1) {
				td.style.cssText = "text-align:center;color:red;background-color:#fff;width:" + width + "px;";
			}
		}
		ttr.appendChild(ttd);
		ptbody.appendChild(ttr);
	}
	
	// 将表头追加到表格
	ptable.appendChild(pthead);
	// 将表体追加到表格
	ptable.appendChild(ptbody);
	// 追加对象样式
	pthead.style.cssText = "background-color:#F3F3F3;font-size:14px; font-weight:600; width:"
			+ width + "px;text-align:center;";
	ptable.style.cssText = "background-color:#999; border:1px; width:" + width
			+ "px;";
	document.getElementById(containerName).appendChild(ptable);
}

//无数据时页面显示内容
function noDataShow(_row) {
	_row.html('<div width="'+ _row.width()
			+ '" style="position:absolute; top:30%; left:36%; text-align: center;" colspan="6"><h2>未找到符合条件的数据!</h2></div>').show();
}