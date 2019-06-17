<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>通用头部</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.js"></script>
<link type="text/css" rel="stylesheet" href="css/style.css" />
<script src="${pageContext.request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>



<script type="text/javascript">
    var url;
	function logout(){
		if(confirm('您确定要退出系统吗？')){
			window.location.href='user_logout.action';
		}
	}
	
	function checkLogin(){
		if('${currentUser.userName}'==''){
			alert("请先登录，然后购物！");
		}else{
			window.location.href="shopping_list.action";
		}
	}
	

	/* todo */
	function openProuductSeacherDialog(){
		$("#dlg").dialog("open").dialog("setTitle","搜索你想要的商品");
	}
	
	
	
	function seacherProduct(){
				if($('#topPrice').val()!=""&&$('#lowPrice').val()!=""){
					if(Number($('#topPrice').val())<Number($('#lowPrice').val())){
						$.messager.alert("系统提示","请输入正确的价格区间！");
						return false;
					}
					
				}
				$("#dlg").dialog("close");
				return $(this).form("validate");
			}

	
	function resetValue(){
		$("#name").val("");
		$("#lowPrice").val("");
		$("#topPrice").val("");
	}
	
	function closeProuductSeacherDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}

</script>
</head>
<body>
<div>
		<!--搜索商品-->
 <div id="dlg" class="easyui-dialog" style="width: 300px;height: 156px;padding: 10px 20px" closed="true" buttons="#dlg-buttons">
  <form id="fm" method="post" onsubmit="return seacherProduct()" action="product.action" >
  	<table cellspacing="8px;">
  		<tr>
  			<td>商品名称：</td>
  			<td colspan="2"><input type="text" id="name" name="s_product.name"  /></td>
  		</tr>
  		<tr>
  			<td valign="top">最低价：</td>
  			<td colspan="2"><input type="text" id="lowPrice" name="s_product.lowPrice"  /></td>
  			
  		</tr>
  		<tr>
  			<td valign="top">最高价：</td>
  			<td colspan="2"><input type="text" id="topPrice" name="s_product.topPrice"  /></td>
  		</tr>
  		<tr>
  		<td></td>
  			<td>
  			<input type="submit" value="提交"  />
  			<input type="button" value="算了" onclick="closeProuductSeacherDialog()" />
  			</td>
  			<td></td>
  		</tr>
  	</table>
 	 </form>
</div>	 


	<div id="logo">
		<!-- 存放logo -->
	</div>
	<!--头部 -->
	<div class="help">
		<c:choose>
			<c:when test="${not empty currentUser}">
				<a href="shopping_list.action" class="shopping">购物车(${shoppingCart.shoppingCartItems==null?0:shoppingCart.shoppingCartItems.size()}件商品)</a>
				<a href="user_userCenter.action">${currentUser.userName }</a>
				<a href="javascript:logout()">注销</a>
				<a href="register.jsp">注册</a>
				<a href="javascript:openProuductSeacherDialog()"  iconCls="icon-search" plain="true">搜索</a>
			</c:when>
			<c:otherwise>
				<a href="javascript:checkLogin()" class="shopping">购物车</a>
				<a href="login.jsp">登录</a>
				<a href="register.jsp">注册</a>
				<a href="javascript:openProuductSeacherDialog()"  iconCls="icon-search" plain="true">搜索</a>
			</c:otherwise>
		</c:choose>	
	</div>
	
	<div class="navbar">
		<ul class="clearfix">
			<li class="current"><a href="index.jsp">首页</a>
			</li>
			<c:forEach var="bigType"  items="${bigTypeList }">
				<li>
					<a href="product.action?s_product.bigType.id=${bigType.id }">${bigType.name }</a>
				</li>
			</c:forEach>
		</ul>
	</div>
</div>

<div id="childNav">
	<div class="wrap">
		<ul class="clearfix">
			<c:forEach var="tag" items="${tagList }"  varStatus="status">
				<c:choose>
					<c:when test="${status.index==0 }">
						<li class="first"><a href="${tag.url }" target="_blank">${tag.name }</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${tag.url }" target="_blank">${tag.name }</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</ul>
	</div>
</div>
</body>
</html>