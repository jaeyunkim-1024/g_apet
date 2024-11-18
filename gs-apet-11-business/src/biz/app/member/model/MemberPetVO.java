package biz.app.member.model;

import framework.common.model.BaseSysVO;
import lombok.Data;

import java.util.ArrayList;

@Data
public class MemberPetVO extends BaseSysVO {
    
    private static final long serialVersionUID = 5175443118332878455L;
    private Long petNo;
    private Long mbrNo;
    private String partnerCd;

    private String name; //펫이름
    private String type; // 종류 - DOG|CAT
    private String breedName; // 품종명 (ex. 킴릭, 쿠리리안밥테일 등)
    private String birthday; // 생년월일 (format. yyyyMMdd)
    private String gender; // 성별 - F|M
    private String imageUrl; // 펫 이미지URL
    private String neutralized; // 중성화여부 (신규 필드, Optional)
    private Double weight; // 몸무게(kg)  (신규 필드, Optional)
    private String createdAt; // 등록일시
    private String updatedAt; // 변경일시

    private String allergyYn;
    private String fixingYn;
    private String wryDaYn;

    private ArrayList<MemberPetSubVO> features;
    private ArrayList<MemberPetSubVO> allergies;

    public void addFeatures(MemberPetSubVO vo){
        if(this.features == null) this.features  = new ArrayList<>();

        this.features.add(vo);
    }

    public void addAllergies(MemberPetSubVO vo){

        if(this.allergies == null) this.allergies  = new ArrayList<>();

        this.allergies.add(vo);
    }


}
