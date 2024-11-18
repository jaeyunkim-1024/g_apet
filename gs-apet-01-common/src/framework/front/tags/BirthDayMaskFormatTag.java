package framework.front.tags;

/**
 * 생년월일 포멧 (뒤 두 자리) 예)1990년 01월 **일, 9001**
 * 
 * @author valueFactory
 * @since 2018. 05. 17.
 */
public class BirthDayMaskFormatTag extends BirthDayMaskFormatSupport {

	private static final long serialVersionUID = 4282554843018574536L;

	public void setData(String data) {
		this.data = data;
	}

}