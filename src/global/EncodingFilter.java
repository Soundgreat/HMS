package global;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletRequest;

/**
 * Servlet Filter implementation class EncodingFilter
 */
@WebFilter(
		filterName = "encodingFilter",
		urlPatterns = { "/*" },
		initParams = {
				@WebInitParam(name = "encoding", value = "utf-8")
		})
public class EncodingFilter implements Filter {
	FilterConfig config;
	String encoding;
    /**
     * Default constructor. 
     */
    public EncodingFilter() {
        // TODO Auto-generated constructor stub
    }
    
    /**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		config = fConfig;
		encoding = fConfig.getInitParameter("encoding");
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		if (encoding != null) {
			request.setCharacterEncoding(encoding);
			response.setCharacterEncoding(encoding);
		}

		((HttpServletRequest)request).getSession().setMaxInactiveInterval(30*60);
		
		chain.doFilter(request, response);
	}
	
	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		config = null;
		encoding = null;
	}

}
