package cn.hbeu.service.impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.hbeu.dao.BaseDAO;
import cn.hbeu.pojo.PageBean;
import cn.hbeu.pojo.ProductBigType;
import cn.hbeu.service.ProductBigTypeService;
import cn.hbeu.util.StringUtil;

/**
 * 商品大类实现类
 * @author Administrator
 *
 */
@Service("productBigTypeService")
public class ProductBigTypeServiceImpl  implements  ProductBigTypeService{

	@Resource
	private BaseDAO<ProductBigType> baseDAO;
	
	



	public List<ProductBigType> findAllBigTypeList() {
		return baseDAO.find(" from ProductBigType");
	}

	public List<ProductBigType> findProductBigTypeList(
			ProductBigType s_productBigType, PageBean pageBean) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from ProductBigType");
		if(s_productBigType!=null){
			if(StringUtil.isNotEmpty(s_productBigType.getName())){
				hql.append(" and name like ?");
				param.add("%"+s_productBigType.getName()+"%");
			}
		}
		if(pageBean!=null){
			return baseDAO.find(hql.toString().replaceFirst("and", "where"),param,pageBean);
		}else{
			return baseDAO.find(hql.toString().replaceFirst("and", "where"), param);			
		}
	}

	public Long getProductBigTypeCount(ProductBigType s_productBigType) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("select count(*) from ProductBigType");
		if(s_productBigType!=null){
			if(StringUtil.isNotEmpty(s_productBigType.getName())){
				hql.append(" and name like ?");
				param.add("%"+s_productBigType.getName()+"%");
			}
		}
		return baseDAO.count(hql.toString().replaceFirst("and", "where"), param);
	}


	public void saveProductBigType(ProductBigType productBigType) {
		baseDAO.merge(productBigType);
	}

	public void delete(ProductBigType productBigType) {
		// TODO Auto-generated method stub
		baseDAO.delete(productBigType);
	}


	public ProductBigType getProductBigTypeById(int id) {
		return baseDAO.get(ProductBigType.class, id);
	}

}
