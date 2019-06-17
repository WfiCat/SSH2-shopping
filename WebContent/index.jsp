<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>小张商城首页</title>
</head>
<body>
<div id="header" class="wrap">
	<jsp:include page="common/top.jsp"/>
</div>

<div id="main" class="wrap">
	<div class="lefter">
		<jsp:include page="common/left.jsp"/>
	</div>
	<div class="main">
			<div class="price-off ">
				<h2 style="width: 747px">今日特价</h2>
				<ul class="product clearfix" style="width: 770px">
				<c:forEach items="${specialPriceProductList}" var="spProduct">
					<li>
						<dl>
							<dt>
								<a href="product_showProduct.action?productId=${spProduct.id}" target="_blank"><img
									src="${spProduct.proPic}" /> </a>
							</dt>
							<dd class="title">
								<a href="product._showProduct.action?productId=${spProduct.id}" >${spProduct.name}</a>
							</dd>
							<dd class="price">￥${spProduct.price}</dd>
						</dl>
					</li>
				</c:forEach>
				</ul>
			</div>
			<div class="side">


			</div>
			<div class="spacer clear"></div> 
			
			<div class="hot">
				<h2>热卖推荐</h2>
				<ul class="product clearfix">
					<c:forEach items="${hotProductList}" var="hProduct">
					<li>
						<dl>
							<dt>
								<a href="product_showProduct.action?productId=${hProduct.id}" ><img
									src="${hProduct.proPic}" /> </a>
							</dt>
							<dd class="title">
								<a href="product_showProduct.action?productId=${hProduct.id}" >${hProduct.name}</a>
							</dd>
							<dd class="price">￥${hProduct.price}</dd>
						</dl>
					</li>
				</c:forEach>

				</ul>
			</div>
			
		</div>
		<div class="clear"></div>
</div>
<div id="footer">
	<jsp:include page="common/footer.jsp"/>
</div>
</body>
</html>