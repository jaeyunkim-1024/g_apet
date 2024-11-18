package biz.app.member.model;

import lombok.Data;

import java.io.Serializable;
import java.util.LinkedHashMap;

@Data
public class NaverApiResultVO implements Serializable {
    private static final long serialVersionUID = -1897387577144361913L;

    private String operationResult;
    private String operationResultMsg;
    private LinkedHashMap<String, Object> contents;

    /* 응답 데이터 중 result */
    public void setResult(String operationResult, String operationResultMsg){
        this.operationResult = operationResult;
        this.operationResultMsg = operationResultMsg;
    }

    /* 응답 데이터 중 Content */
    public void setResultContents(String key, Object value){
        if(contents == null){
            contents = new LinkedHashMap<>();
        }
        this.contents.put(key, value);
    }

}
