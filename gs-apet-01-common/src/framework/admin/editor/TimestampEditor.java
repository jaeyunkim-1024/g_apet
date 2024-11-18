package framework.admin.editor;

import java.beans.PropertyEditorSupport;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class TimestampEditor extends PropertyEditorSupport {

	private final boolean allowEmpty;

	public TimestampEditor(boolean allowEmpty) {
		this.allowEmpty = allowEmpty;
	}

	@Override
	public void setAsText(String text) {
		if (((this.allowEmpty) && (StringUtil.isBlank(text))) || StringUtil.equals(text.toLowerCase(),"null")) {
			setValue(null);
		} else {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);

			if (text.length() == 10) {
				sdf.applyPattern("yyyy-MM-dd");
			} else if (text.length() == 19) {
				if (!DateUtil.isTime(text.substring(11))) {
					log.error(CommonConstants.LOG_EXCEPTION_DATE);
					throw new IllegalArgumentException(CommonConstants.LOG_EXCEPTION_DATE);
				}
			} else {
				log.error(CommonConstants.LOG_EXCEPTION_DATE);
				throw new IllegalArgumentException(CommonConstants.LOG_EXCEPTION_DATE);
			}

			try {
				Date date = sdf.parse(text);
				setValue(new Timestamp(date.getTime()));
			} catch (ParseException e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				throw new IllegalArgumentException(CommonConstants.LOG_EXCEPTION_DATE);
			}
		}
	}

	@Override
	public String getAsText() {
		Timestamp value = (Timestamp) getValue();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
		return ((value != null) ? sdf.format(value) : "");
	}
}