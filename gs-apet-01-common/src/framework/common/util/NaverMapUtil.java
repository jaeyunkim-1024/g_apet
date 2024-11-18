package framework.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * <pre>
 * - 프로젝트명	: 01.common
 * - 패키지명		: framework.common.util
 * - 파일명		: NaverMapUtil.java
 * - 작성일		: 2020. 12. 28.
 * - 작성자		: LDS
 * - 설명			: 네이버 지도 API 호출
 * </pre>
 */
@Component
public class NaverMapUtil {

	@Autowired
	private Properties bizConfig;
	
	private String clientId;
	private String clientSecret;
	
	@PostConstruct
	public void init() {
		this.clientId = this.bizConfig.getProperty("naver.cloud.client.id"); //애플리케이션 클라이언트 아이디값"
		this.clientSecret = this.bizConfig.getProperty("naver.cloud.client.secret"); //애플리케이션 클라이언트 시크릿값"
	}
	
	/**
	 * 주소 정보 검색
	 * 지번, 도로명을 사용해서 주소 세부정보를 검색
	 * 
	 * @param srchText
	 * @param lat
	 * @param lon
	 * @return
	 */
    public String geocoding(String srchText, String lat, String lon) {
        String text = null;
        try {
            text = URLEncoder.encode(srchText, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패", e);
        }

        String query = "query="+text;
        String coordinate = "";
        
        if(StringUtil.isNotEmpty(lat) && StringUtil.isNotEmpty(lon)) {
        	coordinate = "&coordinate="+lon+","+lat;
        }
        
        String apiURL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?"+ query + coordinate;

        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-NCP-APIGW-API-KEY-ID", clientId);
        requestHeaders.put("X-NCP-APIGW-API-KEY", clientSecret);
        String responseBody = get(apiURL,requestHeaders);

        return responseBody;
    }
	
    /**
     * 좌표 -> 주소 변환
     * 좌표에 해당하는 법정동/행정동/지번주소/도로명주소 정보 조회
     * 
     * @param lat
     * @param lon
     * @return
     */
    public String coordToAddr(String lat, String lon) {
        String apiURL = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords="+lon+","+lat+"&sourcecrs=epsg:4326&output=json&orders=legalcode,addr,admcode,roadaddr";

        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-NCP-APIGW-API-KEY-ID", clientId);
        requestHeaders.put("X-NCP-APIGW-API-KEY", clientSecret);
        String responseBody = get(apiURL,requestHeaders);
        
        return responseBody;
    }
	
    private static String get(String apiUrl, Map<String, String> requestHeaders){
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }

            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return readBody(con.getInputStream());
            } else { // 에러 발생
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }

    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }

    private static String readBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);

        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();

            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }

            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
        }
    }

}
