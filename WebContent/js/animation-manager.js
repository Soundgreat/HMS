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
					//alert(err);
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