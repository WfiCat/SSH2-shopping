<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	var url;

	function searchUser() {
		$('#dg').datagrid('load', {
			"s_user.userName" : $("#s_userName").val()
		});
	}

	function openUserAddDialog() {
		$("#dlg").dialog("open").dialog("setTitle", "添加用户信息");
		url = "user_saveUser.action";
	}

	function saveUser() {
		$("#fm").form("submit", {
			url : url,
			onSubmit : function() {
				if ($('#sex').combobox("getValue") == "") {
					$.messager.alert("系统提示", "请选择性别");
					return false;
				}
				return $(this).form("validate");
			},
			success : function(result) {
				var result = eval('(' + result + ')');
				if (result.success) {
					$.messager.alert("系统提示", "保存成功");
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
				} else {
					$.messager.alert("系统提示", "保存失败,用户名可能重复！");
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
					return;
				}
			}
		});
	}

	function resetValue() {
		$("#trueName").val("");
		$("#userName").val("");
		$("#password").val("");
		$("#sex").combobox("setValue", "");
		$("#email").val("");
		$("#mobile").val("");
		$("#address").val("");
	}

	function closeUserDialog() {
		$("#dlg").dialog("close");
		resetValue();
	}

	function openUserModifyDialog() {
		var selectedRows = $("#dg").datagrid('getSelections');
		if (selectedRows.length != 1) {
			$.messager.alert("系统提示", "请选择一条要编辑的数据！");
			return;
		}
		var row = selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle", "编辑用户信息");
		$("#trueName").val(row.trueName);
		$("#userName").val(row.userName);
		$("#password").val(row.password);
		$("#sex").combobox("setValue", row.sex);
		$("#email").val(row.email);
		$("#mobile").val(row.mobile);
		$("#address").val(row.address);
		url = "user_updateUser.action?user.id=" + row.id;
	}

	function deleteUser() {
		var selectedRows = $("#dg").datagrid('getSelections');
		if (selectedRows.length == 0) {
			$.messager.alert("系统提示", "请选择要删除的数据！");
			return;
		}
		var strIds = [];
		for (var i = 0; i < selectedRows.length; i++) {
			strIds.push(selectedRows[i].id);
		}
		var ids = strIds.join(",");
		$.messager.confirm("系统提示", "您确认要删掉这<font color=red>"
				+ selectedRows.length + "</font>条数据吗？", function(r) {
			if (r) {
				$.post("user_deleteUsers.action", {
					ids : ids
				}, function(result) {
					if (result.success) {
						$.messager.alert("系统提示", "数据已成功删除！");
						$("#dg").datagrid("reload");
					} else {
						$.messager.alert('系统提示', result.errorMsg);
					}
				}, "json");
			}
		});
	}

	function formatHot(val, row) {
		if (val == 1) {
			return "普通用户";
		} else {
			return "管理员";
		}
	}

	function formatOper(val, row, index) {
		return '<a href="javascript:void(0)"  onclick="editRoot(' + index
				+ ')">修改</a>';
	}

	function editRoot(index) {
		$('#dg').datagrid('selectRow', index); // 按照选择的index来找到所选行
		var row = $('#dg').datagrid('getSelected');// 获得选中行的数据
		if (row) {// 判读选中行不为空
			var statu = row.status;
			var root ;
			if (statu == 1) {
				root = 2;

			} else if (statu == 2) {
				
				root = 1;
			}
			
			$.messager.confirm('系统提示', '是否修改该用户的权限', function(r) {
				if (r) {
					$.ajax({
						type : 'POST',
						url : 'user_editUserRoot.action',
						async : false,
						data : {
							"editUserRoot.id" : row.id,
							"editUserRoot.status" : root
						},
						dataType : 'json',
						success:function(result){
							if (result.success) {
								$.messager.alert("系统提示", "权限已经修改！");
								$("#dg").datagrid("reload");
							} else {
								$.messager.alert('系统提示', "权限修改失败");
								$("#dg").datagrid("reload");
							} 
					        
						}
						
					});
					}
				
				}
				);
			
		}
	
	}
</script>
</head>
<body style="margin: 1px;">
	<table id="dg" title="用户管理" class="easyui-datagrid" fitColumns="true"
		pagination="true" rownumbers="true" url="user_list.action" fit="true"
		toolbar="#tb">
		<thead>
			<tr>
				<th field="cb" checkbox="true" align="center"></th>
				<th field="id" width="50" align="center">编号</th>
				<th field="trueName" width="100" align="center">收件人姓名</th>
				<th field="userName" width="100" align="center">用户名</th>
				<th field="password" width="100" align="center">用户密码</th>
				<th field="sex" width="50" align="center">性别</th>
				<th field="birthday" width="100" align="center">出生日期</th>
				<th field="email" width="100" align="center">邮件</th>
				<th field="mobile" width="100" align="center">联系电话</th>
				<th field="address" width="100" align="center">收货地址</th>
				<th field="status" width="50" align="center" formatter="formatHot">权限级别</th>
				<th data-options="field:'operate',width:80,align:'center',formatter:formatOper">修改权限</th>
			</tr>
		</thead>

	</table>


	<div id="tb">
		<div>
			<a href="javascript:openUserAddDialog()" class="easyui-linkbutton"
				iconCls="icon-add" plain="true">添加</a> <a
				href="javascript:openUserModifyDialog()" class="easyui-linkbutton"
				iconCls="icon-edit" plain="true">修改</a> <a
				href="javascript:deleteUser()" class="easyui-linkbutton"
				iconCls="icon-remove" plain="true">删除</a>
		</div>
		<div>
			&nbsp;用户名：&nbsp;<input type="text" name="user.userName"
				id="s_userName" size="20"
				onkeydown="if(event.keyCode==13) searchUser()" /> <a
				href="javascript:searchUser()" class="easyui-linkbutton"
				iconCls="icon-search" plain="true">搜索</a>
		</div>
	</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 570px; height: 300px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table cellspacing="8px;">
				<tr>
					<td>真实姓名：</td>
					<td><input type="text" id="trueName" name="user.trueName"
						class="easyui-validatebox" required="true" /></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>用户名：</td>
					<td><input type="text" id="userName" name="user.userName"
						class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<td>密码：</td>
					<td><input type="text" id="password" name="user.password"
						class="easyui-validatebox" required="true" /></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>性别：</td>
					<td><select class="easyui-combobox" id="sex" name="user.sex"
						style="width: 154px;" editable="false" panelHeight="auto">
							<option value="">请选择性别</option>
							<option value="男">男</option>
							<option value="女">女</option>
					</select></td>
				</tr>
				<tr>
					<td>出生日期：</td>
					<td><input type="text" id="birthday" name="user.birthday"
						class="easyui-datebox" editable="false" required="true" /></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>邮件：</td>
					<td><input type="text" id="email" name="user.email"
						class="easyui-validatebox" validType="email" required="true" /></td>

				</tr>
				<tr>
					<td>联系电话：</td>
					<td><input type="text" id="mobile" name="user.mobile"
						class="easyui-validatebox" required="true" /></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<td>收货地址：</td>
					<td colspan="4"><input type="text" id="address"
						name="user.address" class="easyui-validatebox" required="true"
						style="width: 350px;" /></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:saveUser()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> <a href="javascript:closeUserDialog()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>

</body>
</html>