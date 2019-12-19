package com.springmvc.interceptor;

import com.springmvc.service.OtherService;
import com.springmvc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @ClassName AuthorityInterceptor
 * @Author JinZhiyun
 * @Description 用户权限拦截器
 * @Date 2019/5/3 12:58
 * @Version 1.0
 **/
public class AuthorityInterceptor implements HandlerInterceptor {
    private final static org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(AuthorityInterceptor.class);

    @Autowired
    private OtherService otherService;

    /**
     * @return boolean
     * @Author JinZhiyun
     * @Description 拦截访问修改页面的请求，如果非管理员身份，提示error.jsp
     * @Date 13:18 2019/5/3
     * @Param [httpServletRequest, httpServletResponse, o]
     **/
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        if (otherService.ifUserIsAdmin(httpServletRequest.getSession())) {
            logger.info("管理员访问:" + httpServletRequest.getRequestURI());
            return true;
        }
        logger.info("非管理员访问:" + httpServletRequest.getRequestURI() + " 无操作权限");
        httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/error");
        return false;
    }


    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
