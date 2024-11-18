package framework.front.tags;

/**
 * 주소 - 읍면동 미만   예)서울시 중구 을지로 ***** , 서울시 중구 다동 ****
 * 
 * @author valueFactory
 * @since 2018. 05. 17.
 */
public class AddressMaskFormatTag extends AddressMaskFormatSupport {

	private static final long serialVersionUID = 6293142777227229578L;

	public void setData(String data) {
		this.data = data;
	}

}