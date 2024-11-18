package framework.common.util;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.builder.api.DefaultApi20;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.nimbusds.jose.JOSEException;
import com.nimbusds.jose.JWSVerifier;
import com.nimbusds.jose.crypto.RSASSAVerifier;
import com.nimbusds.jose.jwk.JWK;
import com.nimbusds.jose.jwk.RSAKey;
import com.nimbusds.jwt.ReadOnlyJWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import framework.cis.model.request.ApiRequest;
import framework.common.constants.CommonConstants;
import framework.front.constants.FrontConstants;
import lombok.extern.slf4j.Slf4j;
import org.bouncycastle.util.io.pem.PemObject;
import org.bouncycastle.util.io.pem.PemReader;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;
import java.io.FileReader;
import java.io.IOException;
import java.math.BigInteger;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.InvalidKeySpecException;
import java.sql.Date;
import java.text.ParseException;
import java.util.*;

@Slf4j
@Component
public class AppleLoginUtil extends DefaultApi20 implements SnsLoginUtil{
    @Autowired
    private Properties bizConfig;
    private String sessionState;

    /*서비스 아이디*/
    private String clientId;
    private String scope;
    private String nonce;
    private String responseType;
    private String responseMode;

    private String redirectUri;
    private String authorizeApiUri;
    private String tokenApiUri;
    private String keyUri;

    private String appleUri;

    private String teamId;
    private String keyId;

    @PostConstruct
    public void init() {
        this.sessionState = FrontConstants.SESSION_STATE_APPLE;
        this.clientId = this.bizConfig.getProperty("apple.client.id");
        this.scope = "name email";
        this.responseType = "code id_token";
        this.responseMode= "form_post";
        this.redirectUri = bizConfig.getProperty("apple.redirect.uri");
        this.authorizeApiUri = "https://appleid.apple.com/auth/authorize";
        this.tokenApiUri = "https://appleid.apple.com/auth/token";
        this.keyUri = "https://appleid.apple.com/auth/keys";
        this.appleUri = "https://appleid.apple.com";
        this.teamId = bizConfig.getProperty("apple.team.id");
        this.keyId = bizConfig.getProperty("apple.key.id");
    }

    @Override
    public String getAccessTokenEndpoint() {
        return this.tokenApiUri;
    }

    @Override
    protected String getAuthorizationBaseUrl() {
        return this.authorizeApiUri;
    }

    @Override
    public String getLoginAuthorizationUrl(HttpSession session) {
        // 상태 토큰으로 사용할 랜덤 문자열 생성
        this.nonce = generateState();
        String goUrl = this.authorizeApiUri
                +"?client_id="+this.clientId
                +"&redirect_uri="+this.redirectUri
                +"&response_type="+responseType
                +"&response_mode="+responseMode
                +"&scope="+this.scope
                +"&nonce="+this.nonce;
        return goUrl;
    }

    @Override
    public OAuth2AccessToken getAccessToken(HttpSession session, String id_token, String state, String type) {
        return getAccessToken(session,id_token);
    }
    
    //Apple 간편 로그인 -> 통신 보안을 위한 state값(=nonce)는 payload 안에 존재
    private OAuth2AccessToken getAccessToken(HttpSession session,String id_token){
        Boolean validate = false;
        try{
            SignedJWT signedJWT = SignedJWT.parse(id_token);
            ReadOnlyJWTClaimsSet payload = signedJWT.getJWTClaimsSet();

            // EXP
            Date currentTime = new Date(System.currentTimeMillis());
            if (!currentTime.before(payload.getExpirationTime())) {
                validate = false;
            }
            //iss , aud 및 임시 상태값 확인
            if (!this.nonce.equals(payload.getClaim("nonce")) || !this.appleUri.equals(payload.getIssuer()) || !this.clientId.equals(payload.getAudience().get(0))) {
                validate =  false;
            }
            // RSA 해싱 검증 통과
            validate =  verifyPublicKey(signedJWT);
        }catch(ParseException pe){
            log.error("#### Parse Error Jwt And PayLoad");
            validate = false;
        }catch(Exception e){
            log.error("#### Failed Get Access Token {}",e.getClass());
            log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
            validate = false;
        }

        if(!validate) {
            session.invalidate();
        }

        return validate ? new OAuth2AccessToken(id_token,null) : null;
    }

    @Override
    public Map<String, String> getUserProfile(OAuth2AccessToken oauthToken) {
        Map<String,String> user = new HashMap<String,String>();
        try{
            String id_token = Optional.ofNullable(oauthToken).orElseThrow(()->new NullPointerException()).getAccessToken();
            SignedJWT signedJWT = SignedJWT.parse(id_token);
            ReadOnlyJWTClaimsSet payload = signedJWT.getJWTClaimsSet();
            Map<String,String> result = new ObjectMapper().readValue(payload.toJSONObject().toJSONString(),Map.class);

            user.put("email",result.get("email"));          // 유저 정보
            user.put("uuid",result.get("sub"));              // 고유 식별값
        }catch (NullPointerException npe){
            log.error("######## appleLoginApi InValid Token");
            log.error("######## appleLoginApi Caused By Token is NULL");
        }
        catch(Exception e){
            log.error("appleLoginApi getUserProfile error : {}", e);
        }

        return user;
    }
    
    //id_token header 내부 exp->id_token 만료 기간 ,iss->apple ,aud->Service ID,nonce,RSA 값들 유효성 검사
    private boolean verifyPublicKey(SignedJWT signedJWT) {
        boolean result = false;
        try{
            String publicKeys = getPublicKey();
            ObjectMapper objectMapper = new ObjectMapper();
            TypeReference<Map<String, List<Map<String,String>>>> type = new TypeReference<Map<String,List<Map<String,String>>>>() {};
            Map<String, List<Map<String,String>>> obj = objectMapper.readValue(publicKeys, type);
            List<Map<String,String>> keys = obj.get("keys");

            for (Map<String,String> key : keys) {
                RSAKey rsaKey = (RSAKey) JWK.parse(objectMapper.writeValueAsString(key));
                RSAPublicKey publicKey = rsaKey.toRSAPublicKey();
                JWSVerifier verifier = new RSASSAVerifier(publicKey);
                if (signedJWT.verify(verifier)){
                    result = true;
                    break;
                }
            }
            return result;
        }catch(JsonProcessingException jpe){
            return false;
        }catch(IOException ioe){
            return false;
        }catch(ParseException pe){
            return false;
        }catch(NoSuchAlgorithmException nae){
            return false;
        }catch(InvalidKeySpecException ie){
            return false;
        }catch(JOSEException je){
            return false;
        }
    }
    
    //id_token 복호화 위한 공개키 가져오기
    private String getPublicKey(){
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type","application/x-www-form-urlencoded");
        HttpEntity<ApiRequest> entity = new HttpEntity<ApiRequest>(headers);

        org.codehaus.jackson.map.ObjectMapper om = new org.codehaus.jackson.map.ObjectMapper();
        HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
        factory.setConnectTimeout(20*1000); // 읽기시간초과, ms
        factory.setReadTimeout(20*1000); // 연결시간초과, ms

        RestTemplate restTemplate = new RestTemplate(factory);
        ResponseEntity<String> responseEntity = restTemplate.exchange(this.keyUri, HttpMethod.GET, entity, String.class);
        return Optional.ofNullable(responseEntity.getBody()).orElseGet(()->"");
    }

    /*
        20201.01.14 기준 clientSecret 현재 프로세스 상 필요 없음
        필요 시, 다음 항목 필요
          - 애플 계정 등록 시 발급 받은 KEY_ID
          - 애플 계정 등록 시 등록 한 해당 APP(혹은 프로그램) ID(=TEAMS_ID)
          - 다운로드 받은  AuthKey_[KEY_ID].p8 파일
     */
    private String generateClientSecret() {
        /*
        JWSHeader header = new JWSHeader.Builder(JWSAlgorithm.ES256).keyID(keyId).build();
        JWTClaimsSet claimsSet = new JWTClaimsSet();
        Date now = new Date();

        claimsSet.setIssuer(TEAM_ID);
        claimsSet.setIssueTime(now);
        claimsSet.setExpirationTime(new Date(now.getTime() + 3600000));
        claimsSet.setAudience(this.appleUri);
        claimsSet.setSubject(this.clientId);

        SignedJWT jwt = new SignedJWT(header, claimsSet);

        try {
            ECPrivateKey ecPrivateKey = new ECPrivateKeyImpl(getKeyAuthFile(AuthKey 파일 경로));
            JWSSigner jwsSigner = new ECDSASigner(ecPrivateKey.getS());

            jwt.sign(jwsSigner);

        } catch (InvalidKeyException e) {
            log.error("appleLoginApi generateClientSecret - Not Invalid Key error : {}", e);
        } catch (JOSEException e) {
            log.error("appleLoginApi generateClientSecret - JOSEException error : {}", e);
        }

        return jwt.serialize();
        */
        return "";
    }
    
    // AuthKey_[KEY_ID].p8 파일 가져오기
    private byte[] getKeyAuthFile(String path){
        Resource resource = new ClassPathResource(path);
        byte[] content = null;

        try (FileReader keyReader = new FileReader(resource.getURI().getPath());
             PemReader pemReader = new PemReader(keyReader)) {
            {
                PemObject pemObject = pemReader.readPemObject();
                content = pemObject.getContent();
            }
        } catch (IOException e) {
            // 보안성 진단. 오류메시지를 통한 정보노출
        	//e.printStackTrace();
        	log.error("##### IOException When getKeyAuthFile", e.getClass());
        }

        return new byte[]{};
    }

    //TO-DO :: 검증 필요 , client_secret 필요
    @Override
    public String refreshToken(String client_secret) {
        String result = "";
        Map<String, String> param = new HashMap<>();
        param.put("client_id", this.clientId);
        param.put("client_secret", client_secret);
        param.put("grant_type", "refresh_token");
        param.put("refresh_token", null);

        HttpEntity<?> entity;
        ResponseEntity<String> responseEntity;
        String serverUrl = this.tokenApiUri;

        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type","application/x-www-form-urlencoded");
        entity = new HttpEntity<Map<String, String>>(param, headers);

        log.info("Request Header :{}", entity.getHeaders());
        log.info("Request body :{}", entity.getBody());

        HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
        factory.setConnectTimeout(10*1000); // 읽기시간초과, ms
        factory.setReadTimeout(10*1000); // 연결시간초과, ms

        RestTemplate restTemplate = new RestTemplate(factory);
        responseEntity = restTemplate.exchange(serverUrl, HttpMethod.POST, entity, String.class);

        try{
            JSONObject json = new ObjectMapper().readValue(responseEntity.getBody(),JSONObject.class);
            result = json.get("id_token").toString();
        }catch(JsonParseException jpe){
            log.error("##### Parse Error : {}",responseEntity.getBody());
        }catch(IOException ioe){
            log.error("##### IOException When Parse Response");
        }
        return result;
    }

    @Override
    public String deleteAccessToken(String accessToken, String refreshToken) {
        return "";
    }

    @Override
    public String getMypageAuthorizationUrl(HttpSession session) {
        return "";
    }

    @Override
    public String getPopupLoginAuthorizationUrl(HttpSession session) {
        return "";
    }

    public String generateState()
    {
        SecureRandom random = new SecureRandom();
        return new BigInteger(130, random).toString(32);
    }
}
