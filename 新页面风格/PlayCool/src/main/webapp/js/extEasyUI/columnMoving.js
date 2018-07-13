/**
 * 扩展 列拖拽方法
 * @param {Object} jq
 * @date 2014-07-30 12:13
 * @author jing.huang
 * 
 * 调用方式：$('#initList').datagrid({.....}).datagrid("columnMoving");
 */

$.extend($.fn.datagrid.methods,{
	columnMoving:function(jq){
		return jq.each(function(){
			var grid = this;
			var directionDiv = $("<div></div>");
			var source_field;
			directionDiv.hide();
			$("body").append(directionDiv);
			
			$(grid).datagrid("getPanel")
					.find(".datagrid-header td[field]:not(td[field='ids'])").draggable({//获取除checkbox外的表头
				revert:true,
				cursor:"move",
				deltaX:10,
				deltaY:10,
				edge:10,
				proxy:function(source){
					source_field = $(source);
					var proxyEl = $("<div style='position:absolute;border:1px solid #ff0000'></div>");
					proxyEl.addClass("tree-node-proxy tree-dnd-no");
					proxyEl.text($(source).text());
					//proxyEl.hide();
					proxyEl.appendTo($("body"));
					
					return proxyEl;
				},
				onBeforeDrag:function(e){
					//判断是否是IE浏览器
					var isIE = (window.navigator.userAgent.indexOf("IE") == -1) ? false : true;
					var mousedown = false;
					$(grid).datagrid("getPanel").find(".datagrid-header td[field]:not(td[field='ids'])").mousedown(function(){
						//alert(1);
					});
					//判断是否是左键按下
					function isLeftButton(btn) {
					    if(isIE) {
					        if(btn == 1)
					            return true;
					        else
					            return false;
					    } else {
					        if(btn == 0)
					            return true;
					        else
					            return false;
					    }
					}
					if(!isLeftButton(e.button)){
						return false;
					}else{
						var isMouseMove = true;
						$(grid).datagrid("getPanel").find(".datagrid-header td[field]:not(td[field='ids'])").bind('onMouseMove',function(e){
							e = e || event;
							isMouseMove = true;
						});
						
						//alert(isMouseMove);
						return isMouseMove;
					}
				}
			}).droppable({
				accept:".datagrid-header td[field]:not(td[field='"+source_field+"'])",
				onDragOver:function(e,source){
					$(source).draggable("proxy").removeClass("tree-dnd-no").addClass("tree-dnd-yes");
					$(this).css('border-left','1px solid #ff0000');
				},
				onDragLeave:function(e,source){
					$(source).draggable("proxy").removeClass("tree-dnd-yes").addClass("tree-dnd-no");
					$(this).css('border-left','0px solid #ff0000');
					
					directionDiv.hide();
				},
				onDrop:function(e,source){//核心代码
					var fromField = $(source).attr('field');  //源列field
                    var toField = $(this).attr('field');  //目标列field
                    setTimeout(function(){  
                        swapField(fromField,toField);  
                        $(grid).datagrid('columnMoving');  
                    },0);
				}
			});
			
			// 交换逻辑  并根据 新列数组 重新加载datagrid
            function swapField(from,to){
            	var newColumns = new Array();
                var columns = $(grid).datagrid('options').columns;  //源列数组
                var cc = columns[0];
                _swap(from,to);  
                function _swap(fromfiled,tofiled){  
                    var fromtemp;  
                    var totemp;  
                    var fromindex = 0;  
                    var toindex = 0;  
                    for(var i=0; i<cc.length; i++){  
                        if (cc[i].field == fromfiled){  
                            fromindex = i; //得到源列索引
                            fromtemp = cc[i];  
                        }  
                        if(cc[i].field == tofiled){  
                            toindex = i; //得到目标列索引 
                            totemp = cc[i];  
                        }  
                    }  
                    cc.splice(fromindex,1);//删除被拖拽元素所对应的列
//                    global.columnsMovingUpdate($(grid).attr('id') ,fromindex ,toindex);
                    if(fromindex<toindex) {//由左向右拖拽
                    	toindex = toindex-1;
                    }else {//由右向左拖拽
                    	toindex = toindex+1;
                    }
                    cc.splice(toindex,0,fromtemp);
                    newColumns.push(cc);
                    $(grid).datagrid({//重载datagrid
                    	columns:newColumns
                    });
                }  
            }
            
		});
	}
});
