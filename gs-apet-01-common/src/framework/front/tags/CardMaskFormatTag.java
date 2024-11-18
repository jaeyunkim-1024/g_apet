package framework.front.tags;

/**
 * 카드번호 - 가운데 여덟자리 이상   예)1234-****-****-3456
 * 
 * @author valueFactory
 * @since 2018. 05. 17.
 */
public class CardMaskFormatTag extends CardMaskFormatSupport {

	private static final long serialVersionUID = 6483901364025783010L;

	public void setData(String data) {
		this.data = data;
	}

}