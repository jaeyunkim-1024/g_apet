package framework.common.connect;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.SocketException;

import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@Slf4j
public class FtpConnect {

	protected final Logger logger = LoggerFactory.getLogger(getClass());

	private String server_ip = null;
	private int server_port = 21;
	private String user_id = null;
	private String user_pwd = null;
	private FTPClient ftp = null;

	public FtpConnect(String server_ip, int server_port, String user_id, String user_pwd) {
		this.server_ip = server_ip;
		this.server_port = server_port;
		this.user_id = user_id;
		this.user_pwd = user_pwd;
	}

	/**
	 * <pre>FTP 연결</pre>
	 *
	 * @param
	 * @return
	 * @throws IOException 
	 * @throws SocketException 
	 * @throws Exception
	 */
	private String connect() throws IOException  {
		String result = "";

		this.ftp = new FTPClient();
		this.ftp.connect(this.server_ip, this.server_port);
		this.ftp.enterLocalPassiveMode();
		int reply;
		reply = this.ftp.getReplyCode();

		if (!FTPReply.isPositiveCompletion(reply)) {
			this.ftp.disconnect();
			result = "01";
		} else {
			if (!login()) {
				result = "02";
			}
		}

		return result;
	}

	private boolean login() throws IOException{
		return this.ftp.login(this.user_id, this.user_pwd);
	}

	private boolean logout() throws IOException  {
		return this.ftp.logout();
	}

	/**
	 * <pre>파일 전송 전송파일명을 그대로 전송할 경우</pre>
	 * 
	 * @param org_root
	 * @param org_file
	 * @param server_root
	 * @param server_detail_path
	 * @return (01:연결실패, 02:로그인실패, 03:전송파일오류, 04:파일생성실패, 05:서버경로변경실패)
	 * @throws IOException 
	 * @throws SocketException 
	 * @throws Exception
	 */
	public String sendFile(String org_root, String org_file, String server_root, String server_detail_path) throws IOException  {
		return sendFile(org_root, org_file, server_root, server_detail_path, org_file);
	}

	/**
	 * <pre>파일 전송 전송파일명과 전송된 파일명이 다른경우</pre>
	 * 
	 * @param org_root
	 * @param org_file
	 * @param server_root
	 * @param server_detail_path
	 * @param server_file
	 * @return (01:연결실패, 02:로그인실패, 03:전송파일오류, 04:파일생성실패, 05:서버경로변경실패)
	 * @throws IOException 
	 * @throws SocketException 
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	public String sendFile(String org_root, String org_file, String server_root, String server_detail_path, String server_file) throws IOException  {
		String result = "";
		
		boolean res = false;	// 파일 생성 결과
		boolean swd = false;	// 서버 디렉토리 변경 결과

		// ftp 연결
		result = connect();

		if (!"01".equals(result) && !"02".equals(result)) {
			File orgFile = new File(org_root, org_file);
			this.ftp.setFileType(FTP.BINARY_FILE_TYPE);
			try(InputStream ins = new FileInputStream(orgFile.getPath())) {
					boolean aa = this.ftp.changeWorkingDirectory(server_root);
					log.debug(">>>>>>>>>>>>>ftp server change directory=" + server_root + "," + aa);
					boolean ab = this.ftp.makeDirectory(server_detail_path);
					log.debug(">>>>>>>>>>>>>ftp server make directory=" + server_detail_path + "," + ab);
					swd = this.ftp.changeWorkingDirectory(server_root + "/" + server_detail_path);
					log.debug(">>>>>>>>>>>>>ftp server change directory=" + server_root + "/" + server_detail_path + "," + swd);

					if (swd) {
						res = this.ftp.storeFile(orgFile.getName(), ins);

						if (res) {
							result = "00";
						} else {
							result = "04";
						}

					} else {
						result = "05";
					}			
			  } catch (Exception ex) {
				  result = "03";
				  log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, ex);
			  } 

			logout();
			this.ftp.disconnect();
		}

		return result;
	}

}