package cn.hbeu.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;

import cn.hbeu.pojo.PageBean;
import cn.hbeu.pojo.User;
import cn.hbeu.service.UserService;
import cn.hbeu.util.DateJsonValueProcessor;
import cn.hbeu.util.NavUtil;
import cn.hbeu.util.ResponseUtil;
import cn.hbeu.util.StringUtil;

/**
 * 用户Action类
 * @author Administrator
 *
 */
@Controller
public class UserAction extends ActionSupport implements ServletRequestAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private HttpServletRequest request;
	@Resource
	private UserService userService;
	// 权限修改
	private User editUserRoot;
	private String userName;
	// 添加
	private User user;
	private String imageCode;
	private String error;
	
	private String mainPage;
	private String navCode;
	
	
	private String page;
	private String rows;
	// 搜索
	private User s_user;
	
	public User getEditUserRoot() {
		return editUserRoot;
	}

	public void setEditUserRoot(User editUserRoot) {
		this.editUserRoot = editUserRoot;
	}


	private String ids;
		
	public User getS_user() {
		return s_user;
	}

	public void setS_user(User s_user) {
		this.s_user = s_user;
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}



	public String getRows() {
		return rows;
	}



	public void setRows(String rows) {
		this.rows = rows;
	}



	public String getUserName() {
		return userName;
	}



	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	


	public User getUser() {
		return user;
	}



	public void setUser(User user) {
		this.user = user;
	}

	



	public String getImageCode() {
		return imageCode;
	}



	public void setImageCode(String imageCode) {
		this.imageCode = imageCode;
	}
	
	



	public String getError() {
		return error;
	}



	public void setError(String error) {
		this.error = error;
	}
	
	



	public String getMainPage() {
		return mainPage;
	}



	public void setMainPage(String mainPage) {
		this.mainPage = mainPage;
	}



	public String getNavCode() {
		return navCode;
	}



	public void setNavCode(String navCode) {
		this.navCode = navCode;
	}
	
	
	



	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	/**
	 * 判断指定用户名的用户是否存在
	 * @return
	 * @throws Exception
	 */
	public String existUserWithUserName()throws Exception{
		boolean exist=userService.existUserWithUserName(userName);
		JSONObject result=new JSONObject();
		if(exist){
			result.put("exist", true);
		}else{
			result.put("exist", false);
		}
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	/**
	 * 用户注册
	 * @return
	 * @throws Exception
	 */
	public String register()throws Exception{
		userService.saveUser(user);
		return "register_success";
	}
	
	/**
	 * 用户登录
	 * @return
	 * @throws Exception
	 */
	public String login()throws Exception{
		HttpSession session=request.getSession();
		User currentUser=userService.login(user);
		if(currentUser==null){
			error="用户名或密码为空！";
			if(user.getStatus()==2){
				return "adminError";
			}else{
				return ERROR;			
			}
		}else if(!imageCode.equals(session.getAttribute("sRand"))){
			error="验证码错误";
			if(user.getStatus()==2){
				return "adminError";
			}else{
				return ERROR;			
			}
		}else{
			session.setAttribute("currentUser", currentUser);
		}
		if(currentUser.getStatus()==2){
			return "adminLogin";
		}else{
			return "login";			
		}
	}
	
	/**
	 * 注销用户
	 * @throws Exception
	 */
	public String logout()throws Exception{
		request.getSession().invalidate();
		return "logout";
	}
	
	/**
	 * 管理员注销
	 * @return
	 * @throws Exception
	 */
	public String logout2()throws Exception{
		request.getSession().invalidate();
		return "logout2";
	}
	
	/**
	 * 用户中心
	 * @return
	 * @throws Exception
	 */
	public String userCenter()throws Exception{
		navCode=NavUtil.genNavCode("个人中心");
		mainPage="userCenter/ucDefault.jsp";
		return "userCenter";
	}
	
	/**
	 * 获取用户信息
	 * @return
	 * @throws Exception
	 */
	public String getUserInfo()throws Exception{
		navCode=NavUtil.genNavCode("个人中心");
		mainPage="userCenter/userInfo.jsp";
		return "userCenter";
	}
	
	/**
	 * 修改个人信息预操作
	 * @return
	 * @throws Exception
	 */
	public String preSave()throws Exception{
		HttpSession session=request.getSession();
		user=(User)session.getAttribute("currentUser");
		navCode=NavUtil.genNavCode("个人中心");
		mainPage="userCenter/userSave.jsp";
		return "userCenter";
	}
	
	/**
	 * 保存用户信息
	 * @return
	 * @throws Exception
	 */
	public String save()throws Exception{
		HttpSession session=request.getSession();
		userService.saveUser(user);
		session.setAttribute("currentUser", user);
		navCode=NavUtil.genNavCode("个人中心");
		mainPage="userCenter/userInfo.jsp";
		return "userCenter";
	}
	
	
	/**
	 * 后台修改用户信息
	 * 
	 * @return
	 * @throws Exception 
	 */
	public String updateUser() throws Exception {
		// user---已经传入
		JSONObject result = new JSONObject();
		// 用户名存在且id不为修改的项--失败！
		User u = userService.existUser(user.getUserName());
		if (u != null && u.getId() != user.getId()) {
			result.put("success", false);
			ResponseUtil.write(ServletActionContext.getResponse(), result);
			return null;
		}else{
			result.put("success", true);
			userService.saveUser(user);
			ResponseUtil.write(ServletActionContext.getResponse(), result);
			return null;
		}
		
	}
	
	/**
	 * 修改用户权限
	 * @return
	 * @throws Exception
	 */
	public String editUserRoot() throws Exception {
		User u = userService.getUserById(editUserRoot.getId());
		u.setStatus(editUserRoot.getStatus());
		userService.saveUser(u);
		JSONObject result = new JSONObject();
		result.put("success", true);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	/**
	 * 后台-保存用户信息
	 * @return
	 * @throws Exception
	 */
	public String saveUser()throws Exception{		
		JSONObject result = new JSONObject();
		boolean isExist = userService.existUserWithUserName(user.getUserName());
		if (!isExist) {
			result.put("success", true);
			user.setStatus(1);
			userService.saveUser(user);
			ResponseUtil.write(ServletActionContext.getResponse(), result);
			return null;
		}
		result.put("success", false);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}

	/**
	 * 分页查询用户信息
	 * @return
	 * @throws Exception
	 */
	public String list() throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		List<User> userList=userService.findUserList(s_user, pageBean);
	
		long total=userService.getUserCount(s_user);
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(new String[]{"orderList"});
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));  
		JSONArray rows=JSONArray.fromObject(userList,jsonConfig);
		JSONObject result=new JSONObject();
		result.put("rows", rows);
		result.put("total", total);		
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	/**
	 * 删除用户
	 * @return
	 * @throws Exception
	 */
	public String deleteUsers()throws Exception{
		JSONObject result=new JSONObject();
		String []idsStr=ids.split(",");
		for(int i=0;i<idsStr.length;i++){
			User u=userService.getUserById(Integer.parseInt(idsStr[i]));
			userService.delete(u);
		}
		result.put("success", true);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	/**
	 * 修改密码
	 * @return
	 * @throws Exception
	 */
	public String modifyPassword()throws Exception{
		User u=userService.getUserById(user.getId());
		u.setPassword(user.getPassword());
		userService.saveUser(u);
		JSONObject result=new JSONObject();
		result.put("success", true);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}


	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request=request;
	}

}
