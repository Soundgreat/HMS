<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.list td {
	border: black 1px solid;
}
</style>
</head>
<body>
<div id="desk">
 <div >
 	<table>
 	<tr>
 	<td>身份证号</td>
 	<td><input type="number" name="idcard" v-model="checkin.idcard" placeholder="输入预定住客的身份证号" required/></td>
	<td><button @click="queryAdvenceOrder">搜索</button></td>
	</tr>
 	</table>
 	
 	<table calss="list">
 	<tr v-for="(row, rowIdx) in list">
 	<td v-for="(val, colIdx) in row">
 	<input :name="rowIdx+'-'+colIdx" :value="val" @keyup="setUpdatingRowInfo(rowIdx, colIdx)" 
 		:readonly="colIdx < list[0].length -1 || !isUpdating[rowIdx]"/>
 	</td>
 	<td v-if="rowIdx != 0 ">
			<button @click="updatingRow(rowIdx)" :disabled="exclusiveUpdating">修改</button>
			<button v-if="isUpdating[rowIdx] " @click="updatedRow(rowIdx, 'confirm')">确认修改</button>
			<button v-if="isUpdating[rowIdx] " @click="updatedRow(rowIdx, 'cancel')">取消修改</button>
			</td>
	</tr>
 	</table>
 	
 </div>
 
 <div >
 	<table>
 	<tr>
 	<td>房号</td>
 	<td><input type="number" name="roomid" v-model="checkout.roomid" placeholder="输入房号" required/></td>
	<td><button @click="queryRoom">搜索</button></td>
	</tr>
 	</table>
 	
 	<table calss="list">
 	<tr v-for="(row, rowIdx) in list">
 	<td v-for="(val, colIdx) in row">
 	<input :name="rowIdx+'-'+colIdx" :value="val" @keyup="setUpdatingRowInfo(rowIdx, colIdx)" 
 		:readonly="colIdx != 2 || !isUpdating[rowIdx]"/>
 	</td>
 	<td v-if="rowIdx != 0 ">
			<button @click="updatingRow(rowIdx)" :disabled="exclusiveUpdating">修改</button>
			<button v-if="isUpdating[rowIdx] " @click="updatedRow(rowIdx, 'confirm')">确认修改</button>
			<button v-if="isUpdating[rowIdx] " @click="updatedRow(rowIdx, 'cancel')">取消修改</button>
			</td>
	</tr>
 	</table>
 	
 </div>
</div>
<script src="js/vue.js"></script>
<script src="js/jquery.js"></script>
<script>
new Vue({
	el: '#desk',
	data: {
		mode: 'checkout',
		checkin: {
			idcard: '',
		},
		checkout: {
			roomid: '',
		},
		list: [],
		isUpdating: [],
		exclusiveUpdating: false,
		previousRowInfo: {},
		updatingRowInfo: {},
		updatedRowValues: [],
		server: 'ReceptionistServlet'
	},
	
	methods: {
		queryAdvenceOrder: function() {
			$.post(this.server, {
					action: 'checkin',
					idcard: this.checkin.idcard
				}, (res) => {
					if (res.orders.length > 1) {
						this.list = res.orders;
						for (let i = 0; i < this.list.length; i++) {
							this.isUpdating.push(false);
						}
					} else {
						this.list = ['未找到结果！']
					}
				});
		},
		
		queryRoom: function() {
			$.post(this.server, {
				action: 'checkout',
				roomid: this.checkout.roomid
			}, (res) => {
				if (res.rooms.length > 1) {
					this.list = res.rooms;
					for (let i = 0; i < this.list.length; i++) {
						this.isUpdating.push(false);
					}
				} else {
					this.list = ['未找到结果！']
				}
			});
		},
		
		updatingRow: function(rowIdx) {
			this.isUpdating[rowIdx] = !this.isUpdating[rowIdx];
			this.exclusiveUpdating = this.isUpdating[rowIdx];

			for (let i = 0; i < this.list[0].length; i++) {
				this.previousRowInfo[(this.list[0][i])] = this.list[rowIdx][i];
			}
		},
		
		setUpdatingRowInfo: function(rowIdx, colIdx) {
			if (!this.exclusiveUpdating) return;
			this.updatingRowInfo[this.list[0][colIdx]] = $("input[name='" + rowIdx + '-' + colIdx + "']").val();
		},
		
		updatedRow: function(rowIdx, actFlag) {
			this.isUpdating[rowIdx] = !this.isUpdating[rowIdx];
			this.exclusiveUpdating = this.isUpdating[rowIdx];
			switch (actFlag) {
			case 'confirm':
				for (let key in this.updatingRowInfo) {
					if (this.updatingRowInfo[key] != this.previousRowInfo[key]) {
						this.updatedRowValues.push([key, this.updatingRowInfo[key]]);
					}
				}
				$.ajax({
					url: this.server,
					method: 'post',
					data: {
						action: 'updaterow',
						primarykey: this.list[0][0],
						keyvalue: this.list[rowIdx][0],
						updatedvalues: JSON.stringify(this.updatedRowValues)
					},
					success: (res) => {
						if (res.status == 1) {
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
			this.previousRowInfo = {};
			this.updatingRowInfo = {};
			this.updatedRowValues = [];
		},
	}
});
</script>
</body>
</html>