package com.studentapp.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/*")
public class CookieAuthFilter implements Filter {

    private static final String[] PUBLIC_PATHS = {
            "/login", "/login.jsp", "/signup", "/signup.jsp", "/css/", "/error.jsp"
    };

    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        if (isPublic(path)) {
            chain.doFilter(request, response);
            return;
        }

        if (hasValidLoginCookie(req)) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Please+login+to+continue");
        }
    }

    private boolean hasValidLoginCookie(HttpServletRequest req) {
        Cookie[] cookies = req.getCookies();
        if (cookies == null) return false;
        for (Cookie c : cookies) {
            if ("loggedInUser".equals(c.getName()) && c.getValue() != null && !c.getValue().trim().isEmpty()) {
                return true;
            }
        }
        return false;
    }

    private boolean isPublic(String path) {
        for (String p : PUBLIC_PATHS) {
            if (path.equals(p) || path.startsWith(p)) return true;
        }
        return false;
    }

    @Override
    public void destroy() {
    }
}