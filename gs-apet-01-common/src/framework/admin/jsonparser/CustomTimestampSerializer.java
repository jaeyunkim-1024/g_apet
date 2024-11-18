package framework.admin.jsonparser;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.TimeZone;

public class CustomTimestampSerializer extends JsonSerializer<Timestamp> {

	public static final SimpleDateFormat FORMATTER = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	//public static final Locale LOCALE_HUNGARIAN = new Locale("ko", "KO");
	public static final TimeZone LOCAL_TIME_ZONE = TimeZone.getDefault();


	@Override
	public void serialize(Timestamp value, JsonGenerator gen, SerializerProvider serializers)
			throws IOException, JsonProcessingException {
		if (value == null) {
			gen.writeNull();
		} else {
			FORMATTER.setTimeZone(LOCAL_TIME_ZONE);
			gen.writeString(FORMATTER.format(value.getTime()));
		}
	}
}