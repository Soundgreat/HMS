package customer;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import global.JDBC;

/**
 * Servlet implementation class SearchRooms
 */
@WebServlet("/SearchRoomServlet")
public class SearchRoomServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchRoomServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		JSONObject res = new JSONObject();
		ServletContext sc = getServletContext();
		res.put("roomtypes", JDBC.getRoomTypes(sc));
		res.put("rooms", JDBC.getAvailableRooms(sc));
		response.getWriter().print(res);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		JSONObject res = new JSONObject();
		ServletContext sc = getServletContext();
		String action = request.getParameter("action");
		switch (action) {
		case "search":
			String checkinDate = request.getParameter("checkindate");
			String checkoutDate = request.getParameter("checkoutdate");
			
			String[] checkDate = new String[] {checkinDate, checkoutDate};
			request.getSession().setAttribute("checkDate", checkDate);
			
			String roomTypes = request.getParameter("roomtypes");
			JSONArray typeArray = new JSONArray(roomTypes);
			ArrayList<RoomBean> rooms = new ArrayList<RoomBean>();
			for (int i = 0; i < typeArray.length(); i++) {
				ArrayList<RoomBean> sameTypeRooms = JDBC.searchRoom(sc, checkinDate, checkoutDate, typeArray.getString(i));
				for (RoomBean room : sameTypeRooms) {
					rooms.add(room);
				}
			}
			res.put("rooms", rooms);
			break;
		case "selectroom":
			String roomInfo = request.getParameter("room");
			JSONObject room = new JSONObject(roomInfo);
			String roomId = room.getString("roomId");
			String roomType = room.getString("roomType");
			int capacity = room.getInt("capacity");
			int price = room.getInt("price");
			String typeDesc = room.getString("typeDesc");
			String roomDesc = room.getString("roomDesc");
			
			RoomBean roomBean = new RoomBean();
			roomBean.setRoomId(roomId);
			roomBean.setRoomType(roomType);
			roomBean.setCapacity(capacity);
			roomBean.setPrice(price);
			roomBean.setTypeDesc(typeDesc);
			roomBean.setRoomDesc(roomDesc);
			HttpSession session = request.getSession();
			session.setAttribute("room", roomBean);
			res.put("status", 200);
		default:
			break;
		}
		
		response.getWriter().print(res);
	}

}
