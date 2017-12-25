package manager;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.*;

import global.JDBC;

/**
 * Servlet implementation class setRoomInfo
 */
@WebServlet("/SetRoomInfo")
public class SetRoomInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SetRoomInfo() {
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
		String sql = "SELECT 类型 FROM 客房类型;";
		try {
			PreparedStatement st = cn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			ArrayList<String> roomTypes = new ArrayList<String>();
			while (rs.next()) {
				roomTypes.add(rs.getString("类型"));
			}
            rs.close();
			st.close();
            cn.close();
    		res.put("roomtypes", roomTypes);
		} catch (SQLException e) {
			res.put("error", e.getMessage());
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
		String roomid = request.getParameter("roomnum");
		String roomType = request.getParameter("roomtype");
		String available = request.getParameter("available"); 
		String orientation = request.getParameter("orientation");
		String description = request.getParameter("description");
		String[] values = {roomid, roomType, available, orientation, description};
		switch (action) {
		case "insert":
			JDBC.insertRow(getServletContext(), table, values);
			res.put("status", 200);
			break;

		default:
			break;
		}
		response.getWriter().print(res);
	}

}
