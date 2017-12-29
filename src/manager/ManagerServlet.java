package manager;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import global.JDBC;

/**
 * Servlet implementation class Statistic
 */
@WebServlet("/ManagerServlet")
public class ManagerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		JSONObject res = new JSONObject();
		String resource = request.getParameter("resource");
		ServletContext sc = getServletContext();
		switch (resource) {
		case "tableinfo":
			String[] tables = JDBC.getTables(sc);
			for (String table : tables) {
				JSONObject tableJobj = new JSONObject();
				String[] allFields = JDBC.getFields(sc, table);
				ArrayList<String> fields = new ArrayList<String>();
				for (String s : allFields) if (!s.equals("密码")) fields.add(s);
				tableJobj.put("fields", fields);
				if (table.equals("员工") || table.equals("客房") || table.equals("客房类型")) {
					tableJobj.put("insertable", true);
					tableJobj.put("updatable", true);
					tableJobj.put("removable", true);
				} else {
					tableJobj.put("insertable", false);
					tableJobj.put("updatable", false);
					tableJobj.put("removable", false);
				}
				res.put(table, tableJobj);
			}
			break;
		case "roomtypes":
			res.put("roomtypes", JDBC.getRoomTypes(sc));
			break;
		case "graphdata":
			res.put("roomnums", JDBC.getRoomNums(sc));
			res.put("ordernums", JDBC.getSpecificOrderNums(sc));
			res.put("clientnums", JDBC.getClientNums(sc));
			break;
		default:
			break;
		}
			
		response.getWriter().print(res);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		JSONObject res = new JSONObject();
		int status = 0;
		ServletContext sc = getServletContext();
		String action = request.getParameter("action");
		String table = request.getParameter("table");
		String primaryKey = null, keyValue = null;
		switch (action) {
		case "query":
			String field = request.getParameter("field");
			String queryValue = request.getParameter("queryvalue");
			String[][] result = null;
			if (table.contains("订单") && !table.equals("订单")) {
				result = JDBC.querySpecificOrder(sc, table, field, queryValue);
			} else {
				result = JDBC.queryDirectly(sc, table, field, queryValue);
			}
			res.put("queryresult", result);
			break;
		case "deleterow":
			primaryKey = request.getParameter("primarykey");
			keyValue = request.getParameter("keyvalue");
			status = JDBC.deleteRow(sc, table, primaryKey, keyValue);
			res.put("status", status);
			break;
		case "insertrow":
			String values = request.getParameter("values");
			JSONArray list = new JSONArray(values);
			ArrayList<String> valueList = new ArrayList<String>();
			for (int i = 0; i < list.length(); i++) valueList.add(list.getString(i));
			if (table.equals("员工")) {
				String staffid = JDBC.getStaffid(sc, valueList.get(1));
				valueList.add(0, staffid);
				valueList.add(staffid);
				res.put("staffid", staffid);
			} 
			status = JDBC.insertRow(getServletContext(), table, valueList);
			res.put("status", status);
			break;
		case "updaterow":
			primaryKey = request.getParameter("primarykey");
			keyValue = request.getParameter("keyvalue");
			String updatedValues = request.getParameter("updatedvalues");
			JSONArray fieldValues = new JSONArray(updatedValues);
			ArrayList<String[]> fieldValuesList = new ArrayList<String[]>();
			for (int i = 0; i < fieldValues.length(); i++) {
				String[] subList = new String[2];
				JSONArray subJsonList = new JSONArray(fieldValues.get(i).toString());
				subList[0] = subJsonList.getString(0);
				subList[1] = subJsonList.getString(1);
				fieldValuesList.add(subList);
			}
			status= JDBC.updateRow(sc, table, primaryKey, keyValue, fieldValuesList);
			res.put("status", status);
			break;
		default:
			break;
		}
		response.getWriter().print(res);
	}
	
}
