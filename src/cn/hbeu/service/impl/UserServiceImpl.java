package cn.hbeu.service.impl;


import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.hbeu.dao.BaseDAO;
import cn.hbeu.pojo.PageBean;
import cn.hbeu.pojo.User;
import cn.hbeu.service.UserService;
import cn.hbeu.util.StringUtil;

/**
 * ”√ªßService¿‡
 * @author Administrator
 *
 */
@Service("userService")
public class UserServiceImpl implements UserService{

	@Resource
	private BaseDAO<User> baseDAO;
	
	public boolean existUserWithUserName(String userName) {
		String hql="select count(*) from User where userName=?";
		long count=baseDAO.count(hql, new Object[]{userName});
		if(count>0){
			return true;
		}else{
			return false;			
		}
	}

	public void saveUser(User user) {
		baseDAO.merge(user);
	}

	public User login(User user) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from User u where u.userName=? and u.password=?");
		param.add(user.getUserName());
		param.add(user.getPassword());
		if(user.getStatus()==2){
			hql.append(" and u.status=2");
		}
		return baseDAO.get(hql.toString(), param);
	}

	public List<User> findUserList(User s_user,PageBean pageBean) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from User");
		if(s_user!=null){
			if(StringUtil.isNotEmpty(s_user.getUserName())){
				hql.append(" and userName like ?");
				param.add("%"+s_user.getUserName()+"%");
			}
		}
		hql.append(" and (status=1 or status = 2)");
		if(pageBean!=null){
			return baseDAO.find(hql.toString().replaceFirst("and", "where"),param,pageBean);
		}else{
			return null;			
		}
	}

	public Long getUserCount(User s_user) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("select count(*) from User");
		if(s_user!=null){
			if(StringUtil.isNotEmpty(s_user.getUserName())){
				hql.append(" and userName like ?");
				param.add("%"+s_user.getUserName()+"%");
			}
		}
		hql.append(" and status=1");
		return baseDAO.count(hql.toString().replaceFirst("and", "where"), param);
	}

	public void delete(User user) {
		baseDAO.delete(user);
	}

	public User getUserById(int id) {
		return baseDAO.get(User.class, id);
	}

	public User existUser(String userName) {
		List<Object> param=new LinkedList<Object>();
		StringBuffer hql=new StringBuffer("from User u where u.userName=?");
		param.add(userName);
		return baseDAO.get(hql.toString(), param);
	}

}
