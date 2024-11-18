package framework.front.tags;

/**
 * 한글이름 - 이름의 첫 번째 자리 이상 (姓 제외)  예)홍*동, 김*, 선**녀
 * 
 * @author valueFactory
 * @since 2018. 05. 17.
 */
public class KorNameMaskFormatTag extends KorNameMaskFormatSupport {

	private static final long serialVersionUID = -3920063384791574923L;

	public void setData(String data) {
		this.data = data;
	}

}