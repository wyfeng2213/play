/**
 * 扩展combobox 默认选中第一行
 * 
 * 调用方法：$('').combobox({}).combobox('selectedIndex', 0);
 */

$.extend($.fn.combobox.methods, {
            selectedIndex: function (jq, index) {
                if (!index) {
                    index = 0;
                }
                $(jq).combobox({
                    onLoadSuccess: function () {
                        var opt = $(jq).combobox('options');
                        var data = $(jq).combobox('getData');

                        for (var i = 0; i < data.length; i++) {
                            if (i == index) {
                                $(jq).combobox('setValue', eval('data[index].' + opt.valueField));
                                break;
                            }
                        }
                    }
                });
            }
        });