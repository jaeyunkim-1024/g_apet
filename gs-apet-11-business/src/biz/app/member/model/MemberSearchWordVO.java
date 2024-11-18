package biz.app.member.model;

import java.io.UnsupportedEncodingException;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberSearchWordVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Long mbrNo;

	/** 검색 구분 코드 */
	private String srchGbCd;
	
	/** 검색어 */
	private String srchWord;
	
	/** 순번 */
	private Long seq;
	
	public String getSrchShortWord() {
		if(this.srchWord != null) {
			char[] charArray = this.srchWord.toCharArray();
			int length = charArray.length;
			int totalByte = 0;
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < length; i++) {
				String s = String.valueOf(charArray[i]);
				sb.append(s);
				try {
					totalByte = totalByte + s.getBytes("EUC-KR").length;
				} catch (UnsupportedEncodingException e) {
					totalByte = totalByte + 1;
				}
				if(totalByte >= 20) {
					return sb.toString() +"...";
				}		
			}
		}
		return this.srchWord;
	}
}