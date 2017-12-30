package login;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import global.JDBC;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
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
		String accountType = request.getParameter("accounttype");
		String name = request.getParameter("name");
		String passwd = request.getParameter("passwd");
		String[] alias = new String[1];
		int status = JDBC.permitSignIn(getServletContext(), accountType, name, passwd, alias);
		if (status > 0) request.getSession().setAttribute("alias", alias[0]);
		if (status > 0) {
			request.getSession().setAttribute("loginName", name);
		}
		if (status == 1) {
			res.put("newpage", "neworder.jsp"); 
		}
		if (status == 2) {
			res.put("newpage", "manager-panel.jsp"); 
		}
		if (status == 3) {
			res.put("newpage", "manager-panel.jsp"); 
		}
		res.put("status", status);
		response.getWriter().print(res);
	}

}
