package framework.admin.editor;

import java.beans.PropertyEditorSupport;

import framework.common.util.StringUtil;

public class LongEditor extends PropertyEditorSupport {

	private final boolean allowEmpty;

	public LongEditor(boolean allowEmpty) {
		this.allowEmpty = allowEmpty;
	}

	@Override
	public void setAsText(String text) {
		if (((this.allowEmpty) && (StringUtil.isBlank(text))) || StringUtil.equals(text.toLowerCase(),"null")) {
			setValue(null);
		} else {
			String value = text.replaceAll(",", "");
			setValue(Long.parseLong(value));
		}
	}

	@Override
	public String getAsText() {
		Long value = (Long) getValue();
		return ((value != null) ? String.valueOf(value) : "");
	}
}