package framework.front.tags;

/**
 * TextArea 값을 Html로 변환
 * 
 * @author valueFactory
 * @since 2016. 03. 02.
 */
public class SubStrContentTag extends SubStrContentSupport {

	private static final long serialVersionUID = -6809925482855163073L;

	public void setData(String data) {
		this.data = data;
	}

	public void setLength(int length) {
		this.length = length;
	}

}