package framework.admin.editor;

import java.beans.PropertyEditorSupport;

import framework.common.util.StringUtil;

public class DoubleEditor extends PropertyEditorSupport {

	private final boolean allowEmpty;

	public DoubleEditor(boolean allowEmpty) {
		this.allowEmpty = allowEmpty;
	}

	@Override
	public void setAsText(String text) {
		if (((this.allowEmpty) && (StringUtil.isBlank(text))) || StringUtil.equals(text.toLowerCase(),"null")) {
			setValue(null);
		} else {
			String value = text.replaceAll(",", "");
			setValue(Double.parseDouble(value));
		}
	}

	@Override
	public String getAsText() {
		Double value = (Double) getValue();
		return ((value != null) ? String.valueOf(value) : "");
	}
}
