package receptionist;

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
 * Servlet implementation class ReceptionistServlet
 */
@WebServlet("/ReceptionistServlet")
public class ReceptionistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReceptionistServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		JSONObject res = new JSONObject();
		ServletContext sc = getServletContext();
		String action = request.getParameter("action");
		String table = null;
		switch (action) {
		case "checkin":
			table = "订单";
			String idcard = request.getParameter("idcard");
			res.put("orders", JDBC.getAdvanceOrder(sc, idcard));
			break;
		case "checkout":
			String roomId = request.getParameter("roomid");
			res.put("rooms", JDBC.queryDirectly(sc, "客房", "房号", roomId));
			break;
		case "updaterow":
			table = "客房";
			String primaryKey = request.getParameter("primarykey");
			String keyValue = request.getParameter("keyvalue");
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
			int status= JDBC.updateRow(sc, table, primaryKey, keyValue, fieldValuesList);
			res.put("status", status);
			break;
		default:
			break;
		}
		res.put("idcard", action);
		response.getWriter().print(res);
	}

}
