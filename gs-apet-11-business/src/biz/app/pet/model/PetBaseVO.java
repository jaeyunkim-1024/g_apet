package biz.app.pet.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetBaseVO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;

    /*펫 번호*/
    private Long petNo;

    /*회원 번호*/
    private Long mbrNo;

    /*이미지 경로*/
    private String imgPath;

    /*펫 구분 코드*/
    private String petGbCd;

    /*펫 종류 */
    private String petKindNm;

    /*펫 종류(그룹)*/
    private String petKindNms;

    /*펫 이름*/
    private String petNm;
    
    /*펫 이름(그룹)*/
    private String petNms;

    /*펫 성별*/
    private String petGdGbCd;

    /*펫 나이*/
    private String age;

    /*개월수*/
    private String month;

    /*생년월일*/
    private String birth;

    /*몸무게*/
    private Double weight;

    /*대표 여부*/
    private String dlgtYn;

    /*네이버 펫 키*/
    private String naverPetKey;

    /*중성화 여부*/
    private String fixingYn;

    /*알러지 여부*/
    private String allergyYn;

    /*염려질환 여부*/
    private String wryDaYn;

    /* 반려 동물 수 */
    private Integer cnt;
    
    /* 등록일 */
    private String sysRegDt;
    
    /* 접종내역 수 */
    private Integer petInclCnt;
    
    /** 질환 명(콤마) */
    private String diseaseNm;
    
    /** 알러지 명(콤마) */
    private String allergyNm;
    
    /** 나이/생년월일 플래그 구분 */
    private String ageChoose;
    
    /** 세/개월만 입력했을시 나이 배치를 위한 컬럼 */
    private String birthBatch;

    /** 펫 구분 코드*/
    private String petGbCdNm;
    /** 펫_성별_구분_명*/
    private String petGdGbCdNm;
}
