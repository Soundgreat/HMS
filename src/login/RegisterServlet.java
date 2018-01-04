package login;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import global.ClientBean;
import global.JDBC;

/**
 * Servlet implementation class Register
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
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
		String accountType = request.getParameter("accounttype");
		String id = request.getParameter("id");
		String name = request.getParameter("alias");
		String phone = request.getParameter("phone");
		String passwd = request.getParameter("passwd");
		int status = JDBC.permitSignUp(sc, accountType, id, name, phone, passwd);
		if (status == 1) {
			ClientBean user = new ClientBean();
			user.setId(id);
			user.setName(name);
			user.setPhone(phone);
			request.getSession().setAttribute("user",user);
			res.put("newpage", "hotelMain.jsp");
		}
		res.put("status", status);
		response.getWriter().print(res);
	}

}
