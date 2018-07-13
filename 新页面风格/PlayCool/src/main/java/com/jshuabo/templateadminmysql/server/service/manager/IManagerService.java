package com.jshuabo.templateadminmysql.server.service.manager;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.jshuabo.frame.server.service.IBaseService;
import com.jshuabo.templateadminmysql.server.model.manager.Manager;

public interface IManagerService extends IBaseService {
	
	@Transactional
	String addManager(Manager manager);
	
	String findGoodsparam(Integer id, Integer supplier_id);

	List<Manager> findAllManager();

}
