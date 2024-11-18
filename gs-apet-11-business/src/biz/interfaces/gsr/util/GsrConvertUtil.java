package biz.interfaces.gsr.util;

import biz.app.member.dao.MemberBaseDao;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.common.service.BizService;
import biz.interfaces.gsr.model.GsrException;
import biz.interfaces.gsr.model.GsrMemberPointPO;
import biz.interfaces.gsr.model.GsrMemberPointSO;
import biz.interfaces.gsr.model.GsrMemberPointVO;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.base.CaseFormat;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.support.JdbcUtils;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

@Slf4j
@Component
public class GsrConvertUtil {
    @Autowired
    GsrCryptoUtil gsrCryptoUtil;

    @Autowired
    private MemberBaseDao memberBaseDao;

    @Autowired
    private BizService bizService;

    /** GS 필수 동의 약관 번호*/
    private final String GSR_REQUIRED_AGREE_TERMS_NO = "01,02,03,06";

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrConvertUtil.java
     * - 작성일		: 2021. 02. 01.
     * - 작성자		: 김재윤
     * - 설명			: 고객정보 조회 요청 파라미터 생성 ( so에 잇는 정보는 암호화 되지 않은 값)
     * </pre>
     */
    public Map<String,String> getGsrMemberSearchParam(MemberBaseSO so){
        Map<String,String> param = new HashMap<String,String>();
        String gsptNo = Optional.ofNullable(so.getGsptNo()).orElseGet(()->"");
        Long mbrNo = Optional.ofNullable(so.getMbrNo()).orElseGet(()->0L);

        if(StringUtil.isNotEmpty(gsptNo)){
            param.put("cust_no",gsptNo);
        }else{
            String mbrNm=null,mobile=null,birth=null,gdGbCd=null;
            //가입 시
            if(Long.compare(mbrNo,0L)==0){
                mbrNm = Optional.ofNullable(so.getMbrNm()).orElseThrow(()->new GsrException(ExceptionConstants.ERROR_GSR_API_NECESSARY_FIELD_MEMBER_INFO_MBR_NM,so,CommonConstants.GSR_LNK_MBR_SELECT));
                mobile = Optional.ofNullable(so.getMobile()).orElseThrow(()->new GsrException(ExceptionConstants.ERROR_GSR_API_NECESSARY_FIELD_MEMBER_INFO_MOBILE,so,CommonConstants.GSR_LNK_MBR_SELECT));
                birth = Optional.ofNullable(so.getBirth()).orElseThrow(()->new GsrException(ExceptionConstants.ERROR_GSR_API_NECESSARY_FIELD_MEMBER_INFO_BIRTH,so,CommonConstants.GSR_LNK_MBR_SELECT));
                gdGbCd = Optional.ofNullable(so.getGdGbCd()).orElseThrow(()->new GsrException(ExceptionConstants.ERROR_GSR_API_NECESSARY_FIELD_MEMBER_INFO_GD_GB_CD,so,CommonConstants.GSR_LNK_MBR_SELECT));
            }
            //그 외
            else{
                MemberBaseSO so2 = new MemberBaseSO();
                so2.setMbrNo(mbrNo);
                MemberBaseVO vo = memberBaseDao.getMemberBase(so2);
                //연계 번호 있을 시
                if(StringUtil.isNotEmpty(Optional.ofNullable(vo.getGsptNo()).orElseGet(()->""))){
                    param.put("cust_no",vo.getGsptNo());
                    return param;
                }

                mbrNm = Optional.ofNullable(so.getMbrNm()).orElseGet(()->bizService.twoWayDecrypt(vo.getMbrNm()));
                mobile = Optional.ofNullable(so.getMobile()).orElseGet(()->bizService.twoWayDecrypt(vo.getMobile()));
                birth = Optional.ofNullable(so.getBirth()).orElseGet(()->bizService.twoWayDecrypt(vo.getBirth()));
                gdGbCd = Optional.ofNullable(so.getGdGbCd()).orElseGet(()->vo.getGdGbCd());
            }
            param.put("kor_name",mbrNm);
            param.put("hp",convert2GsMobile(mobile));
            param.put("bdate",convert2GsBirth(birth));
            param.put("gender",convert2GsGender(gdGbCd));
        }

        return param;
    }

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrConvertUtil.java
     * - 작성일		: 2021. 02. 01.
     * - 작성자		: 김재윤
     * - 설명			: 회원 가입 가능 여부 파라미터 생성
     * </pre>
     */
    public Map<String,String> getIsJoinCheckParam(MemberBasePO po){
        Map<String,String> param = new HashMap<String,String>();

        //필수값 처리
        String mbrNm = Optional.ofNullable(po.getMbrNm()).orElseGet(()->"");
        String mobile = Optional.ofNullable(po.getMobile()).orElseGet(()->"");
        String birth = Optional.ofNullable(po.getBirth()).orElseGet(()->"");
        String gdGbCd = Optional.ofNullable(po.getGdGbCd()).orElseGet(()->"");
        String ciCtfVal = Optional.ofNullable(po.getCiCtfVal()).orElseGet(()->"");

        String[] hps = convert2GsMobileSeparate(mobile);
        param.put("cust_name",mbrNm);
        param.put("hp1",hps[0]);
        param.put("hp2",hps[1]);
        param.put("hp3",hps[2]);
        param.put("bdate",convert2GsBirth(birth));
        param.put("sex_code",convert2GsGender(gdGbCd));
        param.put("ci_vlue",ciCtfVal);

        return param;
    }

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrConvertUtil.java
     * - 작성일		: 2021. 02. 01.
     * - 작성자		: 김재윤
     * - 설명			: 회원 등록 요청 파라미터 생성
     * </pre>
     */
    public Map<String,String> getRegisterParam(MemberBasePO po){
        Map<String,String> param = new HashMap<String,String>();

        //필수값 처리
        String mbrNm = Optional.ofNullable(po.getMbrNm()).orElseThrow(()->new GsrException(ExceptionConstants.ERROR_GSR_API_NECESSARY_FIELD_MEMBER_INFO_MBR_NM,po,CommonConstants.GSR_LNK_MBR_INSERT));
        String mobile = Optional.ofNullable(po.getMobile()).orElseThrow(()->new GsrException(ExceptionConstants.ERROR_GSR_API_NECESSARY_FIELD_MEMBER_INFO_MOBILE,po,CommonConstants.GSR_LNK_MBR_INSERT));
        String birth = Optional.ofNullable(po.getBirth()).orElseThrow(()->new GsrException(ExceptionConstants.ERROR_GSR_API_NECESSARY_FIELD_MEMBER_INFO_BIRTH,po,CommonConstants.GSR_LNK_MBR_INSERT));
        String gdGbCd = Optional.ofNullable(po.getGdGbCd()).orElseThrow(()->new GsrException(ExceptionConstants.ERROR_GSR_API_NECESSARY_FIELD_MEMBER_INFO_GD_GB_CD,po,CommonConstants.GSR_LNK_MBR_INSERT));
        String ciCtfVal = Optional.ofNullable(po.getCiCtfVal()).orElseThrow(()->new GsrException(ExceptionConstants.ERROR_GSR_API_NECESSARY_FIELD_MEMBER_INFO_CI,po,CommonConstants.GSR_LNK_MBR_INSERT));
        String mobileCd = Optional.ofNullable(po.getMobileCd()).orElseThrow(()->new GsrException(ExceptionConstants.ERROR_GSR_API_NECESSARY_FIELD_MEMBER_INFO_TEL_GB,po,CommonConstants.GSR_LNK_MBR_INSERT));

        String smsRcvYn = CommonConstants.COMM_YN_Y;
        String emailRcvYn = CommonConstants.COMM_YN_Y;

        String[] hps = convert2GsMobileSeparate(mobile);

        param.put("com_co_div_code",convert2GsMobileCd(mobileCd));
        param.put("cust_name",mbrNm);
        param.put("hp1",hps[0]);
        param.put("hp2",hps[1]);
        param.put("hp3",hps[2]);
        param.put("agree_yn","<![CDATA["+GSR_REQUIRED_AGREE_TERMS_NO+"]]>");
        param.put("foreign_yn",CommonConstants.COMM_YN_N);
        param.put("sms_yn",smsRcvYn);
        param.put("email_yn",emailRcvYn);
        param.put("bdate",convert2GsBirth(birth));
        param.put("sex_code",convert2GsGender(gdGbCd));
        param.put("ci_vlue",ciCtfVal);
        return param;
    }

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrConvertUtil.java
     * - 작성일		: 2021. 02. 01.
     * - 작성자		: 김재윤
     * - 설명			: 고객 포인트 조회 요청 파라미터 생성
     * </pre>
     */
    public Map<String,String> getSelectMemberPointParam(GsrMemberPointSO so){
        Map<String,String> param = new HashMap<String,String>();
        param.put("cust_no",so.getCustNo());
        return param;
    }

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrConvertUtil.java
     * - 작성일		: 2021. 02. 01.
     * - 작성자		: 김재윤
     * - 설명			: 고객 포인트 적립 사용 요청 파라미터 생성
     * </pre>
     */
    public Map<String,String> getSaveMemberPointPamram(GsrMemberPointPO po){
        Map<String,String> param = new HashMap<String,String>();
        Map<String,String> poMap = new ObjectMapper().convertValue(po,Map.class);
        Set<String> keys = poMap.keySet();
        for(String key : keys){
            if(!StringUtil.equals("mbrNo",key) && !StringUtil.equals("pntRsnCd",key) && !StringUtil.equals("ordNoForCheck",key)){
                param.put(CaseFormat.UPPER_CAMEL.to(CaseFormat.LOWER_UNDERSCORE, key),poMap.get(key));
            }
        }

        String orgApprNo = Optional.ofNullable(po.getOrgApprNo()).orElseGet(()->"");
        //취소 원거래 번호 존재 시
        if(StringUtil.isNotEmpty(orgApprNo)){
            param.put("org_appr_no",orgApprNo);
            param.put("org_appr_date",Optional.ofNullable(po.getOrgApprDate()).orElseGet(()->DateUtil.getTimestampToString(DateUtil.getTimestamp(), "yyyyMMdd")));
        }

        //어바웃펫에서 API로 가입한 회원은, id X -> 고객번호로 대신.
        param.put("user_id",po.getCustNo());
        return param;
    }

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrConvertUtil.java
     * - 작성일		: 2021. 02. 01.
     * - 작성자		: 김재윤
     * - 설명			: 어바웃펫 성별 구분 코드 -> GS 성별 구분 코드
     * </pre>
     */
    private String convert2GsGender(String gdGbCd){
        return StringUtil.equals(gdGbCd, CommonConstants.GD_GB_0)
                ? CommonConstants.GSR_GENDER_GB_CD_WOMAN : CommonConstants.GSR_GENDER_GB_CD_MAN;
    }

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrConvertUtil.java
     * - 작성일		: 2021. 02. 01.
     * - 작성자		: 김재윤
     * - 설명			: 어바웃펫 핸드폰 번호 -> GSR 핸드폰 번호
     * </pre>
     */
    private String convert2GsMobile(String mobile){
        return mobile.replaceAll("/[-]]/g",mobile);
    }

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrConvertUtil.java
     * - 작성일		: 2021. 02. 01.
     * - 작성자		: 김재윤
     * - 설명			: 어바웃펫 핸드폰 번호 -> GSR 핸드폰 번호(하이픈 없이)
     * </pre>
     */
    private String[] convert2GsMobileSeparate(String mobile){
        mobile = convert2GsMobile(mobile);
        int length = mobile.length();
        if(length == 11){
            return new String[]{mobile.substring(0,3),mobile.substring(3,7),mobile.substring(7)};
        }else if(length == 10){
            return new String[]{mobile.substring(0,3),mobile.substring(3,6),mobile.substring(6)};
        }else{
            return new String[]{"","",""};
        }
    }

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrConvertUtil.java
     * - 작성일		: 2021. 02. 01.
     * - 작성자		: 김재윤
     * - 설명			: 어바웃펫 생일  -> GS 생일(YYYYMMDD)
     * </pre>
     */
    private String convert2GsBirth(String birth){
        birth = birth.replaceAll("/[-|/]/g",birth);
        if(birth.length() == 8){
            return birth;
        }else{
            return null;
        }
    }

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrConvertUtil.java
     * - 작성일		: 2021. 02. 01.
     * - 작성자		: 김재윤
     * - 설명			: 어바웃펫 통신사 구분 코드 -> GSR 통신사 구분 코드
     * </pre>
     */
    private String convert2GsMobileCd(String mobileCd){
        String result = "";
        switch (mobileCd){
            case CommonConstants.MOBILE_CD_SKT : result = CommonConstants.GSR_MOBILE_CD_SKT;break;
            case CommonConstants.MOBILE_CD_KT : result = CommonConstants.GSR_MOBILE_CD_KT;break;
            case CommonConstants.MOBILE_CD_LGT : result = CommonConstants.GSR_MOBILE_CD_LG;break;
            case CommonConstants.MOBILE_CD_SKT_CLTH : result = CommonConstants.GSR_MOBILE_CD_SKT;break;
            case CommonConstants.MOBILE_CD_KT_CLTH : result = CommonConstants.GSR_MOBILE_CD_KT;break;
            case CommonConstants.MOBILE_CD_LG_CLTH : result = CommonConstants.GSR_MOBILE_CD_LG;break;
            default : throw new GsrException(ExceptionConstants.ERROR_GSR_API_NECESSARY_FIELD_MEMBER_INFO_TEL_GB,"MOBILE_GB_CD IS NULL",CommonConstants.GSR_INSERT_MEMBER);
        }
        return result;
    }

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrConvertUtil.java
     * - 작성일		: 2021. 02. 01.
     * - 작성자		: 김재윤
     * - 설명			: GSR 고객 정보 -> MemberBaseVO로 변환
     * </pre>
     */
    public MemberBaseVO convertResult2MemberBaseVO(Map<String,Object> result){
        MemberBaseVO vo = new MemberBaseVO();
        if(!result.containsKey("result_code")){
            vo.setGsptNo(result.get("cust_no").toString());
            vo.setMbrNm(result.get("kor_name").toString());
            vo.setGdGbCd(StringUtil.equals(result.get("gender").toString(),CommonConstants.GSR_GENDER_GB_CD_MAN) ?
                    CommonConstants.GD_GB_1 : CommonConstants.GD_GB_0);
            vo.setCiCtfVal(gsrCryptoUtil.urlDecrypt(result.get("ipin_ci_code").toString()));
            vo.setMbrStatCd(StringUtil.equals(result.get("ident_status_code").toString(),CommonConstants.GSR_MEMBER_STATUS_CODE_01) ? CommonConstants.MBR_STAT_10 : "100") ;
            vo.setEmail(result.get("e_mail") + "@" + result.get("e_mail_site"));

            /* 20201.02.04 -> DB의 이메일,SMS 수신 여부 삭제 -> 정보성,혜택성 수신 여부로 변경 */
            /*vo.setEmailRcvYn(result.get("email_yn"));
            vo.setSmsRcvYn(result.get("sms_yn"));*/

            String passwdChgDate = Optional.ofNullable(result.get("passwd_chg_date")).orElseGet(()->(Object)"").toString();
            if(StringUtil.isNotEmpty(passwdChgDate)){
                vo.setPswdChgDtm(DateUtil.getTimestamp(passwdChgDate,CommonConstants.COMMON_DATE_FORMAT));
            }
            vo.setMobile(result.get("hp").toString());
            vo.setGsLoginId(Optional.ofNullable(result.get("id")).orElseGet(()->"").toString());
            vo.setPoint(Optional.ofNullable(result.get("point")).orElseGet(()->"").toString());

            //분리 보관 여부
            vo.setIsSeparateYn(StringUtil.equals(result.get("cust_del_yn").toString(),"S"));
            vo.setCustDelYn(result.get("cust_del_yn").toString());
        }else{
            vo.setResultCode(result.get("result_code").toString());
            vo.setResultMessage(result.get("result_message").toString());
            vo.setGsptNo("");
            vo.setIsSeparateYn(false);
        }
        return vo;
    }

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrConvertUtil.java
     * - 작성일		: 2021. 02. 01.
     * - 작성자		: 김재윤
     * - 설명			: GSR 고객 포인트 정보 -> GsrMemberPointVO로 변환
     * </pre>
     */
    public GsrMemberPointVO convertResult2GsrMemberPointVO(Map<String,Object> map){
        GsrMemberPointVO vo = new GsrMemberPointVO();
        ObjectMapper mapper = new ObjectMapper();
        Set<String> keys = map.keySet();
        Map<String,String> camelMap = new HashMap<>();
        for(String key : keys){
            String camelKey = JdbcUtils.convertUnderscoreNameToPropertyName(key);
            camelMap.put(camelKey,map.get(key).toString());
        }
        vo = mapper.convertValue(camelMap,GsrMemberPointVO.class);
        return vo;
    }

    /** Map을 Json 문자열로 */
    public String convertRequestMap2JsonString(Map<String,String> param){
        JSONObject jsonObject = new JSONObject();
        for( Map.Entry<String, String> entry : param.entrySet() ) {
            String key = entry.getKey();
            String value = entry.getValue();
            jsonObject.put(key, value);
        }
        return jsonObject.toString();
    }

    /** Map을 Json 문자열로 */
    public String convertResponseMap2JsonString(Map<String,Object> map){
        JSONObject jsonObject = new JSONObject();
        for( Map.Entry<String, Object> entry : map.entrySet() ) {
            String key = entry.getKey();
            Object value = entry.getValue();
            jsonObject.put(key, value);
        }
        return jsonObject.toString();
    }
}
