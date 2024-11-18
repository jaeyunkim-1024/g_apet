package framework.front.tags;

/**
 * Timestamp의 일자를 특정 형식으로 출력
 * 
 * @author valueFactory
 * @since 2016. 04. 06.
 */
public class TimestampFormatTag extends TimestampFormatSupport {

	private static final long serialVersionUID = -6809925482855163073L;

	public void setDate(String date) {
		this.date = date;
	}

	public void setdType(String dType) {
		this.dType = dType;
	}

	public void settType(String tType) {
		this.tType = tType;
	}

}