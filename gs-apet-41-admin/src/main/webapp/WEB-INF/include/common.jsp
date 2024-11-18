<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ page import="framework.common.enums.ImageGoodsSize" %>
<!-- 스크립트에서 사용할 CustomTag 전역 변수는 여기에서 선언하세요 -->
<script type="text/javascript">
	if ('${adminSession.usrNo}' != '') { 
		history.pushState(null, '', location.href);
		window.onpopstate = function(event) {
		    history.go(1);
		};
	}
	var _IMG_URL_HTTP = "<frame:imgUrl http="http"/>";
	var _IMG_URL_HTTPS = "<frame:imgUrl http="https"/>";
	var _IMG_COMMON_PATH = "${adminConstants.COMMON_IMAGE_PATH}";

	var _CONFIRM_UPDATE = "<spring:message code="column.common.confirm.update" />";
	var _COMMON_DATE_FORMAT = "${adminConstants.COMMON_DATE_FORMAT }";
	var _USE_YN = "<frame:gridSelect grpCd='${adminConstants.USE_YN }' showValue='false' />";

	var _COMPANY_SEARCH_LAYER_URL = "<spring:url value='/common/companySearchLayerView.do' />";
	var _COMPANY_GRID_URL = "<spring:url value='/company/companyListGrid.do' />";
	var _POPUP_COMPANY_GRID_URL = "<spring:url value='/company/popupCompanyListGrid.do' />";
	var _COMP_STAT_CD = "<frame:gridSelect grpCd='${adminConstants.COMP_STAT }' />";
	var _CIS_REG_YN = "<frame:gridSelect grpCd='${adminConstants.CIS_REG_YN }' />";
	var _COMP_GB_CD = "<frame:gridSelect grpCd='${adminConstants.COMP_GB }' />";
	var _COMP_TP_CD = "<frame:gridSelect grpCd='${adminConstants.COMP_TP }' />";
	var _COMPANY_SEARCH_GRID_LABEL = {
		  compNo : '<b><u><tt><spring:message code="column.comp_no" /></tt></u></b>' // 업체 번호
		, compNm : '<spring:message code="column.comp_nm" />' // 업체 명
		, bizNo : '<spring:message code="column.biz_no" />' // 사업자 번호
		, compStatCd : '<spring:message code="column.comp_stat_cd" />' // 업체 상태 코드
		, ceoNm : '<spring:message code="column.ceo_nm" />' // 대표자 명
		, compGbCd : '<spring:message code="column.comp_gb_cd" />' // 업체 구분 코드
		, compTpCd : '<spring:message code="column.comp_tp_cd" />' // 업체 유형 코드
		, fax : '<spring:message code="column.fax" />' // 팩스
		, tel : '<spring:message code="column.tel" />' // 전화
		, stIds : "<spring:message code='column.st_id' />"
		, stNms : "<spring:message code='column.st_nm' />"
		, sysRegrNm : '<spring:message code="column.sys_regr_nm" />'
		, sysRegDtm : '<spring:message code="column.sys_reg_dtm" />' // 시스템 등록 일시
		, sysUpdrNm : '<spring:message code="column.sys_updr_nm" />'
		, sysUpdDtm : '<spring:message code="column.sys_upd_dtm" />' // 시스템 수정 일시
		, cisRegYn : '<spring:message code="column.cis_reg_yn" />' // cis 등록여부
	};

	var _MEMBER_SEARCH_LAYER_URL = "<spring:url value='/common/memberSearchLayerView.do' />";
	var _MEMBER_GRID_URL = "<spring:url value='/member/memberListGrid.do' />";
	var _MEMBER_TAB_DETAIL_LAYER_URL = "<spring:url value='/member/membeTabDetailLayerView.do' />";

	var _MEMBER_GRID_POPUP_URL = "<spring:url value='/member/memberListPopupGrid.do' />";

	var _RCV_YN = "<frame:gridSelect grpCd='${adminConstants.RCV_YN }' />";
	var _MBR_STAT_CD = "<frame:gridSelect grpCd='${adminConstants.MBR_STAT }' />";
	var _MBR_GRD_CD = "<frame:gridSelect grpCd='${adminConstants.MBR_GRD_CD }' />";
	var _MBR_GB_CD = "<frame:gridSelect grpCd='${adminConstants.MBR_GB_CD }' />";
	var _GD_GB_CD = "<frame:gridSelect grpCd='${adminConstants.GD_GB }' />";
	var _NTN_GB_CD = "<frame:gridSelect grpCd='${adminConstants.NTN_GB }' />";
	var _JOIN_PATH_CD = "<frame:gridSelect grpCd='${adminConstants.JOIN_PATH }' />";
	var _MEMBER_SEARCH_GRID_LABEL = {
		mbrNo : '<b><u><tt>No.</tt></u></b>' // 회원 번호
		, mbrNm : '회원' // 회원 명
		, mobile : '<spring:message code="column.mobile" />번호' // 휴대폰
		, mbrGbCd : '구분' // 회원 등급 코드
		, mbrPayDtm : '결제일'
		, nickNm : '닉네임'
		, loginId : '회원ID'
		, mbrGrdCd : '회원등급'
		, email : '이메일'
		, joinDtm : '<spring:message code="column.join_dtm" />' // 가입 일시
		/* , mbrStatCd : '<spring:message code="column.mbr_stat_cd" />' // 회원 상태 코드
		, loginId : '<spring:message code="column.login_id" />' // 로그인 아이디
		, tel : '<spring:message code="column.tel" />' // 전화
		, email : '<spring:message code="column.email" />' // 이메일
		, birth : '<spring:message code="column.birth" />' // 생일
		, emailRcvYn : '<spring:message code="column.email_rcv_yn" />' // 이메일 수신 여부
		, smsRcvYn : '<spring:message code="column.sms_rcv_yn" />' // SMS 수신 여부
		, svmnRmnAmt : '<spring:message code="column.svmn_rmn_amt" />' // 적립금 잔여 금액
		, blcRmnAmt : '<spring:message code="column.blc_rmn_amt" />' // 예치금 잔여 금액
		, gdGbCd : '<spring:message code="column.gd_gb_cd" />' // 성별 구분 코드
		, ntnGbCd : '<spring:message code="column.ntn_gb_cd" />' // 국적 구분 코드
		, joinPathCd : '<spring:message code="column.join_path_cd" />' // 가입 경로 코드
		, updrIp : '<spring:message code="column.updr_ip" />' // 수정자 IP
		, sysRegrNm : '<spring:message code="column.sys_regr_nm" />'
		, sysRegDtm : '<spring:message code="column.sys_reg_dtm" />' // 시스템 등록 일시
		, sysUpdrNm : '<spring:message code="column.sys_updr_nm" />'
		, sysUpdDtm : '<spring:message code="column.sys_upd_dtm" />' // 시스템 수정 일시 */
	}

	
	var _USER_SEARCH_LAYER_URL = "<spring:url value='/common/userSearchLayerView.do' />";
	var _USER_GRID_URL = "<spring:url value='/common/userListGrid.do' />";

	var _USR_STAT = "<frame:gridSelect grpCd='${adminConstants.USR_STAT }' />";
	var _USR_GB = "<frame:gridSelect grpCd='${adminConstants.USR_GB }' />";
	var _USER_SEARCH_GRID_LABEL = {
		  usrNo : '<b><u><tt><spring:message code="column.usr_no" /></tt></u></b>'  
		, usrNm : '<spring:message code="column.usr_nm" />'
		, authNm : '<spring:message code="column.auth_nm" />'
		, usrStatCd : '<spring:message code="column.usr_stat_cd" />'
		, usrGbCd : '<spring:message code="column.usr_gb_cd" />'
		, compNm : '<spring:message code="column.comp_nm" />'
		, usrId : '<spring:message code="column.usr_id" />'
		, tel : '<spring:message code="column.tel" />'
		, mobile : '<spring:message code="column.mobile" />'
		, fax : '<spring:message code="column.fax" />'
		, email : '<spring:message code="column.email" />'
		, sysRegrNm : '<spring:message code="column.sys_regr_nm" />'
		, sysRegDtm : '<spring:message code="column.sys_reg_dtm" />' // 시스템 등록 일시
		, sysUpdrNm : '<spring:message code="column.sys_updr_nm" />'
		, sysUpdDtm : '<spring:message code="column.sys_upd_dtm" />' // 시스템 수정 일시
	}
	
	
	var _GOODS_SEARCH_LAYER_URL = "<spring:url value='/goods/goodsSearchLayerView.do' />";
	var _GOODS_GRID_URL = "<spring:url value='/goods/goodsBaseGrid.do' />";
	var _GOODS_EX_LIST_EXCEL_UPLOAD_LAYER_URL = "<spring:url value='/promotion/goodsExListExcelUploadView.do' />";
	var _GOODS_STAT_CD = "<frame:gridSelect grpCd='${adminConstants.GOODS_STAT }' showValue='false' />";
	var _GOODS_TP_CD = "<frame:gridSelect grpCd='${adminConstants.GOODS_TP }' showValue='false' />";
	var _GOODS_CSTRT_TP_CD = "<frame:gridSelect grpCd='${adminConstants.GOODS_CSTRT_TP }' showValue='false' />";
	var _GOODS_AMT_TP_CD = "<frame:gridSelect grpCd='${adminConstants.GOODS_AMT_TP }' showValue='false' />";
	var _SHOW_YN = "<frame:gridSelect grpCd='${adminConstants.SHOW_YN }' showValue='false' />";
	var _COMM_YN = "<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='false' />";
	var _IMG_URL = "<frame:imgUrl />";
	var _IMG_CDN_URL = "<frame:imgCdnUrl />";
	
	var _IMAGE_GOODS_SIZE_70_0 = "${ImageGoodsSize.SIZE_10.size[0]}";
	var _IMAGE_GOODS_SIZE_70_1 = "${ImageGoodsSize.SIZE_10.size[1]}";

	var _GOODS_SEARCH_GRID_LABEL = {
		goodsId : "<b><u><tt><spring:message code='column.goods_id' /></tt></u></b>"
		, compGoodsId : "<spring:message code='column.goods.compGoodsId' />"
		, imgPaths: "<spring:message code='column.tn_img_path.goods_list' />"
		, imgSeq: "<spring:message code='column.img_seq' />"
		, goodsNm : "<spring:message code='column.goods_nm' />"
		, stIds : "<spring:message code='column.st_id' />"
		, stNms : "<spring:message code='column.st_nm' />"
		, goodsStatCd : "<spring:message code='column.goods_stat_cd' />"
		, bigo : "<spring:message code='column.bigo' />"
		, goodsTpCd : "<spring:message code='column.goods_tp_cd' />"
		, goodsCstrtGb : "<spring:message code='column.goods_cstrt_gb' />"
		, goodsCstrtTpCd : "<spring:message code='column.goods.cstrt.tp.cd' />"
		, goodsAmtTpCd : "<spring:message code='column.goods.amt.tp.cd' />"
		, mdlNm : "<spring:message code='column.mdl_nm' />"
		, saleAmt : "<spring:message code='column.sale_prc' />"
		, orgSaleAmt : "<spring:message code='column.goods.org_sale_prc' />"
		, splAmt : "<spring:message code='column.spl_prc' />"
		, compNm : "<spring:message code='column.goods.comp_nm' />"
		, bndNmKo : "<spring:message code='column.bnd_nm' />"
		, bndNmEn : "<spring:message code='column.bnd_nm_en' />"
		, mmft : "<spring:message code='column.mmft' />"
		, saleStrtDtm : "<spring:message code='column.sale_strt_dtm' />"
		, saleEndDtm : "<spring:message code='column.sale_end_dtm' />"
		, showYn : "<spring:message code='column.show_yn' />"
		, sysRegrNm : "<spring:message code='column.sys_regr_nm' />"
		, sysRegDtm : "<spring:message code='column.sys_reg_dtm' />"
	};

	var _COUPON_SEARCH_LAYER_URL = "<spring:url value='/promotion/couponSearchLayerView.do' />";
	var _COUPON_GRID_URL = "<spring:url value='/promotion/couponListGrid.do' />";
	var _CP_TG = "<frame:gridSelect grpCd='${adminConstants.CP_TG }' showValue='false' />";
	var _CP_KIND_CD = "<frame:gridSelect grpCd='${adminConstants.CP_KIND }' showValue='false' />";
	var _CP_STAT_CD = "<frame:gridSelect grpCd='${adminConstants.CP_STAT }' showValue='false' />";
	var _CP_APL_CD = "<frame:gridSelect grpCd='${adminConstants.CP_APL }' showValue='false' />";
	var _DUPLE_USE_YN = "<frame:gridSelect grpCd='${adminConstants.DUPLE_USE_YN }' showValue='false' />";
	var _COUPON_SEARCH_GRID_LABEL = {
		cpNo : "<spring:message code='column.cp_no' />"
		, cpNm : "<spring:message code='column.cp_nm' />"
		, stNms : "<spring:message code='column.st_nm' />"
		, cpTgCd : "<spring:message code='column.cp_tg_cd' />"
		, cpKindCd : "<spring:message code='column.cp_kind_cd' />"
		, cpStatCd : "<spring:message code='column.cp_stat_cd' />"
		, cpAplCd : "<spring:message code='column.cp_apl_cd' />"
		, aplVal : "<spring:message code='column.apl_val' />"
		, minBuyAmt : "<spring:message code='column.min_buy_amt' />"
		, maxDcAmt : "<spring:message code='column.max_dc_amt' />"
		, aplStrtDtm : "<spring:message code='column.apl_strt_dtm' />"
		, aplEndDtm : "<spring:message code='column.apl_end_dtm' />"
		, dupleUseYn : "<spring:message code='column.duple_use_yn' />"
		, sysRegrNm : "<spring:message code='column.sys_regr_nm' />"
		, sysRegDtm : "<spring:message code='column.sys_reg_dtm' />"
		, sysUpdrNm : "<spring:message code='column.sys_updr_nm' />"
		, sysUpdDtm : "<spring:message code='column.sys_upd_dtm' />"
	};

	var _ITEM_SEARCH_LAYER_URL = "<spring:url value='/goods/itemSearchLayerView.do' />";
	var _ITEM_GRID_URL = "<spring:url value='/goods/itemGrid.do' />";
	var _ITEM_STAT_CD = "<frame:gridSelect grpCd='${adminConstants.ITEM_STAT }' showValue='false' />";
	var _ITEM_SEARCH_GRID_LABEL = {
		goodsId : "<spring:message code='column.goods_id' />"
		, goodsNm : "<spring:message code='column.goods_nm' />"
		, goodsStatCd : "<spring:message code='column.goods_stat_cd' />"
		, goodsTpCd : "<spring:message code='column.goods_tp_cd' />"
		, mdlNm : "<spring:message code='column.mdl_nm' />"
		, compNm : "<spring:message code='column.goods.comp_nm' />"
		, bndNmKo : "<spring:message code='column.bnd_nm' />"
		, saleStrtDtm : "<spring:message code='column.sale_strt_dtm' />"
		, saleEndDtm : "<spring:message code='column.sale_end_dtm' />"
		, cstrtGoodsId : "<spring:message code='column.cstrt_goods_id' />"
		, itemNo : "<spring:message code='column.item_no' />"
		, itemNm : "<spring:message code='column.item_nm' />"
		, itemStatCd : "<spring:message code='column.item_stat_cd' />"
		, saleAmt : "<spring:message code='column.sale_prc' />"
		, addSaleAmt : "<spring:message code='column.add_sale_amt' />"
		, webStkQty : "<spring:message code='column.web_stk_qty' />"
	};


	var _BRAND_SEARCH_LAYER_URL = "<spring:url value='/brand/brandSearchLayerView.do' />";
	var _BRAND_GRID_URL = "<spring:url value='/brand/brandBaseGrid.do' />";
	var _BRAND_SEARCH_GRID_LABEL = {
		bndNo : "<b><u><tt><spring:message code='column.bnd_no' /></tt></u></b>"
		, bndNmKo : "<spring:message code='column.bnd_nm_ko' />"
		//, bndNmEn : "<spring:message code='column.bnd_nm_en' />"
		, bndGbCd : "<spring:message code='column.bnd_gb_cd' />"
		, useYn : "<spring:message code='column.use_yn' />"
		, sortSeq : "<spring:message code='column.sort_seq' />"
		, compNm : "<spring:message code='column.goods.comp_nm' />"
		, sysRegrNm : "<spring:message code='column.sys_regr_nm' />"
		, sysRegDtm : "<spring:message code='column.sys_reg_dtm' />"
	};

	var _COMPANY_CATEGORY_LAYER_URL = "<spring:url value='/company/companyCategoryLayerView.do' />";
	var _COMPANY_CATEGORY_GRID_URL = "<spring:url value='/company/compDispMapListGrid.do' />";
	var _COMPANY_CATEGORY_GRID_LABEL = {
		   stNm : "<spring:message code='column.st_nm' />"
		, dispClsfNo : "<spring:message code='column.disp_clsf_no' />"
		, dispClsfNm : "<spring:message code='column.disp_clsf_nm' />"
		, ctgPath : "<spring:message code='column.display.disp_clsf.path' />"
		, goodsId : "전시분류 번호"
		, stId : "<spring:message code='column.st_id' />" 
	};
	
	var _USER_INFO_LAYER_URL = "<spring:url value='/common/userInfoLayerView.do' />";
	var _USER_INFO_UPDATE_URL = "<spring:url value='/common/userInfoUpdate.do' />";

	// 전시목록
	var _CATEGORY_SEARCH_LAYER_URL = "<spring:url value='/display/displaySearchLayerView.do' />";

	// 전시 분류(전시카테고리)
	var _CATEGORY_SEARCH_LAYER_DISP_CLSF_10 = "${adminConstants.DISP_CLSF_10 }";
	var _CATEGORY_SEARCH_LAYER_DISP_CLSF_30 = "${adminConstants.DISP_CLSF_30 }";
	
	//펫로그 콘텐츠 관리
	var _PET_TV_CONTENT_LAYER_URL = "<spring:url value='/petlog/petTvContentViewPop.do' />"
	
	//펫로그  관리
	var _PET_LOG_SEARCH_LAYER_URL = "<spring:url value='/petLogMgmt/petLogSearchLayerView.do' />"
	var _PET_LOG_GRID_URL = "<spring:url value='/petLogMgmt/listPetLog.do' />"
	var _CONTS_STAT_CD = "<frame:gridSelect grpCd='${adminConstants.CONTS_STAT }' showValue='false' />";
	var _PETLOG_CHNL = "<frame:gridSelect grpCd='${adminConstants.PETLOG_CHNL}' showValue='false' />";
	var PETLOG_CONTS_GB = "<frame:gridSelect grpCd='${adminConstants.PETLOG_CONTS_GB}' showValue='false' />";
	var _PET_LOG_GRID_LABEL = {
		rowIndex : '<spring:message code="column.no" />'	// 번호	 
		, petLogChnlCd : '<spring:message code="column.petlog.chnl" />'	/* 등록유형 */
		, petlogContsGb : '<spring:message code="column.petlog.conts_gb" />'	/* 컨텐츠구분 */
		, vdThumPath : '<spring:message code="column.thum" />'	/* 썸네일 */
		, dscrt : '<spring:message code="column.content" />'	// 내용
		, goodsRcomYn : '<spring:message code="column.goods_map" />'	/* 상품추천 */
		, pstNm : '<spring:message code="column.location" />'	/* 위치 */
		, nickNm : '<spring:message code="column.nickname" />'	/* 닉네임 */
		, shareCnt : '<spring:message code="column.vod.share_cnt" />'	/* 공유수 */
		, goodCnt : '<spring:message code="column.good_cnt" />'	// 좋아요
		, hits : '<spring:message code="column.hits" />'	// 조회수
		, claimCnt : '<spring:message code="column.claim_cnt" />'	// 신고수
		, snctYn : '<spring:message code="column.snct_yn" />'	// 제재여부
		, petLogNo : '<<spring:message code="column.no" />'	//  번호					  
		, contsStatCd : '<spring:message code="column.contsStat" />'	// 전시여부 
		, regModDtm : '<spring:message code="column.sys_reg_dt" /><br/>(<spring:message code="column.sys_upd_dt" />)'	// 등록수정일 
	};
	
	//배너 이미지/영상/태그
	var _BNR_VOD_TAG_UPDATE = "<spring:message code='column.common.confirm.save' />";
	var _DISPLAY_BNR_VOD_TAG_URL = "<spring:url value='/dispaly/dispBnrVodTagViewPop.do' />";
	
	//배너목록
	var _BANNER_USE_YN_UPDATE = "<spring:message code='column.bnr_use_yn_update' />";
	var _BANNER_SEARCH_LAYER_URL = "<spring:url value='/banner/bannerSearchLayerView.do' />";
	var _BANNER_GRID_URL = "<spring:url value='/appweb/bannerListGrid.do' />";
	var _BANNER_USE_YN_UPDATE_URL = "<spring:url value='/banner/updateUseYn.do' />";
	var _BANNER_TP = "<frame:gridSelect grpCd='${adminConstants.BNR_TP_CD }' showValue='false' />";
	var _BANNER_GRID_LABEL = {
			bnrNo : "<spring:message code='column.bnr_no' />"
			, stId : "<spring:message code='column.st_id' />"
			, bnrId : "<spring:message code='column.bnr_id' />"
			, bnrMobileImgPath : "<spring:message code='column.bnr_mo_img_path' />"
			, bnrTtl : "<spring:message code='column.bnr_ttl' />"
			, bnrTpCd : "<spring:message code='column.bnr_tp_cd_nm' />"
			, useYn : "<spring:message code='column.bnr_use_yn' />"
			, bnrLinkUrl : "<spring:message code='column.bnr_link_url' />"
			, bnrMobileLinkUrl : "<spring:message code='column.bnr_mobile_link_url' />"
			, sysRegDtm : "<spring:message code='column.sys_reg_dtm' />"
			, sysRegrNm : "<spring:message code='column.sys_regr_nm' />"
			, sysUpdDtm : '<spring:message code="column.sys_upd_dtm" />'
			, sysUpdrNm : '<spring:message code="column.sys_updr_nm" />'
	};
	
	//시리즈 목록
	var _SERIES_SEARCH_LAYER_URL = "<spring:url value='/display/seriesSearchLayerView.do' />";
	var _SERIES_GRID_URL = "<spring:url value='/series/listSeries.do' />";
	var _SERIES_APET_TP = "<frame:gridSelect grpCd='${adminConstants.APET_TP }' showValue='false' />";
	var _SERIES_DISP_STAT = "<frame:gridSelect grpCd='${adminConstants.DISP_STAT}' showValue='false' />";
	var _SERIES_GRID_LABEL = {
			srisNo : "<spring:message code="column.no" />"
			, rowIndex : '<spring:message code="column.no" />'
			, regModDtm : "<spring:message code='column.sys_reg_dt' /><br/>(<spring:message code='column.sys_upd_dt' />)"
			, srisId : '<spring:message code="column.sris_id" />'
			, srisNm : "<spring:message code='column.sris_nm' />"
			, sesnCnt : "<spring:message code='column.sesn_cnt' />"
			, tpCd : "<spring:message code='column.type' />"
			, dispYn : "<spring:message code='column.vod.disp' />"
	}
	
	// 상품평
	var _GOODS_COMMENT_SEARCH_LAYER_URL = "<spring:url value='/display/displayGoodsCommentSearchLayerView.do' />";
	var _GOODS_COMMENT_GRID_URL = "<spring:url value='/goods/goodsCommentGrid.do' />";
	var _IMAGE_YN = "<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='false' />";
	var _DEL_YN = "<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='false' />";
	var _GOODS_COMMENT_GRID_LABEL = {
			goodsEstmNo : "<spring:message code='column.goods_estm_no' />"
			, estmId : "<spring:message code='column.login_id' />"
			, mbrNm : "<spring:message code='column.mbr_nm' />"
			, ttl : "<spring:message code='column.ttl' />"
			, imgRegYn : "<spring:message code='column.img_reg_yn' />"
			, sysDelYn : "<spring:message code='column.sys_del_yn' />"
			, goodsId : "<spring:message code='column.goods_id' />"
			, goodsNm : "<spring:message code='column.goods_nm' />"
			, sysRegDtm : "<spring:message code='column.sys_reg_dtm' />"
		};

	var _HISTORY_VIEW_LAYER_URL = "<spring:url value='/common/historyLayerView.do' />";
	var _GOODS_HISTORY_GRID_URL = "<spring:url value='/goods/goodsHistoryGrid.do' />";
	var _ITEM_HISTORY_GRID_URL = "<spring:url value='/goods/itemHistoryGrid.do' />";
	var _COMP_DLVR_MTD_CD = "<frame:gridSelect grpCd='${adminConstants.COMP_DLVR_MTD }' />";
	var _TAX_GB_CD = "<frame:gridSelect grpCd='${adminConstants.TAX_GB }' />";
	var _PPLRT_SET_CD = "<frame:gridSelect grpCd='${adminConstants.PPLRT_SET }' />";
	var _WEB_MOBILE_GB_CD = "<frame:gridSelect grpCd='${adminConstants.WEB_MOBILE_GB }' />";
	var _HISTORY_VIEW_GRID_LABEL = {
		columnId : "<spring:message code='column.column_id' />"
		, columnNm : "<spring:message code='column.column_nm' />"
		, value1 : "<spring:message code='column.before_value' />"
		, value2 : "<spring:message code='column.next_value' />"
		, sysRegrNm : "<spring:message code='column.sys_regr_nm' />"
		, sysRegDtm : "<spring:message code='column.sys_reg_dtm' />"
		, sysUpdrNm : "<spring:message code='column.sys_updr_nm' />"
		, sysUpdDtm : "<spring:message code='column.sys_upd_dtm' />"
		, histNo : "<spring:message code='column.goods_base_hist_no' />"
		, goodsNm : "<spring:message code='column.goods_nm' />"
		, goodsStatCd : "<spring:message code='column.goods_stat_cd' />"
		, ntfId : "<spring:message code='column.ntf_id' />"
		, mdlNm : "<spring:message code='column.mdl_nm' />"
		, compNo : "<spring:message code='column.comp_no' />"
		, kwd : "<spring:message code='column.kwd' />"
		, ctrOrg : "<spring:message code='column.ctr_org' />"
		, minOrdQty : "<spring:message code='column.min_ord_qty' />"
		, maxOrdQty : "<spring:message code='column.max_ord_qty' />"
		, bndNo : "<spring:message code='column.bnd_no' />"
		, dlvrMtdCd : "<spring:message code='column.dlvr_mtd_cd' />"
		, dlvrcPlcNo : "<spring:message code='column.dlvrc_plc_no' />"
		, compPlcNo : "<spring:message code='column.comp_plc_no' />"
		, prWds : "<spring:message code='column.pr_wds' />"
		, freeDlvrYn : "<spring:message code='column.free_dlvr_yn' />"
		, importer : "<spring:message code='column.importer' />"
		, mmft : "<spring:message code='column.mmft' />"
		, taxGbCd : "<spring:message code='column.tax_gb_cd' />"
		, stkMngYn : "<spring:message code='column.stk_mng_yn' />"
		, mdUsrNo : "<spring:message code='column.md_usr_no' />"
		, pplrtRank : "<spring:message code='column.pplrt_rank' />"
		, pplrtSetCd : "<spring:message code='column.pplrt_set_cd' />"
		, goodsId : "<spring:message code='column.goods_id' />"
		, saleStrtDtm : "<spring:message code='column.sale_strt_dtm' />"
		, saleEndDtm : "<spring:message code='column.sale_end_dtm' />"
		, showYn : "<spring:message code='column.show_yn' />"
		, compGoodsId : "<spring:message code='column.comp_goods_id' />"
		, webMobileGbCd : "<spring:message code='column.web_mobile_gb_cd' />"
		, rtnPsbYn : "<spring:message code='column.rtn_psb_yn' />"
		, rtnMsg : "<spring:message code='column.rtn_msg' />"
		, prWdsShowYn : "<spring:message code='column.pr_wds_show_yn' />"
		, itemMngYn : "<spring:message code='column.item_mng_yn' />"
		, goodsTpCd : "<spring:message code='column.goods_tp_cd' />"
		, bigo : "<spring:message code='column.bigo' />"
		, vdLinkUrl : "<spring:message code='column.vd_link_url' />"
		, hits : "<spring:message code='column.hits' />"
	};
	
	
	var _ST_SEARCH_LAYER_URL = "<spring:url value='/common/stSearchLayerView.do' />";
	var _ST_GRID_URL = "<spring:url value='/st/stStdInfoGrid.do' />";
	var _ST_SEARCH_GRID_LABEL = {
		stId : '<b><u><tt><spring:message code="column.st_id" /></tt></u></b>' // 사이트 ID
		, stNm : '<spring:message code="column.st_nm" />' // 사이트 명
		, stSht : '<spring:message code="column.st_url" />' // 사이트 URL
		, stSht : '<spring:message code="column.st_sht" />' // 사이트 약어
		, useYn : '<spring:message code="column.use_yn" />' // 사용여부
		, compNm : '<spring:message code="column.comp_nm" />' // 업체 명
		, compStatCd : '<spring:message code="column.comp_stat_cd" />' // 업체 상태
		, sysRegrNm : '<spring:message code="column.sys_regr_nm" />'
		, sysRegDtm : '<spring:message code="column.sys_reg_dtm" />' // 시스템 등록 일시
		, sysUpdrNm : '<spring:message code="column.sys_updr_nm" />'
		, sysUpdDtm : '<spring:message code="column.sys_upd_dtm" />' // 시스템 수정 일시
	};


	var _BRAND_CNTS_SEARCH_LAYER_URL = "<spring:url value='/brandCnts/brandCntsSearchLayerView.do' />";
	var _BRAND_CNTS_GRID_URL = "<spring:url value='/brandCnts/brandCntsGrid.do' />";
	var _CNTS_GB = "<frame:gridSelect grpCd='${adminConstants.CNTS_GB }' showValue='false' />";
	var _BRAND_CNTS_SEARCH_GRID_LABEL = {
		bndCntsNo : "<spring:message code='column.bnd_cnts_no' />" // 브랜드 콘텐츠 번호 */
		, bndNo : "<spring:message code='column.bnd_no' />" // 브랜드 번호 */
		, bndNmKo : "<spring:message code='column.bnd_nm_ko' />" // 브랜드 국문 */
		//, bndNmEn : "<spring:message code='column.bnd_nm_en' />" // 브랜드 영문 */
		, cntsGbCd : "<spring:message code='column.cnts_gb_cd' />" // 콘텐츠 구분 코드
		, cntsTtl : "<spring:message code='column.cnts_ttl' />" // 타이틀
		, cntsImgPath : "<spring:message code='column.cnts_img_path' />" // 콘텐츠 이미지 경로
		, cntsMoImgPath : "<spring:message code='column.cnts_mo_img_path' />" // 콘텐츠 모바일 이미지 경로
		, tnImgPath : "<spring:message code='column.tn_img_path' />" // 썸네일 이미지 경로
		, tnMoImgPath : "<spring:message code='column.tn_mo_img_path' />" // 썸네일 모바일 이미지 경로
	};
	
	
	// Tag 검색 팝업 layer---------------------------------------------------------------------//
	var _TAG_BASE_SEARCH_LAYER_URL = "<spring:url value='/tag/tagBaseSearchLayerView.do' />";
	var _TAG_BASE_GRID_URL = "<spring:url value='/tag/tagBaseGrid.do' />";	
	var _TAG_BASE_SEARCH_GRID_LABEL = {
		  tagNo : '<b><u><tt><spring:message code="column.tag_no" /></tt></u></b>' 	// Tag 번호
		, tagNm : '<spring:message code="column.tag_nm" />' 						// Tag 명
		, grpNm : '<spring:message code="column.tag_grpko"/>'						// 소속 그룹
		, rltTagCnt : '<spring:message code="column.rlt_tag" />'					// 관련 태그
		, rltCntsCnt : '<spring:message code="column.rlt_cnts_cnt" />'				// 관련 영상 수
		, rltGoodsCnt : '<spring:message code="column.rlt_goods_cnt" />'			// 관련 상품 수
		, synTag : '<spring:message code="column.syn_tag" />' 					// 동의 Tag 명
		, statCd : '<spring:message code="column.stat_cd" />' 						// 상태 코드
		, sysRegrNm : '<spring:message code="column.sys_regr_nm" />'
		, sysRegDtm : '<spring:message code="column.sys_reg_dtm" />' 				// 시스템 등록 일시
		, sysUpdrNm : '<spring:message code="column.sys_updr_nm" />'
		, sysUpdDtm : '<spring:message code="column.sys_upd_dtm" />' 				// 시스템 수정 일시
	};
	
	// Tag 상세 팝업 layer---------------------------------------------------------------------//
	var _TAG_BASE_DETAIL_LAYER_URL = "<spring:url value='/tag/tagBaseDetailLayerView.do' />";

	// Tag 관련 상품 layer---------------------------------------------------------------------// 
	var _TAG_GOODS_LAYER_URL = "<spring:url value='/tag/tagGoodsLayerView.do' />";
	var _TAG_GOODS_LIST_GRID_URL = "<spring:url value='/tag/tagGoodsListGrid.do' />";	
	var _TAG_CONTENTS_LAYER_URL = "<spring:url value='/tag/tagContentsLayerView.do' />";
	var _TAG_CONTENTS_LIST_GRID_URL = "<spring:url value='/tag/tagContentsListGrid.do' />";
	
	var _TAG_RLT_LIST_GRID_LABEL = {
		  rltGb : '<spring:message code="column.gb_cd" />' 						// 구분
		, rltTp : '<spring:message code="column.clsf" />' 						// 분류
		, rltNm : '<spring:message code="column.ttl" />' 						// 제목
		, vdGbCd : '<spring:message code="column.vod_tp" />' 						// 제목
		, sysRegrNm : '<spring:message code="column.sys_regr_nm" />'
		, sysRegDtm : '<spring:message code="column.sys_reg_dtm" />' 			// 시스템 등록 일시
		, sysUpdrNm : '<spring:message code="column.sys_updr_nm" />'
		, sysUpdDtm : '<spring:message code="column.sys_upd_dtm" />' 			// 시스템 수정 일시
	};	
	
	var _TAG_STAT = "<frame:gridSelect grpCd='${adminConstants.TAG_STAT }' showValue='false' />";
	
	// 영상 조회
	var _VOD_SEARCH_LAYER_URL = "<spring:url value='/contents/vodSearchLayerView.do' />";
	var _VOD_UPDATE_DISP_URL = "<spring:url value='/contents/batchUpdateDisp.do' />";
	var _VOD_GRID_URL = "<spring:url value='/contents/vodListGrid.do' />";
	var _VOD_IMG_URL = "<frame:imgUrl />";
	var _VOD_DISP_STAT = "<frame:gridSelect grpCd='${adminConstants.DISP_STAT }' showValue='false' />";
	var _VOD_SEARCH_GRID_LABEL = {
		rowIndex : '<spring:message code="column.no" />' // row no
		, vdId : '<spring:message code="column.vd_id" />' // 영상 Id
		, thumPath : '<spring:message code="column.thum_img_path" />' // 썸네일 이미지
		, ttl : '<spring:message code="column.ttl" />' // 제목
		, srisNm : '<spring:message code="column.vod.series" />' // 시리즈
		, sesnNm : '<spring:message code="column.vod.season" />' // 시즌
		, shareCnt : '<spring:message code="column.vod.share_cnt" />' // 공유수
		, hits : '<spring:message code="column.vod.hits" />' // 조회수
		, likeCnt : '<spring:message code="column.vod.like" />' // 좋아요
		, replyCnt : '<spring:message code="column.vod.reply_cnt" />' // 댓글수
		, dispYn : '<spring:message code="column.vod.disp" />' // 전시
		, sysRegDtm : '<spring:message code="column.sys_reg_upd_dt" />' // 등록일(수정일)
	};
	
	//우편번호 검색 팝업
	var _JUSO_LAYER_URL = "<spring:url value='/common/moisPostLayerPopup.do' />";
	//우편번호 검색 승인키
	var _JUSO_CONFMKEY = "<spring:eval expression="@bizConfig['bo.mois.post.confmKey']" />";

	//영상 업로드 URL
	var _VOD_UPLOAD_URL = "<spring:eval expression="@bizConfig['vod.upload.api.url']" />";
	//영상 List URL
	var _VOD_LIST_URL = "<spring:eval expression="@bizConfig['vod.list.api.url']" />";
	//영상 정보 URL
	var _VOD_INFO_URL = "<spring:eval expression="@bizConfig['vod.info.api.url']" />";
	//영상 그룹 List URL
	var _VOD_GROUP_LIST_URL = "<spring:eval expression="@bizConfig['vod.group.list.api.url']" />";
	//영상 그룹 추가 URL
	var _VOD_GROUP_ADD_URL = "<spring:eval expression="@bizConfig['vod.group.add.api.url']" />";
	//영상 그룹 내 영상 순서 변경 URL
	var _VOD_GROUP_CHNL_ORD_URL = "<spring:eval expression="@bizConfig['vod.group.chnl.ord.api.url']" />";
	//영상 채널 아이디(tv)
	var _VOD_CHNL_ID_TV = "<spring:eval expression="@bizConfig['vod.api.chnl.id.tv']" />";
	//영상 채널 아이디(log)
	var _VOD_CHNL_ID_LOG = "<spring:eval expression="@bizConfig['vod.api.chnl.id.log']" />";
	//영상 채널 List URL
	var _VOD_CHNL_LIST_URL = "<spring:eval expression="@bizConfig['vod.chnl.list.api.url']" />";
	//영상 채널 default 추가
	var _VOD_GROUP_DEFAULT = "<spring:eval expression="@bizConfig['vod.group.default']" />";
	//영상 그룹 변경
	var _VOD_GROUP_MOVE_API_URL = "<spring:eval expression="@bizConfig['vod.group.move.api.url']" />";

	var _EVENT_WINNER_LAYER_URL = "<spring:url value='/event/eventWinnerPopView.do' />";

	var _EVENT_WINNER_UPLOAD_CSV_URL = "<spring:url value='/event/eventWinnerUploadCsv.do' />"
	var _DELECT_EVENT_WIN_INFO_URL = "<spring:url value='/event/deleteEventWinInfo.do' />"
	var _MESSAGE_UPLOAD_EVENT_WIN_INFO = "<spring:message code='column.event_view.message.upload_event_win_info' />";
	var _MESSAGE_DELETE_EVENT_WIN_INFO = "<spring:message code='column.event_view.message.delete_event_win_info' />";
</script>

<%-- Jquery --%>
<script type="text/javascript" src="/tools/jquery/jquery-1.12.1.min.js" charset="utf-8"></script>
<!-- <script type="text/javascript" src="/tools/jquery/jquery-3.3.1.min.js" charset="utf-8"></script> -->
<script type="text/javascript" src="/tools/jquery/jquery.cookie.js" charset="utf-8"></script>
<script type="text/javascript" src="/tools/jquery/jquery.mask.min.js" charset="utf-8"></script>
<script type="text/javascript" src="/tools/jquery/jquery.countdown.js" charset="utf-8"></script>
<script type="text/javascript" src="/tools/jquery/jquery.form.min.js" charset="utf-8"></script>
<!-- <script type="text/javascript" src="/tools/jquery/jquery.blockUI.js" charset="utf-8"></script> -->
<script type="text/javascript" src="/tools/jquery/autoNumeric.js" charset="utf-8"></script>
<script type="text/javascript" src="/tools/jquery/jquery.number.min.js" charset="utf-8"></script>
<script type="text/javascript" src="/tools/jquery/jquery.bighover.js" charset="utf-8"></script>

<%-- Jquery UI --%>
<link rel="stylesheet" type="text/css" media="screen" href="/tools/jquery/jquery-ui-1.11.4/jquery-ui.min.css" />
<script type="text/javascript" src="/tools/jquery/jquery-ui-1.11.4/jquery-ui.min.js" charset="utf-8"></script>

<%-- Jquery Grid --%>
<link rel="stylesheet" type="text/css" media="screen" href="/tools/jqGrid/css/ui.jqgrid.css" />
<script type="text/javascript" src="/tools/jqGrid/src/jquery.jqGrid.js" charset="utf-8"></script>
<script type="text/javascript" src="/tools/jqGrid/js/i18n/grid.locale-kr.js" charset="utf-8"></script>

<%-- Jquery JsTree --%>
<link rel="stylesheet" type="text/css" media="screen" href="/tools/jsTree/dist/themes/default/style.css" />
<script type="text/javascript" src="/tools/jsTree/dist/jstree.min.js" charset="utf-8"></script>

<%-- Jquery Validation Engine --%>
<link type="text/css" rel="stylesheet" href="/tools/jquery/validation-Engine-2.6.4/css/validationEngine.jquery.css" />
<script type="text/javascript" src="/tools/jquery/validation-Engine-2.6.4/js/languages/jquery.validationEngine-ko.js?1" charset="utf-8"></script>
<script type="text/javascript" src="/tools/jquery/validation-Engine-2.6.4/js/jquery.validationEngine.js" charset="utf-8"></script>

<%-- EasyUI --%>
<link rel="stylesheet" type="text/css" href="/tools/jquery-easyui-1.5.3/themes/gray/easyui.css">
<link rel="stylesheet" type="text/css" href="/tools/jquery-easyui-1.5.3/themes/icon.css">
<link rel="stylesheet" type="text/css" href="/tools/jquery-easyui-1.5.3/themes/color.css">
<script type="text/javascript" src="/tools/jquery-easyui-1.5.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="/tools/jquery-easyui-1.5.3/datagrid-cellediting.js"></script>

<script type="text/javascript" src="/tools/jquery/jquery.blockUI.js" charset="utf-8"></script>
<%-- veci --%>
<link rel="stylesheet" type="text/css" href="/css/font-awesome.css">
<link rel="stylesheet" type="text/css" href="/css/common.css">
<link rel="stylesheet" type="text/css" href="/css/design.css">
<script type="text/javascript" src="/js/custom.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/common.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/code.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/file.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/layer.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/design-ui.js" charset="utf-8"></script>

<%-- 네이버 에디터 --%>
<script type="text/javascript" src="/tools/smartEditor/js/HuskyEZCreator.js" charset='utf-8'></script>
<script type="text/javascript" src="/js/editor.js" charset='utf-8'></script>

<%--네이버 Map --%>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=<spring:eval expression="@bizConfig['naver.cloud.client.id']" />&submodules=geocoder"></script>

<%-- 다음 우편번호 --%>
<c:choose>
	<c:when test="${pageContext.request.scheme eq 'https'}">
		<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js" charset="utf-8"></script>
	</c:when>
	<c:otherwise>
		<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js" charset="utf-8"></script>
	</c:otherwise>
</c:choose>

<%-- Common Layer --%>
<script type="text/javascript" src="/js/common_layer.js" charset="utf-8"></script>

<script type="text/javascript">
	var _GRID_COLUMNS = {
		// 업체번호
		 compNo_b : {name:'compNo', label:'<b><u><tt><spring:message code="column.comp_no" /></tt></u></b>', width:'90', align:'center', formatter:'integer', classes:'pointer fontbold', sortable:false}
		,compNo : {name:'compNo', label:'<spring:message code="column.comp_no" />', width:'90', align:'center', formatter:'integer', sortable:false}
		
		,compNm : {name:'compNm', label:'<spring:message code="column.comp_nm" />', width:'130', align:'center', sortable:false}	// 업체 명
		,fax : {name:'fax', label:'<spring:message code="column.fax" />', width:'120', align:'center', sortable:false}				// 팩스
		,tel : {name:'tel', label:'<spring:message code="column.tel" />', width:'120', align:'center', sortable:false}				// 전화
		,mobile : {name:'mobile', label:'<spring:message code="column.mobile" />', width:'120', align:'center', sortable:false}		// 모바일
		,email : {name:'email', label:'<spring:message code="column.email" />', width:'200', align:"center", sortable:false}		// 이메일
		
		,stId : {name:'stId', label:'<spring:message code="column.st_id" />', width:'100', align:'center', sortable:false}			// 사이트 ID
		,stNm : {name:'stNm', label:'<spring:message code="column.st_nm" />', width:'100', align:'center', sortable:false}			// 사이트 명
		
		//회원
		,mbrNo_b : {name:'mbrNo', label:'<b><u><tt><spring:message code="column.mbr_no" /></tt></u></b>', width:'90', align:'center', formatter:'integer', classes:'pointer fontbold'}
		,mbrNo : {name:'mbrNo', label:'<spring:message code="column.mbr_no" />', width:'90', align:'center', formatter:'integer'}
		
		// 상품번호
		,goodsId_b : {name:'goodsId', label:'<b><u><tt><spring:message code="column.goods_id" /></tt></u></b>', width:'120', key: true, align:'center', classes:'pointer fontbold'}
		,goodsId : {name:'goodsId', label:'<spring:message code="column.goods_id" />', width:'120', align:'center'}
		,compGoodsId : {name:"compGoodsId", label:"<spring:message code='column.goods.comp.goods.id' />", width:"100", align:"center", sortable:false}
		// 상품명
		,goodsNm_b : {name:'goodsNm', label:'<b><u><tt><spring:message code="column.goods_nm" /></tt></u></b>', width:'320', align:'center', sortable:false, classes:'pointer fontbold'} 
		,goodsNm : {name:'goodsNm', label:'<spring:message code="column.display_view.goods_nm" />', width:'320', align:'center', sortable:false }	

		//상품상태
		,goodsStatCd : {name:'goodsStatCd', label:'<spring:message code="column.goods_stat_cd" />', width:'90', align:'center', sortable:false, formatter:'select', editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_STAT }' showValue='false' />" } }	// 상품 상태

		//상품구성유형
		,goodsCstrtTpCd : {name:'goodsCstrtTpCd', label:'<spring:message code="column.goods.cstrt.tp.cd" />', width:'100', align:'center', sortable:false, formatter:'select', editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_CSTRT_TP }' showValue='false' />" } }
		,goodsTpCd : {name:'goodsTpCd', label:'<spring:message code="column.goods_tp_cd" />', width:'100', align:'center', sortable:false, formatter:"select", editoptions:{value:_GOODS_TP_CD } }		// 상품 유형
		,bndNmKo : {name:'bndNmKo', label:'<spring:message code="column.bnd_nm" />', width:'150', align:'center', sortable:false }					// 브랜드명
		
		,dispYn : {name:'dispYn', label:'<spring:message code="column.disp_yn" />', width:'90', align:'center', sortable:false, formatter:'select', editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.DISP_YN}' showValue='false'/>"}}
		,useYn : {name:'useYn', label:'<spring:message code="column.use_yn" />', width:'90', align:'center', sortable:false, formatter:'select', editoptions:{value:_USE_YN } }  	// 사용 여부
		,showYn : {name:'showYn', label:'<spring:message code="column.show_yn" />', width:'100', align:'center', formatter:'select', editoptions:{value:_SHOW_YN } }
		,dispPriorRank : {name:'dispPriorRank', label:'<spring:message code="column.disp_prior_rank" />', width:'120', align:'center', editable:true, sortable:false}				// 전시 우선 순위
		
		,sysRegrNm : {name:'sysRegrNm', label:'<spring:message code="column.sys_regr_nm" />', width:'90', align:'center', sortable:false}	
		,sysRegDtm : {name:'sysRegDtm', label:'<spring:message code="column.sys_reg_dtm" />', width:'150', align:'center', formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
		,sysUpdrNm : {name:'sysUpdrNm', label:'<spring:message code="column.sys_updr_nm" />', width:'90', align:'center', sortable:false}
		,sysUpdDtm : {name:'sysUpdDtm', label:'<spring:message code="column.sys_upd_dtm" />', width:'150', align:'center', formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
	};

	 /*
		작성자 : 김재윤
		작성 일자 : 2021.05.31
		내	용 : BO에서 개인정보 접근 이력 쌓기 ( 최초 - 회원관리 - 회원 조회에서만 )

		* 가이드
			maskingUnlock = N 면 , 마스킹 해제 안함
			maskingUnlock = Y 면, 마스킹 해제

			colGbcd -> 단건 조회 및 수정 시, 정보 처리 컬럼( 공통 상수 : CommonConstants.COL_GB_CD )
			inqrGbCd -> 열람,조회,수정,다운로드 ( 공통 상수 : CommonConstants.INQR_GB_CD )

		1.개인정보 해제 시, 리로드가 되는 화면( ex : 상세 조회 화면 ) 이면 document.ready에 아래와 같이 선언
			$(document).ready(function(){
				...
				va.init(va.data.cnctHistNo);

				//다건 조회(목록 조회)
				va.la(maskingUnlock,inqrGbCd);

				//단건 조회(1명의 회원 정보 조회 시)
				va.ac(mbrNo,colGbCd,inqrGbCd,maskingUnlock);
			});

		2.개인정보 해제 시 , 리로드 없이 갱신이 되는 화면 ( ex : 그리드 ) 이면, grid.create|reload 이후 아래와 같이 선언

				options.accessYn = "Y";

				//CASE 1 다건 조회(목록 조회)
				va.la(maskingUnlock,inqrGbCd);
				//CASE 2단건 조회(1명의 회원 정보 조회 시)
				va.ac(mbrNo,colGbCd,inqrGbCd,maskingUnlock);

				options.searchParam = $.extend(serializeFormData(),va.data);
				grid.create( "orderList", options);
	 */
	var va = {
			data : {}
		,	init : function(cnctHistNo,inqrHistNo){
				va.data.cnctHistNo = null;
				if(cnctHistNo != undefined && cnctHistNo!= null && cnctHistNo != "" && !isNaN(cnctHistNo) && parseInt(cnctHistNo) != 0 ){
					va.data.cnctHistNo = cnctHistNo;
				}
				va.data.inqrHistNo = null;
				if(inqrHistNo != undefined && inqrHistNo!= null && inqrHistNo != "" && !isNaN(inqrHistNo) && parseInt(inqrHistNo) != 0 ){
					va.data.inqrHistNo = inqrHistNo;
				}
				va.data.url = "${commonMenuDetail.url}";
				va.data.menuNo = "${commonMenuDetail.menuNo}";
				va.data.actNo = "${commonMenuDetail.actNo}";
		}
		//목록으로 회원 정보 조회 시
		,	la : function(maskingUnlock,inqrGbCd){
				if(maskingUnlock == undefined || maskingUnlock == null || maskingUnlock == ""){
					maskingUnlock = "${adminConstants.COMM_YN_N}";
				}

				var data = $.extend({
						maskingUnlock : maskingUnlock
					, 	inqrGbCd : inqrGbCd
				},va.data);
				data.inqrHistNo = null;

				$.ajax({
					url : "/common/privacy-access.do"
					,	async: false
					,	data : data
					,	type : "POST"
					,	dataType : "JSON"
				}).done(function(data,textStatus,jqXHR){
					va.init(data.cnctHistNo,data.inqrHistNo);
				});
		}
		//단건으로 조회 시
		,	ac : function(mbrNo,colGbCd,inqrGbCd,maskingUnlock,execSql){
				if(maskingUnlock == undefined || maskingUnlock == null || maskingUnlock == ""){
					maskingUnlock = "${adminConstants.COMM_YN_N}";
				}

				var data =  $.extend({
						mbrNo : mbrNo
					, 	colGbCd : colGbCd
					,	maskingUnlock : maskingUnlock
					,	inqrGbCd : inqrGbCd
					,	cnctHistNo : va.data.cnctHistNo
				},va.data);
				data.inqrHistNo = null;

				$.ajax({
					url : "/common/privacy-access.do"
					,	data : data
					,	type : "POST"
					,	dataType : "JSON"
				}).done(function(data,textStatus,jqXHR){
					va.init(data.cnctHistNo,data.inqrHistNo);
					va.data.execSql = execSql;
					va.qLog(va.data);
				});
		}
		,	qLog : function(data){
				$.ajax({
					url : "/common/updateQuery.do"
					,	data : data
					,	type : "POST"
					,	dataType : "JSON"
				}).done(function(data,textStatus,jqXHR){});
		}
	};


	// 개발자도구에서의 console.[log, debug] control
	logger("<spring:eval expression="@bizConfig['envmt.gb']" />");

	$(function(){
		$(document).on("click",".fQuik",function(){
			$(".select-quik-btn").find("input[type='radio']").prop("checked",false);
			$(".select-quik-btn").find("input[type='radio']").removeAttr("checked");
			$(".select-quik-btn").removeClass("select-quik-btn");

			$(this).find("input[type='radio']").prop("checked",true);
			$(this).find("input[type='radio']").attr("checked","");
			$(this).find(".quikBtn").addClass("select-quik-btn");

			searchDateChange();
		});

		va.init();
	})
</script>