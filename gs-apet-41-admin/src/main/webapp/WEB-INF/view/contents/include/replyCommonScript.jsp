<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	$(document).ready(function(){
		searchDateChange();
		newSetCommonDatePickerEvent('#strtDate','#endDate');
	});
	
	// 펫TV 댓글 목록 그리드
	function apetReplyListGrid(rptpGb){
		var options = {
			url : "<spring:url value='/contents/listApetReplyGrid.do' />"
			, height : 400
			, searchParam : $("#contsReplyListForm").serializeJson()
			, multiselect : true
			, cellEdit : true
			, colModels : [
					// 댓글 순번
					{name:"aplySeq", label:'댓글 번호', width:"80", align:"center", hidden:true, classes:'pointer fontbold', sortable:false}
					// 댓글-답변 구분값
					, {name:"replyGb", label:'구분', width:"120", align:"center", hidden:true, sortable:false}
					// 등록일(수정일)
					, {name:'sysRegDate', label:'<spring:message code="column.reply.reg_upd_dtm" />', width:'100', align:'center', sortable:false}
					// 수정일시
					, {name:'sysUpdDate', label:'<spring:message code="column.sys_upd_dtm" />', width:'150', align:'center', hidden:true, sortable:false}
					// 답변 등록일시
					, {name:'rplRegDate', label:'<spring:message code="column.sys_reg_dtm" />', width:'150', align:'center', hidden:true, sortable:false}
					// 답변 수정일시
					, {name:'rplUpdDate', label:'<spring:message code="column.sys_upd_dtm" />', width:'150', align:'center', hidden:true, sortable:false}
					// 영상ID
					, {name:"vdId", label:'<spring:message code="column.vd_id" />', width:"150", align:"center", classes:'pointer', sortable:false}
					// 썸네일 이미지
					, {name:"thumPath", label:'<spring:message code="column.thum" />', width:"120", align:"center", classes:'pointer', sortable:false, formatter: function(cellvalue, options, rowObject) {
							if(rowObject.thumPath != "" && rowObject.thumPath != null) {
								var imgPath = rowObject.thumPath.indexOf('cdn.ntruss.com') > -1 ? rowObject.thumPath : '${frame:optImagePath("' + rowObject.thumPath + '", adminConstants.IMG_OPT_QRY_400)}';
								return '<img src='+imgPath+' style="width:100px; height:100px;" onError="this.src=\'/images/noimage.png\'"  />';
							} else {
								return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
							}
						}
					}
					// 영상 제목
					, {name:"ttl", label:'영상 제목', width:"300", align:"left", classes:'pointer vodTtlColor', sortable:false}
					// 등록자
					, {name:"loginId", label:'<spring:message code="column.reply.regr_nm" />', width:"200", align:"center", sortable:false, classes:'pointer', formatter: function(cellvalue, options, rowObject) {
						var str;
						if (rowObject.replyGb == "R") {
							str = "<p style='font-weight:bold; margin-right:18px;'>&#9495;&nbsp;&nbsp;" + rowObject.replyRegrNm + "</p>";
						} else {
							str = cellvalue;
						}
						return str;
					}}
                    // 댓글
                    , {name:"aply", label:'<spring:message code="column.reply.content" />', width:"555", align:"left", classes:'pointer', sortable:false, formatter: function(cellvalue, options, rowObject) {
                    	var str;
                    	if (rowObject.replyGb == "R") {
                    		str = "<b>@ " + rowObject.loginId;
                    		str += "</b><br>";
                    		str += rowObject.aply;
                    	} else {
                    		str = rowObject.aply;
                    	}
                    	return str;
                    }}
                 	// 답변
					, {name:"rpl", label:'답변', width:"700", align:"center", hidden:true, sortable:false}
                 	// 답변자 명
                    , {name:"replyRegrNm", label:'답변자 명', width:"700", align:"center", hidden:true, sortable:false}
                 	// 신고 접수 건수
                    , {name:"rptpCnt", label:'<spring:message code="column.reply.rptp_cnt" />', width:"80", align:"center", sortable:false}
					// 컨텐츠 상태 (전시 여부)
					, {name:"contsStatCd", label:'<spring:message code="column.disp_yn" />', width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CONTS_STAT}" />"}}
				]
			, onCellSelect : function (id, cellidx, cellvalue) {
				var rowData = $("#contsReplyList").getRowData(id);
				if (cellidx == 10 || cellidx == 11) {
					// 댓글 상세
					if ("${replyGb}" == "apet") {
						apetReplyDetailView(rowData.aplySeq, rowData.loginId, rowData.rpl);	
					} else if ("${replyGb}" == "apetRptp") {
						apetReplyRptpDetailView(rowData.aplySeq, rowData.loginId, rowData.rpl);
					}
					gridRowId = id;
					replyGbData = rowData.replyGb;
				}
				
				if ((cellidx == 7 || cellidx == 8 || cellidx == 9) && rowData.replyGb == 'A') {
					vodView(rowData.vdId);
				}
			}
			, loadComplete : function(data) {
				var rowIds = $("#contsReplyList").jqGrid("getDataIDs");
                var gridData = $("#contsReplyList").jqGrid("getRowData");
                var jsonData = {};
                var rowIdCount;
                var td;
				
            	if (gridData.length > 0) {
	                for (var i=0; i<gridData.length; i++) {
	                	var strSys;
	                	strSys = gridData[i].sysRegDate + "<br><p style='font-size:11px;'>(" + gridData[i].sysUpdDate+ ")</p>";
						$("#contsReplyList").jqGrid("setCell",rowIds[i],"sysRegDate",strSys);
	                	if (gridData[i].rpl) {
	                		var strRpl;
	                		strRpl = gridData[i].rplRegDate + "<br><p style='font-size:11px;'>(" + gridData[i].rplUpdDate + ")</p>";
							$("#contsReplyList").jqGrid("setCell",rowIds[i],"sysRegDate",strSys);
		                	var jsonData = {
								aply : gridData[i].rpl
								, rpl : gridData[i].rpl
								, aplySeq : gridData[i].aplySeq
								, contsStatCd : gridData[i].contsStatCd
								, loginId : gridData[i].loginId
								, replyRegrNm : gridData[i].replyRegrNm
								, replyGb : "R"
								, sysRegDate : gridData[i].sysRegDate
								, sysUpdDate : gridData[i].sysUpdDate
								, rplRegDate : gridData[i].rplRegDate
								, rplUpdDate : gridData[i].rplUpdDate
							}
		                	
		                	rowIdCount = $("#contsReplyList").getGridParam("reccount")+1;
			                $("#contsReplyList").jqGrid("addRowData",rowIdCount,jsonData,"after",rowIds[i]);
			                $("#contsReplyList").jqGrid("setCell",rowIdCount,"sysRegDate",strRpl);
			                
							td = $("#contsReplyList").find("tr[id="+rowIdCount+"]").find("td[aria-describedby=contsReplyList_cb],td[aria-describedby=contsReplyList_vdId],td[aria-describedby=contsReplyList_ttl],td[aria-describedby=contsReplyList_thumPath]");
							$(td).empty();
							td = $("#contsReplyList").find("tr[id="+rowIdCount+"]").find("td[aria-describedby=contsReplyList_ttl],td[aria-describedby=contsReplyList_vdId],td[aria-describedby=contsReplyList_thumPath]");
							$(td).attr('class', '');
	                	}
	                }
	                td = $("#contsReplyList").find("tr").find("td[aria-describedby=contsReplyList_loginId]");
					$(td).css('color', '#0066CC');
					addRowNo = rowIdCount;
            	}
			}
			, grouping: true
			, groupField: ["aplySeq"]
			, groupText: ["댓글 번호"]
			, groupOrder : ["desc"]
			, groupCollapse: false
			, groupColumnShow : [false]
		};
		if (rptpGb != undefined) {
			$.extend(options.searchParam, {
				rptpGb : rptpGb
			});
		}
		grid.create("contsReplyList", options);
	}
	
	// 펫로그 댓글 목록 그리드
	function petLogReplyListGrid(rptpGb){
		var options = {
			url : "<spring:url value='/contents/listPetLogReplyGrid.do' />"
			, height : 400
			, searchParam : $("#contsReplyListForm").serializeJson()
			, multiselect : true
			, cellEdit : true
			, colModels : [
					// 댓글 번호
					{name:"petLogAplySeq", label:'댓글 번호', width:"80", align:"center", sortable:false}
					// 등록일(수정일)
					, {name:'sysRegDtm', label:'<spring:message code="column.reply.reg_upd_dtm" />', width:'100', align:'center', sortable:false, formatter: function(cellvalue, options, rowObject) {
						return new Date(rowObject.sysRegDtm).format("yyyy-MM-dd") + "<br><p style='font-size:11px;'>(" + new Date(rowObject.sysUpdDtm).format("yyyy-MM-dd") + ")</p>";
					}}
					// 펫로그 내용
					, {name:"dscrt", label:'펫로그 내용', width:"540", align:"left", sortable:false, classes:'pointer'}
					// 등록자
					, {name:"loginId", label:'등록자', width:"180", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
						var str;
						if (cellvalue == null) {
							str = "member" + options.rowId;
							return str;
						} else {
							return cellvalue;
						}
					}}
                    // 댓글(내용)
                    , {name:"aply", label:'댓글', width:"535", align:"center", sortable:false}		
                 	// 신고 접수 건수
                    , {name:"rptpCnt", label:'<spring:message code="column.reply.rptp_cnt" />', width:"80", align:"center", sortable:false}
					// 컨텐츠 상태 (전시 여부)
					, {name:"contsStatCd", label:'전시 여부', width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CONTS_STAT}" />"}}
					// 수정일시
					, {name:'sysUpdDtm', label:'<spring:message code="column.sys_upd_dtm" />', width:'150', align:'center', hidden:true, sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
					// 펫로그 번호
                    , {name:"petLogNo", label:'<spring:message code="column.no" />', width:"80", align:"center", hidden:true, sortable:false}
				]
			, onCellSelect : function (id, cellidx, cellvalue) {
				if (cellidx == 3) {
					var rowData = $("#contsReplyList").getRowData(id);
					if ("${replyGb}" == "petLogRptp") {
						petLogReplyRptpDetailView(rowData);
					}
				}
			}
			, loadComplete : function(data) {
            	var td = $("#contsReplyList").find("tr").find("td[aria-describedby=contsReplyList_dscrt]");
				$(td).css('color', '#0066CC');
			}
		};
		if (rptpGb != undefined) {
			$.extend(options.searchParam, {
				rptpGb : rptpGb
			});
		}
		grid.create("contsReplyList", options);
	}
	
	//전시 여부 일괄 변경
	function updateSelectAllReply() {
		var rowIds = $("#contsReplyList").jqGrid('getGridParam', 'selarrrow');
		if (rowIds.length <= 0) {
			messager.alert("변경할 목록을 선택해 주세요.", "Info", "info");
			return;
		}
		
		if (!$("#contsStat").val()) {
			messager.alert("전시 변경 상태 값을 선택해 주세요.", "Info", "info");
			$("#contsStat").focus();
			return;
		}
		
		messager.confirm("선택 댓글의 전시 상태를 변경합니다.", function(r) {
			if (r) {
				var arrReplySeq = new Array();
				var selectData;
				for (var i=0; i<rowIds.length; i++) {
					selectData = $("#contsReplyList").jqGrid("getRowData", rowIds[i]);
					if (selectData.contsStatCd != $("#contsStat").val()) {
						arrReplySeq.push("${replyGb}" == "apet" || "${replyGb}" == "apetRptp" ? selectData.aplySeq : selectData.petLogAplySeq);
					}
				}
				
				if (arrReplySeq.length > 0) {
					var sendData = {
						arrReplySeq : arrReplySeq
						, contsStatCd : $("#contsStat").val()
					}
					var options = {
						  url : "${replyGb}" == "apet" || "${replyGb}" == "apetRptp" ? "/contents/updateApetReplyContsStat.do" : "/contents/updatePetLogReplyContsStat.do"
						, data : sendData
						, callBack : function(data) {
							grid.reload("contsReplyList", options);
						}
					};
					ajax.call(options);
				} else {
					var options = {
							searchParam : $("#contsReplyListForm").serializeJson()
					};
					grid.reload("contsReplyList", options);
				}
				
			}
		});
	}
	
	// 댓글 검색
	function searchReplyList(){
		compareDateAlert('strtDate','endDate','term');
		var strtDateVal = $("#strtDate").val();
		var endDateVal = $("#endDate").val();
		var dispStrtDtm = $("#strtDate").val().replace(/-/gi, "");
		var dispEndDtm = $("#endDate").val().replace(/-/gi, "");
		var diffMonths = getDiffMonths(dispStrtDtm, dispEndDtm);
		var term = $("#checkOptDate").children("option:selected").val();	
		
		var options = {
				searchParam : $("#contsReplyListForm").serializeJson()
				, rptpCnt : $("#rptpCnt option:selected").val()
		};
		if (options.searchParam.vdSearchTxt) {
			if (!options.searchParam.vdSearchGb) {
				messager.alert("영상별 검색 구분을 선택해 주세요.", "Info", "info");
				return;
			}
		}
		if((strtDateVal != "" && endDateVal != "") || (strtDateVal == "" && endDateVal == "")){ // 시작날짜 종료날짜 둘다 있을 때 시작날짜 종료날짜 둘다 없을 때만 조회
			if(term == "50" || diffMonths <= 3){ 				//날짜 3개월 이상 차이 날때 조회 X term이 3개월일 때는 예외적 허용 예를들어 2월 28일과 5월 31일은 90일이 넘기때문
				grid.reload("contsReplyList", options);
			}
		}
	}
	
	// 목록 초기화
	function searchReset(form){
		resetForm(form);
		searchDateChange();
	}
	
	// 기간 검색
	function searchDateChange(){
		var term = $("#checkOptDate").children("option:selected").val();
		if(term == "" ) {
			$("#strtDate").val("");
			$("#endDate").val("");
		} else if(term == "50") {
			setSearchDateThreeMonth("strtDate","endDate");
		} else {
			setSearchDate(term, "strtDate", "endDate");
		}
	}
	
	// 운영자 답변 등록 시 행 추가
	function addGridRow(grid,jsonData){
		var updateRowId = $("#contsReplyList tr[id="+gridRowId+"]").next("tr").attr("id");
		if (replyGbData == "R") {
			updateRowId = gridRowId;
		}
		addRowNo = addRowNo+1;
		var str = new Date(jsonData.sysRegDtm).format("yyyy-MM-dd") + "<br><p style='font-size:11px;'>(" + new Date(jsonData.sysUpdDtm).format("yyyy-MM-dd") + ")</p>";
		
		if (isInsertGb) {
			$(grid).jqGrid("addRowData",addRowNo,jsonData,"after",gridRowId);
			$(grid).jqGrid("setCell",gridRowId,"rpl",jsonData.rpl);
			$(grid).jqGrid("setCell",addRowNo,"sysRegDtm",str);
			$(grid).jqGrid("setCell",gridRowId,"rplRegDtm",jsonData.sysRegDtm);
			$(grid).jqGrid("setCell",gridRowId,"rplUpdDtm",jsonData.sysUpdDtm);
			
			var td = $("#contsReplyList").find("tr[id="+addRowNo+"]").find("td[aria-describedby=contsReplyList_loginId]");
			$(td).css('color', '#0066CC');
			td = $("#contsReplyList").find("tr[id="+addRowNo+"]").find("td[aria-describedby=contsReplyList_cb],td[aria-describedby=contsReplyList_vdId],td[aria-describedby=contsReplyList_ttl],td[aria-describedby=contsReplyList_thumPath]");
			$(td).empty();
			td = $("#contsReplyList").find("tr[id="+addRowNo+"]").find("td[aria-describedby=contsReplyList_ttl],td[aria-describedby=contsReplyList_vdId],td[aria-describedby=contsReplyList_thumPath]");
			$(td).attr('class', '');
		} else {
			$(grid).jqGrid("setRowData",updateRowId,jsonData);
			$(grid).jqGrid("setCell",updateRowId,"sysRegDtm",str);
			var td = $("#contsReplyList").find("tr[id="+updateRowId+"]").find("td[aria-describedby=contsReplyList_ttl],td[aria-describedby=contsReplyList_vdId],td[aria-describedby=contsReplyList_thumPath]");
			$(td).attr('class', '');
		}
	}
	
	// 영상 상세
	function vodView(vdId) {
		addTab('영상 상세', '/contents/vodDetailView.do?vdId=' + vdId);
	}
</script>