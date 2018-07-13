package com.jshuabo.templateadminmysql.server.web.channel;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jshuabo.templateadminmysql.server.service.channel.IChannelService;

@Controller
@RequestMapping(value = "channel")
public class ChannelController {
	
	@Autowired
	private IChannelService CS;
	
	@RequestMapping(value = "list")
	public String list(HttpServletRequest re) {
		return "channel/list";
	}

}
