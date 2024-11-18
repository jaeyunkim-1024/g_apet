package framework.common.multipartfile;

import java.io.IOException;
import java.io.InputStream;

import org.springframework.core.io.InputStreamResource;

public class MultipartInputStreamFileResource extends InputStreamResource {

	private String filename;

	public MultipartInputStreamFileResource(InputStream inputStream, String filename) {
		super(inputStream, filename);
		this.filename = filename;
	}

	@Override
	public String getFilename() { 
		return this.filename;
	}

	@Override
	public long contentLength() throws IOException {
		return -1; // we do not want to generally read the whole stream into memory ...
	}
}
