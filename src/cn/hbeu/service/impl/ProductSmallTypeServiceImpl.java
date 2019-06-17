package cn.hbeu.service.impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.hbeu.dao.BaseDAO;
import cn.hbeu.pojo.PageBean;
import cn.hbeu.pojo.ProductSmallType;
import cn.hbeu.service.ProductSmallTypeService;
import cn.hbeu.util.StringUtil;

/**
 * 商品小类实现类
 * @author Administrator
 *
 */
@Service("productSmallTypeService")
public class ProductSmallTypeServiceImpl implements ProductSmallTypeService{

	@Resource
	private BaseDAO<ProductSmallType> baseDAO;
	
	public boolean existSmallTypeWithBigTypeId(int bigTypeId) {
		StringBuffer hql=new StringBuffer("from ProductSmallType where bigType.id="+bigTypeId);
		if(baseDAO.find(hql.toString()).size()>0){
			return true;
		}else{
			return false;			
		}
	}

	public List<ProductSmallType> findProductSmallTypeList(
			ProductSmallType s_productSmallType, PageBean pageBean) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from ProductSmallType");
		if(s_productSmallType!=null){
			if(StringUtil.isNotEmpty(s_productSmallType.getName())){
				hql.append(" and name like ?");
				param.add("%"+s_productSmallType.getName()+"%");
			}
			if(s_productSmallType.getBigType()!=null &&s_productSmallType.getBigType().getId()!=-1){
				hql.append(" and bigType.id = ?");
				param.add(s_productSmallType.getBigType().getId());
			}
		}
		if(pageBean!=null){
			return baseDAO.find(hql.toString().replaceFirst("and", "where"),param,pageBean);
		}else{
			return baseDAO.find(hql.toString().replaceFirst("and", "where"), param);			
		}
	}

	public Long getProductSmallTypeCount(ProductSmallType s_productSmallType) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("select count(*) from ProductSmallType");
		if(s_productSmallType!=null){
			if(StringUtil.isNotEmpty(s_productSmallType.getName())){
				hql.append(" and name like ?");
				param.add("%"+s_productSmallType.getName()+"%");
			}
		}
		return baseDAO.count(hql.toString().replaceFirst("and", "where"), param);
	}

	public void saveProductSmallType(ProductSmallType productSmallType) {
		// TODO Auto-generated method stub
		baseDAO.merge(productSmallType);
	}

	public void delete(ProductSmallType productSmallType) {
		// TODO Auto-generated method stub
		baseDAO.delete(productSmallType);
	}

	public ProductSmallType getProductSmallTypeById(int id) {
		// TODO Auto-generated method stub
		return baseDAO.get(ProductSmallType.class, id);
	}

}
