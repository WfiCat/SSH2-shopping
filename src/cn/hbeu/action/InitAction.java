package cn.hbeu.action;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import cn.hbeu.pojo.PageBean;
import cn.hbeu.pojo.Product;
import cn.hbeu.pojo.ProductBigType;
import cn.hbeu.service.ProductBigTypeService;
import cn.hbeu.service.ProductService;

@Component
public class InitAction  implements ServletContextListener,ApplicationContextAware  {
	

	private static ApplicationContext applicationContext;
	

	public InitAction() {
		super();
		// TODO Auto-generated constructor stub
	}


	public void contextDestroyed(ServletContextEvent servletContextEvent) {
		// TODO Auto-generated method stub
	}


	public void contextInitialized(ServletContextEvent servletContextEvent) {
		// TODO Auto-generated method stub
		ServletContext application = servletContextEvent.getServletContext();
		ProductBigTypeService productBigTypeService=(ProductBigTypeService)applicationContext.getBean("productBigTypeService");
		List<ProductBigType> bigTypeList=productBigTypeService.findAllBigTypeList();
		application.setAttribute("bigTypeList", bigTypeList);
		

		
		// 今日特价
		Product s_product=new Product();
		s_product.setSpecialPrice(1);
		ProductService productService=(ProductService)applicationContext.getBean("productService");
		List<Product> specialPriceProductList= productService.findProductList(s_product, new PageBean(1,10));
		application.setAttribute("specialPriceProductList", specialPriceProductList);
		
		// 热卖推荐
		s_product=new Product();
		s_product.setHot(1);
		List<Product> hotProductList= productService.findProductList(s_product, new PageBean(1, 6));
		application.setAttribute("hotProductList", hotProductList);
	}

	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {
		this.applicationContext=applicationContext;
	}

	
}
