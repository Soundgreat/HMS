<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>graph</title>
<style>
#board {
	margin: 0 auto;
	border: black solid 1px;
}
</style>
</head>
<body>
<div id="vue">
<canvas id="board" width="1000" height="600" align="center"></canvas>
</div>
<script src="js/jquery.js"></script>
<script src="js/vue.js"></script>
<script>
new Vue({
	el: '#vue',
	data: function() {
		return {
			board: null,
			graph: null,
			animationParams: {
				animationChain: [true, false, false],
				pieChart: {
					x: 0,
					y: 0,
					r: 0,
					meetDegree: (1.8/2)*Math.PI,
					leftBeginDegree: (2/2)*Math.PI,
					leftEndDegree: (3/2)*Math.PI,
					rightBeginDegree: (3/2)*Math.PI,
					rightEndDegree: (3.2/2)*Math.PI,
					meetSpeed: (1/200)*Math.PI
				},
				verticalBarChart: {
					x: 0,
					y: 0,
					width: 0,
					height: 0,
					barHeights: [324, 654, 584, 232, 323],
					animatedBarHeights: [],
					pullback: [],
					growthSpeed: 10
				},
				horizontalBarChart: {
					x: 0,
					y: 0,
					width: 0,
					height: 0,
					barHeights: [654, 584, 232],
					animatedBarHeights: [],
					pullback: [],
					growthSpeed: 25
				}
			},
			statistic: {
				rooms: {
					available: 100,
					unavailable: 200
				}
			}
		}
	},
	
	mounted: function() {
		this.board = document.getElementById('board');
		this.graph = this.board.getContext('2d');
		
		this.animationParams.pieChart.width = 6*(this.board.width/25);
		this.animationParams.pieChart.height = 6*(this.board.height/25);
		this.animationParams.pieChart.r = this.animationParams.pieChart.width/2;
		this.animationParams.pieChart.x = 2*(this.board.width/25)+ this.animationParams.pieChart.r;
		this.animationParams.pieChart.y = (2.5)*this.board.height/25 + this.animationParams.pieChart.r;
		
		this.animationParams.verticalBarChart.width = 11*(this.board.width/25);
		this.animationParams.verticalBarChart.height = 11*(this.board.height/25);
		this.animationParams.verticalBarChart.x = 12*(this.board.width/25);
		this.animationParams.verticalBarChart.y = 2*(this.board.height/25) + 
			this.animationParams.verticalBarChart.height;
		for (let i = 0; i < this.animationParams.verticalBarChart.barHeights.length; i++) {
			this.animationParams.verticalBarChart.animatedBarHeights[i] = 0;
			this.animationParams.verticalBarChart.pullback[i] = false;
		}
		
		this.animationParams.horizontalBarChart.width = 5*(this.board.height/25);
		this.animationParams.horizontalBarChart.height = 22*(this.board.width/25);
		this.animationParams.horizontalBarChart.x = 2*(this.board.height/25);
		this.animationParams.horizontalBarChart.y = this.board.height - 
			(this.animationParams.horizontalBarChart.width + 2*(this.board.height/25));
		for (let i = 0; i < this.animationParams.horizontalBarChart.barHeights.length; i++) {
			this.animationParams.horizontalBarChart.animatedBarHeights[i] = 0;
			this.animationParams.horizontalBarChart.pullback[i] = false;
		}
		
		setInterval(this.draw, 16);
		
		setTimeout(() => {
			this.animationParams.animationChain[1] = true;
		},600);
		setTimeout(() => {
			this.animationParams.animationChain[2] = true;
		},800);
	},
	
	methods: {
		drawPieChart: function() {
			if (!this.animationParams.animationChain[0]) return;
			
			let x = this.animationParams.pieChart.x;
			let y = this.animationParams.pieChart.y;
			let r = this.animationParams.pieChart.r;
			let leftBeginDegree = this.animationParams.pieChart.leftBeginDegree;
			let rightBeginDegree = this.animationParams.pieChart.rightBeginDegree;
			let leftEndDegree = this.animationParams.pieChart.leftEndDegree;
			let rightEndDegree = this.animationParams.pieChart.rightEndDegree;
			let leftSectorDegree = 2*Math.PI - this.animationParams.pieChart.meetDegree;
			let rightSectorDegree = this.animationParams.pieChart.meetDegree;
			let meetDegree = this.animationParams.pieChart.meetDegree - (1/2)*Math.PI;
			let meetSpeed = this.animationParams.pieChart.meetSpeed;
			
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
			
			if (leftBeginDegree%(2*Math.PI) > meetDegree) {
				this.animationParams.pieChart.leftBeginDegree -= leftSectorDegree/(1/meetSpeed);
			}
			if (rightEndDegree < meetDegree+2*Math.PI) {
				this.animationParams.pieChart.rightEndDegree += rightSectorDegree/(1/meetSpeed);
			}
		},
		
		drawVerticalBarChart: function() {
			if (!this.animationParams.animationChain[1]) return;
			
			let x = this.animationParams.verticalBarChart.x;
			let y = this.animationParams.verticalBarChart.y;
			let width = this.animationParams.verticalBarChart.width;
			let height = this.animationParams.verticalBarChart.height;
			let barHeights = this.animationParams.verticalBarChart.barHeights;
			let max = Math.max.apply(null, barHeights);
			let scale = (max/10 + 1)*10;
			barHeights.forEach((val, idx, arr) => {
				arr[idx] = val / scale * height;
			});
			let animatedBarHeights = this.animationParams.verticalBarChart.animatedBarHeights;
			let span = width/8;
			let barWidth = (width-span*(barHeights.length+1))/barHeights.length;
			let growthSpeed = this.animationParams.verticalBarChart.growthSpeed

			let items = ['预定中订单', '交易中订单','已完成订单'];
			
			this.graph.beginPath();
			this.graph.strokeStyle = 'green';
			this.graph.moveTo(x, y-height);
			this.graph.lineTo(x, y);
			this.graph.lineTo(x+width, y);
			this.graph.stroke();
			
			let fillStyle = ['green', 'orange'];
			for (let i = 0; i < barHeights.length; i++) {
				this.graph.beginPath();
				this.graph.fillStyle = fillStyle[i%fillStyle.length >= fillStyle.length ? 0 : i%fillStyle.length] ;
				this.graph.moveTo(x+(i+1)*span+i*barWidth, y);
				this.graph.lineTo(x+(i+1)*span+i*barWidth, y-animatedBarHeights[i]);
				this.graph.lineTo(x+(i+1)*span+i*barWidth+barWidth, y-animatedBarHeights[i]);
				this.graph.lineTo(x+(i+1)*span+i*barWidth+barWidth, y);
				this.graph.lineTo(x+(i+1)*span+i*barWidth, y);
				let fontSize = 12;
				this.graph.font = fontSize + 'px Arial';
				this.graph.fillText(items[i], x+(i+1)*span+i*barWidth-fontSize, y+2*fontSize);
				this.graph.fill();
			}
			
			this.animationParams.verticalBarChart.animatedBarHeights.forEach((val, idx, arr) => {
				if (!this.animationParams.verticalBarChart.pullback[idx] && 
						arr[idx] <= (barHeights[idx] + barHeights[idx]/6)) {
					arr[idx] += growthSpeed;
				} else {
					this.animationParams.verticalBarChart.pullback[idx] = true;
				}
				if (arr[idx] >= barHeights[idx] && this.animationParams.verticalBarChart.pullback[idx]) {
					arr[idx] -= growthSpeed;
				}
			});
			
			this.animationParams.verticalBarChart.growthSpeed -= growthSpeed/150;
		},
		
		drawHorizontalBarChart: function() {
			if (!this.animationParams.animationChain[2]) return;
			
			let x = this.animationParams.horizontalBarChart.x;
			let y = this.animationParams.horizontalBarChart.y;
			let width = this.animationParams.horizontalBarChart.width;
			let height = this.animationParams.horizontalBarChart.height;
			let barHeights = this.animationParams.horizontalBarChart.barHeights;
			let max = Math.max.apply(null, barHeights);
			let scale = (max/10 + 1)*10;
			barHeights.forEach((val, idx, arr) => {
				arr[idx] = val / scale * height;
			});
			let animatedBarHeights = this.animationParams.horizontalBarChart.animatedBarHeights;
			let span = width/3;
			let barWidth = (width-span*(barHeights.length-1))/barHeights.length;
			let growthSpeed = this.animationParams.horizontalBarChart.growthSpeed
			
			this.graph.beginPath();
			this.graph.strokeStyle = 'orange';
			this.graph.moveTo(x, y);
			this.graph.lineTo(x, y+width);
			this.graph.stroke();
			
			let fillStyle = ['green', 'orange'];
			for (let i = 0; i < barHeights.length; i++) {
				this.graph.beginPath();
				this.graph.fillStyle = fillStyle[i%fillStyle.length >= fillStyle.length ? 0 : i%fillStyle.length] ;
				this.graph.moveTo(x, y+i*span+i*barWidth);
				this.graph.lineTo(x+animatedBarHeights[i], y+i*span+i*barWidth);
				this.graph.lineTo(x+animatedBarHeights[i], y+i*span+i*barWidth+barWidth);
				this.graph.lineTo(x, y+i*span+i*barWidth+barWidth);
				this.graph.lineTo(x, y+i*span+i*barWidth);
				this.graph.fill();
			}
			
			this.animationParams.horizontalBarChart.animatedBarHeights.forEach((val, idx, arr) => {
				if (!this.animationParams.horizontalBarChart.pullback[idx] && 
						arr[idx] <= (barHeights[idx] + barHeights[idx]/16)) {
					arr[idx] += growthSpeed;
				} else {
					this.animationParams.horizontalBarChart.pullback[idx] = true;
				}
				if (arr[idx] >= barHeights[idx] && this.animationParams.horizontalBarChart.pullback[idx]) {
					arr[idx] -= growthSpeed;
				}
			});
			this.animationParams.horizontalBarChart.growthSpeed -= growthSpeed/100;
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