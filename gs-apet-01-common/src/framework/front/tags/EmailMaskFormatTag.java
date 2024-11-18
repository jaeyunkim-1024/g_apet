package framework.front.tags;

/**
 * 아이디 중 앞 세 자리를 제외한 나머지   예)abc*****@nate.com
 * 
 * @author valueFactory
 * @since 2018. 05. 17.
 */
public class EmailMaskFormatTag extends EmailMaskFormatSupport {

	private static final long serialVersionUID = -6626849414045710273L;

	public void setData(String data) {
		this.data = data;
	}

}