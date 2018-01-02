<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MANAGER PANEL</title>
<style>
html, body {
	width: 100%;
	height: 100%;
	padding: 0;
	margin: 0;
	text-align: center;
	font: bold 16px Arial;
}
[v-cloak] {
	display: none;
}
td {
	text-align: center;
	padding: 5px;
	border: gray solid 1px;
}
td input {
	border: none;
}
.warning {
	color: red;
}
.cover {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 680px;
	background-color: rgba(35,65,84,.6);
}
.dialog {
	width: 25%;
	height: 40%;
	position: absolute;
	top: 25%;
	left: 36%;
	text-align: center;
	padding: 25px;
	background: white;
	border: black solid 1px;
	z-index: 999;
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
.translatePage-enter-active {
	animation: bouncePage-in .3s;
}
.translatePage-leave-active {
	animation: bouncePage-in .3s reverse;
}
.length-limit {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
</style>
</head>
<body>
<div v-cloak id="manager-panel">

	<div id="search-bar">
	<transition-group name="bouncePage">
	<h3 key="caption">数据管理</h3>
	<div key="bar">
		<label>查找范围</label>
		<select name="table" v-model="multifunction.currentTable">
		<option v-for="table in multifunction.tables" :value="table">{{table}}</option>
		</select>
		<label>关键字</label>
		<select name="field">
		<option v-for="field in multifunction.tableInfo[multifunction.currentTable]['fields']" :value="field">{{field}}</option>
		</select>
		<input type="text" name="queryvalue" placeholder="直接点击搜索查询所有内容" required/>
		<button @click="submitquery" :disabled="multifunction.exclusiveUpdating">搜索</button>
		<button v-if="multifunction.tableInfo[multifunction.currentTable]['insertable']" @click="insertRow " :disabled="multifunction.exclusiveUpdating">添加{{multifunction.currentTable}}</button>
	</div>
	</transition-group>	
	</div>
	

<transition name="bouncePage">
<div id="search-result" v-if="multifunction.showQueryResult">
	<span v-if="multifunction.queryResult.length > 0">找到{{multifunction.queryResult.length-1}}条结果</span>
	<button @click="hideQueryResult">X</button>
	<table v-if="multifunction.queryResult.length > 1">
		<tr v-for="(row, rowIdx) in multifunction.queryResult">
			<td v-for="(val, colIdx) in row"><input :name="rowIdx+'-'+colIdx" :value="val" @keyup="setUpdatingRowInfo(rowIdx, colIdx)" :readonly="!multifunction.isUpdating[rowIdx]"/></td>
			<template v-if="(multifunction.tableInfo[multifunction.queriedTable]['removable'] || multifunction.tableInfo[multifunction.queriedTable]['updatable'])">

			<td v-if="rowIdx != 0 ">
			<button v-if="multifunction.tableInfo[multifunction.queriedTable]['updatable'] && !multifunction.isUpdating[rowIdx] " @click="updatingRow(rowIdx)" :disabled="multifunction.exclusiveUpdating">修改</button>
			<button v-if="multifunction.tableInfo[multifunction.queriedTable]['updatable'] && multifunction.isUpdating[rowIdx] " @click="updatedRow(rowIdx, 'confirm')">确认修改</button>
			<button v-if="multifunction.tableInfo[multifunction.queriedTable]['updatable'] && multifunction.isUpdating[rowIdx] " @click="updatedRow(rowIdx, 'cancel')">取消修改</button>
			<button v-if="multifunction.tableInfo[multifunction.queriedTable]['removable'] && !multifunction.isUpdating[rowIdx] " @click="deleteRow(rowIdx)"  :disabled="multifunction.exclusiveUpdating">删除</button>
			</td>

			<td v-else>操作</td>
			</template>
		</tr>
	</table>
</div>
</transition>

	<div v-if="roomTypeDialog.open || roomDialog.open || staffDialog.open" class="cover"></div>
	
	<transition name="bouncePage">
	<div v-if="roomTypeDialog.open" class="dialog">
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
	<span class="warning">{{submitHint}}</span>
	</div>
	</transition>
	
	<transition name="bouncePage">
	<div v-if="roomDialog.open" class="dialog">
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
	<span class="warning">{{submitHint}}</span>
	</div>
	</transition>
	
	
	<transition name="bouncePage">
	<div v-if="staffDialog.open" class="dialog">
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
	<span class="warning">{{submitHint}}</span>
	</div>
	</transition>
	
<transition name="translatePage">
<div v-cloak id="graph">
<canvas id="board" width="1000" height="600"></canvas>
</div>
</transition>
	
</div>
<script src="js/vue.js"></script>
<script src="js/jquery.js"></script>
<script src="js/panel-manager.js"></script>
<script src="js/animation-manager.js"></script>
</body>
</html>