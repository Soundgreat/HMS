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
	<h5 key="greeting">你好！{{managerName}}</h5>
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
			<td><input type="number" name="roomnum" maxlength="4" required :disabled="roomDialog.disabled"></td>
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
			<td><textarea name="description" :disabled="roomDialog.disabled">尚无描述信息...</textarea></td>
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
<script>
let Panel = new Vue({
	el: '#manager-panel',
	data: function() {
		return {
			managerName: '',
			multifunction: {
				currentTable: '',
				queriedTable: '',
				tableInfo: {},
				tables: [],
				queryResult: [],
				showQueryResult: false,
				isUpdating: [],
				exclusiveUpdating: false,
				previousRowInfo: {},
				updatingRowInfo: {},
				updatedRowValues: []
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
			statistic: {},
			currentAction: '',
			rowClickedInQueryResult: 0,
			submitHint: '',
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
				if (!$.isEmptyObject(res)) this.multifunction.tableInfo = res;
				else alert('系统暂无可查数据！');
			},
			error: (req, sta, err) => {
				alert('服务端错误！请稍后再试');
			}
		});
		for (var key in this.multifunction.tableInfo)
			this.multifunction.tables.push(key);
		this.multifunction.currentTable = this.multifunction.tables[1];
		
	},
	
	methods: {
		submitquery: function() {
			this.multifunction.showQueryResult = true;
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
						this.multifunction.queryResult = res.queryresult;
						for (let i = 0; i < this.multifunction.queryResult.length; i++) {
							this.multifunction.isUpdating.push(false);
						}
					} else this.multifunction.queryResult = [''];
					this.multifunction.queriedTable = this.multifunction.currentTable;
				},
				error: (req, sta, err) => {
					alert('可能遇到一些问题');
				}
			});
		}, 
		
		hideQueryResult: function() {
			this.multifunction.showQueryResult = false;
			setTimeout(Graph.bootAnimation,200);
		},
		
		deleteRow: function(rowIdx) {
			$.ajax({
				url: this.server,
				method: 'post',
				data: {
					action: 'deleterow',
					table: this.multifunction.queriedTable,
					primarykey: this.multifunction.queryResult[0][0],
					keyvalue: this.multifunction.queryResult[rowIdx][0]
				},
				success: (res) => {
					if (res.status == 1) this.submitquery();
					else alert('不可接受的删除！');
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
		
		updatingRow: function(rowIdx) {
			this.multifunction.isUpdating[rowIdx] = !this.multifunction.isUpdating[rowIdx];
			this.multifunction.exclusiveUpdating = this.multifunction.isUpdating[rowIdx];

			for (let i = 0; i < this.multifunction.queryResult[0].length; i++) {
				this.multifunction.previousRowInfo[(this.multifunction.queryResult[0][i])] = this.multifunction.queryResult[rowIdx][i];
			}
		},
		
		setUpdatingRowInfo: function(rowIdx, colIdx) {
			if (!this.multifunction.exclusiveUpdating) return;
			this.multifunction.updatingRowInfo[this.multifunction.queryResult[0][colIdx]] = $("input[name='" + rowIdx + '-' + colIdx + "']").val();
		},
		
		updatedRow: function(rowIdx, actFlag) {
			this.multifunction.isUpdating[rowIdx] = !this.multifunction.isUpdating[rowIdx];
			this.multifunction.exclusiveUpdating = this.multifunction.isUpdating[rowIdx];
			switch (actFlag) {
			case 'confirm':
				for (let key in this.multifunction.updatingRowInfo) {
					if (this.multifunction.updatingRowInfo[key] != this.multifunction.previousRowInfo[key]) {
						this.multifunction.updatedRowValues.push([key, this.multifunction.updatingRowInfo[key]]);
					}
				}
				$.ajax({
					url: this.server,
					method: 'post',
					data: {
						action: 'updaterow',
						table: this.multifunction.queriedTable,
						primarykey: this.multifunction.queryResult[0][0],
						keyvalue: this.multifunction.queryResult[rowIdx][0],
						updatedvalues: JSON.stringify(this.multifunction.updatedRowValues)
					},
					success: (res) => {
						if (res.status == 1) {
							this.submitquery();
							alert('修改成功！');
						}
						if (res.status == 0) {
							alert('不可接受的修改！');
						}
					},
					error: (req, sta, err) => {
						alert('可能遇到一些问题');
					}
				});
				break;
			case 'cancel':
				break;
			}
			this.multifunction.previousRowInfo = {};
			this.multifunction.updatingRowInfo = {};
			this.multifunction.updatedRowValues = [];
		},
		
		openDialog: function() {
			switch (this.multifunction.currentTable) {
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
			this.submitHint = '';
		},
		
		submitRoomType: function() {
			let values = [
					$("input[name='roomtype']").val(),
			    	$("select[name='capacity']").val(),
			    	$("input[name='surplus']").val(),
			    	$("input[name='price']").val()
				];
			this.submit(values, (res) => {
				if (res.status == 1) alert('添加成功！');
				else alert('添加失败! 请检查数据格式');
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
					if (res.status == 1) alert('添加成功！');
					else alert('添加失败! 请检查数据格式');
				});
		},
		
		submitStaff: function() {
			let values = [
				$("input[name='staffname']").val(),
				$("select[name='role']").val()
			];
			this.submit(values, (res) => {
				if (res.status == 1) alert('添加成功！ 员工号是：' + res.staffid);
				else alert('添加失败！');
			});
		},
		
		submit: function(values, callback) {
			for (let idx in values) {
				values[idx] = $.trim(values[idx]);
				if (values[idx] == '') {
					this.submitHint = '请提交完整信息！';
					setTimeout(() => {
						this.submitHint = '';
					},1000);
					return;
				}
			}
			$.ajax({
				url: this.server,
				method: 'post',
				data: {
					action: 'insertrow',
					table: this.multifunction.currentTable,
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

let Graph = new Vue({
	el: '#graph',
	data: function() {
		return {
			board: null,
			graph: null,
			statistic: {
				rooms: {
					available: 100,
					unavailable: 200
				},
				orders: {
					advance: 0,
					pending: 0,
					completed: 0
				},
				clients: {
					uers: 0,
					lodgers: 0
				}
			},
			animationParams: {
				animationChain: [true, false, false],
				pieChart: {
					x: 0,
					y: 0,
					r: 0,
					items: ['空置客房', '非空客房'],
					sectorNums: [0, 0],
					meetDegree: 0,
					leftBeginDegree: (3/2)*Math.PI,
					leftEndDegree: (3/2)*Math.PI,
					rightBeginDegree: -(1/2)*Math.PI,
					rightEndDegree: -(1/2)*Math.PI,
					meetSpeed: (1/120)*2*Math.PI
				},
				verticalBarChart: {
					x: 0,
					y: 0,
					width: 0,
					height: 0,
					items: ['预定中订单', '交易中订单','已完成订单'],
					barNums: [0, 0, 0],
					animatedBarHeights: [],
					growthSpeed: 20
				},
				horizontalBarChart: {
					x: 0,
					y: 0,
					width: 0,
					height: 0,
					items: ['用户人数', '房客人次'],
					barNums: [0,0],
					animatedBarHeights: [],
					growthSpeed: 10
				}
			},
			server: 'ManagerServlet'
		}
	},
	
	mounted: function() {
		this.board = document.getElementById('board');
		this.graph = this.board.getContext('2d');

		this.animationParams.pieChart.width = 6*(this.board.width/25);
		this.animationParams.pieChart.height = 6*(this.board.height/25);
		this.animationParams.pieChart.r = this.animationParams.pieChart.width/2;
		this.animationParams.pieChart.x = 3*(this.board.width/25)+ this.animationParams.pieChart.r;
		this.animationParams.pieChart.y = (2.5)*this.board.height/25 + this.animationParams.pieChart.r;
		
		this.animationParams.verticalBarChart.width = 11*(this.board.width/25);
		this.animationParams.verticalBarChart.height = 11*(this.board.height/25);
		this.animationParams.verticalBarChart.x = 13*(this.board.width/25);
		this.animationParams.verticalBarChart.y = 2*(this.board.height/25) + 
			this.animationParams.verticalBarChart.height;
		
		this.animationParams.horizontalBarChart.width = 5*(this.board.height/25);
		this.animationParams.horizontalBarChart.height = 20*(this.board.width/25);
		this.animationParams.horizontalBarChart.x = 6*(this.board.height/25);
		this.animationParams.horizontalBarChart.y = this.board.height - 
			(this.animationParams.horizontalBarChart.width + 2*(this.board.height/25));
		

		for (let i = 0; i < this.animationParams.verticalBarChart.barNums.length; i++) {
			this.animationParams.verticalBarChart.animatedBarHeights[i] = 0;
		}
		for (let i = 0; i < this.animationParams.horizontalBarChart.barNums.length; i++) {
			this.animationParams.horizontalBarChart.animatedBarHeights[i] = 0;
		}
		
		this.updateGraphData().setInterval(this.updateGraphData, 1000);
		
		setInterval(this.draw, 16);
		
		this.bootAnimation();
	},
	
	methods: {
		updateGraphData: function() {
			$.ajax({
				url: this.server,
				method: 'get',
				data: {
					resource: 'graphdata'
				},
				success: (res) => {
					Panel.managerName = res.alias;
					
					this.statistic.rooms.available = res.roomnums[0];
					this.statistic.rooms.unavailable = res.roomnums[1];
					this.statistic.orders.advance = res.ordernums[0];
					this.statistic.orders.pending = res.ordernums[1];
					this.statistic.orders.compeleted = res.ordernums[2];
					this.statistic.clients.users = res.clientnums[0];
					this.statistic.clients.lodgers = res.clientnums[1];
					this.animationParams.pieChart.sectorNums[0] = this.statistic.rooms.available;
					this.animationParams.pieChart.sectorNums[1] = this.statistic.rooms.unavailable;
					this.animationParams.verticalBarChart.barNums[0] = this.statistic.orders.advance;
					this.animationParams.verticalBarChart.barNums[1] = this.statistic.orders.pending;
					this.animationParams.verticalBarChart.barNums[2] = this.statistic.orders.compeleted;
					this.animationParams.horizontalBarChart.barNums[0] = this.statistic.clients.users;
					this.animationParams.horizontalBarChart.barNums[1] = this.statistic.clients.lodgers;
					
					let sum = this.animationParams.pieChart.sectorNums[0] + this.animationParams.pieChart.sectorNums[1];
					this.animationParams.pieChart.meetDegree = (this.animationParams.pieChart.sectorNums[1]/sum) * 2*Math.PI;
				},
				error: (req, sta, err) => {
					alert(err);
				}
			});	
			return window;
		},
		
		bootAnimation: function() {
			this.animationParams.pieChart.leftBeginDegree = (3/2)*Math.PI;
			this.animationParams.pieChart.rightEndDegree = -(1/2)*Math.PI;
			this.animationParams.pieChart.rightBeginDegree = -(1/2)*Math.PI;
			this.animationParams.pieChart.rightEndDegree = -(1/2)*Math.PI;
			
			setTimeout(() => {
				this.animationParams.verticalBarChart.animatedBarHeights.forEach((val, idx, arr) => {
				arr[idx] = 0;
				});
				this.animationParams.animationChain[1] = true;
			},600);
			setTimeout(() => {
				this.animationParams.horizontalBarChart.animatedBarHeights.forEach((val, idx, arr) => {
					arr[idx] = 0;
				});
				this.animationParams.animationChain[2] = true;
			},800);
		},
		
		drawPieChart: function() {
			if (!this.animationParams.animationChain[0]) return;
			
			let x = this.animationParams.pieChart.x;
			let y = this.animationParams.pieChart.y;
			let r = this.animationParams.pieChart.r;
			let leftBeginDegree = this.animationParams.pieChart.leftBeginDegree;
			let rightBeginDegree = this.animationParams.pieChart.rightBeginDegree;
			let leftEndDegree = this.animationParams.pieChart.leftEndDegree;
			let rightEndDegree = this.animationParams.pieChart.rightEndDegree;
			
			let meetDegree = this.animationParams.pieChart.meetDegree  - (1/2)*Math.PI; //convert
			let leftSectorDegree = meetDegree - leftBeginDegree;
			let rightSectorDegree = meetDegree - rightEndDegree;
			let meetSpeed = this.animationParams.pieChart.meetSpeed;
			
			let items = this.animationParams.pieChart.items;
			let sum = this.animationParams.pieChart.sectorNums[0] + this.animationParams.pieChart.sectorNums[1];
			let leftSectorNum = parseInt((leftEndDegree - leftBeginDegree) / (2*Math.PI)*sum+0.5);
			let rightSectorNum = parseInt((rightEndDegree - rightBeginDegree) / (2*Math.PI)*sum+0.5);
			
			let leftMidDegree = (leftBeginDegree + leftEndDegree)/2;
			let rightMidDegree = (rightBeginDegree + rightEndDegree)/2;
			let leftPointer = [x+r/2*Math.cos(leftMidDegree), y+r/2*Math.sin(leftMidDegree)];
			let rightPointer = [x+r/2*Math.cos(rightMidDegree), y+r/2*Math.sin(rightMidDegree)];
			
			this.graph.beginPath();
			this.graph.fillStyle = "gray";
			this.graph.arc(x, y, r, 0, 2*Math.PI);
			this.graph.fill();
			
			this.graph.beginPath();
			this.graph.strokeStyle = this.graph.fillStyle = "green";
			this.graph.arc(x, y, r, leftBeginDegree, leftEndDegree);
			this.graph.lineTo(x, y);
			this.graph.lineTo(x+r*Math.cos(leftBeginDegree),y+r*Math.sin(leftBeginDegree));
			this.graph.stroke();
			this.graph.fill();
			
			this.graph.beginPath();
			this.graph.strokeStyle = this.graph.fillStyle = "orange";
			this.graph.arc(x, y, r, rightBeginDegree, rightEndDegree);
			this.graph.lineTo(x, y);
			this.graph.lineTo(x+r*Math.cos(rightBeginDegree),y+r*Math.sin(rightBeginDegree));
			this.graph.stroke();
			this.graph.fill();
			
			let pointerLength = 0.7*r;
			this.graph.beginPath();
			let fontSize = 12;
			this.graph.font = fontSize + 'px Arial';
			this.graph.lineWidth = 1.5;
			this.graph.strokeStyle = "orange";
			this.graph.moveTo(leftPointer[0], leftPointer[1]);
			this.graph.lineTo(leftPointer[0]+pointerLength*Math.cos(leftMidDegree), leftPointer[1]+pointerLength*Math.sin(leftMidDegree));
			let text = items[0] + ' ' + '(' + leftSectorNum + ')';
			let textWidth = this.graph.measureText(text).width;
			this.graph.lineTo(leftPointer[0]+pointerLength*Math.cos(leftMidDegree)-textWidth, leftPointer[1]+pointerLength*Math.sin(leftMidDegree));
			this.graph.strokeText(text, leftPointer[0]+pointerLength*Math.cos(leftMidDegree)-textWidth, leftPointer[1]+pointerLength*Math.sin(leftMidDegree)-fontSize/2);
			this.graph.stroke();
			this.graph.beginPath();
			this.graph.strokeStyle = "green";
			this.graph.moveTo(rightPointer[0], rightPointer[1]);
			this.graph.lineTo(rightPointer[0]+pointerLength*Math.cos(rightMidDegree), rightPointer[1]+pointerLength*Math.sin(rightMidDegree));
			text = items[1] + ' ' + '(' + rightSectorNum + ')';
			textWidth = this.graph.measureText(text).width;
			this.graph.lineTo(rightPointer[0]+pointerLength*Math.cos(rightMidDegree)+textWidth, rightPointer[1]+pointerLength*Math.sin(rightMidDegree));
			this.graph.strokeText(text, rightPointer[0]+pointerLength*Math.cos(rightMidDegree), rightPointer[1]+pointerLength*Math.sin(rightMidDegree)-fontSize/2);
			this.graph.stroke();
			
			if (leftBeginDegree != meetDegree) this.animationParams.pieChart.leftBeginDegree += leftSectorDegree*meetSpeed;
			if (rightEndDegree != meetDegree) this.animationParams.pieChart.rightEndDegree += rightSectorDegree*meetSpeed;
		},
		
		drawVerticalBarChart: function() {
			if (!this.animationParams.animationChain[1]) return;
			
			let x = this.animationParams.verticalBarChart.x;
			let y = this.animationParams.verticalBarChart.y;
			let width = this.animationParams.verticalBarChart.width;
			let height = this.animationParams.verticalBarChart.height;
			
			let barHeights = [];
			this.animationParams.verticalBarChart.barNums.forEach((val, idx, arr) => {
				barHeights[idx] = val;
			});
			let max = Math.max.apply(null, barHeights);
			let scale = (max/10 + 1)*10;
			barHeights.forEach((val, idx, arr) => {
				arr[idx] = val / scale * height;
			});
			let animatedBarHeights = this.animationParams.verticalBarChart.animatedBarHeights;
			let distances = [];
			this.animationParams.verticalBarChart.animatedBarHeights.forEach((val, idx, arr) => {
				distances[idx] = barHeights[idx] - val;
			});
			
			let span = width/(2*barHeights.length+1);
			let barWidth = span;
			let growthSpeed = this.animationParams.verticalBarChart.growthSpeed;
			let items = this.animationParams.verticalBarChart.items;
			
			this.graph.beginPath();
			this.graph.strokeStyle = 'green';
			this.graph.moveTo(x, y-height);
			this.graph.lineTo(x, y);
			this.graph.lineTo(x+width, y);
			this.graph.stroke();
			
			let fillStyle = ['green', 'orange'];
			for (let i = 0; i < animatedBarHeights.length; i++) {
				this.graph.beginPath();
				let fontSize = 16;
				this.graph.font = 'bold ' + fontSize + 'px Arial';
				this.graph.fillStyle = fillStyle[i%fillStyle.length >= fillStyle.length ? 0 : i%fillStyle.length] ;
				this.graph.moveTo(x+(i+1)*span+i*barWidth, y);
				this.graph.lineTo(x+(i+1)*span+i*barWidth, y-animatedBarHeights[i]);
				let currentNum = parseInt(scale*(animatedBarHeights[i]/height)+0.5);
				let textWidth = this.graph.measureText(currentNum).width;
				this.graph.fillText(currentNum, x+(i+1)*span+i*barWidth+barWidth/2-textWidth/2, y-animatedBarHeights[i]-fontSize);
				this.graph.lineTo(x+(i+1)*span+i*barWidth+barWidth, y-animatedBarHeights[i]);
				this.graph.lineTo(x+(i+1)*span+i*barWidth+barWidth, y);
				this.graph.lineTo(x+(i+1)*span+i*barWidth, y);
				textWidth = this.graph.measureText(items[i]).width;
				this.graph.fillText(items[i], x+(i+1)*span+i*barWidth+barWidth/2-textWidth/2, y+2*fontSize);
				this.graph.fill();
			}
			
			this.animationParams.verticalBarChart.animatedBarHeights.forEach((val, idx, arr) => {
				if (val != barHeights[idx]) arr[idx] += distances[idx]/growthSpeed;
			});
		},
		
		drawHorizontalBarChart: function() {
			if (!this.animationParams.animationChain[2]) return;
			
			let x = this.animationParams.horizontalBarChart.x;
			let y = this.animationParams.horizontalBarChart.y;
			let width = this.animationParams.horizontalBarChart.width;
			let height = this.animationParams.horizontalBarChart.height;
			
			let barHeights = [];
			this.animationParams.horizontalBarChart.barNums.forEach((val, idx, arr) => {
				barHeights[idx] = val;
			});
			let max = Math.max.apply(null, barHeights);
			let scale = (max/10 + 1)*10;
			barHeights.forEach((val, idx, arr) => {
				arr[idx] = val / scale * height;
			});
			let animatedBarHeights = this.animationParams.horizontalBarChart.animatedBarHeights;
			let distances = [];
			this.animationParams.horizontalBarChart.animatedBarHeights.forEach((val, idx, arr) => {
				distances[idx] = barHeights[idx] - val;
			});
			
			let span = width/(2*barHeights.length-1);
			let barWidth = span;
			let growthSpeed = this.animationParams.horizontalBarChart.growthSpeed;
			let items = this.animationParams.horizontalBarChart.items;
			
			this.graph.beginPath();
			this.graph.strokeStyle = 'orange';
			this.graph.moveTo(x, y);
			this.graph.lineTo(x, y+width);
			this.graph.stroke();
			
			let fillStyle = ['green', 'orange'];
			for (let i = 0; i < animatedBarHeights.length; i++) {
				this.graph.beginPath();
				let fontSize = 16;
				this.graph.font = 'bold ' + fontSize + 'px Arial';
				this.graph.fillStyle = fillStyle[i%fillStyle.length >= fillStyle.length ? 0 : i%fillStyle.length] ;
				this.graph.moveTo(x, y+i*span+i*barWidth);
				this.graph.lineTo(x+animatedBarHeights[i], y+i*span+i*barWidth);
				let currentNum = parseInt(scale*(animatedBarHeights[i]/height)+0.5);
				this.graph.fillText(currentNum, x+animatedBarHeights[i]+fontSize, y+i*span+i*barWidth+fontSize+(barWidth/2-fontSize/2));
				this.graph.lineTo(x+animatedBarHeights[i], y+i*span+i*barWidth+barWidth);
				this.graph.lineTo(x, y+i*span+i*barWidth+barWidth);
				this.graph.lineTo(x, y+i*span+i*barWidth);
				let textWidth = this.graph.measureText(items[i]).width;
				this.graph.fillText(items[i], x-(textWidth+fontSize), y+i*span+i*barWidth+fontSize+(barWidth/2-fontSize/2));
				this.graph.fill();
			}
			
			this.animationParams.horizontalBarChart.animatedBarHeights.forEach((val, idx, arr) => {
				if (val != barHeights[idx]) arr[idx] += distances[idx]/growthSpeed;
			});
		},
		
		draw: function() {
			this.graph.clearRect(0, 0, this.board.width, this.board.height);
			this.drawPieChart();
			this.drawVerticalBarChart();
			this.drawHorizontalBarChart();
		}
	}
});
</script>
</body>
</html>