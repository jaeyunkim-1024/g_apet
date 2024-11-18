package biz.twc.service;

import biz.twc.model.CounslorPO;
import biz.twc.model.TicketPO;


/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.twc.service
 * - 파일명		: TwcService.java
 * - 작성일		: 2021.03.24
 * - 작성자		: KKB
 * - 설명		: TWC 서비스
 * </pre>
 */

public interface TwcService {

	public String sendCounselorInfo(CounslorPO po);
	
	public String sendTicketEvent(TicketPO po);

}
