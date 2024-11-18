package framework.admin.jsonparser;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

public class CustomTimestampDeserializer extends JsonDeserializer<Timestamp> {

	@Override
	public Timestamp deserialize(JsonParser jsonparser, DeserializationContext context)
			throws IOException, JsonProcessingException {
		String dateAsString = jsonparser.getText();
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			dateFormat.setTimeZone(TimeZone.getDefault());
			Date parsedDate = dateFormat.parse(dateAsString);
			Timestamp timestamp = new Timestamp(parsedDate.getTime());
			return timestamp;
		} catch (ParseException e) {
			throw new RuntimeException(e);
		}
	}
}