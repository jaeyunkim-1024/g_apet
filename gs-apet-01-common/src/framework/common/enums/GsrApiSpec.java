package framework.common.enums;

import framework.common.constants.CommonConstants;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpMethod;

@Getter
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public enum GsrApiSpec {

    /** 회원 등록*/
    GSR_INSERT_MEMBER(
                CommonConstants.GSR_INSERT_MEMBER
            ,   HttpMethod.POST
            ,   CommonConstants.GSR_WSDL_CUSTOMER
            ,   CommonConstants.GSR_API_SYSTEM_CRM
            ,   CommonConstants.GSR_API_CONTENT_TP
            ),

    /** 회원 가입 가능 여부 및 수정*/
    GSR_CHECK_IS_JOIN_OR_UPDATE(
                CommonConstants.GSR_CHECK_JOIN_OR_UPDATE
            ,   HttpMethod.POST
            ,   CommonConstants.GSR_WSDL_CUSTOMER
            ,   CommonConstants.GSR_API_SYSTEM_CRM
            ,   CommonConstants.GSR_API_CONTENT_TP
            ),

    /** 고객 정보 조회*/
    GSR_SELECT_MEMBER_INFO(
                CommonConstants.GSR_SELECT_MEMBER
            ,   HttpMethod.POST
            ,   CommonConstants.GSR_WSDL_CUSTOMER
            ,   CommonConstants.GSR_API_SYSTEM_CRM
            ,   CommonConstants.GSR_API_CONTENT_TP
            ),

    /** 회원 분리 보관 복원*/
    GSR_INSERT_SEAPRATE_MEMBER_STORAGE(
                CommonConstants.GSR_RECOVER_SEPARATE_MEMBER_STORAGE
            ,   HttpMethod.POST
            ,   CommonConstants.GSR_WSDL_CUSTOMER
            ,   CommonConstants.GSR_API_SYSTEM_CRM
            ,   CommonConstants.GSR_API_CONTENT_TP
            ),

    /** 포인트 적립 사용*/
    GSR_SAVE_MEMBER_POINT(
                CommonConstants.GSR_SAVE_MEMBER_POINT
            ,   HttpMethod.POST
            ,   CommonConstants.GSR_WSDL_POINT
            ,   CommonConstants.GSR_API_SYSTEM_CRM
            ,   CommonConstants.GSR_API_CONTENT_TP
            ),

    /** 고객 포인트 조회*/
    GSR_SELECT_MEMBER_POINT(
                CommonConstants.GSR_SELECT_MEMBER_POINT
            ,   HttpMethod.POST
            ,   CommonConstants.GSR_WSDL_POINT
            ,   CommonConstants.GSR_API_SYSTEM_CRM
            ,   CommonConstants.GSR_API_CONTENT_TP
            ),

    /** 고객 카드 포인트 상세 조회*/
    GSR_SELECT_MEMBER_CPOINT(
                CommonConstants.GSR_SELECT_MEMBER_CPOINT
            ,   HttpMethod.POST
            ,   CommonConstants.GSR_WSDL_POINT
            ,   CommonConstants.GSR_API_SYSTEM_CRM
            ,   CommonConstants.GSR_API_CONTENT_TP
            ),
    ;

    private String serviceName;
    private HttpMethod httpMethod;
    private String wsdl;
    private String systemType;
    private String contentType;
}
