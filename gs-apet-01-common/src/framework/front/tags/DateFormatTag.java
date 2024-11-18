package framework.front.tags;

/**
 * 문자열 형태의 날짜를 특정 형식으로 출력
 * 
 * @author valueFactory
 * @since 2016. 04. 06.
 */
public class DateFormatTag extends DateFormatSupport {

	private static final long serialVersionUID = -6809925482855163073L;

	public void setDate(String date) {
		this.date = date;
	}

	public void setType(String type){
		this.type = type;
	}

}