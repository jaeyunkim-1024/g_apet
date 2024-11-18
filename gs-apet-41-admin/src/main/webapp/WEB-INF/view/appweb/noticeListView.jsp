<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				// 게시판 글 그리드
// 				$("input:checkbox[name=arrPocGb]").prop("checked",true);
				fncSrchDateChange();
				bbsLetterGrid();
				//날짜선택시 selectbox 기간선택문구로 변경 
				newSetCommonDatePickerEvent("#searchDtmStart", "#searchDtmEnd"); 
	            $(document).on("keydown","#bbsLetterListForm input",function(){
	      			if ( window.event.keyCode == 13 ) {
	      				searchBBSLetterList();
	    		  	}
	            });					
			});
			
			$(function(){
				//POC 구분 클릭 이벤트
				$("input:checkbox[name=arrPocGb]").click(function(){
					var count = true;
					$('input:checkbox[name="arrPocGb"]').each( function() {
						if($(this).is(":checked")) 
						count = false;
					});
					
					if ( count == false ) {
						$("input:checkbox[id=arrPocGb_default]").prop("checked",false);
					}else{
						$("input:checkbox[id=arrPocGb_default]").prop("checked", true);
					}
				});
			});

			// 게시판 글 리스트
			function bbsLetterGrid(){
				var options = {
					url : "<spring:url value='/${board.bbsId}/bbsLetterListGrid.do' />"
					, height : 400
					, searchParam : $("#bbsLetterListForm").serializeJson()
					, colModels : [
						// 글 번호
						{name:"lettNo", label:'<spring:message code="column.lett_no" /></tt></u></b>', width:"70", align:"center", sortable:false, formatter:'integer'}
						// 분류
						, {name:"bbsGbNm", label:'분류</tt></u></b>', width:"100", align:"center", sortable:false}
						// OS구분
						, {name:"pocGbCd", label:'OS 구분</tt></u></b>', width:"130", align:"left",  sortable:false}
						// 제목
						, {name:"ttl", label:'<b><u><tt><spring:message code="column.ttl" /></tt></u></b>', width:"370", align:"left", classes:'pointer fontbold', sortable:false}
						// 게시상태
						, {name:"bbsStatCd", label:'게시상태</tt></u></b>', width:"80", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.BBS_STAT_CD}" />"}}
						// 공지기간
						, {name:"bbsDtm", label:'공지기간</tt></u></b>', width:"200", align:"center", sortable:false,formatter: function(rowId, val, rawObject, cm) {
							if(rawObject.bbsDtm == null ) return "";
							else if(rawObject.bbsDtm != null && rawObject.bbsDtm.indexOf("1999") > -1 ) return "무기한" ;
			 				else return rawObject.bbsDtm ;
			 			}} 
						// 알림발송여부
						, {name:"almSndYn", label:'알림발송여부</tt></u></b>', width:"80", align:"center", sortable:false, formatter: function(rowId, val, rawObject, cm) {
			 				if(rawObject.almSndYn == "Y") return "발송" ;
			 				else return "미발송" ;
			 			}}
						// 시스템 등록자
						, {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center", sortable:false}
						// 시스템 등록 일시
						, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
						, {name:"bbsId", hidden:true }  
					]
					, multiselect : false
					, cellEdit : true
					, onCellSelect : function (ids, cellidx, cellvalue) {
						if(cellidx != 0) { // CODE 선택
							var rowdata = $("#bbsLetter").getRowData(ids);
							bbsLetterDetailView(rowdata.lettNo);
						}
					}, gridComplete : function() {

						$("#noData").remove();
						var grid = $("#bbsLetter").jqGrid('getRowData');
						if(grid.length <= 0) {
							var str = "";
							str += "<tr id='noData' role='row' class='jqgrow ui-row-ltr ui-widget-content'>";
							str += "	<td role='gridcell' colspan='9' style='text-align:center;'>조회결과가 없습니다.</td>";
							str += "</tr>"
								
							$("#bbsLetter.ui-jqgrid-btable").append(str);
						}
						
						
					}
				};
				grid.create("bbsLetter", options);
			}
			
			

			// 게시판 등록
			function bbsLetterView(bbsId) {
				var title = getSeletedTabTitle();
				addTab(title + ' 등록', '/appweb/NoticeWriteView.do?bbsId=${board.bbsId}');
			}

			

			// 게시판 상세보기
			function bbsLetterDetailView(lettNo) {
				var title = getSeletedTabTitle();
				addTab(title + ' 상세', '/appweb/NoticeWriteView.do?lettNo=' + lettNo+'&bbsId=${board.bbsId}');
			}
			

	
			
		     // 게시글 검색 조회
	        function searchBBSLetterList () {
	        	//검색버튼 click이후에 alert창 띄우기 
				compareDateAlert("searchDtmStart", "searchDtmEnd", "term");
	        	
	        	var pocVal = $("input[name*='arrPocGb']:checked").val();
				if(pocVal == null || pocVal == ""){
					messager.alert('POC 구분을 선택해 주세요', "Info", "info");
					return false;
				} 
				
	            var options = {
	                searchParam : fncSerializeFormData()
	            };
	            
	            gridReload('searchDtmStart','searchDtmEnd','bbsLetter','term', options);
	        }

	        // 초기화 버튼클릭
	        function searchReset () {
	            resetForm ("bbsLetterListForm");
	            fncSrchDateChange();
	        }
	        
	    	// 업데이트일 변경
			function fncSrchDateChange() {
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "") {
					$("#searchDtmStart").val("");
					$("#searchDtmEnd").val("");
				}else if(term == "50"){
					//3개월 기간조회시에만 호출하는 메소드
					setSearchDateThreeMonth("searchDtmStart", "searchDtmEnd");
				} else {
					setSearchDate(term, "searchDtmStart", "searchDtmEnd");
				}
			}
	    	
			//selectbox관련
			function fncSerializeFormData() {
	            var data = $("#mobileSearchForm").serializeJson();
	            if ( undefined != data.arrMobileOs && data.arrMobileOs != null && Array.isArray(data.arrMobileOs) ) {
	                $.extend(data, {arrMobileOs : data.arrMobileOs.join(",")});
	            } else {
	                // 전체를 선택했을 때 Array.isArray 가 false 여서 이 부분을 실행하게 됨.
	                // 전체를 선택하면 검색조건의 모든 POC구분을 배열로 만들어서 파라미터 전달함.
	                var arrMobileOs = new Array();
	                if ($("#arrMobileOs_default").is(':checked')) {
	                    $('input:checkbox[name="arrMobileOs"]').each( function() {
	                        if (! $(this).is(':checked')) {
	                        	arrMobileOs.push($(this).val());
	                        }
	                    });

	                    $.extend(data, {arrMobileOs : arrMobileOs.join(",")});
	                }
	            }
	            return data;
			}
			
			//poc 전체 클릭 시 처리
			function fncSelectAllPoc(){
				var allFlag =$("#arrPocGb_default").is(":checked");
				if(allFlag){
					$("input:checkbox[name=arrPocGb]").prop("checked",false);
				}
				else{
					$("input:checkbox[name=arrPocGb_default]").prop("checked",true);
				}
			}
			
			// form data set - poc관련
			function fncSerializeFormData() {
	            var data = $("#bbsLetterListForm").serializeJson();
	            if ( undefined != data.arrPocGb && data.arrPocGb != null && Array.isArray(data.arrPocGb) ) {
	                $.extend(data, {arrPocGb : data.arrPocGb.join(",")});
	            } else {
	                // 전체를 선택했을 때 Array.isArray 가 false 여서 이 부분을 실행하게 됨.
	                // 전체를 선택하면 검색조건의 모든 POC구분을 배열로 만들어서 파라미터 전달함.
	                var arrPocGb = new Array();
	                if ($("#arrPocGb_default").is(":checked")) {
	                    $('input:checkbox[name="arrPocGb"]').each( function() {
	                        if (! $(this).is(':checked')) {
	                        	arrPocGb.push($(this).val());
	                        }
	                    });

	                    $.extend(data, {arrPocGb : arrPocGb.join(",")});
	                }
	            }

	            return data;
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

		<%-- <c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd and board.bbsId eq 'cpnotice'}"> --%>
			<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
				<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
		<%-- </c:if>		 --%>
					<form id="bbsLetterListForm" name="bbsLetterListForm" method="post" >
						<table class="table_type1">
							<caption>게시판 글 목록</caption>
							<tbody>
								<tr>
									<th scope="row"><spring:message code="column.faq.gb" /></th>
									<td>
										<!-- 구분 -->
										<select name="bbsGbNo" id="bbsGbNo" title="<spring:message code="column.faq.gb" />">
											<option value="">전체</option>
											<c:forEach items="${gb}" var="item">
												<option value="${item.bbsGbNo}">${item.bbsGbNm}</option>
											</c:forEach>
										</select>
									</td>
									<th scope="row">게시상태</th>
									<td>
										<select id="bbsStatCd" name="bbsStatCd" >  											
											<frame:select grpCd="${adminConstants.BBS_STAT_CD }" />
										</select>
									</td>
								</tr>
								<tr>
									<th scope="row">알림발송 여부</th>
									<td colspan="3">
										<!-- 알림발송 여부 -->
										<select name="almSndYn" id="almSndYn" title="알림발송 여부">
											<option value="" selected="selected">전체</option>
											<option value="Y">발송</option>
											<option value="N">미발송</option>
										</select>
									</td>
								</tr>	
								<tr> 
									<th scope="row">POC 구분</th>
									<td colspan="3">
										<label class="fCheck">
											<input type="checkbox"  id="arrPocGb_default" name="arrPocGb_default" checked="checked" value="0" onClick="fncSelectAllPoc()"> 
											<span >전체</span>
										</label>
										(<frame:checkbox  name="arrPocGb" grpCd="${adminConstants.POC_GB}" />)
									</td>
								</tr>
								<tr>
									<th scope="row"><spring:message code="column.faq.regist_date" /></th> <!-- 업데이트 일 -->
									<td colspan="3">
										<select name="dateType" id="dateType" title="알림발송 여부">
											<option value="regDtm" selected="selected">게시일자</option>
											<option value="endDtm">만료일자</option>
											<option value="updDtm">수정일자</option>
										</select>
										<frame:datepicker startDate="searchDtmStart" startValue="${frame:toDate('yyyy-MM-dd')}" endDate="searchDtmEnd" endValue="${frame:toDate('yyyy-MM-dd')}" />
										&nbsp;
										<select id="checkOptDate" name="checkOptDate" onchange="fncSrchDateChange();">
											<frame:select grpCd="${adminConstants.SELECT_PERIOD }"  selectKey="${adminConstants.SELECT_PERIOD_40 }" defaultName="기간선택" excludeOption="${adminConstants.SELECT_PERIOD_30 },${adminConstants.SELECT_PERIOD_50 }"/>
										</select>
									</td>
								</tr>
								<tr>
									<th scope="row"><spring:message code="column.faq.search_text" /></th>
									<td colspan="3">
										<!-- 검색어 -->
										<select name="searchType" id="searchType" title="<spring:message code="column.faq.search_text" />">
											<option value="ttl" selected="selected">제목</option>
											<option value="cont">내용</option>
										</select>
										<input type="text" name="searchWord" style="width:38%;" title="<spring:message code="column.faq.search_text" />" >
									</td>
								</tr>
								
							</tbody>
						</table>
					</form>
		<%-- <c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd and board.bbsId eq 'cpnotice'}"> --%>
				    <div class="btn_area_center">
			           <button type="button" onclick="searchBBSLetterList();" class="btn btn-ok">검색</button>
			           <button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
			        </div>
				</div>
			</div>
		<%-- </c:if> --%>

			<div class="mModule">
				<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
				<div style="left:90%;width: fit-content;">
					<button type="button" onclick="bbsLetterView('');" class="btn btn-add">+공지사항 등록</button>
				</div>
				</c:if>
			
				<table id="bbsLetter" class="grid"></table>
				<div id="bbsLetterPage"></div>
			</div>
</t:putAttribute>
</t:insertDefinition>
<style>
.ui-jqgrid tr.jqgrow td { text-overflow: ellipsis; -o-text-overflow: ellipsis; white-space: nowrap; }
</style>
