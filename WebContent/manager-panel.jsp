<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MANAGER PANEL</title>
<style>
td {
	text-align: center;
	padding: 5px;
	border: gray solid 1px;
}
td input {
	border: none;
}
.dialog {
	
	text-align: center;
	border: black solid 1px;
}
.bouncePage-enter-active {
    animation: bouncePage-in .3s;
}
.bouncePage-leave-active {
    animation: bouncePage-in .3s reverse;
}
@keyframes bouncePage-in {
    0% {
        transform: scale(0);
    }
    80% {
        transform: scale(1.2);
    }
    100% {
        transform: scale(1);
    }
}
.length-limit {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
</style>
</head>
<body>
<div id="manager-panel">

	<div id="search-bar">
	<h3>数据管理</h3>
		<label>范围</label>
		<select name="table" v-model="queryBar.currentTable">
		<option v-for="table in queryBar.tables" :value="table">{{table}}</option>
		</select>
		<label>字段</label>
		<select name="field">
		<option v-for="field in queryBar.tableInfo[queryBar.currentTable]['fields']" :value="field">{{field}}</option>
		</select>
		<input type="text" name="queryvalue" placeholder="直接点击搜索查询所有内容" required/>
		<button @click="submitquery" :disabled="queryBar.exclusiveUpdating">搜索</button>
		<button v-if="queryBar.tableInfo[queryBar.currentTable]['insertable']" @click="insertRow " :disabled="queryBar.exclusiveUpdating">添加{{queryBar.currentTable}}</button>
	</div>
	
<transition name="bouncePage">
<div id="search-result">
	<h5 v-if="queryBar.queryResult.length > 0">找到{{queryBar.queryResult.length-1}}条结果</h5>
	<table v-if="queryBar.queryResult.length > 1">
		<tr v-for="(row, rowIdx) in queryBar.queryResult">
			<td v-for="(val, colIdx) in row"><input :value="val" @keyup="setUpdatingRowInfo(rowIdx, colIdx)" :readonly="!queryBar.updating[rowIdx]"/></td>
			<template v-if="(queryBar.tableInfo[queryBar.queriedTable]['removable'] || queryBar.tableInfo[queryBar.queriedTable]['updatable'])">

			<td v-if="rowIdx != 0 ">
			<button v-if="queryBar.tableInfo[queryBar.queriedTable]['updatable'] && !queryBar.updating[rowIdx] " @click="updatingRow(rowIdx)" :disabled="queryBar.exclusiveUpdating">修改</button>
			<button v-if="queryBar.tableInfo[queryBar.queriedTable]['updatable'] && queryBar.updating[rowIdx] " @click="updatedRow(rowIdx, 'confirm')">确认修改</button>
			<button v-if="queryBar.tableInfo[queryBar.queriedTable]['updatable'] && queryBar.updating[rowIdx] " @click="updatedRow(rowIdx, 'cancel')">取消修改</button>
			<button v-if="queryBar.tableInfo[queryBar.queriedTable]['removable'] && !queryBar.updating[rowIdx] " @click="deleteRow(rowIdx)"  :disabled="queryBar.exclusiveUpdating">删除</button>
			</td>

			<td v-else>操作</td>
			</template>
		</tr>
	</table>
</div>
</transition>

	<div id="roomtype-dialog" v-if="roomTypeDialog.open" class="cover">
	<transition name="bouncePage">
	<div class="dialog">
	<h5>添加客房类型</h5>
	<table>
		<tr>
			<td>客房类型</td>
			<td><input type="text" name="roomtype" required></td>
		</tr>
		<tr>
			<td>客房容量</td>
			<td>
			<select name="capacity" required>
			<option v-for="num in roomTypeDialog.roomTypeCapacities" :value="num">{{num}}</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>客房价格</td>
			<td><input type="text" name="price" required></td>
		</tr>
		<tr>
			<td>客房余量</td>
			<td><input type="number" name="surplus" required></td>
		</tr>
		<tr>
			<td><button @click="submitRoomType">{{currentAction}}</button></td>
			<td><button @click="closeDialog">退出</button></td>
		</tr>
	</table>
	</div>
	</transition>
	</div>
	
	<div id="room-dialog" v-if="roomDialog.open" class="cover" align="center">
	<transition name="bouncePage">
	<div class="dialog" align="center">
	<h5>添加客房</h5>
	<table  align="center">
		<tr>
			<td>房间号</td>
			<td><input type="number" name="roomnum" required :disabled="roomDialog.disabled"></td>
		</tr>
		<tr>
			<td>房间类型</td>
			<td>
			<select name="roomtype" required :disabled="roomDialog.disabled">
			<option v-for="roomtype in roomDialog.roomTypes" :value="roomtype">{{roomtype}}</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>朝向</td>
			<td>
			<select name="orientation" required :disabled="roomDialog.disabled">
			<option v-for="orientation in roomDialog.orientations" :value="orientation">{{orientation}}</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>房间特征描述</td>
			<td><textarea name="description" :disabled="roomDialog.disabled"></textarea></td>
		</tr>
		<tr>
			<td>是否空置</td>
			<td>
			<label>是</label>
			<input type="radio" name="available" value="1" checked :disabled="roomDialog.disabled">
			<label>否</label>
			<input type="radio" name="available" value="0" :disabled="roomDialog.disabled">
			</td>
		</tr>
		<tr>
			<td><button @click="submitRoom" :disabled="roomDialog.disabled">{{currentAction}}</button></td>
			<td><button @click="closeDialog">退出</button></td>
		</tr>
	</table>
	</div>
	</transition>
	</div>
	
	<div id="staff-dialog" v-if="staffDialog.open" class="cover">
	<transition name="bouncePage">
	<div class="dialog">
	<h3>添加员工</h3>
	<table>
		<tr>
			<td>员工姓名</td>
			<td><input type="text" name="staffname" required></td>
		</tr>
		<tr>
			<td>员工职位</td>
			<td>
			<select name="role" required>
			<option v-for="role in staffDialog.roles" :value="role">{{role}}</option>
			</select>
			</td>
		</tr>
		<tr>
			<td><button @click="submitStaff">{{currentAction}}</button></td>
			<td><button @click="closeDialog">退出</button></td>
		</tr>
	</table> 
	</div>
	</transition>
	</div>
	
</div>
<script src="js/vue.js"></script>
<script src="js/jquery.js"></script>
<script>
new Vue({
	el: '#manager-panel',
	data: function() {
		return {
			queryBar: {
				currentTable: '',
				queriedTable: '',
				tableInfo: {},
				tables: [],
				queryResult: [],
				updating: [],
				exclusiveUpdating: false,
				updatingRowInfo: {}
			},
			roomTypeDialog: {
				open: false,
				roomTypeCapacities: 4
			},
			roomDialog: {
				open: false,
				roomTypes: [],
				orientations: ['南', '北', '东', '西', '东南', '东北', '西南', '西北'],
				disabled: false
			},
			staffDialog: {
				open: false,
				roles: ['前台','经理']
			},
			currentAction: '',
			rowClickedInQueryResult: 0,
			server: 'ManagerServlet'
		}
	},
	
	beforeMount: function() {
		$.ajax({
			url: this.server,
			method: 'get',
			async: false,
			data: {
				resource: 'tableinfo'
			},
			success: (res) => {
				if (!$.isEmptyObject(res)) this.queryBar.tableInfo = res;
				else alert('系统暂无可查数据！');
			},
			error: (req, sta, err) => {
				alert('服务端错误！请稍后再试');
			}
		});
		for (var key in this.queryBar.tableInfo)
			this.queryBar.tables.push(key);
		this.queryBar.currentTable = this.queryBar.tables[0];
	},
	
	methods: {
		submitquery: function() {
			$.ajax({
				url: this.server,
				method: 'post',
				async: false,
				data: {
					action: 'query',
					table: $("select[name='table']").val(),
					field: $("select[name='field']").val(),
					queryvalue: $("input[name='queryvalue']").val()
				},
				success: (res) => {
					if (res.queryresult.length > 1) {
						this.queryBar.queryResult = res.queryresult;
						for (let i = 0; i < this.queryBar.queryResult.length; i++) {
							this.queryBar.updating.push(false);
						}
					}
					else this.queryBar.queryResult = [''];
					this.queryBar.queriedTable = this.queryBar.currentTable;
				},
				error: (req, sta, err) => {
					alert('可能遇到一些问题');
				}
			});
		},
		
		deleteRow: function(idx) {
			$.ajax({
				url: this.server,
				method: 'post',
				data: {
					action: 'deleterow',
					table: $("select[name='table']").val(),
					primarykey: this.queryBar.queryResult[0][0],
					keyvalue: this.queryBar.queryResult[idx][0]
				},
				success: (res) => {
					let oldLength = this.queryBar.queryResult.length;
					this.submitquery();
					if (oldLength == this.queryBar.queryResult.length) {
						alert('该项正在被引用，请解除后再作删除！');
					}
				},
				error: (req, sta, err) => {
					alert('可能遇到一些问题');
				}
			});
		},
		
		insertRow: function() {
			this.openDialog();
			this.currentAction = '添加';
		},
		
		updatingRow: function(idx) {
			this.queryBar.updating[idx] = !this.queryBar.updating[idx];
			this.queryBar.exclusiveUpdating = this.queryBar.updating[idx];
		},
		
		setUpdatingRowInfo: function(rowIdx, colIdx) {
			this.queryBar.updatingRowInfo.primaryKey = this.queryBar.queryResult[0][0];
			this.queryBar.updatingRowInfo.keyValue = this.queryBar.queryResult[rowIdx][0];
			this.queryBar.updatingRowInfo.field = this.queryBar.queryResult[0][colIdx];
			this.queryBar.updatingRowInfo.fieldValue = this.queryBar.queryResult[rowIdx][colIdx];
		},
		
		updatedRow: function(idx, actFlag) {
			this.queryBar.updating[idx] = !this.queryBar.updating[idx];
			this.queryBar.exclusiveUpdating = this.queryBar.updating[idx];
			switch (actFlag) {
			case 'confirm':
				console.log(this.queryBar.updatingRowInfo)
				break;
			case 'cancel':
				this.queryBar.updatingRowInfo = {};
				break;
			}
		},
		
		openDialog: function() {
			switch (this.queryBar.currentTable) {
			case '客房类型': 
				this.roomTypeDialog.open = true;
			break;
			case '客房':
				this.roomDialog.open = true;
				$.ajax({
				    url: this.server,
				    method: 'get',
				    data: {
				    	resource: 'roomtypes'
				    },
				    success: (res) => {
				    	if (res.roomtypes.length != 0) this.roomDialog.roomTypes = res.roomtypes;
				    	else {
				    		this.roomDialog.disabled = true;
				    		alert('请先添加房间类型！');
				    	}
				    },
				    error: (req, sta, err) => {
				    	alert('无法获取服务端信息，请检查网络设置！', sta, err);
				    }
				});
			break;
			case '员工':
				this.staffDialog.open = true;
			break;
			}
		},
		
		closeDialog: function() {
			this.cover = false;
			this.roomTypeDialog.open = false;
			this.roomDialog.open = false;
			this.staffDialog.open = false;
			this.currentAction = '';
			this.indexClickedInQueryResult = 0;
		},
		
		submitRoomType: function() {
			let values = [
					$("input[name='roomtype']").val(),
			    	$("select[name='capacity']").val(),
			    	$("input[name='surplus']").val(),
			    	$("input[name='price']").val()
				];
			this.submit(values, (res) => {
			    	if (res.status == 200) alert('添加成功！');
			    	else alert('添加失败：' + res.status);
			});
		},
		
		submitRoom: function() {
			let values = [
				$("input[name='roomnum']").val(),
				$("select[name='roomtype']").val(),
				$("input:radio[name='available']:checked").val(),
				$("select[name='orientation']").val(),
				$("textarea[name='description']").val()
			];
			this.submit(values, (res) => {
					if (res.status == 200) alert('添加成功！');
					else alert('添加失败：' + res.status);
				});
		},
		
		submitStaff: function() {
			let values = [
				$("input[name='staffname']").val(),
				$("select[name='role']").val()
			];
			this.submit(values, (res) => {
				if (res.staffid) alert('添加成功！ 员工号是：' + res.staffid);
				else alert(res.status);
			});
		},
		
		submit: function(values, callback) {
			let action, keyValue;
			if (this.rowClickedInQueryResult > 0) {
				action = 'update';
				keyValue = this.queryBar.queryResult[this.rowClickedInQueryResult][0];
			} else {
				action = 'insert';
				keyValue = null;
			}
			$.ajax({
				url: this.server,
				method: 'post',
				data: {
					action: action,
					table: this.queryBar.currentTable,
			    	primarykey: this.queryBar.tableInfo[this.queryBar.currentTable]['fields'][0],
			    	keyvalue: keyValue,
			    	values: JSON.stringify(values)
				},
				success: callback,
				error: (req, sta, err) => {
					alert('可能遇到一些问题！请查询确认');
				}
			});
		}
	}
});
</script>
</body>
</html>