package biz.interfaces.gsr.model;

import lombok.Data;

import java.io.Serializable;

@Data
public class GsrLnkMapSO implements Serializable {
    private String rcptNo;

    private String ordNo;

    private Long petLogNo;

    private Long goodsEstmNo;

    private String apprNo;

    private String apprDate;
}
