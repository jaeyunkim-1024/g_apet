package framework.front.tags;

/**
 * 비밀번호 -  모든 자리    예) *********
 * 
 * @author valueFactory
 * @since 2018. 05. 17.
 */
public class PasswordMaskFormatTag extends PasswordMaskFormatSupport {

	private static final long serialVersionUID = 5083050362527292744L;

	public void setData(String data) {
		this.data = data;
	}

}