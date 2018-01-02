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