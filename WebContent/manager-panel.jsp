<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>manager-statistic</title>
<style>
td {
	text-align: center;
	padding: 5px;
	border: gray solid 1px;
}
.cover {
	display: flex;
	flex-direction: column;
	justify-content: center;
}
.dialog {
	margin: 0 auto;
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
		<button @click="submitquery">搜索</button>
		<button v-if="queryBar.tableInfo[queryBar.currentTable]['insertable']" @click="insertRow">添加{{queryBar.currentTable}}</button>
	</div>
	
<transition name="bouncePage">
<div id="search-result">
	<h5 v-if="queryBar.queryResult.length > 0">找到{{queryBar.queryResult.length-1}}条结果</h5>
	<table v-if="queryBar.queryResult.length > 1">
		<tr v-for="(ret, rowIdx) in queryBar.queryResult">
			<td v-for="val in ret">{{val}}</td>
			<template v-if="(queryBar.tableInfo[queryBar.queriedTable]['removable'] || queryBar.tableInfo[queryBar.queriedTable]['updatable'])">
			<td v-if="rowIdx != 0">
			<button v-if="queryBar.tableInfo[queryBar.queriedTable]['updatable']" @click="updateRow(rowIdx)">修改</button>
			<button v-if="queryBar.tableInfo[queryBar.queriedTable]['removable']" @click="deleteRow(rowIdx)">删除</button>
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
	
	<div id="room-dialog" v-if="roomDialog.open" class="cover">
	<transition name="bouncePage">
	<div class="dialog">
	<h5>添加客房</h5>
	<table>
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
				queryResult: []
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
			indexClickedInQueryResult: 0
		}
	},
	beforeMount: function() {
		$.ajax({
			url: 'Statistic',
			method: 'get',
			async: false,
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
				url: 'Statistic',
				method: 'post',
				async: false,
				data: {
					action: 'query',
					table: $("select[name='table']").val(),
					field: $("select[name='field']").val(),
					queryvalue: $("input[name='queryvalue']").val()
				},
				success: (res) => {
					if (res.queryresult.length > 1) this.queryBar.queryResult = res.queryresult;
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
				url: 'Statistic',
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
		updateRow: function(idx) {
			this.openDialog();
			this.currentAction = '修改';
			this.indexClickedInQueryResult = idx;
		},
		openDialog: function() {
			switch (this.queryBar.currentTable) {
			case '客房类型': 
				this.roomTypeDialog.open = true;
			break;
			case '客房':
				this.roomDialog.open = true;
				$.ajax({
				    url: 'SetRoomInfo',
				    method: 'get',
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
			let action, keyValue;
			if (this.idxClickedInQueryResult > 0) {
				action = 'update';
				keyValue = this.queryBar.queryResult[this.idxClickedInQueryResult][0];
			} else {
				action = 'indert';
				keyValue = null;
			}
			if ($("input[name='roomtype']").val() != '' 
				&& $("input[name='capacity']").val() != ''
				&& $("input[name='surplus']").val() != '' 
				&& $("input[name='price']").val() != '')
			$.ajax({
			    url: 'SetRoomType',
			    method: 'post',
			    data: {
			    	action: action,
			    	table: this.queryBar.currentTable,
			    	primaykey: this.queryBar.tableInfo[this.queryBar.currentTable]['fields'][0],
			    	keyvalue: keyValue,
			    	roomtype: $("input[name='roomtype']").val(),
			    	capacity: $("select[name='capacity']").val(),
			    	surplus: $("input[name='surplus']").val(),
			    	price: $("input[name='price']").val()
			    },
			    success: (res) => {
			    	if (res.status == 200) alert('添加成功！');
			    	else alert('添加失败：' + res.status);
			    },
			    error: (req, sta, err) => {
			    	alert('可能遇到一些问题！请查询确认');
			    }
			});
		},
		submitRoom: function() {
			let action, keyValue;
			if (this.idxClickedInQueryResult > 0) {
				action = 'update';
				keyValue = this.queryBar.queryResult[this.idxClickedInQueryResult][0];
			} else {
				action = 'insert';
				keyValue = null;
			}
			if ($("input[name='roomnum']").val() != ''
					&& $("input[name='floornum']").val() != ''
					&& $("select[name='orientation']").val() != '' )
			$.ajax({
				url: 'SetRoomInfo',
				method: 'post',
				data: {
					action: action,
			    	table: this.queryBar.currentTable,
			    	primarykey: this.queryBar.tableInfo[this.queryBar.currentTable]['fields'][0],
			    	keyvalue: keyValue,
					roomnum: $("input[name='roomnum']").val(),
					floornum: $("input[name='floornum']").val(),
					roomtype: $("select[name='roomtype']").val(),
					orientation: $("select[name='orientation']").val(),
					description: $("textarea[name='description']").val(),
					available: $("input:radio[name='available']:checked").val(),
				},
				success: (res) => {
					if (res.status == 200) alert('添加成功！');
					else alert('添加失败：' + res.status);
				},
				error: (req, sta, err) => {
					alert('可能遇到一些问题！请查询确认');
				}
			});
		},
		submitStaff: function() {
			let action, keyValue;
			if (this.idxClickedInQueryResult > 0) {
				action = 'update';
				keyValue = this.queryBar.queryResult[this.idxClickedInQueryResult][0];
			} else {
				action = 'indert';
				keyValue = null;
			}
			$.ajax({
				url: 'SetAccount',
				method: 'post',
				data: {
					action: 'addstaff',
					table: this.queryBar.currentTable,
			    	primarykey: this.queryBar.tableInfo[this.queryBar.currentTable]['fields'][0],
			    	keyvalue: keyValue,
					staffname: $("input[name='staffname']").val(),
					role: $("select[name='role']").val()
				},
				success: (res) => {
					if (res.staffid) alert('添加成功！ 员工号是：' + res.staffid);
					else alert(res.status);
				},
				error: (req, sta, err) => {
					alert('可能遇到一些问题！请查询确认');
				}
			});
		}
	},
	watch: {
		 
	}
});
</script>
</body>
</html>