package framework.front.tags;

/**
 * 전화번호 - 가운데 국번 네자리 이상 070-****-1234
 * 
 * @author valueFactory
 * @since 2018. 05. 17.
 */
public class TelMaskFormatTag extends TelMaskFormatSupport {

	private static final long serialVersionUID = -6809925482855163073L;

	public void setData(String data) {
		this.data = data;
	}
}