package com.jshuabo.templateadminmysql.server.service.supplier;

import java.util.List;

import com.jshuabo.frame.server.service.IBaseService;
import com.jshuabo.templateadminmysql.server.model.supplier.SupplierInfo;

public interface ISupplierService extends IBaseService {

	List<SupplierInfo> getAllSupplier();
	SupplierInfo selectByPrimaryKey(Long id);

}
