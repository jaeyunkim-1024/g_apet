package framework.common.model;

import lombok.Data;
import org.springframework.http.HttpMethod;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import java.util.Map;

@Data
public class NaverApiVO {
    private String targetUrl;
    private HttpMethod httpMethod;
    private Map<String, Object> requestParamByPost; // POST param
    private MultiValueMap<String, String> requestParamByPostMult; // POST param
    private MultiValueMap<String, String> requestParamByGet; // GET param
    /** API 인가용 key */
    private String headerApiKey;
    /** store 인가용 key (=) interlockSellerNo (=) affiliate-seller-key */
    private String headerAffiliateSellerKey;
    private String headerContentType;

    // result
    /** 사용자인증토큰 */
    private String token;
    /** 실행결과 ( SUCCESS / FAIL ) */
    private String operationResult;
    /** 네이버회원식별번호 */
    private String interlockMemberIdNo;
    /** 제휴사연동스토어(브랜드)번호  (=) interlockSellerNo (=) affiliate-seller-key*/
    private String interlockSellerNo;
    /** 제휴사회원식별번호 (memberBase의 mbrNo) */
    private String affiliateMemberIdNo;
    /** 연동상태 ( true or false ) */
    private Boolean interlock;
    /** 동의한 약관 식별 번호 목록 */
    private String[] provisionIds;
    /** 추가 약관 식별 번호 목록 */
    private String[] optionIds;

    /** sns */
    private String snsLnkCd;
    /** 네아로 회원 고유 식별자 */
    private String snsUuid;
    /** CI */
    private String ciCtfVal;
    /** 회원 회원사 연동 결과테이블 시퀀스 ( 업데이트 시 사용 ) member_prtn_intlk.intlk_no*/
    private Long intlkNo;
    /** member_base.mbr_no*/
    private Long mbrNo;
    /** member_prtn_intlk.pet_prtn_cd*/
    private String petPrtnCd;

    /** 회원연동 시 이미 SNS로 가입된 인원은 U / 신규가입된 인원은 I */
    private String status;

    /** 신규(insert) / 수정(upate)  */
    private String workType;

    /** 호출 사이트 구분 (네이버톡톡, 어바웃펫) */
    private String siteGb;

    public void setRequestParamByPostMult(Map<String, Object> map){
        this.requestParamByPostMult = new LinkedMultiValueMap<String, String>();
        for(Map.Entry<String, Object> entry : map.entrySet()){
            System.out.println(entry.getKey() +" / "+(String) entry.getValue());
            this.requestParamByPostMult.add(entry.getKey(), (String) entry.getValue());
        }
    }

    public void setRequestParamByGet(Map<String, Object> map){
        this.requestParamByGet = new LinkedMultiValueMap<String, String>();
        for(Map.Entry<String, Object> entry : map.entrySet()){

            if(entry.getValue() instanceof Integer){
                this.requestParamByGet.add(entry.getKey(), String.valueOf((Integer) entry.getValue()));
            }else if(entry.getValue() instanceof String){
                this.requestParamByGet.add(entry.getKey(), (String) entry.getValue());
            }
        }
    }


}
