package biz.app.emma.service;

import biz.app.emma.model.SmtClientPO;
import biz.app.emma.model.SmtTranPO;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.emma.service
* - 파일명		: EmmaService.java
* - 작성일		: 2017. 2. 2.
* - 작성자		: WilLee
* - 설명		 	: SMS 전송 테이블 관련 서비스
 * </pre>
 */
public interface EmmaService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EmmaService.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: WilLee
	* - 설명			: SMS 전송테이블(em_smt_tran) 등록
	* </pre>
	* @param st
	 */
	void insertSmtTran(SmtTranPO st);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EmmaService.java
	* - 작성일		: 2017. 2. 2.
	* - 작성자		: WilLee
	* - 설명			: 수신자 번호 리스트 테이블(em_smt_client) 등록
	* </pre>
	* @param sc
	 */
	void insertSmtClient(SmtClientPO sc);

	/**
	 * 
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EmmaService.java
	* - 작성일		: 2017. 2. 3.
	* - 작성자		: WilLee
	* - 설명			: 동보 메세지 Key getting
	* </pre>
	* @param st
	 */
	int getMaxSmtPr();

	/**
	 * 
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EmmaService.java
	* - 작성일		: 2017. 2. 3.
	* - 작성자		: WilLee
	* - 설명			: SMS 전송테이블(em_smt_tran) 상태 Update
	* </pre>
	* @param st
	 */
	void updateSmtTran(SmtTranPO st);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EmmaService.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: WilLee
	* - 설명			: MMS 전송 테이블(em_mmt_tran) 등록
	* </pre>
	* @param st
	 */
	void insertMmtTran(SmtTranPO st);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EmmaService.java
	* - 작성일		: 2017. 2. 2.
	* - 작성자		: WilLee
	* - 설명			: 수신자 번호 리스트 테이블(em_mmt_client) 등록
	* </pre>
	* @param sc
	 */
	void insertMmtClient(SmtClientPO sc);

	/**
	 * 
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EmmaService.java
	* - 작성일		: 2017. 2. 3.
	* - 작성자		: WilLee
	* - 설명			: 동보 메세지 Key getting
	* </pre>
	* @param st
	 */
	int getMaxMmtPr();

	/**
	 * 
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EmmaService.java
	* - 작성일		: 2017. 2. 3.
	* - 작성자		: WilLee
	* - 설명			: MMS 전송테이블(em_mmt_tran) 상태 Update
	* </pre>
	* @param st
	 */
	void updateMmtTran(SmtTranPO st);
}