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

import org.json.JSONObject;

import global.ClientBean;
import global.JDBC;

/**
 * Servlet implementation class PushOrder
 */
@WebServlet("/Order")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("applicaiton/json");
		JSONObject res = new JSONObject();
		HttpSession session = request.getSession();
		String[] checkDate = (String[])session.getAttribute("checkDate");
		res.put("checkdate", checkDate);
		response.getWriter().print(res);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		JSONObject res = new JSONObject();
		ServletContext sc = getServletContext();
		HttpSession session = request.getSession();
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		RoomBean room = (RoomBean)session.getAttribute("room");
		String[] checkDate = (String[])session.getAttribute("checkDate");
		ClientBean lodger = new ClientBean();
		lodger.setId(id);
		lodger.setName(name);
		lodger.setPhone(phone);
		ArrayList<ClientBean> lodgers = new ArrayList<ClientBean>();
		lodgers.add(lodger);
		String orderId = JDBC.generateOrder(sc, checkDate, room, lodgers);
		res.put("orderid", orderId);
		response.getWriter().print(res);
	}

}
