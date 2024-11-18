package biz.app.member.model;

import biz.app.pet.model.PetDaVO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.ToString;

@Data
public class MemberPetSubVO extends PetDaVO {

    private String id;
    private String name;

    private String daCdNm; // 질병 이름
}

