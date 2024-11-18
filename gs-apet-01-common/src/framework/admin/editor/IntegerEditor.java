package framework.admin.editor;

import java.beans.PropertyEditorSupport;

import framework.common.util.StringUtil;

public class IntegerEditor extends PropertyEditorSupport {

	private final boolean allowEmpty;

	public IntegerEditor(boolean allowEmpty) {
		this.allowEmpty = allowEmpty;
	}

	@Override
	public void setAsText(String text) {
		if (((this.allowEmpty) && (StringUtil.isBlank(text))) || StringUtil.equals(text.toLowerCase(),"null")) {
			setValue(null);
		} else {
			String value = text.replaceAll(",", "");
			setValue(Integer.parseInt(value));
		}
	}

	@Override
	public String getAsText() {
		Integer value = (Integer) getValue();
		return ((value != null) ? String.valueOf(value) : "");
	}
}