package util;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.web.servlet.ModelAndView;
public class MrRes {


	private enum Code {
        Ok(0), Redirect(302), Verify(403), Error(20000);

        private int value = 0;

        Code(int value) {
            this.value = value;
        }

        public int value() {
            return value;
        }
        
    }
	
	@SuppressWarnings("unused")
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
	
	
	private int error_code = Code.Ok.value();

	private String error_msg = "";
	
	private long time;

	
	private Map<String, Object> data = new HashMap<String, Object>();

	
	public MrRes() {
		this.time = System.currentTimeMillis();
	}

	public MrRes addResponse(String key, Object value) {
		this.data.put(key, value);
		return this;
	}

	public MrRes addError(String errorMessage) {
		return addError(20000, errorMessage);
	}

	public MrRes addError(int errorCode, String errorMessage) {
        if (ValidateUtils.isNull(errorCode)
                || ValidateUtils.isNull(errorMessage)) {
            return this;
        }
        addMessage(errorCode, errorMessage, false);      
        return this;
    }
	
	private MrRes addMessage(int errorCode, String message, boolean cdata) {
        if (ValidateUtils.isNull(message)) {
            return this;
        }
        if (cdata) {
            message = "<![CDATA[ " + message + " ]]>";
        }
        this.error_msg = message;
        this.error_code = errorCode;
        return this;
    }
	
	public void commit() throws ServiceException {
		// throw new ServiceException(messages.getMessage("sys.busy"));
	}

	public ModelAndView toView(FormatType formatType, String viewName,
			String callback, HttpServletResponse response) {
		return toView(formatType, viewName, callback, response, null);
	}

	
	public ModelAndView toView(FormatType formatType, String viewName,
			String callback, HttpServletResponse response,
			Map<String, Object> global) {
		if (FormatType.json.name().equals(formatType.name())) {
			if (callback == null || "".equals(callback)) {
				return JsonView.Render(this, response);
			} else {
				return JsonView.Render(new JSONPObject(callback, this),
						response);
			}
		} else {
			return null;
		}
	}

	public int getError_code() {
		return error_code;
	}

	public void setError_code(int error_code) {
		this.error_code = error_code;
	}

	public String getError_msg() {
		return error_msg;
	}

	public void setError_msg(String error_msg) {
		this.error_msg = error_msg;
	}

	public Map<String, Object> getData() {
		return data;
	}

	public void setData(Map<String, Object> data) {
		this.data = data;
	}

	public long getTime() {
		return time;
	}

	public void setTime(long time) {
		this.time = time;
	}

}