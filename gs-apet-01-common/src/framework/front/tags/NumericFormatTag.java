package framework.front.tags;

/**
 * 숫자 포맷 변경 (3자리마다 , 처리)
 * 
 * @author valueFactory
 * @since 2016. 05. 03.
 */
public class NumericFormatTag extends NumericFormatSupport {

	private static final long serialVersionUID = -6809925482855163073L;

	public void setData(String data) {
		this.data = data;
	}

}