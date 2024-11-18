package biz.interfaces.gsr.service;

import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.pay.model.PayBasePO;
import biz.app.pay.model.PayBaseSO;
import biz.app.pay.model.PayBaseVO;
import biz.app.system.model.CodeDetailVO;
import biz.interfaces.gsr.model.*;

import java.util.List;
import java.util.Map;

public interface GsrService {
    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrService.java
     * - 작성일		: 2021. 02. 01.
     * - 작성자		: 김재윤
     * - 설명			: CRM 고객정보 조회
     * </pre>
     */
    public MemberBaseVO getGsrMemberBase(MemberBaseSO so);

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrService.java
     * - 작성일		: 2021. 02. 01.
     * - 작성자		: 김재윤
     * - 설명			: CRM 회원 등록
     * </pre>
     */
    public MemberBaseVO saveGsrMember(MemberBasePO po);
    
    //GSR 연계시 DB 업데이트 및 MEMBER_BASE 이력 등록
    public void update(MemberBasePO po);

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrService.java
     * - 작성일		: 2021. 02. 01.
     * - 작성자		: 김재윤
     * - 설명			: CRM 회원 가입 가능 여부
     * </pre>
     */
    public Map<String,String> checkJoin(MemberBasePO po);

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrService.java
     * - 작성일		: 2021. 02. 01.
     * - 작성자		: 김재윤
     * - 설명			: CRM 고객 포인트 조회
     * </pre>
     */
    public GsrMemberPointVO getGsrMemberPoint(GsrMemberPointSO so);

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrService.java
     * - 작성일		: 2021. 03. 11.
     * - 작성자		: 김재윤
     * - 설명			: GS 포인트 사용
     * </pre>
     */
    public GsrMemberPointVO useGsPoint(GsrMemberPointPO po);

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrService.java
     * - 작성일		: 2021. 03. 11.
     * - 작성자		: 김재윤
     * - 설명			: GS 포인트 사용 취소
     * </pre>
     */
    public GsrMemberPointVO useCancelGsPoint(GsrMemberPointPO po);

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrService.java
     * - 작성일		: 2021. 03. 11.
     * - 작성자		: 김재윤
     * - 설명			: GS 포인트 적립
     * </pre>
     */
    public GsrMemberPointVO accumGsPoint(GsrMemberPointPO po);

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrService.javag
     * - 작성일		: 2021. 03. 11.
     * - 작성자		: 김재윤
     * - 설명			: 펫로그 좋아요 카운트(100,500,1000) 넘을 시 포인트 지급
     * </pre>
     */
    public GsrMemberPointVO petLogPotinAccumtByCount(GsrMemberPointPO po);

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrService.javag
     * - 작성일		: 2021. 03. 11.
     * - 작성자		: 김재윤
     * - 설명			: 펫로그 후기 남길 시 포인트 지급
     * </pre>
     */
    public GsrMemberPointVO petLogReviewAccumPoint(GsrMemberPointPO po);

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrService.javag
     * - 작성일		: 2021. 03. 11.
     * - 작성자		: 김재윤
     * - 설명			: GS 포인트 적립 취소
     * </pre>
     */
    public GsrMemberPointVO accumCancelGsPoint(GsrMemberPointPO po);

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrService.javag
     * - 작성일		: 2021. 03. 11.
     * - 작성자		: 김명섭
     * - 설명			: GS 연동 이력
     * </pre>
     */
    public List<GsrLnkHistVO> gsrLinkedHistoryGrid(GsrLnkHistSO so);

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrService.javag
     * - 작성일		: 2021. 03. 11.
     * - 작성자		: 김재윤
     * - 설명			: 명의 체크
     * </pre>
     */
    public void checkMbrNm(Long mbrNo, String mbrNm);

    public Integer getRcptNoCnt(GsrLnkMapSO so);

    public String getGsptNo(Long mbrNo);

    public List<CodeDetailVO> listCodeDetailVO(String grpCd);

    public CodeDetailVO getCodeDetailVO(String grpCd , String dtlCd);

    public void getGsrPointAccumeForPetLogReview();

    public PayBaseVO getPayBase(PayBaseSO so);

    public void updatePayBaseComplete(PayBasePO po);

    public void insertPayBase(PayBasePO po);
}
