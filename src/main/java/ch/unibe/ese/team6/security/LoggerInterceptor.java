package ch.unibe.ese.team6.security;

import java.security.Principal;
import java.util.Enumeration;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.*;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoggerInterceptor extends HandlerInterceptorAdapter{

		private static final Logger logger = Logger.getLogger("HomeLender logger");

		@Override
		public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
			UUID requestId = UUID.randomUUID();
				
			
			request.setAttribute("RequestId", requestId.toString());
			Principal user = request.getUserPrincipal();

			String userName = user != null ? user.getName() : "Anonymous";
			StringBuilder sb = new StringBuilder();
			
			Enumeration<String> parameterNames = request.getParameterNames();

			while (parameterNames.hasMoreElements()) {
				String paramName = parameterNames.nextElement();
				String[] paramValues = request.getParameterValues(paramName);
				for (int i = 0; i < paramValues.length; i++) {
					String paramValue = paramValues[i];
					sb.append(String.format("%s=%s", paramName, paramValue));
					sb.append(" ");
				}
			}

			String logEntry = String.format("%s %s { %s} %s, RequestUUID: %s", request.getMethod(), request.getRequestURI(), sb.toString(), userName, requestId.toString());

			logger.info(logEntry);

			return true;
		}

		@Override
		public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

			Principal user = request.getUserPrincipal();
			String requestId = (String) request.getAttribute("RequestId");
			String userName = user != null ? user.getName() : "Anonymous";
			String logEntry = String.format("Request %s completed with status code %d, %s, Request UUID: %s ", request.getRequestURI(), response.getStatus(), userName, requestId);

			logger.info(logEntry);
		}
}
