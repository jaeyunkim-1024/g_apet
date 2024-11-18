package admin.web.view.system.controller;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.appweb.model.NoticeSendCommonVO;
import biz.app.appweb.model.NoticeSendListDetailVO;
import biz.app.appweb.model.NoticeSendSO;
import biz.app.appweb.service.PushService;
import com.fasterxml.jackson.databind.ObjectMapper;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.model.ExcelViewParam;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@Slf4j
@Controller
public class NoticeController {
    @Autowired
    private PushService pushService;

    /**
     * <pre>
     * - 프로젝트명	: 41.admin.web
     * - 파일명		: NoticeController.java
     * - 작성일		: 2021. 01. 07.
     * - 작성자		: valueFactory
     * - 설명		: 휴면 안내
     * </pre>
     * @param model
     * @return
     */
    @RequestMapping("/system/sleepMemberListView.do")
    public String sleepMemberListView(Model model){
        model.addAttribute("sysCd", AdminConstants.SYS_MEMBER_DORMANT);
        return "/system/noticeSendListView";
    }

    /**
     * <pre>
     * - 프로젝트명	: 41.admin.web
     * - 파일명		: NoticeController.java
     * - 작성일		: 2021. 01. 07.
     * - 작성자		: valueFactory
     * - 설명		: 마케팅정보 수신동의 내역
     * </pre>
     * @param model
     * @return
     */
    @RequestMapping("/system/marketingListView.do")
    public String  marketingListView(Model model){
        model.addAttribute("sysCd", AdminConstants.SYS_GB_CD_TMPL + "_0" + AdminConstants.TERMS_GB_40);
        return "/system/noticeSendListView";
    }

    /**
     * <pre>
     * - 프로젝트명	: 41.admin.web
     * - 파일명		: NoticeController.java
     * - 작성일		: 2021. 01. 07.
     * - 작성자		: valueFactory
     * - 설명		: 개인정보 이용 내역 통지
     * </pre>
     * @param model
     * @return
     */
    @RequestMapping("/system/prsnlInfoHistListView.do")
    public String  prsnlInfoHistListView(Model model){
        String[] sysCds = {
                        AdminConstants.SYS_GB_CD_TMPL+"_0"+AdminConstants.TERMS_GB_20 , AdminConstants.SYS_GB_CD_TMPL+"_0"+AdminConstants.TERMS_GB_30
                    ,   AdminConstants.SYS_GB_CD_TMPL+"_0"+AdminConstants.TERMS_GB_50 , AdminConstants.SYS_GB_CD_TMPL+"_0"+AdminConstants.TERMS_GB_60
                    ,   AdminConstants.SYS_GB_CD_TMPL+"_0"+AdminConstants.TERMS_GB_70 , AdminConstants.SYS_GB_CD_TMPL+"_0"+AdminConstants.TERMS_GB_80
                    ,   AdminConstants.SYS_GB_CD_TMPL+"_0"+AdminConstants.TERMS_GB_90
        };
        model.addAttribute("sysCds",sysCds);
        return "/system/noticeSendListView";
    }

    /**
     * <pre>
     * - 프로젝트명	: 41.admin.web
     * - 파일명		: NoticeController.java
     * - 작성일		: 2021. 01. 11.
     * - 작성자		: valueFactory
     * - 설명		: 데이터 3법 관련 이용 내역 통지
     * </pre>
     * @param model
     * @return
     */
    @RequestMapping(value="/system/dataThreeLaws.do")
    public String dataThreeLaws(Model model){
        String[] sysCds = {
                    AdminConstants.SYS_GB_CD_DATA_LAW + AdminConstants.DATA_LAW_PERSONAL_INFO
                ,   AdminConstants.SYS_GB_CD_DATA_LAW + AdminConstants.DATA_LAW_CREDIT
                ,   AdminConstants.SYS_GB_CD_DATA_LAW + AdminConstants.DATA_LAW_INFO_CMNC
        };
        model.addAttribute("sysCds",sysCds);
        return "/system/noticeSendListView";
    }

    /**
     * <pre>
     * - 프로젝트명	: 41.admin.web
     * - 파일명		: NoticeController.java
     * - 작성일		: 2021. 01. 07.
     * - 작성자		: valueFactory
     * - 설명		: 일자별 발송 내역
     * </pre>
     * @return
     */
    @ResponseBody
    @RequestMapping("/system/pageNoticeSendListByDailiy.do")
    public GridResponse pageNoticeSendListByDailiy(NoticeSendSO so){
        so.setCtgCd(AdminConstants.CTG_30);
        so.setSidx("ROW_NUM");
        so.setSord("DESC");
        List<NoticeSendCommonVO> list =pushService.pageNoticeSendListByDailiy(so);
        /*Integer rowNum = so.getTotalCount() - (((int)so.getPage()-1)*so.getRows());;
        for(NoticeSendCommonVO v : list){
            v.setRowNum(Long.parseLong(rowNum.toString()));
            rowNum -=1;
        }*/
        return new GridResponse(list,so);
    }

    /**
     * <pre>
     * - 프로젝트명	: 41.admin.web
     * - 파일명		: NoticeController.java
     * - 작성일		: 2021. 01. 07.
     * - 작성자		: valueFactory
     * - 설명		: 대상자별 발송 내역
     * </pre>
     * @return
     */
    @ResponseBody
    @RequestMapping("/system/pageMemberSendHist.do")
    public GridResponse pageMemberSendHist(NoticeSendSO so){
        so.setCtgCd(AdminConstants.CTG_30);
        so.setSidx("ROW_NUM");
        so.setSord("DESC");
        List<NoticeSendCommonVO> list =pushService.pageNoticeSendListForMbr(so);
        /*Integer rowNum = so.getTotalCount() - (((int)so.getPage()-1)*so.getRows());
        for(NoticeSendCommonVO v : list){
            v.setRowNum(Long.parseLong(rowNum.toString()));
            rowNum -=1;
        }*/
        return new GridResponse(list,so);
    }

    /**
     * <pre>
     * - 프로젝트명	: 41.admin.web
     * - 파일명		: NoticeController.java
     * - 작성일		: 2021. 01. 07.
     * - 작성자		: valueFactory
     * - 설명		: 대상자별 발송 내역 상세 팝업
     * </pre>
     * @return
     */
    @RequestMapping("/system/noticeDetailLayerPop.do")
    public String noticeDetailLayerPop(Model model,NoticeSendCommonVO vo){
        model.addAttribute("vo",vo);
        model.addAttribute("sndInfo",convertSndInfo(Optional.ofNullable(vo.getSndInfo()).orElseGet(()->"")));
        return "/system/noticeDetailLayerPop";
    }
    
    //전송 정보(JSON) 변환
    private Map convertSndInfo(String sndInfo){
        Map<String,String> result = new HashMap<String,String>();
        if(StringUtil.isNotEmpty(sndInfo)){
            try{
                result = new ObjectMapper().readValue(sndInfo, Map.class);
            }catch(Exception e){
                log.error("### SEND INFO CONVERT ERROR ###");
                // 보안성 진단. 오류메시지를 통한 정보노출
                //log.error("{}",e.getMessage());
            }
        }
        return result;
    }

    /**
     * <pre>
     * - 프로젝트명	: 41.admin.web
     * - 파일명		: NoticeController.java
     * - 작성일		: 2021. 01. 11.
     * - 작성자		: valueFactory
     * - 설명		:날짜별 발송 내역 엑셀 다운로드
     * </pre>
     * @return
     */
    @RequestMapping("/system/noticeSendListExcelDownload.do")
    public String noticeSendListExcelDownload(NoticeSendSO so , Model model){
        so.setRows(999999999);

        List<NoticeSendCommonVO> list = new ArrayList<NoticeSendCommonVO>();
        so.setCtgCd(AdminConstants.CTG_30);
        list = pushService.pageNoticeSendListByDailiy(so);

        String[] headerName = {"발송일","대상자 수","발송 수단","제목","발송 결과"};
        String[] fieldName = {"sendReqDtm","cnt","sndTypeNm","subject","sndRstNm"};

        model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("NoticeSendList", headerName, fieldName, list));
        model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "NoticeSendList");

        return View.excelDownload();
    }

    /**
     * <pre>
     * - 프로젝트명	: 41.admin.web
     * - 파일명		: NoticeController.java
     * - 작성일		: 2021. 01. 11.
     * - 작성자		: valueFactory
     * - 설명		:대상자별 발송 내역 엑셀 다운로드
     * </pre>
     * @return
     */
    @RequestMapping("/system/memberSendHistListExcelDownload.do")
    public String memberSendHistListExcelDownload(NoticeSendSO so , Model model){
        so.setRows(999999999);

        List<NoticeSendCommonVO> list = new ArrayList<NoticeSendCommonVO>();
        so.setCtgCd(AdminConstants.CTG_30);
        list = pushService.pageNoticeSendListForMbr(so);
        for(NoticeSendCommonVO v : list){
            if(StringUtil.equals(v.getSndTypeCd(),AdminConstants.SND_TYPE_40)){
                v.setReceiverInfo(v.getReceiverEmail());
            }else if(StringUtil.equals(v.getSndTypeCd(),AdminConstants.SND_TYPE_10) || StringUtil.equals(v.getSndTypeCd(),AdminConstants.SND_TYPE_20)
                    || StringUtil.equals(v.getSndTypeCd(),AdminConstants.SND_TYPE_30)){
                v.setReceiverInfo(v.getRcvrNo());
            }
        }

        String[] headerName = {"발송일","회원 ID","회원명","발송 수단","Email/휴대폰 번호","발송 제목","발송 결과"};
        String[] fieldName = {"sendReqDtm","loginId","mbrNm","sndTypeNm","receiverInfo","subject","sndRstNm"};

        model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("NoticeMemberSendList", headerName, fieldName, list));
        model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "NoticeMemberSendList");

        return View.excelDownload();
    }
}
