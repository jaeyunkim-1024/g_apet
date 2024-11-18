package framework.admin.binder;

import java.sql.Timestamp;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.InitBinder;

import framework.admin.editor.DoubleEditor;
import framework.admin.editor.IntegerEditor;
import framework.admin.editor.LongEditor;
import framework.admin.editor.TimestampEditor;

@ControllerAdvice
public class CustomInitBinder {

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(Timestamp.class, new TimestampEditor(true));
		binder.registerCustomEditor(Integer.class, new IntegerEditor(true));
		binder.registerCustomEditor(Long.class, new LongEditor(true));
		binder.registerCustomEditor(Double.class, new DoubleEditor(true));
	}

}