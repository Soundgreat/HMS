new Vue({
	el: '#page',
	data: function() {
		return {
			checkinDate: '',
			checkoutDate: '',
			roomTypes: [],
			searching: false,
			checkedRoomTypes: [],
			availableRooms: [],
			pageIdx: 0,
			server: 'SearchRoomServlet'
		}
	},
	mounted: function() {
		$.ajax({
			url: this.server,
			method: 'get',
			success: (res) => {
				this.roomTypes = res.roomtypes;
				this.availableRooms = res.rooms;
			}
		});
	},
	methods: {
		search: function() {
			this.searching = true;
			let checkedRoomTypes = [];
			$("input[name='checkbox2']:checked").each(function() {
				checkedRoomTypes.push(this.value);
            })
			this.checkinDate = $("input[name='checkindate']").val();
			this.checkoutDate = $("input[name='checkoutdate']").val();
			this.checkedRoomTypes = checkedRoomTypes;
			if (this.checkedRoomTypes.length <=0 || this.checkinDate == '' || this.checkoutDate == '') {
				alert('请填写完整信息！')
			} else {
				$.post(this.server, {
					action: 'search',
					checkindate: this.checkinDate,
					checkoutdate: this.checkoutDate,
					roomtypes: JSON.stringify(this.checkedRoomTypes)
				},(res) => {
					this.availableRooms = res.rooms
				});
			}
		},
		
		browseDetail: function(idx) {
			$.post(this.server,{
					action: 'selectroom',
					room: JSON.stringify(this.availableRooms[idx])
				},(res) => {
					console.log(res.status)
					if (res.status == 200)
					window.location = 'room-detail.jsp';
					else alert('error')
				});
		},
		
		switchPage: function(actFlag) {
			if (actFlag == 'prev' && this.pageIdx*20 - 20 >= 0) this.pageIdx--;
			if (actFlag == 'next' && this.pageIdx*20 + 20 < this.availableRooms.length) this.pageIdx++;
		},
		
		bookRoom: function(idx) {
			$.post(this.server,{
				action: 'selectroom',
				room: JSON.stringify(this.availableRooms[idx])
			}, (res) => {
				window.location = 'order.jsp';
			});
		}
	}
});