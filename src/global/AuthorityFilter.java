//package global;
//
//import java.io.IOException;
//import javax.servlet.FilterChain;
//import javax.servlet.FilterConfig;
//import javax.servlet.ServletException;
//import javax.servlet.ServletRequest;
//import javax.servlet.ServletResponse;
//import javax.servlet.annotation.WebFilter;
//import javax.servlet.annotation.WebInitParam;
//import javax.servlet.http.HttpServletRequest;
//
///**
// * Servlet Filter implementation class Filter
// */
//@WebFilter(
//		filterName = "authorityFilter",
//		urlPatterns = { "/*" },
//		initParams = {
//				@WebInitParam(name = "register", value = "register.jsp"),
//				@WebInitParam(name = "login", value = "login.jsp"),
//				@WebInitParam(name = "home", value = "hotelMain.jsp"),
//				@WebInitParam(name = "search", value = "searchhotel.jsp")
//		})
//public class AuthorityFilter implements javax.servlet.Filter {
//	private FilterConfig config; 
//    /**
//     * Default constructor. 
//     */
//    public AuthorityFilter() {
//        // TODO Auto-generated constructor stub
//    }
//
//	/**
//	 * @see AuthorityFilter#init(FilterConfig)
//	 */
//	public void init(FilterConfig fConfig) throws ServletException {
//		config = fConfig;
//	}
//
//	/**
//	 * @see AuthorityFilter#doFilter(ServletRequest, ServletResponse, FilterChain)
//	 */
//	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//		HttpServletRequest hRequest = (HttpServletRequest) request;
//		String path = hRequest.getServletPath();
//		ClientBean user = (ClientBean)hRequest.getSession().getAttribute("user");
//		String register = config.getInitParameter("register");
//		String login = config.getInitParameter("login");
//		String home = config.getInitParameter("home");
//		String search = config.getInitParameter("search");
//		if (user == null) {
//			if (!path.endsWith(register) && !path.endsWith(login)
//					&& !path.endsWith(home) && !path.endsWith(search)) {
//				hRequest.getRequestDispatcher("login.jsp").forward(request, response);
//			}
//		}
//		chain.doFilter(request, response);
//	}
//
//	/**
//	 * @see AuthorityFilter#destroy()
//	 */
//	public void destroy() {
//		// TODO Auto-generated method stub
//	}
//	
//}
