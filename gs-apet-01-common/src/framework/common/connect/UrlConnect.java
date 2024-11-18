package framework.common.connect;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class UrlConnect {

	private URL url = null;
	private HttpURLConnection connection = null;
	private String connectionUrl = null;
	private String params = null;
	private String methodType = null;
	private String charsetName = null;

	public static final String METHOD_POST = "POST";
	public static final String METHOD_GET = "GET";
	public static final String METHOD_PUT = "PUT";
	public static final String METHOD_DELETE = "DELETE";

	public static final String CHARSET_NAME_ECU_KR = "euc-kr";
	public static final String CHARSET_NAME_UTF_8 = "utf-8";

	@SuppressWarnings("static-access")
	public UrlConnect(String connectionUrl) {
		this.connectionUrl = connectionUrl;
		this.methodType = this.METHOD_GET;
		this.charsetName = this.CHARSET_NAME_ECU_KR;
	}

	@SuppressWarnings("static-access")
	public UrlConnect(String connectionUrl, String methodType) {
		this.connectionUrl = connectionUrl;
		this.methodType = methodType;
		this.charsetName = this.CHARSET_NAME_ECU_KR;
	}

	public UrlConnect(String connectionUrl, String methodType, String charsetName) {
		this.connectionUrl = connectionUrl;
		this.methodType = methodType;
		this.charsetName = charsetName;
	}

	/*
	 * URL Connection 생성
	 * 
	 * @see com.stis.framework.connector.DefaultInterface#makeUrl(java.lang.String)
	 */
	@SuppressWarnings("static-access")
	private String execute(String jsonYn) throws IOException {
		String result = "";

		if (this.METHOD_POST.equals(this.methodType)) {
			this.url = new URL(this.connectionUrl);
			this.connection = (HttpURLConnection) url.openConnection();
			this.connection.setDoOutput(true);
		} else {
			this.url = new URL(this.connectionUrl + "?" + this.params);
			this.connection = (HttpURLConnection) url.openConnection();
			this.connection.setDoInput(true);
		}

		this.connection.setFollowRedirects(false);
		this.connection.setRequestMethod(this.methodType);
		this.connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=" + this.charsetName);
		this.connection.setRequestProperty("Content-Length", "" + Integer.toString(this.params.getBytes().length));
		this.connection.setUseCaches(false);

		if (this.METHOD_POST.equals(this.methodType)) {
			//보안 진단. 부적절한 자원 해제 (IO)
			OutputStreamWriter osw = null;
			BufferedWriter wr = null;
			try {
				osw = new OutputStreamWriter(this.connection.getOutputStream(), this.charsetName);
				wr = new BufferedWriter(osw);
				wr.write(this.params);
				wr.flush();
				wr.close();
			} catch (IOException e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			} finally {
				if(osw != null) {
					osw.close();
				}
				if(wr != null) {
					wr.close();
				}
			}
			
		}

		log.debug("URL Connect >>>>>>>>>> " + this.connectionUrl);
		log.debug("Params >>>>>>>>>>> " + this.params);
		log.debug("Method Type >>>>>>> " + this.methodType);

		// 정상일경우
		if (HttpURLConnection.HTTP_OK == connection.getResponseCode()) {
			//보안 진단. 부적절한 자원 해제 (IO)
			BufferedReader rd = null;
			try {
				if (CommonConstants.COMM_YN_Y.equals(jsonYn)) {
					InputStreamReader isr = new InputStreamReader(connection.getInputStream(), this.charsetName);
					JSONObject object = (JSONObject) JSONValue.parseWithException(isr);
					isr.close();
					result = object.toJSONString();
				} else {
					// 내용을 읽어서 화면에 출력한다..
					rd = new BufferedReader(new InputStreamReader(connection.getInputStream(), this.charsetName));
					String line;
					StringBuilder response = new StringBuilder();
					while ((line = rd.readLine()) != null) {
						response.append(line);
					}

					rd.close();
					result = response.toString();
				}
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			} finally {
				if(rd != null) {
					rd.close();
				}
			}
		} else {
			result = "Http Error Status >>>>>>>>>>> " + connection.getResponseCode();
		}

		return result;
	}

	/*
	 * Connection Parameter 생성
	 * 
	 * @see
	 * com.stis.framework.connector.DefaultInterface#makeParam(java.lang.Object)
	 */
	private void makeParam(Object obj, String urlEncodingType) throws IllegalAccessException, UnsupportedEncodingException  {

		StringBuilder param = new StringBuilder();

		if (obj != null) {

			Class<? extends Object> cls = obj.getClass();

			Field[] fieldList = cls.getDeclaredFields();

			if (fieldList.length > 0) {
				for (int i = 0; i < fieldList.length; i++) {
					fieldList[i].setAccessible(true);

					String genericParam = "";

					if (i > 0) {
						genericParam += "&";
					}

					String param_name = fieldList[i].getName();
					String param_value = "";

					if (fieldList[i].get(obj) != null && !"".equals(fieldList[i].get(obj))) {
						if (urlEncodingType != null && fieldList[i].getType() == String.class) {
							param_value = URLEncoder.encode((String) fieldList[i].get(obj), urlEncodingType);
						} else {
							param_value = fieldList[i].get(obj).toString();
						}
					} else {
						param_value = "";
					}

					genericParam += param_name + "=" + param_value;

					param.append(genericParam);
				}
			}

		}

		this.params = param.toString();
	}

	/**
	 * 실행
	 * 
	 * @param Object : Parameter Object
	 * @return
	 * @throws IOException 
	 * @throws IllegalAccessException 
	 * @throws IllegalArgumentException 
	 * @throws Exception
	 */
	public String connect(Object obj) throws IllegalAccessException, IOException  {
		return connect(obj, null);
	}

	/**
	 * 실행
	 * 
	 * @param obj
	 * @param security
	 * @return
	 * @throws IOException 
	 * @throws IllegalAccessException 
	 * @throws IllegalArgumentException 
	 * @throws Exception
	 */
	public String connect(Object obj, String urlEncodingType) throws IOException, IllegalAccessException{
		// Parameter Create
		makeParam(obj, urlEncodingType);
		return execute(CommonConstants.COMM_YN_N);
	}

	/**
	 * 실행
	 * 
	 * @param params
	 * @return
	 * @throws IOException 
	 * @throws Exception
	 */
	public String connect(String params) throws IOException {
		this.params = params;
		return execute(CommonConstants.COMM_YN_N);
	}

	public String connectJson(String params) throws IOException  {
		this.params = params;
		return execute(CommonConstants.COMM_YN_Y);
	}

}
