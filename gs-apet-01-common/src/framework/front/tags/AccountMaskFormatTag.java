package framework.front.tags;

/**
 * 계좌번호 -  뒤 네 자리를 제외한 나머지   예) *********1234
 * 
 * @author valueFactory
 * @since 2018. 05. 17.
 */
public class AccountMaskFormatTag extends AccountMaskFormatSupport {

	private static final long serialVersionUID = 6937569310699815798L;

	public void setData(String data) {
		this.data = data;
	}

}