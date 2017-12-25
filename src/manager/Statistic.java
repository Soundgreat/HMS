package manager;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.plaf.basic.BasicTabbedPaneUI.TabbedPaneLayout;

import org.json.JSONObject;

import global.JDBC;

/**
 * Servlet implementation class Statistic
 */
@WebServlet("/Statistic")
public class Statistic extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Statistic() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		JSONObject res = new JSONObject();
		Connection cn = JDBC.getConnection(getServletContext());
		
		try {
			String[] tables = JDBC.getTables(cn);
			for (String table : tables) {
				JSONObject tableJobj = new JSONObject();
				String[] allFields = JDBC.getFields(cn, table);
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
			cn.close();
		} catch (SQLException e) {
		}
		response.getWriter().print(res);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		JSONObject res = new JSONObject();
		String action = request.getParameter("action");
		String table = request.getParameter("table");
		switch (action) {
		case "query":
			String field = request.getParameter("field");
			String queryValue = request.getParameter("queryvalue");
			String[][] result = null;
			if (table.contains("订单") && !table.equals("订单")) {
				result = JDBC.querySpecificOrder(getServletContext(), table, field, queryValue);
			} else {
				result = JDBC.queryDirectly(getServletContext(), table, field, queryValue);
			}
			res.put("queryresult", result);
			break;
		case "deleterow":
			String primaryKey = request.getParameter("primarykey");
			String keyValue = request.getParameter("keyvalue");
			boolean success = JDBC.deleteRow(getServletContext(), table, primaryKey, keyValue);
			res.put("status", success);
			break;

		default:
			break;
		}
		
		response.getWriter().print(res);
	}
	
}
