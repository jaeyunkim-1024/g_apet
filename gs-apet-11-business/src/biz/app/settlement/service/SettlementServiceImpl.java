package biz.app.settlement.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.contents.model.VodPO;
import biz.app.order.model.OrderDetailPO;
import biz.app.order.model.OrderListExcelVO;
import biz.app.order.model.OrderListVO;
import biz.app.settlement.dao.SettlementDao;
import biz.app.settlement.model.GsPntHistSO;
import biz.app.settlement.model.GsPntHistVO;
import biz.app.settlement.model.SettlementListExcelVO;
import biz.app.settlement.model.SettlementListSO;
import biz.app.settlement.model.SettlementListVO;
import biz.app.settlement.model.SettlementPO;
import biz.app.settlement.model.SettlementSO;
import biz.app.settlement.model.SettlementVO;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;



/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.settlement.service
* - 파일명		: SettlementServiceImpl.java
* - 작성일		: 2017. 6. 20.
* - 작성자		: schoi
* - 설명			:
* </pre>
*/
@Slf4j
@Transactional
@Service("settlementService")
public class SettlementServiceImpl implements SettlementService {

	@Autowired
	private SettlementDao settlementDao;

	@Override
	public List<SettlementVO> pageListSettlement (SettlementSO settlementSO) {
		String selYear = settlementSO.getSelYear();
		String selMon = StringUtil.padLeft(settlementSO.getSelMon(),"0",2);
		if(selYear != null && selYear.length() > 0 && selMon != null && selMon.length() > 0){
			String stlMonth = selYear + selMon;
			settlementSO.setStlMonth(stlMonth);			
		}
		return settlementDao.pageListSettlement(settlementSO);
	}
	
	@Override
	public List<SettlementVO> pageListSettlementDtl (SettlementSO settlementSO) {
		return settlementDao.pageListSettlementDtl(settlementSO);
	}

	@Override
	public void updateSettlementListStlStat(SettlementPO settlementPO) {
		if(settlementPO.getArrStlNo() != null && settlementPO.getArrStlNo().length > 0) {
			for(Long stlNo : settlementPO.getArrStlNo()){
				settlementPO.setStlNo(stlNo);
				settlementPO.setStlStatCd(settlementPO.getStlStatCd());
				int result = settlementDao.updateSettlementListStlStat(settlementPO);
				
				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	@Override
	public List<SettlementVO> pageListSettlementComplete (SettlementSO settlementSO) {
		String selYear = settlementSO.getSelYear();
		String selMon = StringUtil.padLeft(settlementSO.getSelMon(),"0",2);
		if(selYear != null && selYear.length() > 0 && selMon != null && selMon.length() > 0){
			String stlMonth = selYear + selMon;
			settlementSO.setStlMonth(stlMonth);			
		}
		return settlementDao.pageListSettlementComplete(settlementSO);
	}
	
	@Override
	public List<SettlementVO> pageListSettlementCompleteDtl (SettlementSO settlementSO) {
		return settlementDao.pageListSettlementCompleteDtl(settlementSO);
	}
	
	@Override
	public List<SettlementVO> listSettlementCompleteTaxInvoice (SettlementSO settlementSO) {
		if(settlementSO.getArrStlNo() != null && settlementSO.getArrStlNo().length > 0) {
			for(Long stlNo : settlementSO.getStlNos()){
				settlementSO.setStlNo(stlNo);
				settlementSO.setStlNos(settlementSO.getStlNos());
				settlementSO.setCompNos(settlementSO.getCompNos());
				settlementSO.setStIds(settlementSO.getStIds());
				settlementSO.setStlOrders(settlementSO.getStlOrders());
			}
		}
		return settlementDao.listSettlementCompleteTaxInvoice(settlementSO);
	}
	
	@Override
	public void updateSettlementCompletePvdStat(SettlementPO settlementPO) {
		if(settlementPO.getArrStlNo() != null && settlementPO.getArrStlNo().length > 0) {
			for(Long stlNo : settlementPO.getArrStlNo()){
				settlementPO.setStlNo(stlNo);
				settlementPO.setPvdStatCd(settlementPO.getPvdStatCd());
				int result = settlementDao.updateSettlementCompletePvdStat(settlementPO);
				
				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	@Override
	public List<SettlementVO> pageListSettlementInfo (SettlementSO settlementSO) {
		String selYear = settlementSO.getSelYear();
		String selMon = StringUtil.padLeft(settlementSO.getSelMon(),"0",2);
		if(selYear != null && selYear.length() > 0 && selMon != null && selMon.length() > 0){
			String stlMonth = selYear + selMon;
			settlementSO.setStlMonth(stlMonth);			
		}
		return settlementDao.pageListSettlementInfo(settlementSO);
	}

	@Override
	public List<GsPntHistVO> pageGsPntHist(GsPntHistSO so) {
		return settlementDao.pageGsPntHist(so);
	}

	@Override
	public GsPntHistVO getGsPntHistTotal(GsPntHistSO so) {
		return settlementDao.getGsPntHistTotal(so);
	}

	@Override
	@Transactional(readOnly = true)
	public List<SettlementListVO> pageOrderOrgStlm(SettlementListSO so) {
		Integer rownum = 0;
		List<SettlementListVO> baseData = this.settlementDao.pageOrderOrgStlm(so);
		List<SettlementListVO> returnData = new ArrayList<>();

		for (SettlementListVO temp : baseData) {
			int cnt = temp.getOrderDetalListVO().size();
			rownum = 0;

			for (SettlementListVO orderListVO : temp.getOrderDetalListVO()) {

				rownum++;
				orderListVO.setOrdDlvNum(rownum);
				if( "member".equals(so.getSearchTypeExcel()) && rownum != 1) orderListVO.setRealDlvrAmt(0l);  // 엑셀에서 배송비는 첫 상품에만 부과로 표시
				orderListVO.setOrdDlvCnt(cnt);
				orderListVO.setDlvrcNo(temp.getDlvrcNo());

				returnData.add(orderListVO);
			}
		}

		return returnData;
	}

	@Override
	public int batchUpdateStat(List<OrderDetailPO> orderDetailPoList) {
		int updateCnt = 0;
		if(orderDetailPoList != null && !orderDetailPoList.isEmpty()) {
			for(OrderDetailPO po : orderDetailPoList) {
				settlementDao.batchUpdateStat(po);
				updateCnt ++;
			}
		}
		return updateCnt;
	}

	@Override
	@Transactional(readOnly = true)
	public List<SettlementListExcelVO> settlementAdjustExcel(SettlementListSO so) {
		Integer rownum = 0;
		List<SettlementListExcelVO> baseData = this.settlementDao.settlementAdjustExcel(so);
		List<SettlementListExcelVO> returnData = new ArrayList<>();

		for (SettlementListExcelVO temp : baseData) {
			int cnt = temp.getOrderDetalListVO().size();
			rownum = 0;

			for (SettlementListExcelVO orderListVO : temp.getOrderDetalListVO()) {

				rownum++;
				orderListVO.setOrdDlvNum(rownum);
				orderListVO.setOrdDlvCnt(cnt);
				orderListVO.setDlvrcNo(temp.getDlvrcNo());
				orderListVO.setBizNo(StringUtil.bizNo(orderListVO.getBizNo()));
				returnData.add(orderListVO);
			}
		}

		return returnData;
	}
}
