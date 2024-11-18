package framework.front.tags;

/**
 * 초단위의 숫자를 시간으로 계산
 * 
 * @author valueFactory
 * @since 2016. 03. 02.
 */
public class TimeCalculationTag extends TimeCalculationSupport {

	private static final long serialVersionUID = -6809925482855163073L;

	public void setTime(String time) {
		this.time = time;
	}

	public void setType(String type) {
		this.type = type;
	}

}