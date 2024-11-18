package framework.front.tags;

/**
 * 이메일 마스킹
 * 
 * @author valueFactory
 * @since 2018. 04. 20.
 */
public class SecretEmailFormatTag extends SecretEmailFormatSupport {

	private static final long serialVersionUID = 1L;

	public void setData(String data) {
		this.data = data;
	}

}
