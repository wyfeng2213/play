package com.jshuabo.templateadminmysql.server.service.supplierGoods;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.jshuabo.frame.server.service.IBaseService;
import com.jshuabo.templateadminmysql.server.model.supplier.SupplierInfo;
import com.jshuabo.templateadminmysql.server.model.supplierGoods.GoodInfo;

public interface ISupplierGoodsService extends IBaseService {
	@Transactional
	Long addGoodInfo(GoodInfo goodInfo);

	GoodInfo loadById(Long id);

	void updateByPrimaryKeySelective(GoodInfo goodInfo);
	
	String findGoodsparam(Integer id, Integer supplierId);

	List<GoodInfo> findSupplierGoods(Long supplierId);

}
