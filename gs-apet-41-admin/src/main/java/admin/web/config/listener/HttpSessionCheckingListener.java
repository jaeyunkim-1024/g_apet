package admin.web.config.listener;

import java.util.Date;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class HttpSessionCheckingListener implements HttpSessionListener {

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		if (log.isDebugEnabled()) {
			log.debug("Session ID : ".concat(se.getSession().getId()).concat(" created at ").concat(new Date().toString()));
		}
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		if (log.isDebugEnabled()) {
			log.debug("Session ID : ".concat(se.getSession().getId()).concat(" destroyed at ").concat(new Date().toString()));
		}
	}

}
