package biz.common.model;

import java.io.Serializable;

import framework.common.model.BaseSearchVO;
import javassist.compiler.Parser;
import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.sms.model
* - 파일명		: SmsSendPO.java
* - 작성일		: 2016. 4. 21.
* - 작성자		: snw
* - 설명		: SMS 전송 히스토리
* </pre>
*/
@Data
public class EmSmtLogSO  extends BaseSearchVO<EmSmtLogSO> {



	private static final long serialVersionUID = 1L;

	/** 마스터키 */
	private String mtPr;
	/** 전송예약시간 */
	private String dateClientReq;
	/** 발신자전화번호 */
	private String callback;
	/** 전송메세지 */
	private String content;
	/** 수신자전화번호 */
	private String recipientNum;
	/** 메세지상태 1-전송대기,2-결과대기 ,3-완료*/
	private String msgStatus;
	/** 조회년도 */
	private String	selYear;
	/** 조회월 */
	private String	selMon;

	public String	getTableName(){
		String rtn ="";
		if ( Integer.parseInt(  selMon)  > 9 ){
			rtn = "EM_SMT_LOG_" +selYear + selMon;
		}else{
			rtn = "EM_SMT_LOG_" +selYear +"0"+ selMon;
		}
		return   rtn;
	}

	public String	getMmsTableName(){
		String rtn ="";
		if ( Integer.parseInt(  selMon)  > 9 ){
			rtn = "EM_MMT_LOG_" +selYear + selMon;
		}else{
			rtn = "EM_MMT_LOG_" +selYear +"0"+ selMon;
		}
		return   rtn;
	}
}