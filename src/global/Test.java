package global;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Servlet implementation class Test
 */
@WebServlet("/Test")
public class Test extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Test() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		JSONObject res = new JSONObject();
		String table = request.getParameter("table");
		String values = request.getParameter("values");
		JSONArray list = new JSONArray("[[1,11],[2,22]]");
		ArrayList<Integer> rowValues = new ArrayList<Integer>();
		for (int i = 0; i<list.length();i++) {
			JSONArray subList = new JSONArray(list.get(i).toString());
			rowValues.add(subList.getInt(0));
			rowValues.add(subList.getInt(1));
		}
//		for (Object string : list) {
//			rowValues.add((String)string);
//		}
//		res.put("status", JDBC.insertRow(getServletContext(), table, rowValues));
		res.put("res", rowValues);
		response.getWriter().print(res);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
