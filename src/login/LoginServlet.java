package login;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import global.JDBC;
import global.ClientBean;

/**
 * Servlet implementation class Login
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
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
		request.getSession().invalidate();
		String accountType = request.getParameter("accounttype");
		String id = request.getParameter("name");
		String passwd = request.getParameter("passwd");
		String[] name = new String[1];
		String[] phone = new String[1];
		int status = JDBC.permitSignIn(getServletContext(), accountType, id, passwd, name, phone);
		if (status > 0) {
			ClientBean user = new ClientBean();
			user.setId(id);
			user.setName(name[0]);
			user.setPhone(phone[0]);
			request.getSession().setAttribute("user",user);
		}
		if (status == 1) {
			res.put("newpage", "hotelMain.jsp"); 
		}
		if (status == 2) {
			res.put("newpage", "manager-panel.jsp"); 
		}
		if (status == 3) {
			res.put("newpage", "receptionist.jsp"); 
		}
		res.put("status", status);
		response.getWriter().print(res);
	}

}
