//document.write("<script src='js/vue.js'></script> <script src='js/jquery.js'></script>");
//
//new Vue({
//	el: '#container',
//	data: function() {
//		return {
//			roomType: '',
//			capacity: 0 ,
//			price: 0 ,
//			typeDesc: ''
//		}
//	},
//	mounted: function() {
//		$.ajax({
//			url: 'RoomDetail',
//			method: 'get',
//			success: (res) => {
//				this.roomType = res.room.roomType;
//				this.capacity = res.room.capacity;
//				this.price = res.room.price;
//				this.typeDesc = res.room.typeDesc;
//			}
//		});
//	}
//});