package biz.interfaces.gsr.util;

import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.CryptoUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.net.URLDecoder;
import java.net.URLEncoder;

@Slf4j
@Component
public class GsrCryptoUtil {
    private final String CRYPTO_ALGORITHM_3DES = "DESede";
    private final String CRYPTO_ALGORITHM_SHA256 = "SHA-256";

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrConvertUtil.java
     * - 작성일		: 2021. 02. 02.
     * - 작성자		: 김재윤
     * - 설명			: 비밀번호 암호화 ( 웹 비밀번호 -> SHA256 , 카드 비밀번호 -> SHA256,3DES)
     * </pre>
     */
    public String pswdEncrypt(String pswd,String algorithm){
        if(algorithm.equals(CRYPTO_ALGORITHM_3DES)){
            return CryptoUtil.encryptDES3(pswd);
        }else if(algorithm.equals(CRYPTO_ALGORITHM_SHA256)){
            return CryptoUtil.encryptSHA256_CRM(pswd);
        }else{
            throw new CustomException(ExceptionConstants.ERROR_CODE_FRONT_DEFAULT);
        }
    }

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrConvertUtil.java
     * - 작성일		: 2021. 02. 02.
     * - 작성자		: 김재윤
     * - 설명			: 비밀번호 복호화 ( 카드 비밀번호 -> 3DES)
     * </pre>
     */
    public String pswdDecrypt(String pswd,String algorithm){
        if(algorithm.equals(CRYPTO_ALGORITHM_3DES)){
            return CryptoUtil.decryptDES3(pswd);
        }else{
            throw new CustomException(ExceptionConstants.ERROR_CODE_FRONT_DEFAULT);
        }
    }

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrConvertUtil.java
     * - 작성일		: 2021. 02. 02.
     * - 작성자		: 김재윤
     * - 설명			: CI 값 -> URL 인코딩
     * </pre>
     */
    public String urlEncrypt(String ci){
        return URLEncoder.encode(ci);
    }

    /**
     * <pre>
     * - 프로젝트명	: 11.business
     * - 패키지명		: biz.app.gsr.service
     * - 파일명		: GsrConvertUtil.java
     * - 작성일		: 2021. 02. 02.
     * - 작성자		: 김재윤
     * - 설명			: CI 값 -> URL 디코딩
     * </pre>
     */
    public String urlDecrypt(String ci){
        return URLDecoder.decode(ci);
    }
}
