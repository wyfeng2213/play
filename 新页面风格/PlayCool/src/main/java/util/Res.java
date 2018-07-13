
package util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.web.servlet.ModelAndView;



public class Res {
    
    private enum Code {
        Ok(200), Redirect(302), Verify(403), Error(500);

        private int value = 0;

        Code(int value) {
            this.value = value;
        }

        public int value() {
            return value;
        }
        
    }

    private static class Message{
    	private String id;
    	private String message;

    	public Message(String id, String message){
    		this.id = id;
    		this.message = message;
    	}

		public String getId() {
			return id;
		}

		public String getMessage() {
			return message;
		}

    }

    
    private int	code     = Code.Ok.value();

    
    private List<Message> messages = new ArrayList<Message>();

    
    private Map<String, Object> data = new HashMap<String, Object>();

    
    public Res() {
    	data.put("time", System.currentTimeMillis());
    }

    
    public Res addSuccess(String message) {
        return addMessage("doAction", message, false);
    }

    
    public void setRedirect(String url) {
        this.code = Code.Redirect.value();
        addMessage("returnUrl", url, false);
    }

    
    public void setVerify() {
        this.code = Code.Verify.value();
    }

    
    public Res addError(String errorMessage) {
        return addError("doAction", errorMessage);
    }

    
    public Res addError(String errorKey, String errorMessage) {
        if (ValidateUtils.isNull(errorKey)
                || ValidateUtils.isNull(errorMessage)) {
            return this;
        }
        addMessage(errorKey, errorMessage, false);
        if(this.code != Code.Error.value()){
        	this.code = Code.Error.value(); // 设置为错误
        }
        return this;
    }

    
    private Res addMessage(String id, String message, boolean cdata) {
        if (ValidateUtils.isNull(message)) {
            return this;
        }
        if (cdata) {
            message = "<![CDATA[ " + message + " ]]>";
        }
        messages.add(new Message(id, message));
        return this;
    }

    public Res addData(String key , Object value) {
		this.data.put(key, value);
		return this;
	}

    public Res setResponse(Object value) {
		addData("response", value);
		return this;
	}

    public Res addResponse(String key , Object value) {
		Map responseMap = new HashMap();
		if(this.getData().containsKey("response")){
			responseMap = (Map)this.getData().get("response");
		}
		responseMap.put(key, value);
		addData("response", responseMap);
		return this;
	}

    public void commit() throws ServiceException {
    	//throw new ServiceException(messages.getMessage("sys.busy"));
	}

    private static String toJavaScript(String str) {
        if (ValidateUtils.isNull(str))
            return "";
        StringBuffer out = new StringBuffer();
        int sz = str.length();
        for (int i = 0; i < sz; i++) {
            char ch = str.charAt(i);
            switch (ch) {
            case '\b':
                out.append('\\');
                out.append('b');
                break;
            case '\n':
                // out.append('\\');
                // out.append('n');
                break;
            case '\t':
                // out.append('\\');
                // out.append('t');
                break;
            case '\f':
                // out.append('\\');
                // out.append('f');
                break;
            case '\r':
                // out.append('\\');
                // out.append('r');
                break;
            case '\'':
                // out.append('\\');
                out.append('\\');
                out.append('\'');
                break;
            case '"':
                // out.append('\\');
                out.append('"');
                break;
            case '\\':
                out.append('\\');
                out.append('\\');
                break;
            default:
                out.append(ch);
                break;
            }
        }
        // str = str.replaceAll("'", "\\'");
        // str = str.replaceAll("\r\n", "");
        // str = str.replaceAll("\n", "");
        // str = str.replaceAll("\r", "");
        // str = str.replaceAll("\t", ""); //转义字符
        return out.toString();
    }

    
    public String toJson() {
        StringBuffer json = new StringBuffer();
        json.append("{");

        json.append("code:'" + code + "',");
        json.append("messages:[");
        for (Message message : messages) {
            if (message != null){
                json.append("{id:'" + message.getId() + "'," +
                			"message:'" + toJavaScript(message.getMessage()) + "'},");
            }
        }
        if (messages.size() > 0) {
            // 去掉最后一个,
            json.setLength(json.length() - 1);
        }
        json.append("]");

        json.append("}");
        return json.toString();
    }

    // 导出为xml格式
    public String toXml() {
        StringBuffer xml = new StringBuffer();
        xml.append("<response code=\"" + code + "\">");
        if (code == Code.Ok.value()) {
            xml.append("<messages>");
            for (Message message : messages) {
                if (message != null) {
                    xml.append("<message id=\"" + message.getId() + "\">");
                    xml.append(message.getMessage());
                    xml.append("</message>");
                }
            }
            xml.append("</messages>");
        }
        xml.append("</response>");
        return xml.toString();
    }

    
    public String toJs(String callback) {
        if (ValidateUtils.isNull(callback)) {
            callback = "jsCallBack";
        }
        StringBuffer js = new StringBuffer();
        String json = toJson();
        js.append("if(" + callback + "){\n" + callback + "(" + json
                + "[0]);\n}");
        return js.toString();
    }

    public ModelAndView toView(FormatType formatType, String viewName, String callback, HttpServletResponse response) {
    	return toView(formatType, viewName, callback, response, null);
    }

    
    public ModelAndView toView(FormatType formatType, String viewName, String callback, HttpServletResponse response, Map<String, Object> global) {
    	if (FormatType.json.name().equals(formatType.name())) {
    		if(callback==null || "".equals(callback)){
    			return JsonView.Render(this, response);
    		}else{
    			return JsonView.Render(new JSONPObject(callback, this), response);
    		}
		}else if (FormatType.html.name().equals(formatType.name())) {
			if(viewName==null || "".equals(viewName)){
				ModelAndView mav =  new ModelAndView("null");
				mav.addObject("res", this);
				return mav;
			}else{
				if (this.getCode() == Code.Error.value()) {
					viewName = "500";
				}
				ModelAndView mav =  new ModelAndView(viewName);
				mav.addObject("res", this);
				if(global!=null){
					mav.addObject("global", global);
					mav.addObject("globalStr", JsonUtils.convertEntity2Json(global));
				}
				return mav;
			}
		}else{
			return null;
		}
    }

    public int getCode() {
        return code;
    }

	public List<Message> getMessages() {
		return messages;
	}
	
	public Map<String, Object> getData() {
		return data;
	}
}