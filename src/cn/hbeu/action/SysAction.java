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
 * ϵͳAction��
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
	 * ��Ʒ����service
	 */
	@Resource
	private ProductBigTypeService productBigTypeService;

	/**
	 * ��Ʒservice
	 */
	@Resource
	private ProductService productService;

	public void setApplication(Map<String, Object> application) {
		this.application = application;
	}

	/**
	 * ˢ��ϵͳ
	 * 
	 * @return
	 * @throws Exception
	 */
	public String refreshSystem() throws Exception {
		List<ProductBigType> bigTypeList = productBigTypeService.findAllBigTypeList();
		application.put("bigTypeList", bigTypeList);

		// �����ؼ�
		Product s_product = new Product();
		s_product.setSpecialPrice(1);
		List<Product> specialPriceProductList = productService.findProductList(s_product, new PageBean(1, 8));
		application.put("specialPriceProductList", specialPriceProductList);

		// �����Ƽ�
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
