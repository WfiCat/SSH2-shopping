package cn.hbeu.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.context.annotation.DependsOn;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;

import cn.hbeu.pojo.PageBean;
import cn.hbeu.pojo.Product;
import cn.hbeu.pojo.ProductBigType;

import cn.hbeu.service.ProductBigTypeService;
import cn.hbeu.service.ProductService;
import cn.hbeu.util.PageUtil;
import cn.hbeu.util.PropertiesUtil;
import cn.hbeu.util.StringUtil;

/**
 * 主页初始化Action类
 * 
 * @author Administrator
 *
 */
@Controller
public class IndexAction extends ActionSupport implements ServletRequestAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private HttpServletRequest request;

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

	/**
	 * 商品查询类
	 */
	private Product s_product;

	/**
	 * 商品集合
	 */
	private List<Product> productList;

	/**
	 * 特价商品集合
	 * 
	 * @return
	 */
	private List<Product> specialPriceProductList;

	/**
	 * 热卖商品集合
	 * 
	 * @return
	 */
	private List<Product> hotProductList;

	public List<Product> getSpecialPriceProductList() {
		return specialPriceProductList;
	}

	public void setSpecialPriceProductList(List<Product> specialPriceProductList) {
		this.specialPriceProductList = specialPriceProductList;
	}

	public List<Product> getHotProductList() {
		return hotProductList;
	}

	public void setHotProductList(List<Product> hotProductList) {
		this.hotProductList = hotProductList;
	}

	public List<Product> getProductList() {
		return productList;
	}

	public void setProductList(List<Product> productList) {
		this.productList = productList;
	}

	private String page; // 商品 第几页
	private Long total; // 商品 总记录数
	private String pageCode; // 商品 分页代码

	public Product getS_product() {
		return s_product;
	}

	public void setS_product(Product s_product) {
		this.s_product = s_product;
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}

	public Long getTotal() {
		return total;
	}

	public void setTotal(Long total) {
		this.total = total;
	}

	public String getPageCode() {
		return pageCode;
	}

	public void setPageCode(String pageCode) {
		this.pageCode = pageCode;
	}

	@Override
	public String execute() throws Exception {
		if (StringUtil.isEmpty(page)) {
			page = "1";
		}

		return SUCCESS;
	}

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

}
