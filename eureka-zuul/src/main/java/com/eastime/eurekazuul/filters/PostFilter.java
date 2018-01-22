package com.eastime.eurekazuul.filters;

import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.context.RequestContext;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;

@Component
public class PostFilter extends ZuulFilter {

    /**
     可以返回下面四种类型
     pre：路由之前
     routing：路由之时
     post： 路由之后
     error：发送错误调用
     * @return
     */
    @Override
    public String filterType() {
        return "post";// 前置过滤器
    }

    /**
     * 过滤的顺序
     * @return
     */
    @Override
    public int filterOrder() {
        return 0;//优先级为0，数字越大，优先级越低
    }

    /**
     * 这里可以写逻辑判断，是否要过滤
     * true:表示过滤,false:表示不过滤
     * @return
     */
    @Override
    public boolean shouldFilter() {
        return true;// 是否执行该过滤器，此处为true，说明需要过滤
    }

    /**
     * 过滤器的具体逻辑。可用很复杂，包括查sql，nosql去判断该请求到底有没有权限访问
     * @return
     */
    @Override
    public Object run() {
        RequestContext ctx = RequestContext.getCurrentContext();
        HttpServletRequest request = ctx.getRequest();
        String username = request.getParameter("name");// 获取请求的参数
        ctx.setSendZuulResponse(true);
        ctx.setResponseStatusCode(200);
        if(null != username && username.equals("filter")) {
            ctx.setResponseBody("{\"name\":\"change result:" + username + "\"}");// 输出最终结果
        }
        return null;
    }
}
