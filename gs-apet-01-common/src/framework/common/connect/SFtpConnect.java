package framework.common.connect;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

public class SFtpConnect {

	protected final Logger logger = LoggerFactory.getLogger(getClass());

	private String server_ip = null;
	private int server_port = 22;
	private String user_id = null;
	private String user_pwd = null;

	private Session session = null;
	private Channel channel = null;
	private ChannelSftp ftp = null;

	public SFtpConnect(String server_ip, int server_port, String user_id, String user_pwd) {
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
	 * @throws JSchException 
	 * @throws Exception
	 */
	private void connect() throws JSchException  {

		JSch jsch = new JSch();

		this.session = jsch.getSession(this.user_id, this.server_ip, this.server_port);
		this.session.setPassword(this.user_pwd);

		Properties config = new Properties();
		config.put("StrictHostKeyChecking", "no");
		this.session.setConfig(config);
		this.session.connect();

		this.channel = this.session.openChannel("sftp");
		this.channel.connect();

		this.ftp = (ChannelSftp) channel;
	}

	/**
	 * <pre>파일 전송 전송파일명을 그대로 전송할 경우</pre>
	 * 
	 * @param org_root
	 * @param org_file
	 * @param server_root
	 * @param server_detail_path
	 * @return (01:연결실패)
	 * @throws IOException 
	 * @throws SftpException 
	 * @throws JSchException 
	 * @throws Exception
	 */
	public void sendFile(String org_root, String org_file, String server_root, String server_detail_path) throws JSchException, SftpException, IOException  {
		sendFile(org_root, org_file, server_root, server_detail_path, org_file);
	}

	/**
	 * <pre>파일 전송 전송파일명과 전송된 파일명이 다른 경우</pre>
	 * 
	 * @param org_root
	 * @param org_file
	 * @param server_root
	 * @param server_detail_path
	 * @param server_file
	 * @return
	 * @throws JSchException 
	 * @throws SftpException 
	 * @throws IOException 
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	public void sendFile(String org_root, String org_file, String server_root, String server_detail_path, String server_file) throws JSchException, SftpException, IOException  {
		

		// ftp 연결
		connect();

		File orgFile = new File(org_root, org_file);

		this.ftp.cd(server_root);

		try {
			this.ftp.mkdir(server_detail_path);
			this.ftp.cd(server_detail_path);
		} catch (Exception e) {
			this.ftp.cd(server_detail_path);
		}
		// 디렉토리 체크 로직 필요
		try(FileInputStream ins = new FileInputStream(orgFile.getPath())){
			this.ftp.put(ins, orgFile.getName());
		}	

		this.ftp.quit();
	}

}