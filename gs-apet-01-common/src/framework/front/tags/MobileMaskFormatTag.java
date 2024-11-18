package framework.front.tags;

/**
 * 핸드폰번호 - 가운데 국번 네자리 이상 010-****-1234
 * 
 * @author valueFactory
 * @since 2018. 05. 17.
 */
public class MobileMaskFormatTag extends MobileMaskFormatSupport {

	private static final long serialVersionUID = -6809925482855163073L;

	public void setData(String data) {
		this.data = data;
	}

}