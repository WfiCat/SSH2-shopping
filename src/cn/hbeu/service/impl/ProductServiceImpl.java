package cn.hbeu.service.impl;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.hbeu.dao.BaseDAO;
import cn.hbeu.pojo.PageBean;
import cn.hbeu.pojo.Product;
import cn.hbeu.service.ProductService;
import cn.hbeu.util.StringUtil;

/**
 * ��ƷService��
 * @author Administrator
 *
 */
@Service("productService")
public class ProductServiceImpl implements ProductService {

	@Resource
	private BaseDAO<Product> baseDAO;
	
	public List<Product> findProductList(Product s_product, PageBean pageBean) {

		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from Product");
		if(s_product!=null){
			if(s_product.getBigType()!=null){
				hql.append(" and bigType.id = ?");
				param.add(s_product.getBigType().getId());
			}
			if(s_product.getSmallType()!=null){
				hql.append(" and smallType.id = ?");
				param.add(s_product.getSmallType().getId());
			}
			//--����
			if(StringUtil.isNotEmpty(s_product.getName())){
				hql.append(" and name like ?");
				param.add("%"+s_product.getName()+"%");
			}
			if(s_product.getLowPrice()!= 0) {
				hql.append("  and price >= ?");
				param.add(s_product.getLowPrice());
			}
			if(s_product.getTopPrice()!= 0) {
				hql.append(" and price <= ?");
				param.add(s_product.getTopPrice());
			}
			//
			
			if(s_product.getSpecialPrice()==1){
				hql.append(" and specialPrice =1 order by specialPriceTime desc ");
			}
			if(s_product.getHot()==1){
				hql.append(" and hot =1 order by hotTime desc ");
			}
			
		}
		if(pageBean!=null){
			return baseDAO.find(hql.toString().replaceFirst("and", "where"), param, pageBean);
		}else{
			return null;
		}
	}

	public Long getProductCount(Product s_product) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("select count(*) from Product");
		if(s_product!=null){
			if(s_product.getBigType()!=null){
				hql.append(" and bigTypeId = ?");
				param.add(s_product.getBigType().getId());
			}
			if(s_product.getSmallType()!=null){
				hql.append(" and smallTypeId = ?");
				param.add(s_product.getSmallType().getId());
			}
			//--����
			if(StringUtil.isNotEmpty(s_product.getName())){
				hql.append(" and name like ?");
				param.add("%"+s_product.getName()+"%");
			}
			if(s_product.getLowPrice()!= 0) {
				hql.append(" and price >= ?");
				param.add(s_product.getLowPrice());
			}
			if(s_product.getTopPrice()!= 0) {
				hql.append(" and price <= ?");
				param.add(s_product.getTopPrice());
			}
			//
		}
		return baseDAO.count(hql.toString().replaceFirst("and", "where"), param);
	}

	public Product getProductById(int productId) {
		return baseDAO.get(Product.class, productId);
	}

	public boolean existProductWithSmallTypeId(int smallTypeId) {
		StringBuffer hql=new StringBuffer("from Product where smallType.id="+smallTypeId);
		if(baseDAO.find(hql.toString()).size()>0){
			return true;
		}else{
			return false;			
		}
	}

	public void saveProduct(Product product) {
		// TODO Auto-generated method stub
		baseDAO.merge(product);
	}

	public void deleteProduct(Product product) {
		// TODO Auto-generated method stub
		baseDAO.delete(product);
	}

	public void setProductWithHot(int productId) {
		// TODO Auto-generated method stub
		Product product=baseDAO.get(Product.class, productId);
		product.setHot(1);
		product.setHotTime(new Date());
		baseDAO.save(product);
	}

	public void setProductWithSpecialPrice(int productId) {
		// TODO Auto-generated method stub
		Product product=baseDAO.get(Product.class, productId);
		product.setSpecialPrice(1);
		product.setSpecialPriceTime(new Date());
		baseDAO.save(product);
	}

}
