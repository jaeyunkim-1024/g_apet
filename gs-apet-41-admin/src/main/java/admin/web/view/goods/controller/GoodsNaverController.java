package admin.web.view.goods.controller;

import biz.interfaces.naver.model.NaverEpVO;
import biz.interfaces.naver.service.NaverEpService;
import com.opencsv.CSVWriter;
import com.opencsv.CSVWriterBuilder;
import com.opencsv.bean.*;
import com.opencsv.exceptions.CsvDataTypeMismatchException;
import com.opencsv.exceptions.CsvRequiredFieldEmptyException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.StringWriter;
import java.util.List;

/**
 * <pre>
 *     TODO[상품, 이하정, 20210302] 작업중
 * - 프로젝트명 : workspace
 * - 패키지명   : admin.web.view.goods.controller
 * - 파일명     : GoodsNaverController.java
 * - 작성일     : 2021. 03. 02.
 * - 작성자     : valfac
 * - 설명       : 네이버 EP 정보
 * </pre>
 */


@Slf4j
//@Controller
public class GoodsNaverController {

	@Autowired
	NaverEpService naverEpService;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 네이버 EP 조회
	 * </pre>
	 *
	 * 첫 행은 헤더만 포함
	 * 데이터는 탭으로 구분 ( TSV )
	 * 약속시간 10시 이전에 목록 완료가 되어야 함
	 * 전일 데이터만 유효 (그 이전 데이터는 반영되지 않음)
	 * 당일 주문이 아니더라도 환불/취소주문일 경우 전송
	 * 전체주문의 합산이 마이너스일 경우, 0으로 환산하여 반영
	 * 전일 판매된 상품이 없더라도 헤더값은 무조건 전송해야 함 : 빈 목록으로 보내기
	 * --------------------------------------------------------------------------
	 * mall_id      | 몰상품ID   varchar(50) 영문, 숫자 및 한정된 특수문자 -, _ 만 허용
	 * sale_count   | 판매수량    bigint(6) 정수로 입력, 반품으로 인한 환불처리된 경우 음수
	 * sale_price   | 판매금액    bigint(10)  정수로 입력, 반품으로 인한 환불처리된 경우 음수
	 * order_count  | 주문건수    bigint(6)   정수로 입력, 반품으로 인한 환불처리된 경우 음수
	 * dt           | 판매일자    varchar(10) 1일동안 판매된 총 주문건수 정수로 입력, 반품으로 인한 환불처리된 경우 음수
	 * --------------------------------------------------------------------------
	 * @param model
	 * @return
	 */
	//@RequestMapping( name="/interface/naver-ep.do", method= RequestMethod.GET, produces = MediaType.TEXT_PLAIN_VALUE)
	public void naverEPView(Model model, HttpServletResponse response) throws IOException {
		String[] headers = {"id","title","price_pc","normal_price","link","mobile_link","image_link","add_image_link"
				,"category_name1","category_name2","category_name3","category_name4","naver_category","naver_product_id","condition","import_flag"
				,"parallel_import","order_made","product_flag","adult","model_number","brand","maker","origin","event_words","coupon"
				,"interest_free_event","point","installation_costs","search_tag","minimum_purchase_quantity","review_count","shipping"
				,"delivery_grade","delivery_detail","attribute","age_group","gender"};
		StringBuffer naverInfo = new StringBuffer();
		response.setContentType("text/plain;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");

		List<NaverEpVO> list = naverEpService.getNaverEpInfo();

		HeaderColumnNameMappingStrategy headerStrategy = new HeaderColumnNameMappingStrategy();
		headerStrategy.setType(NaverEpVO.class);

		ColumnPositionMappingStrategy<NaverEpVO> mapStrategy = new ColumnPositionMappingStrategy();
		mapStrategy.setType(NaverEpVO.class);
		//mapStrategy.setColumnMapping(headers);

		StringWriter writer = new StringWriter();
		CSVWriterBuilder builder = new CSVWriterBuilder(writer);
		StatefulBeanToCsv<NaverEpVO> beanToCsv = new StatefulBeanToCsvBuilder<NaverEpVO>(writer)
				.withQuotechar(CSVWriter.NO_QUOTE_CHARACTER)
				.withMappingStrategy(mapStrategy)
				//.withMappingStrategy(headerStrategy)
				.withSeparator('\t')
				.build();

		try {

			beanToCsv.write(list);

			naverInfo.append(StringUtils.join(headers, '\t'));
			naverInfo.append("\n");
			naverInfo.append(writer.toString());

		} catch (CsvDataTypeMismatchException e) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			//e.printStackTrace();
			log.error("##### CsvDataTypeMismatchException When naverEPView", e.getClass());
		} catch (CsvRequiredFieldEmptyException e) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			//e.printStackTrace();
			log.error("##### CsvRequiredFieldEmptyException When naverEPView", e.getClass());
		}

		response.setStatus(HttpServletResponse.SC_OK);
		response.getWriter().write(naverInfo.toString());
		response.getWriter().flush();
	}
}