package biz.interfaces.gsr.model;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class GsrException extends RuntimeException{
    private String	exCode;

    private Object param;

    private String gsrLnkCd;

    private String reqParam;

    public GsrException(String exCode,Object param,String gsrLnkCd) {
        this.exCode = exCode;
        this.param = param;
        this.gsrLnkCd = gsrLnkCd;

        String reqParam = "";
        try{
            reqParam = new ObjectMapper().writeValueAsString(param);
        }catch(JsonProcessingException jpe){
            reqParam = jpe.getMessage();
        }
        this.reqParam = reqParam;
    }

    public String getExCode() {
        return this.exCode;
    }

    public Object getParam(){
        return this.param;
    }

    public String getReqParam(){
        return this.reqParam;
    }

    public String getGsrLnkCd(){
        return this.gsrLnkCd;
    }
}
