package cn.hbeu.action;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ApplicationAware;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;

import cn.hbeu.pojo.PageBean;
import cn.hbeu.pojo.Product;
import cn.hbeu.pojo.ProductBigType;
import cn.hbeu.service.ProductBigTypeService;
import cn.hbeu.service.ProductService;
import cn.hbeu.util.ResponseUtil;

/**
 * 系统Action类
 * 
 * @author Administrator
 *
 */
@Controller
public class SysAction extends ActionSupport implements ApplicationAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Map<String, Object> application;

	/**
	 * 商品大类service
	 */
	@Resource
	private ProductBigTypeService productBigTypeService;

	/**
	 * 商品service
	 */
	@Resource
	private ProductService productService;

	public void setApplication(Map<String, Object> application) {
		this.application = application;
	}

	/**
	 * 刷新系统
	 * 
	 * @return
	 * @throws Exception
	 */
	public String refreshSystem() throws Exception {
		List<ProductBigType> bigTypeList = productBigTypeService.findAllBigTypeList();
		application.put("bigTypeList", bigTypeList);

		// 今日特价
		Product s_product = new Product();
		s_product.setSpecialPrice(1);
		List<Product> specialPriceProductList = productService.findProductList(s_product, new PageBean(1, 8));
		application.put("specialPriceProductList", specialPriceProductList);

		// 热卖推荐
		s_product = new Product();
		s_product.setHot(1);
		List<Product> hotProductList = productService.findProductList(s_product, new PageBean(1, 6));
		application.put("hotProductList", hotProductList);

		JSONObject result = new JSONObject();
		result.put("success", true);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}

}
