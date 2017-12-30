<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>manager-statistic</title>
<style type="text/css">
#d1  {
    width: 100%;
    height: 42px;
    padding-left: 10px;
    border: 2px solid #7BA7AB;
    border-radius: 5px;
    outline: none;
    background: #F9F0DA;
    color: #9E9C9C;
}
button, input {
    line-height: normal;
}
button, input, select, textarea {
    font-family: inherit;
    font-size: 100%;
    margin: 0;
}
</style>
</head>
<body>
<div id="vue">
<h3>搜索</h3>

<table>
	<tr>
		<td>
		<label>范围</label>
		<select name="table" v-model="currentTable">
		<option v-for="table in tables" :value="table">{{table}}</option>
		</select>
		<label>字段</label>
		<select name="field">
		<option v-for="field in ranges[currentTable]" :value="field">{{field}}</option>
		</select>
		</td>
		<td>
		<input type="text" name="queryvalue" placeholder="直接点击搜索查询所有内容" required/>
		</td>
		<td><button id="submitquery" @click="submitquery">搜索</button></td>
	</tr>
</table>

	  
	  <input type="text" placeholder="搜索从这里开始...">
	  <button type="submit">搜索</button>
	 
<table>
	<tr v-for="ret in queryResult">
		<td v-for="val in ret">{{val}}</td>
	</tr>
</table>
</div>
<script src="js/vue.js"></script>
<script src="js/jquery.js"></script>
<script>
var url = 'Statistic';
new Vue({
	el: '#vue',
	data: function() {
		return {
			currentTable: '',
			tables: [],
			ranges: {},
			queryResult: []
		}
	},
	mounted: function() {
		$.ajax({
			url: url,
			method: 'get',
			async: false,
			success: (res) => {
				if (!$.isEmptyObject(res))this.ranges = res;
				else alert('系统暂无可查数据！');
			},
			error: (req, sta, err) => {
				alert('服务端错误！请稍后再试');
			}
		});
		for (var key in this.ranges)
			this.tables.push(key);
		this.currentTable = this.tables[0];
	},
	methods: {
		submitquery: function() {
			$.ajax({
				url: url,
				method: 'post',
				data: {
					table: $("select[name='table']").val(),
					field: $("select[name='field']").val(),
					queryvalue: $("input[name='queryvalue']").val()
				},
				success: (res) => {
					if (res.queryresult.length > 1) this.queryResult = res.queryresult;
					else {
						let hint = "尚无" + this.currentTable + "数据！";
						this.queryResult = [hint];
					}
				},
				error: (req, sta, err) => {
					alert('可能遇到一些问题');
				}
			});
		}
	}
});
</script>
</body>
</html>