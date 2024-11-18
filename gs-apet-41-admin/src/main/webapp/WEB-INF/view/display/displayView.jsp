<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function() {
				// 사이트 select 생성 --> 비노출 처리
				// createStStdInfoSelect();
				createDisplayTree();
			});
			
			// 브랜드 검색
			function searchBrand () {
				var options = {
					bndGbCd : "${adminConstants.BND_GB_30}"
					, multiselect : false
					, callBack : function(result) {
						if(result.length > 0 ) {
							$("#bndNo").val(result[0].bndNo );
							$("#bndNmKo").val(result[0].bndNmKo);
							$("#bndNmEn").val(result[0].bndNmEn);
						}
					}
				}
				layerBrandList.create(options);
			}

			// 기본정보 템플릿 문구 노출
			$(document).on("change", "#tmplNo", function(e) {
				var templateWords = $("#tmplNo option:selected").text() + "<spring:message code="column.display_view.message.template_words" />";
				$("#templateWords").text(templateWords);
			});

			// 기획전 검색조건
			$(document).on("change", "#selectStId", function(e) {
				$("#displayTree").jstree().refresh();
				$("#stId").val ($("#selectStId option:selected").val());
			});
/* 전시메인화면 기획전 삭제 2017-06-08
			// 기획전 검색조건
			$(document).on("change", "#searchPlan", function(e) {
				$("#displayTree").jstree().refresh();
			});
 */			
			// 사이트 select 생성
			function createStStdInfoSelect() {
				var options = {
					url : "<spring:url value='/st/stList.do' />"
					, callBack : function(result) {
						var rows = result.rows;
						var selectStId = "";
						
						jQuery(rows).each(function(i){
							if (i ==0) {
								selectStId += "<option value='" + rows[i].stId + "'selected='selected'>" + rows[i].stId + " - " + rows[i].stNm + "</option>";
								$("#stId").val (rows[i].stId);
							} else {
								selectStId += "<option value='" + rows[i].stId + "'>" + rows[i].stId + " - " + rows[i].stNm + "</option>";
							}
	                    });

						jQuery("#selectStId").append(selectStId);
						// 전시 관리 트리 생성
						createDisplayTree();
					}
				};

				ajax.call(options);
			}
			
			function emptyDisplayView() {
				// 전시 기본정보
				$("#displayBaseView").empty();
				// 전시 코너
				$("#displayCornerListView").empty();
				// 전시 분류 아이템
				$("#displayClsfCornerListView").empty();
				// 전시 코너 아이템
				$("#displayCornerItemListView").empty();
				// 전시 상품
				$("#displayGoodsListView").empty();
				// 관련 브랜드
				$("#displayBrandListView").empty();
				//쇼룸 전시 상품
				$("#displayShowRoomGoodsListView").empty();
			}
			// 전시 관리 트리 생성
			function createDisplayTree() {
				emptyDisplayView()
				$("#displayTree").jstree({
					core : {
						multiple : false
						, data : {
							type : "POST"
							, url : function(node) {
								return "/display/displayListTree.do";
							}
							, data : function(node) {
								var data = {
									/* 전시메인화면 기획전 삭제 2017-06-08 searchPlan : $("#searchPlan option:selected").val()
									, */ stId : '1'
								};

								return data;
							}
						}
					}
					, plugins : [ "themes" ]
				})
				.on('changed.jstree', function(e, data) {
					var dispClsfNo = "";	// 전시 분류 번호
					var dispClsfCd = "";	// 전시 분류 코드
					var dispLvl = 0;		// 전시 레벨
					for(var i = 0; i < data.selected.length; i++) {
						dispClsfNo = data.instance.get_node(data.selected[i]).id;
						dispClsfCd = data.instance.get_node(data.selected[i]).original.dispClsfCd;
						dispLvl = data.instance.get_node(data.selected[i]).original.dispLvl;

					}

					var result = {
						dispClsfCd : dispClsfCd
						, dispClsfNo : dispClsfNo
						, upDispClsfNo : dispClsfNo
						, dispLvl : dispLvl
						, stId : $("#selectStId option:selected").val()
					}
					
					if(result.dispClsfCd == '${adminConstants.DISP_CLSF_30}' || result.dispLvl == 0 || result.dispLvl == 3) {
						$("#categoryAdd").css("display" , "none");
					}else {
						$("#categoryAdd").css("display" , "");
					}
					if(dispClsfNo != "" && result.dispLvl > 0) {
						displayBaseView(result, false);
					}else if(result.dispLvl== 0) {
						emptyDisplayView();
					}
				})
				.bind("ready.jstree", function (event, data) {
					// 전시트리 전체 열기
					//$("#displayTree").jstree("open_all");
					// 기획전 배너 영역
					$(".planBnr").empty();
					// 기획전 노출 상품수
					$(".planGdsCnt").empty();
				})
				.bind("refresh.jstree", function (event, data) {
					updateTab();
				});
			}

			// 전시 기본정보
			function displayBaseView(data, isAdd) {
				var options = {
					url : "<spring:url value='/display/displayBaseView.do' />"
					, data : data
					, dataType : "html"
					, callBack : function(result){
						$("#displayBaseView").html(result);

						// 기본정보 템플릿 문구 노출
						var templateWords = $("#tmplNo option:selected").text() + "<spring:message code="column.display_view.message.template_words" />";
						$("#templateWords").text(templateWords);

						// 전시 코너
						$("#displayCornerListView").empty();
						// 전시 분류 아이템
						$("#displayClsfCornerListView").empty();
						// 전시 코너 아이템
						$("#displayCornerItemListView").empty();
						// 전시 상품
						$("#displayGoodsListView").empty();
						// 관련 브랜드
						$("#displayBrandListView").empty();
						//쇼룸 전시 상품
						$("#displayShowRoomGoodsListView").empty();

						// 1 Depth 이상인 경우,
						if(data.dispLvl >= 1 && data.dispClsfNo != null) {
							// 기획전이 아닌 경우,
							if("${adminConstants.DISP_CLSF_20}" != data.dispClsfCd) {
								// 기획전 배너 영역
								$(".planBnr").empty();
								// 기획전 노출 상품수
								$(".planGdsCnt").empty();
								
								// 브랜드 일 경우,
								if("${adminConstants.DISP_CLSF_40}" == data.dispClsfCd){
									// 관련 브랜드 화면
									displayBrandListView(data.dispClsfNo);
								} else {
									// 전시 코너 화면 (1 depth만 노출)
// 									if (data.dispLvl == 1) { 
										displayCornerListView(data.dispClsfNo, $("#tmplNo").val());
// 									}
								}							
							}
						} else {
							// 기획전이 아닌 경우,
							if("${adminConstants.DISP_CLSF_20}" != data.dispClsfCd) {
								// 기획전 배너 영역
								$(".planBnr").empty();
								// 기획전 노출 상품수
								$(".planGdsCnt").empty();
							}
						}

						// 기획전인 경우,
						if("${adminConstants.DISP_CLSF_20}" == data.dispClsfCd) {
							if(data.dispLvl < 3) {
								// 기획전 배너 영역
								$(".planBnr").hide();
								// 기획전 노출 상품수
								$(".planGdsCnt").hide();
								
								if(data.dispLvl < 1) {
									// 기획전 화면 템플릿(2depth 비노출)
									$(".planTmpl").show();
								} else if((data.dispLvl == 2 && !isAdd)
									|| (data.dispLvl == 1 && isAdd)) {
									// 기획전 배너 영역
									$(".planBnr").show();
									// 기획전 타이틀 HTML(PC)
									EditorCommon.setSEditor("dispClsfTitleHtml", '${adminConstants.DISPLAY_IMAGE_PATH}');
									// 기획전 타이틀 HTML(MOBILE)
									EditorCommon.setSEditor("dispClsfTitleHtmlMo", '${adminConstants.DISPLAY_IMAGE_PATH}');
								} else {
									if(data.dispClsfNo == null) {
										// 기획전 노출 상품수
										$(".planGdsCnt").show();
									} else {
										// 기획전 노출 상품수
										$(".planGdsCnt").hide();
										// 기획전 타이틀 HTML(PC)
										EditorCommon.setSEditor("dispClsfTitleHtml", '${adminConstants.DISPLAY_IMAGE_PATH}');
										// 기획전 타이틀 HTML(MOBILE)
										EditorCommon.setSEditor("dispClsfTitleHtmlMo", '${adminConstants.DISPLAY_IMAGE_PATH}');										
									}
								}
								
								if(data.dispLvl == 2 && isAdd) {
									// 기획전 화면 템플릿(3depth 비노출)
									$(".planTmpl").hide();
								}
							} else {
								// 기획전 화면 템플릿(3depth 비노출)
								$(".planTmpl").hide();
								// 기획전 배너 영역
								$(".planBnr").hide();
								// 전시 상품 리스트 화면
// 								if(data.LeafYn != "Y") {
// 									// 기획전 화면 템플릿(3depth 비노출)
// 									displayGoodsListView(data.dispClsfNo);
// 								}
							}
						}
						// $("#stId").val ($("#selectStId option:selected").val());
						$("#stId").val ('1');
					}
				};

				ajax.call(options);
			}

			// 배너 이미지(PC) 파일 업로드
			function resultBnrPcImage(result) {
				$("#bnrImgPath").val(result.filePath);
				$("#bnrImgNm").val(result.fileName);
			}

			// 배너 이미지(MOBILE) 파일 업로드
			function resultBnrMobileImage(result) {
				$("#bnrMobileImgPath").val(result.filePath);
				$("#bnrMobileImgNm").val(result.fileName);
			}
			
	        // 대카테고리 이미지 파일 업로드
            function resultDispClsfImage(result) {
                $("#tnImgPath").val(result.filePath);
                $("#tnImgNm").val(result.fileName);
                var tnImgSrc = $("#tnImgPathView").attr('src');
                if(tnImgSrc != null && tnImgSrc != undefined && tnImgSrc != ""){
                	$("#tnImgPathView").attr('src', '/common/imageView.do?filePath=' + result.filePath);
                    $("#tnImgPathView").attr('alt', result.fileName);
                } else {
                	$("#tnImgPathView").attr('src', '/common/imageView.do?filePath=' + result.filePath);
                    $("#tnImgPathView").attr('alt', result.fileName);
                    $("#tnImgPathView").closest('td').append('&nbsp;<button type="button" class="btn" onclick="deleteDispClsfImage();">삭제</button>');
                }
            }
	        
            // 대카테고리 이미지 파일 삭제
            function deleteDispClsfImage() {
                $("#tnImgPath").val('');
                $("#tnImgNm").val('');
                $("#tnImgPathView").attr('src', '/images/noimage.png');
                $("#tnImgPathView").attr('alt', '');
            }

			// 전시목록 추가
			function displayAddView() {
				var data = $("#displayTree").jstree();
				var length = data._data.core.selected.length;
				var upDispClsfNo = "";	// 상위 전시 분류 번호
				var dispClsfCd = "";	// 전시 분류 코드
				var dispLvl = 0;		// 전시 레벨

				for (var i = 0; i < length; i++) {
					upDispClsfNo = $("#displayTree").jstree().get_node(data._data.core.selected[i]).id;
					dispClsfCd = $("#displayTree").jstree().get_node(data._data.core.selected[i]).original.dispClsfCd;
					dispLvl = $("#displayTree").jstree().get_node(data._data.core.selected[i]).original.dispLvl;
				}

				// 최하위 레벨이면 추가 불가
				if("${adminConstants.DISP_CLSF_40}" == dispClsfCd) { // 브랜드 카테고리 이면,
					if(dispLvl == 2) {
						
						messager.alert('<spring:message code="column.display_view.message.tree_fail" />',"Info","info");	
						return;
					}
				} else {
/* 					// TODO : display max level 은 사이트 설정으로 빼자.
					if(dispLvl == 3) {
						alert('<spring:message code="column.display_view.message.tree_fail" />');
						return;
					} */
				}

				var data = {
					  dispClsfCd : dispClsfCd
					, dispClsfNo : null
					, upDispClsfNo : upDispClsfNo
					, dispLvl : dispLvl
					, stId : $("#selectStId option:selected").val()
				}
				displayBaseView(data, true);
			}

			// 전시 기본정보 등록 및 수정
			function displayBaseSave() {
				if(validate.check("displayBaseForm")) {
					
					/* // 이미지 선택 셀렉터 잘못되어있어 주석처리
					if ($("#displayBaseForm #dispClsfCd").val() == null) {
						alert("대카테고리 이미지를 선택하세요.");
						return;
					} */
					var dispClsfCd = $("#displayBaseForm #dispClsfCd").val();
					var dispLvl = $("#displayBaseForm #dispLvl").val();

					// 기획전인 경우,
					//OO기획전
					if("${adminConstants.DISP_CLSF_20}" == dispClsfCd && dispLvl == "2") {
						oEditors.getById["dispClsfTitleHtml"].exec("UPDATE_CONTENTS_FIELD", []);
						oEditors.getById["dispClsfTitleHtmlMo"].exec("UPDATE_CONTENTS_FIELD", []);
// 					}else if("${adminConstants.DISP_CLSF_40}" == dispClsfCd && dispLvl != "2") { // 블라스코기획전 
// 						oEditors.getById["dispClsfTitleHtml"].exec("UPDATE_CONTENTS_FIELD", []);
// 						oEditors.getById["dispClsfTitleHtmlMo"].exec("UPDATE_CONTENTS_FIELD", []);
					}

					var categoryFilters = "";
/*					$("input:checkbox[name^='filters']").each(function() {
						if ($(this).is(":checked") == false) {
							$(this).attr('disabled', true);
						}
					});*/
					$("input:checkbox[id='filters[]']:checked").each(function() {
						categoryFilters += $(this).val() + ",";
					});
					if (categoryFilters != "") categoryFilters = categoryFilters.slice(0, -1);
					$("#categoryFilters").val(categoryFilters);
					
// 					var check = true;
					var message = '<spring:message code="column.common.confirm.insert" />';
					var sendData = $("#displayBaseForm").serializeJson();

					if(!validation.isNull($("#displayBaseForm #dispClsfNo").val())) {
// 						check = false;
						// 전시 코너 drag&drop 우선순위 반영
						var dispCornerList = [];
						var grid = $("#displayCornerList");
						var gridCount = grid.jqGrid("getRowData").length;
						var rowids = null;
						
						if(gridCount > 0) {
							for(var i = 1; i <= gridCount; i++) {
								dispCornerList.push(grid.jqGrid('getRowData', i));
							}
						}
						
						$.extend(sendData, {
							dispCornerListPO : JSON.stringify(dispCornerList)
						});
						message = '<spring:message code="column.common.confirm.update" />';
					}
					
					messager.confirm(message,function(r){
						if(r){
							var options = {
									url : "<spring:url value='/display/displayBaseSave.do' />"
									, data : sendData
									, callBack : function(result) {
										messager.alert("<spring:message code='column.display_view.message.save'/>","Info","info",function(){
											$("#displayTree").jstree().refresh();
										});
									}
								};
							ajax.call(options);
						}
					});
				}
			}

			// 전시 기본정보 삭제
			function displayBaseDelete() {
				messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/display/displayBaseDelete.do' />"
								, data : $("#displayBaseForm").serializeJson()
								, callBack : function(result) {
									messager.alert("<spring:message code='column.display_view.message.delete'/>","Info","info",function(){
										$("#displayTree").jstree().refresh();
										displayBaseView("", false);
									});									
								}
							};
						ajax.call(options);
					}	
				});
			}

			// 전시 코너 화면
			function displayCornerListView(dispClsfNo, tmplNo) {
				var options = {
					url : "<spring:url value='/display/displayCornerListView.do' />"
					, dataType : "html"
					, callBack : function(result){
						$("#displayCornerListView").html(result);
						
						//전시 코너 추가/삭제 버튼 hidden처리
						$("#dispCornAddBtn").hide();
						$("#dispCornDelBtn").hide();
						
						// 전시 코너 리스트
						createDisplayCornerGrid(dispClsfNo, tmplNo);

						// 전시카테고리의 소카테고리인 경우,
						if("${adminConstants.DISP_CLSF_10}" == $("#displayBaseForm #dispClsfCd").val()) {
							if($("#displayBaseForm #leafYn").val() == "${adminConstants.LEAF_YN_Y}") {
								// 전시 상품 화면
								displayGoodsListView(dispClsfNo);

								// 관련 브랜드 화면
								//displayBrandListView(dispClsfNo);
							}
						}
					}
				};

				ajax.call(options);
			}

			// 전시 분류 코너 아이템 화면
			function displayClsfCornerListView(dispClsfNo, dispCornNo, dispCornTpCd) {
				// 전시 코너 아이템
				$("#displayCornerItemListView").empty();
				
				var data = {
					dispClsfNo : dispClsfNo
					, dispCornNo : dispCornNo
					, dispCornTpCd : dispCornTpCd
				}

				var options = {
					url : "<spring:url value='/display/displayClsfCornerListView.do' />"
					, data : data
					, dataType : "html"
					, callBack : function(result) {
						$("#displayClsfCornerListView").html(result);
						createDisplayClsfCornerGrid(dispClsfNo, dispCornNo);
					}
				};

				ajax.call(options);
			}

			// 전시분류코너 Grid colModel
			var clsfCornGrid = {
			    colModelCommon: [
					//전시 분류 코너 번호
					{name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"110", align:"center", hidden:true}
					//전시 분류 번호
					, {name:"dispClsfNo", label:'<spring:message code="column.disp_clsf_no" />', width:"100", align:"center", hidden:true}
					// 전시 코너 번호
					, {name:"dispCornNo", label:'<spring:message code="column.disp_corn_no" />', width:"100", align:"center", hidden:true}
					// 상세보기
					, {name:"button", label:'분류 상세 보기', width:"100", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
						var str = '<button type="button" onclick="displayClsfCornerViewPop(' + $('#displayClsfCornerForm #dispCornTpCd').val() + ', ' + rowObject.dispClsfCornNo + ')" class="btn_h25_type1">분류 상세</button>';
						return str;
					}}
					//전시 분류 코너 번호
                    , {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"140", align:"center", classes:'pointer fontbold', hidden:false}
				]
				, colModelDispShowTp: [
 					// 전시 노출 타입 코드
 					{name:"dispShowTpCd", label:'<spring:message code="column.disp_show_tp_cd" />', width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.DISP_SHOW_TP }' showValue='true' />" }, hidden:true } 
 	             ]
				, colModelTitle: [
 					// 타이틀
 					{name:"cntsTtl", label:'<spring:message code="column.ttl" />', width:"200", align:"center"}
 					// 설명
 					//, {name:"cntsDscrt", label:'<spring:message code="column.dscrt" />', width:"200", align:"center"}
 					// 이미지(PC)
 					, {name:"cornImgNm", label:'<spring:message code="column.display_view.pc_img" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
 							if(rowObject.cornImgPath != "") {
 								return '<img src="${frame:imagePath( "'+rowObject.cornImgPath+'" )}" style="width:100px; height:100px;" alt="' + rowObject.cornImgNm + '" />';
 							} else {
 								return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
 							}
 						}
 					}
 					// 이미지(모바일)
 					, {name:"cornMobileImgNm", label:'<spring:message code="column.display_view.mobile_img" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
 							if(rowObject.cornMobileImgPath != "") {
 								return '<img src="${frame:imagePath( "'+rowObject.cornMobileImgPath+'" )}" style="width:100px; height:100px;" alt="' + rowObject.cornMobileImgNm + '" />';
 							} else {
 								return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
 							}
 						}
 					}
 	             ]
	            , colModelLink: [
	                // PC 링크 URL
	                {name:"linkUrl", label:"<spring:message code='column.display_view.pc_link' />", width:"250", align:"center"}
	                // 모바일 링크 URL
	                , {name:"mobileLinkUrl", label:"<spring:message code='column.display_view.mobile_link' />", width:"250", align:"center"}
	             ]
	            /* , colModelBgColor: [
	                // BG 컬러값
	                {name:"bgColor", label:"<spring:message code='column.display_view.bg_color' />", width:"100", align:"center"}
	             ]  
				, colModelGoodsAutoYn: [
					// 상품 자동 여부
					{name:"goodsAutoYn", label:"<spring:message code='column.goods_auto_yn' />", width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='false' />" } }
	             ] */  
				, colModelCommon2: [
 					// 전시 기간 설정 여부
 					{name:"dispPrdSetYn", label:"<spring:message code='column.disp_prd_set_yn' />", width:"120", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='false' />" } }
 					// 전시 시작일자
 					, {name:"dispStrtdt", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd", classes:'pointer fontbold'}
 					// 전시 종료일자
 					, {name:"dispEnddt", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
 	             ]
			};
			
			// 전시 분류 코너 리스트
			function createDisplayClsfCornerGrid(dispClsfNo, dispCornNo) {
				var colModel = clsfCornGrid.colModelCommon;
				
				var listDispShowTp = new Array(); 
				<c:forEach items="${frame:listCode(adminConstants.DISP_SHOW_TP)}" var="item">
					listDispShowTp.push("${item.usrDfn1Val}");
				</c:forEach>
				
				$(listDispShowTp).each(function(i){
					if (listDispShowTp[i] == $("#displayClsfCornerForm #dispCornTpCd").val()) {
						colModel = colModel.concat(clsfCornGrid.colModelDispShowTp);
						return false;
					}
				});
				
				// 테마
				if("${adminConstants.DISP_CORN_TP_81}" == $("#displayClsfCornerForm #dispCornTpCd").val()) {	
					colModel = colModel.concat(clsfCornGrid.colModelTitle);
					colModel = colModel.concat(clsfCornGrid.colModelLink);
					
				}
				
				// 상품 / 테마
				/* if("${adminConstants.DISP_CORN_TP_60}" == $("#displayClsfCornerForm #dispCornTpCd").val() 
						|| "${adminConstants.DISP_CORN_TP_81}" == $("#displayClsfCornerForm #dispCornTpCd").val()) {    
					colModel = colModel.concat(clsfCornGrid.colModelBgColor);
					colModel = colModel.concat(clsfCornGrid.colModelGoodsAutoYn);
				} */
				
				if("${adminConstants.DISP_CORN_TP_110}" == $("#displayClsfCornerForm #dispCornTpCd").val()){
					$("#displayClsfCornerListView").empty();
					return;
				}
				
				colModel = colModel.concat(clsfCornGrid.colModelCommon2);
				
				var options = {
					url : "<spring:url value='/display/displayClsfCornerGrid.do' />"
					, height : 400
					, multiselect : true
					, paging : false
					, searchParam : {
						  dispClsfNo : dispClsfNo
						, dispCornNo : dispCornNo
					}
					, colModels : colModel
					, onSelectRow : function(ids) {
						var rowdata = $("#displayClsfCornerList").getRowData(ids);

						// 전시 코너 아이템 화면
						displayCornerItemListView(dispClsfNo, rowdata.dispClsfCornNo, $("#displayClsfCornerForm #dispCornTpCd").val());
					}
					/* , gridComplete : function(data) {
						var gridCount = $("#displayClsfCornerList").jqGrid('getRowData').length;
						
						if(gridCount >= 1 ) {
							$("#displayClsfCornerAddBtn").hide();
						} else {
							$("#displayClsfCornerAddBtn").show();
						}
					} */
				};

				grid.create("displayClsfCornerList", options);
			}

			// 전시 분류 코너 추가
			function displayClsfCornerAddPop() {
				displayClsfCornerViewPop($("#displayClsfCornerForm #dispCornTpCd").val());
			}

			// 전시 분류 코너 삭제
			function displayClsfCornerDelete() {
				var grid = $("#displayClsfCornerList");
				var clsfCorners = new Array();

				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.display_view.message.no_select' />","Info","info");
					return;
				} else {
					for(var i = 0; i < rowids.length; i++) {
						var data = $("#displayClsfCornerList").getRowData(rowids[i]);
						clsfCorners.push(data);
					}

					sendData = {
		 				displayClsfCornerPOList : JSON.stringify(clsfCorners)
	 				};
				}

				messager.confirm("<spring:message code='column.display_view.message.item_all_delete' />",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/display/displayClsfCornerDelete.do' />"
								, data : sendData
								, callBack : function(data ) {
									messager.alert("<spring:message code='column.display_view.message.delete'/>","Info","info",function(){
										// 전시 분류 코너 화면
										displayClsfCornerListView($("#displayClsfCornerForm #dispClsfNo").val(), $("#displayClsfCornerForm #dispCornNo").val(), $("#displayClsfCornerForm #dispCornTpCd").val());
									});									
								}
							};
						ajax.call(options);
					}
				});
			}
			
			function displayClsfCornerViewPop(dispCornTpCd, dispClsfCornNo) {
				var options = {
					url : '/display/displayClsfCornerViewPop.do'
					, data : {
						dispClsfNo : $("#displayClsfCornerForm #dispClsfNo").val(),
						dispCornNo : $("#displayClsfCornerForm #dispCornNo").val(),
						dispCornTpCd : $("#displayClsfCornerForm #dispCornTpCd").val(),
						dispClsfCornNo : typeof(dispClsfCornNo) == "undefined" ? "" : dispClsfCornNo,
						usrDfn1Val : $("#displayClsfCornerForm #usrDfn1Val").val(),
						dispShowTpCd : $("#displayClsfCornerForm option:selected").val(),
						tmplNo : $("#displayClsfCornerForm #tmplNo").val()
					}
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "displayClsfCornerView"
							, width : 800
							, height : 350
							, top : 200
							, title : "전시 분류 코너"
							, body : data
							, button : "<button type=\"button\" onclick=\"insertdisplayClsfCorner();\" class=\"btn btn-ok\">저장</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options );
 			}
			
			// 그리드 마우스 drag & drop
			function dispCornerItemDragAndDrop(girdId) {
			   $("#"+girdId).jqGrid("sortableRows");
			   $("#"+girdId).jqGrid('sortableRows', {
			      update: function (e, html) {
			         var ids = $("#"+girdId).jqGrid("getDataIDs");
			         var gridData = $("#"+girdId).jqGrid("getRowData");
			         for (var i=0; i<gridData.length; i++) {
			            var rank = i+1;
			            $("#"+girdId).jqGrid("setCell", ids[i], 'dispPriorRank', rank);
			         }
			         var dispCornerItemList = [];
			         var grid = $("#"+girdId);
			         var gridCount = grid.jqGrid("getRowData").length;
			         var rowids = null;
			         
			         for(var i = 1; i <= gridCount; i++) {
			        	 dispCornerItemList.push(grid.jqGrid('getRowData', i));
			         }
			         
			         var options = {
			        		 url : "<spring:url value='/display/displayCornerItemSave.do' />"
			        		 , data : {
			        			 displayCornerItemPOList : JSON.stringify(dispCornerItemList)
			        		 }
			        		 , callBack : function(data) {
			        			 reloadDisplayCornerItemGrid($("#displayCornerItemForm #dispClsfNo").val(), $("#displayCornerItemForm #dispClsfCornNo").val(), $("#displayCornerItemForm #dispCornTpCd").val());
			        		 }
			         }
			         ajax.call(options);
			      }
			   });
			}
			
			   
			// 전시 코너 리스트
			function createDisplayCornerGrid(dispClsfNo, tmplNo) {
				var options = {
					url : "<spring:url value='/display/displayCornerListGrid.do' />"
					, height : 300
					, paging : false
					, searchParam : { dispClsfNo : dispClsfNo
									, tmplNo : tmplNo
					}
					, colModels : [
						// 전시 분류 번호
						{name:"dispClsfNo", label:'<spring:message code="column.disp_clsf_no" />', width:"100", align:"center", hidden:true}
						// 템플릿 번호
						, {name:"tmplNo", label:'<spring:message code="column.tmpl_no" />', width:"100", align:"center", hidden:true}
						// 상세보기
						, {name:"button", label:'<spring:message code="column.goods.btn.detail" />', width:"100", align:"center", sortable:false, hidden: dispClsfNo == '300000171' ? false : true
							, formatter: function(cellvalue, options, rowObject) {
							var str = ""
							if("${adminConstants.DISP_CORN_TP_130}" == rowObject.dispCornTpCd 			// 시리즈 TAG
								|| "${adminConstants.DISP_CORN_TP_131}" == rowObject.dispCornTpCd		// 동영상 TAG
								|| "${adminConstants.DISP_CORN_TP_132}" == rowObject.dispCornTpCd		// 시리즈 미고정
								|| "${adminConstants.DISP_CORN_TP_133}" == rowObject.dispCornTpCd){		// 동영상 미고정
								str = '<button type="button" onclick="displayCornerViewPop(' + rowObject.dispClsfNo + ', ' + rowObject.dispCornNo + ', ' + rowObject.dispCornTpCd + ')" class="btn_h25_type1">코너 상세</button>';
							}
							return str;
						}}
						// 전시 우선 순위
                        , {name:"dispPriorRank", label:'<spring:message code="column.sort" />', width:"50", align:"center", hidden:false}
						// 전시 코너 번호
						, {name:"dispCornNo", label:'<spring:message code="column.disp_corn_no" />', width:"120", align:"center", classes:'pointer fontbold'}
						// 전시 코너명 
						, {name:"dispCornNm", label:'<spring:message code="column.disp_corn_nm" />', width:"200", align:"center"}
						// 전시 코너 타입
						, {name:"dispCornTpCd", label:'<spring:message code="column.disp_corn_tp_cd" />', width:"150", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.DISP_CORN_TP}" />"}}
						// 기본 노출 개수
 						, {name:"showCnt", label:'<spring:message code="column.display_view.show_cnt" />', width:"100", align:"center", formatter:'integer', hidden:false}
						// 전시 코너 설명
						, {name:"dispCornDscrt", label:'<spring:message code="column.disp_corn_dscrt" />', width:"300", align:"center"}
					]
					, onSelectRow : function(rowid) {
						// 전시 분류 코너 화면
						var rowdata = $("#displayCornerList").getRowData(rowid);
						displayClsfCornerListView(rowdata.dispClsfNo, rowdata.dispCornNo, rowdata.dispCornTpCd);
					}
					, loadComplete: function (data) {
						// 홈별로 고정 row에 unmovable class를 추가
						if(data.data[0] != null) {
							//펫shop
							if(data.data[0].dispClsfNo == "300000173" || data.data[0].dispClsfNo == "300000174" ||
							   data.data[0].dispClsfNo == "300000175" || data.data[0].dispClsfNo == "300000176") {
								$("#displayCornerList tr.jqgrow").eq(0).addClass("unmovable");
								$("#displayCornerList tr.jqgrow").eq(1).addClass("unmovable");
							} else if(data.data[0].dispClsfNo == "300000171") {
								//펫tv
								$("#displayCornerList tr.jqgrow").eq(0).addClass("unmovable");
							} else {
								var rowDatas = $("#displayCornerList").jqGrid("getRowData");
								for(var i = 0; i < rowDatas.length; i++) {
									$("#displayCornerList tr.jqgrow").eq(i).addClass("unmovable");
								}
							}
						}
					}
				};

				grid.create("displayCornerList", options);
				
				// 마우스 drag & drop
				$("#displayCornerList").jqGrid('sortableRows', {
				  items: ".jqgrow:not(.unmovable)",
			      update: function (e, html) {
			         var ids = $("#displayCornerList").jqGrid("getDataIDs");
			         var gridData = $("#displayCornerList").jqGrid("getRowData");
			         for (var i=0; i<gridData.length; i++) {
			            var rank = i+1;
			            $("#displayCornerList").jqGrid("setCell", ids[i], 'dispPriorRank', rank);
			         }
			      }
			   });
			}

			// 전시 코너 리스트
			function reloadDisplayCornerGrid() {
				var options = {
					searchParam : {
						dispClsfNo : $("#displayBaseForm #dispClsfNo").val()
					  , tmplNo : $("#displayBaseForm #tmplNo").val()
					}
				};

				grid.reload("displayCornerList", options);
			}

			// 전시 분류 코너 리스트
			function reloadDisplayClsfCornerGrid(dispCornTpCd) {
				// 전시 분류 코너 화면
				displayClsfCornerListView($("#displayClsfCornerForm #dispClsfNo").val(), $("#displayClsfCornerForm #dispCornNo").val(), dispCornTpCd != undefined ? dispCornTpCd : $("#displayClsfCornerForm #dispCornTpCd").val());
			}

			// 전시 코너 아이템 리스트
			function reloadDisplayCornerItemGrid() {
				// 전시 코너 아이템 화면
				displayCornerItemListView($("#displayCornerItemForm #dispClsfNo").val(), $("#displayCornerItemForm #dispClsfCornNo").val(), $("#displayCornerItemForm #dispCornTpCd").val());
			}

			// 전시코너 추가/수정 팝업
			function displayCornerViewPop(dispClsfNo, dispCornNo, dispCornTpCd) {
				var options = {
					url : '/display/displayCornerViewPop.do'
					, data : {
						dispClsfNo : typeof(dispClsfNo) == "undefined" ? "" : dispClsfNo,
						tmplNo : $("#displayBaseForm #tmplNo").val(),
						dispCornNo : typeof(dispCornNo) == "undefined" ? "" : dispCornNo,
						dispCornTpCd : typeof(dispCornTpCd) == "undefined" ? "" : dispCornTpCd
					}
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "displayCornerView"
							, width : 800
							, height : 350
							, top : 200
							, title : "전시 코너"
							, body : data
							, button : "<button type=\"button\" onclick=\"displayCornerSave();\" class=\"btn btn-ok\">저장</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options );
			}
			
			// 등록 / 수정
			function displayCornerSave() {
				// 전시 코너 drag&drop 우선순위 반영
				var dispCornerList = [];
				var grid = $("#displayCornerList");
				var gridCount = grid.jqGrid("getRowData").length;
				var rowids = null;
				
				if(gridCount > 0) {
					for(var i = 1; i <= gridCount; i++) {
						dispCornerList.push(grid.jqGrid('getRowData', i));
					}
					
					messager.confirm('<spring:message code="column.display_view.message.confirm_save" />',function(r){
						if(r){
							var options = {
								url : "<spring:url value='/display/displayCornerSave.do' />"
								, data : {
									dispCornerListPO : JSON.stringify(dispCornerList)
								}
								, callBack : function(result){
									reloadDisplayCornerGrid();
								}
							};
							ajax.call(options);				
						}
					});
				}else {
					messager.alert("<spring:message code='admin.web.view.msg.display.no.data.save' />","Info","info");
				}
				
			}
			
			// 전시코너 삭제
			function displayCornerDelete() {
				var grid = $("#displayCornerList");

				var rowid = grid.jqGrid('getGridParam', 'selrow');
				var	dispClsfNo = "";
				var	dispCornNo = "";
				var	tmplNo = "";

				dispClsfNo = grid.jqGrid('getRowData', rowid).dispClsfNo
				dispCornNo = grid.jqGrid('getRowData', rowid).dispCornNo
				tmplNo = grid.jqGrid('getRowData', rowid).tmplNo

				if(rowid == null) {
					messager.alert("<spring:message code='column.display_view.message.no_select' />","Info","info");
					return;
				}

				messager.confirm("<spring:message code='column.display_view.message.item_all_delete'/>",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/display/displayCornerDelete.do' />"
								, data : { dispCornNo : dispCornNo }
								, callBack : function(data ) {
									messager.alert("<spring:message code='column.display_view.message.delete'/>","Info","info",function(){
										// 전시 코너 화면
										displayCornerListView(dispClsfNo, tmplNo);
										// 전시 분류 코너
										$("#displayClsfCornerListView").empty();
										// 전시 코너 아이템
										$("#displayCornerItemListView").empty();
									});									
								}
							};
							ajax.call(options);				
					}
				});
			}

			// 전시코너 아이템 추가 / 수정 팝업
			var itemIdx = 0;

 			function displayCornerItemViewPop(dispCnrItemNo, dispBnrNo) {
				var duplCnt = 0; // 중복 건수
 				var dispCornTpCd = $("#displayCornerItemForm #dispCornTpCd").val();
 				itemIdx++;
				if("${adminConstants.DISP_CORN_TP_60}" == dispCornTpCd) {	// 상품
					var options = {
						  multiselect : true
						, callBack : function(result) {
							if(result != null && result.length > 0) {
								var sendData = new Array();
								var goodsId = new Array();
								//var goodsCheck = false;
								var message = new Array();

								for(var i in result) {
									var goodsCheck = false;
									// 중복 상품 체크
									var rowids = $("#displayCornerItemList").jqGrid('getDataIDs');
									for(var j = 0; j < rowids.length; j++) {
										var rowdata = $("#displayCornerItemList").getRowData(rowids[j]);
										if(result[i].goodsId == rowdata.goodsId) {
											goodsCheck = true;
											message.push("[ " + result[i].goodsNm + " ] 중복된 상품입니다.");
											duplCnt++;
											break;
										}
									}

									if(!goodsCheck){
										sendData.push({
											goodsId : result[i].goodsId
											, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
											, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
											, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
											, dispPriorRank : rowids.length+(i*1)+1
											, dispStrtdt : "${frame:toDate('yyyy-MM-dd')}"
											, dispEnddt : "${frame:addMonth('yyyy-MM-dd', 1)}"
										});
									}
									//console.log("@@@@ goodsCheck : "+goodsCheck+"\n"+JSON.stringify(sendData));
								}

								var options = {
									url : "<spring:url value='/display/displayCornerItemSave.do' />"
									, data : {
										displayCornerItemPOList : JSON.stringify(sendData)
									}
									, callBack : function(data) {
										// 전시 코너 아이템 화면
										displayCornerItemListView($("#displayCornerItemForm #dispClsfNo").val(), $("#displayCornerItemForm #dispClsfCornNo").val(), $("#displayCornerItemForm #dispCornTpCd").val());
									}
								};

								if(duplCnt > 0) {
									if(message != null && message.length > 0) {
										if(result.length > duplCnt){
											message.push("중복상품은 제외하고 등록됩니다.");
										}else{
											message.push("중복상품 외 등록할 상품이 없습니다.");
											messager.alert(message.join("<br/>"),"Info","info"); return;
										}

										messager.confirm(message.join("<br/>"), function(r){
											if(r){
												if(result.length > duplCnt){
													ajax.call(options);
												}
											}
										})
									}
								}else{
									ajax.call(options);
								}
							}
						}
					}

					layerGoodsList.create(options);
				} else if("${adminConstants.DISP_CORN_TP_70}" == dispCornTpCd) {	// 상품평
					var sendData = new Array();
					var message = new Array();

					var options = {
						  multiselect : true
						, callBack : function(result) {
							if(result != null) {
								var idx = $('#displayCornerItemList').getDataIDs();

								for(var i in result) {
									var check = true;

									for(var j in idx) {
										var rowData = $("#displayCornerItemList").getRowData(idx[j]);

										if(result[i].goodsEstmNo == rowData.goodsEstmNo) {
											check = false;
										}
									}

									if(check) {
										sendData.push({
											  goodsId : result[i].goodsId
											, goodsEstmNo : result[i].goodsEstmNo
											, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
											, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
											, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
											, dispPriorRank : '99'
											, dispStrtdt : "${frame:toDate('yyyy-MM-dd')}"
											, dispEnddt : "${frame:addMonth('yyyy-MM-dd', 1)}"
										});

									} else {
										message.push("[ " + result[i].goodsNm + " ] 중복된 상품평입니다.");
									}
								}

								if(message != null && message.length > 0) {
									messager.alert(message.join("<br/>"),"Info","info");
								} else {
									var options = {
										url : "<spring:url value='/display/displayCornerItemSave.do' />"
										, data : {
											displayCornerItemPOList : JSON.stringify(sendData)
										}
										, callBack : function(data) {
											// 전시 코너 아이템 화면
											displayCornerItemListView($("#displayCornerItemForm #dispClsfNo").val(), $("#displayCornerItemForm #dispClsfCornNo").val(), $("#displayCornerItemForm #dispCornTpCd").val());
										}
									};

									ajax.call(options);
								}
							}
						}
					}
					layerGoodsCommentList.create(options);
				} else if("${adminConstants.DISP_CORN_TP_10}" == dispCornTpCd
						|| "${adminConstants.DISP_CORN_TP_20}" == dispCornTpCd
						|| "${adminConstants.DISP_CORN_TP_30}" == dispCornTpCd) {
					// 배너 HTMl / 배너 TEXT /  이미지+TEXT
					var height = '520';
					if ("${adminConstants.DISP_CORN_TP_40}" == dispCornTpCd) {
						height = '600';
					}
					
					var options = {
						url : '/display/displayCornerItemViewPop.do'
						, data : {
							dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val(),
							dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val(),
							dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val(),
							dispCnrItemNo : typeof(dispCnrItemNo) == "undefined" ? "" : dispCnrItemNo,
							dispBnrNo : typeof(dispBnrNo) == "undefined" ? "" : dispBnrNo
						}
						, dataType : "html"
						, callBack : function (data ) {
							var config = {
								id : "displayCornerItemView"
								, width : 800
								, height : height
								, top : 200
								, title : "전시 코너 아이템"
								, body : data
								, button : "<button type=\"button\" onclick=\"insertDisplayCornerItem();\" class=\"btn btn-ok\">저장</button>"
							}
							layer.create(config);
						}
					}
					ajax.call(options );
				} else if("${adminConstants.DISP_CORN_TP_83}" == dispCornTpCd) {
					var options = {
						url : '/display/displayCornerBrandCntsItemViewPop.do'
						, data : {
							dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val(),
							dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val(),
							dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val(),
							dispCnrItemNo : typeof(dispCnrItemNo) == "undefined" ? "" : dispCnrItemNo,
							dispBnrNo : typeof(dispBnrNo) == "undefined" ? "" : dispBnrNo
						}
						, dataType : "html"
						, callBack : function (data ) {
							var config = {
								id : "displayCornerBrandCntsItemView"
								, width : 800
								, height : 350
								, top : 200
								, title : "전시 코너 아이템"
								, body : data
								, button : "<button type=\"button\" onclick=\"insertDisplayCornerItem();\" class=\"btn btn-ok\">저장</button>"
							}
							layer.create(config);
						}
					}
					ajax.call(options );
					
				} else if("${adminConstants.DISP_CORN_TP_80}" == dispCornTpCd) {	// 태그 리스트
					var options = {
						multiselect : true
						, callBack : function(result) {
							if(result != null && result.length > 0) {
								var sendData = new Array();
								var tagCheck = false;
								var message = new Array();
								
								for(var i=0; i < result.length; i++) {
									var rowids = $("#displayCornerItemList").jqGrid('getDataIDs');
									for(var j = 0; j < rowids.length; j++) {
										var rowdata = $("#displayCornerItemList").getRowData(rowids[j]);
										if(result[i].tagNo == rowdata.tagNo) {
											tagCheck = true;
											message.push("[ " + result[i].tagNm + " ] 중복된 태그입니다.");
										}
									}
									
									sendData.push({
										tagNo : result[i].tagNo
										, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
										, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
										, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
										, dispPriorRank : rowids.length + (i+1)
										, dispStrtdt : "${frame:toDate('yyyy-MM-dd')}"
										, dispEnddt : "${frame:addMonth('yyyy-MM-dd', 1)}"
									});
								}

								if(tagCheck) {
									if(message != null && message.length > 0) {
										messager.alert(message.join("<br/>") + "<br/><spring:message code='admin.web.view.msg.display.dupl.tag.error' />","Info","info");
									}
									return;
								}

								var options = {
									url : "<spring:url value='/display/displayCornerItemSave.do' />"
									, data : {
										displayCornerItemPOList : JSON.stringify(sendData)
									}
									, callBack : function(data) {
										// 전시 코너 아이템 화면
										reloadDisplayCornerItemGrid($("#displayCornerItemForm #dispClsfNo").val(), $("#displayCornerItemForm #dispClsfCornNo").val(), $("#displayCornerItemForm #dispCornTpCd").val());
									}
								};
								ajax.call(options);
							}
						}
					}
					layerTagBaseList.create(options);
				} else if("${adminConstants.DISP_CORN_TP_90}" == dispCornTpCd) {	// 펫로그 회원
					var options = {
							multiselect : true
							, param : {petRegYn : "Y"}
							, callBack : function(result) {
								if(result != null && result.length > 0) {
									var sendData = new Array();
									var mbrCheck = false;
									var message = new Array();
									
									for(var i=0; i < result.length; i++) {
										var rowids = $("#displayCornerItemList").jqGrid('getDataIDs');
										for(var j = 0; j < rowids.length; j++) {
											var rowdata = $("#displayCornerItemList").getRowData(rowids[j]);
											if(result[i].mbrNo == rowdata.mbrNo) {
												mbrCheck = true;
												message.push("[ " + result[i].mbrNm + " ] 중복된 회원입니다.");
											}
										}
										
										sendData.push({
											mbrNo : result[i].mbrNo
											, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
											, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
											, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
											, dispPriorRank : rowids.length + (i+1)
											, dispStrtdt : "${frame:toDate('yyyy-MM-dd')}"
											, dispEnddt : "${frame:addMonth('yyyy-MM-dd', 1)}"
										});
									}

									if(mbrCheck) {
										if(message != null && message.length > 0) {
											messager.alert(message.join("<br/>") + "<br/><spring:message code='admin.web.view.msg.display.dupl.petlog.member.error' />","Info","info");
										}
										return;
									}

									var options = {
										url : "<spring:url value='/display/displayCornerItemSave.do' />"
										, data : {
											displayCornerItemPOList : JSON.stringify(sendData)
										}
										, callBack : function(data) {
											// 전시 코너 아이템 화면
											reloadDisplayCornerItemGrid($("#displayCornerItemForm #dispClsfNo").val(), $("#displayCornerItemForm #dispClsfCornNo").val(), $("#displayCornerItemForm #dispCornTpCd").val());
										}
									};

									ajax.call(options);
								}
							}
						}
					layerMemberList.create(options);
				} else if("${adminConstants.DISP_CORN_TP_100}" == dispCornTpCd) {	// 펫로그 리스트
					var dispClsfNo = $("#displayCornerItemForm #dispClsfNo").val();
					var petLogChnlCd = "";
					var contsStatCd = "";
					var dispCallYn = "N";
					if(dispClsfNo != '${adminConstants.PETLOG_MAIN_DISP_CLSF_NO}') {
						petLogChnlCd = "${adminConstants.PETLOG_CHNL_20}"
						, contsStatCd = "${adminConstants.CONTS_STAT_10}"
						, dispCallYn = 'Y'
					}
					var options = {
							multiselect : true
							, petLogChnlCd: petLogChnlCd
							, contsStatCd: contsStatCd
							, dispCallYn: dispCallYn
							, callBack : function(result) {
								if(result != null && result.length > 0) {
									var sendData = new Array();
									var petLogCheck = false;
									var message = new Array();
									
									for(var i=0; i < result.length; i++) {
										var rowids = $("#displayCornerItemList").jqGrid('getDataIDs');
										for(var j = 0; j < rowids.length; j++) {
											var rowdata = $("#displayCornerItemList").getRowData(rowids[j]);
											if(result[i].petLogNo == rowdata.petLogNo) {
												petLogCheck = true;
												message.push("[ " + result[i].dscrt + " ] 중복된  펫로그입니다.");
											}
										}
										
										sendData.push({
											petLogNo : result[i].petLogNo
											, mbrNo : result[i].mbrNo
											, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
											, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
											, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
											, dispPriorRank : rowids.length + (i+1)
											, dispStrtdt : "${frame:toDate('yyyy-MM-dd')}"
											, dispEnddt : "${frame:addMonth('yyyy-MM-dd', 1)}"
										});
									}

									if(petLogCheck) {
										if(message != null && message.length > 0) {
											messager.alert(message.join("<br/>") + "<br/><spring:message code='admin.web.view.msg.display.dupl.petlog.error' />","Info","info");
										}
										return;
									}

									var options = {
										url : "<spring:url value='/display/displayCornerItemSave.do' />"
										, data : {
											displayCornerItemPOList : JSON.stringify(sendData)
										}
										, callBack : function(data) {
											// 전시 코너 아이템 화면
											reloadDisplayCornerItemGrid($("#displayCornerItemForm #dispClsfNo").val(), $("#displayCornerItemForm #dispClsfCornNo").val(), $("#displayCornerItemForm #dispCornTpCd").val());
										}
									};
									ajax.call(options);
								}
							}
						}
					layerPetLogList.create(options);
				} else if("${adminConstants.DISP_CORN_TP_130}" == dispCornTpCd || "${adminConstants.DISP_CORN_TP_131}" == dispCornTpCd) {	// 시리즈TAG, 영상TAG
					var options = {
						dispCornTpCd : dispCornTpCd
						, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
						, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
						, itemLength : $("#displayCornerItemList").jqGrid('getDataIDs').length
						, callBack : function(result) {
							if(result.tagNo.length != null) {
								var sendData = new Array();
								var tagCheck = false;
								var message = new Array();
								
								for(var i=0; i < result.tagNo.length; i++) {
									var rowids = $("#displayCornerItemList").jqGrid('getDataIDs');
									for(var j = 0; j < rowids.length; j++) {
										var rowdata = $("#displayCornerItemList").getRowData(rowids[j]);
										if(result.tagNo[i] == rowdata.tagNo) {
											tagCheck = true;
											message.push("[ " + rowdata.tagNm + " ] 중복된 Tag입니다.");
										}
									}
									
									sendData.push({
										tagNo : result.tagNo[i]
										, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
										, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
										, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
										, dispPriorRank : rowids.length + (i+1)
										, dispStrtdt : result.dispStrtdt
										, dispEnddt : result.dispEnddt
									});
								}
								if(tagCheck) {
									if(message != null && message.length > 0) {
										messager.alert(message.join("<br/>") + "<br/><spring:message code='admin.web.view.msg.display.dupl.tag.error' />","Info","info");
									}
									return;
								}
								var options = {
									url : "<spring:url value='/display/displayCornerItemSave.do' />"
									, data : {
										displayCornerItemPOList : JSON.stringify(sendData)
									}
									, callBack : function(data) {
										// 전시 코너 아이템 화면
										reloadDisplayCornerItemGrid($("#displayCornerItemForm #dispClsfNo").val(), $("#displayCornerItemForm #dispClsfCornNo").val(), $("#displayCornerItemForm #dispCornTpCd").val());
									}
								};
								ajax.call(options);
							}
						}
					}
					layerPetTvMainLayer.create(options);
				} else if("${adminConstants.DISP_CORN_TP_71}" == dispCornTpCd 
					   || "${adminConstants.DISP_CORN_TP_133}" == dispCornTpCd) {
					if(dispCnrItemNo == null) {
						var options = {
								dispCornTpCd : dispCornTpCd
								, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
								, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
								, dispCnrItemNo : dispCnrItemNo
								, itemLength : $("#displayCornerItemList").jqGrid('getDataIDs').length
								, callBack : function(result) {
									if(result != null) {
										var sendData = new Array();
										var idCheck = false;
										var message = new Array();
										var displayCornerItemPOList = new Array();

										// 콘텐츠 중복 체크
	 										var rowids = $("#displayCornerItemList").jqGrid('getDataIDs');
	  										for(var j = 0; j < rowids.length; j++) {
												var rowdata = $("#displayCornerItemList").getRowData(rowids[j]);

												if(result.vdId == rowdata.vdId) {
													idCheck = true;
													message.push("영상 아이디 [" + result.vdId + "] 가 중복입니다.");
												}
											}
											
											displayCornerItemPOList.push({
												vdId : $("#displayCornerItemPopForm #vdId").val()
												, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
												, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
												, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
												, dispPriorRank : rowids.length + 1
												, dispStrtdt : $("#displayCornerItemPopForm #dispStrtdt").val()
												, dispEnddt : $("#displayCornerItemPopForm #dispEnddt").val()
												, dispCornerItemStrtdt : $("#displayCornerItemPopForm #dispStrtdt").val()
												, dispCornerItemEnddt : $("#displayCornerItemPopForm #dispEnddt").val()
											});
											
										if(idCheck) {
											if(message != null && message.length > 0) {
												messager.alert(message.join("<br/>"),"Info","info");
											}
											return;
										}
										
										var sendData = {
								 				displayCornerItemPOList : JSON.stringify(displayCornerItemPOList)
							 				};

										var options = {
											url : "<spring:url value='/display/displayCornerItemSave.do' />"
											, data : sendData
											, callBack : function(data) {
												// 영상+배너+태그 그리드 리로드
												reloadDisplayCornerBnrVodTagGrid($("#displayCornerItemForm #dispClsfCornNo").val());
											}
										};

										ajax.call(options);
										}
									}
								}
					} else {
						var options = {
								dispCornTpCd : dispCornTpCd
								, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
								, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
								, dispCnrItemNo : dispCnrItemNo
								, callBack : function(result) {
									if(result != null) {
										var sendData = new Array();
										var idCheck = false;
										var message = new Array();
										var displayCornerItemPOList = new Array();

											displayCornerItemPOList.push({
												vdId : $("#displayCornerItemPopForm #vdId").val()
												, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
												, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
												, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
												, dispStrtdt : $("#displayCornerItemPopForm #dispStrtdt").val()
												, dispEnddt : $("#displayCornerItemPopForm #dispEnddt").val()
												, dispCornerItemStrtdt : $("#displayCornerItemPopForm #dispStrtdt").val()
												, dispCornerItemEnddt : $("#displayCornerItemPopForm #dispEnddt").val()
												, dispCnrItemNo : dispCnrItemNo
											});
											
										var sendData = {
								 				displayCornerItemPOList : JSON.stringify(displayCornerItemPOList)
							 				};

										var options = {
											url : "<spring:url value='/display/displayCornerItemSave.do' />"
											, data : sendData
											, callBack : function(data) {
												// 영상+배너+태그 그리드 리로드
												reloadDisplayCornerBnrVodTagGrid($("#displayCornerItemForm #dispClsfCornNo").val());
											}
										};

										ajax.call(options);
										}
									}
								}
					}
					layerPetTvMainLayer.create(options);
				} else if("${adminConstants.DISP_CORN_TP_72}" == dispCornTpCd) {
					if(dispCnrItemNo == null) {
						var options = {
								dispCornTpCd : "${adminConstants.DISP_CORN_TP_72}"
								, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
								, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
								, callBack : function(result) {
									if(result != null) {
										var sendData = new Array();
										var idCheck = false;
										var message = new Array();
										var displayCornerItemPOList = new Array();

											var rowids = $("#displayCornerItemList").jqGrid('getDataIDs');
											
												data = {
													dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
													, vdId : $("#displayCornerItemPopForm #vdId").val()
													, bnrNo : $("#displayCornerItemPopForm #bnrNo").val()
													, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
													, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
													, bnrVodGb : $("#displayCornerItemPopForm #bnrVodGb").val()
													, bnrImgPath : $("#displayCornerItemPopForm #bnrImgPath").val()
													, bnrMobileImgPath : $("#displayCornerItemPopForm #bnrMobileImgPath").val()
													, bnrLinkUrl : $("#displayCornerItemPopForm #bnrLinkUrl").val()
													, bnrMobileLinkUrl : $("#displayCornerItemPopForm #bnrMobileLinkUrl").val()
													, bnrText : $("#displayCornerItemPopForm #bnrText").val()
													, bnrDscrt : $("#displayCornerItemPopForm #bnrDscrt").val()
													, contentId : $("#displayCornerItemPopForm #contentId").val()
													, contentTtl : $("#displayCornerItemPopForm #contentTtl").val()
													, dispPriorRank : rowids.length +1
													, dispStrtdt : $("#displayCornerItemPopForm #dispStrtdt").val()
													, dispEnddt : $("#displayCornerItemPopForm #dispEnddt").val()
												}
											
												$.extend(data, {
													tagNos : result.tagNo
												});

										var options = {
											url : "<spring:url value='/display/displayCornerItemSave.do' />"
											, data : data
											, callBack : function(data) {
												// 영상+배너+태그 그리드 리로드
												reloadDisplayCornerBnrVodTagGrid($("#displayCornerItemForm #dispClsfCornNo").val());
											}
										};

										ajax.call(options);
										}
									}
								}
					} else {
						var options = {
								dispCornTpCd : "${adminConstants.DISP_CORN_TP_72}"
								, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
								, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
								, dispCnrItemNo : dispCnrItemNo
								, dispBnrNo : dispBnrNo
								, callBack : function(result) {
									if(result != null) {
										var sendData = new Array();
										var idCheck = false;
										var message = new Array();
										var displayCornerItemPOList = new Array();

											var rowids = $("#displayCornerItemList").jqGrid('getDataIDs');
											
												data = {
													dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
													, vdId : $("#displayCornerItemPopForm #vdId").val()
													, bnrNo : $("#displayCornerItemPopForm #bnrNo").val()
													, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
													, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
													, bnrVodGb : $("#displayCornerItemPopForm #bnrVodGb").val()
													, bnrImgPath : $("#displayCornerItemPopForm #bnrImgPath").val()
													, bnrMobileImgPath : $("#displayCornerItemPopForm #bnrMobileImgPath").val()
													, bnrLinkUrl : $("#displayCornerItemPopForm #bnrLinkUrl").val()
													, bnrMobileLinkUrl : $("#displayCornerItemPopForm #bnrMobileLinkUrl").val()
													, bnrText : $("#displayCornerItemPopForm #bnrText").val()
													, bnrDscrt : $("#displayCornerItemPopForm #bnrDscrt").val()
													, contentId : $("#displayCornerItemPopForm #contentId").val()
													, contentTtl : $("#displayCornerItemPopForm #contentTtl").val()
													, dispStrtdt : $("#displayCornerItemPopForm #dispStrtdt").val()
													, dispEnddt : $("#displayCornerItemPopForm #dispEnddt").val()
													, dispCornerItemStrtdt : $("#displayCornerItemPopForm #dispStrtdt").val()
													, dispCornerItemEnddt : $("#displayCornerItemPopForm #dispEnddt").val()
													, dispBnrNo : $("#displayCornerItemPopForm #dispBnrNo").val()
													, dispCnrItemNo : dispCnrItemNo
												}
											
												$.extend(data, {
													tagNos : result.tagNo
												});
								
										var options = {
											url : "<spring:url value='/display/displayCornerItemSave.do' />"
											, data : data
											, callBack : function(data) {
												// 영상+배너+태그 그리드 리로드
												reloadDisplayCornerBnrVodTagGrid($("#displayCornerItemForm #dispClsfCornNo").val());
											}
										};

										ajax.call(options);
										}
									}
								}
					}
					layerPetTvMainLayer.create(options);
				} else if("${adminConstants.DISP_CORN_TP_73}" == dispCornTpCd) {
					var options = {
							dispCornTpCd : "${adminConstants.DISP_CORN_TP_73}"
							, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
							, callBack : function(result) {
								if(result != null) {
									var sendData = new Array();
									var idCheck = false;
									var message = new Array();

									// 콘텐츠 중복 체크
										var rowids = $("#displayCornerItemList").jqGrid('getDataIDs');
										for(var j = 0; j < rowids.length; j++) {
											var rowdata = $("#displayCornerItemList").getRowData(rowids[j]);

											if(result.bnrNo == null || result.bnrNo == '') {
												if(result.vdId == rowdata.vdId) {
													idCheck = true;
													message.push("영상 [ " + rowdata.vdId + " ]이 중복입니다.");
												}
											} else if(result.vdId == null || result.vdId == ''){
												if(result.bnrNo == rowdata.bnrNo) {
													idCheck = true;
													message.push("배너 [ " + rowdata.bnrNo + " ]이 중복입니다.");
												}
											}
										}
										
										/* sendData.push({
												contentId : result.contentId
												, vdId : result.vdId
												, dispBnrNo : result.dispBnrNo
												, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
												, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
												, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
												, dispPriorRank : rowids.length + 1
												, dispStrtdt : "${frame:toDate('yyyy-MM-dd')}"
												, dispEnddt : "${frame:addMonth('yyyy-MM-dd', 1)}"
										}); */
										
										
										data = {
												dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
												, vdId : $("#displayCornerItemPopForm #vdId").val()
												, bnrNo : $("#displayCornerItemPopForm #bnrNo").val()
												, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
												, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
												, bnrVodGb : $("#displayCornerItemPopForm #bnrVodGb").val()
												, bnrImgPath : $("#displayCornerItemPopForm #bnrImgPath").val()
												, bnrMobileImgPath : $("#displayCornerItemPopForm #bnrMobileImgPath").val()
												, bnrLinkUrl : $("#displayCornerItemPopForm #bnrLinkUrl").val()
												, bnrMobileLinkUrl : $("#displayCornerItemPopForm #bnrMobileLinkUrl").val()
												, bnrText : $("#displayCornerItemPopForm #bnrText").val()
												, bnrDscrt : $("#displayCornerItemPopForm #bnrDscrt").val()
												, contentId : $("#displayCornerItemPopForm #contentId").val()
												, contentTtl : $("#displayCornerItemPopForm #contentTtl").val()
												, contentTtl : $("#displayCornerItemPopForm #dispBnrNo").val()
												, dispPriorRank : rowids.length +1
												, dispStrtdt : "${frame:toDate('yyyy-MM-dd')}"
												, dispEnddt : "${frame:addMonth('yyyy-MM-dd', 1)}"
										}
									
									if(idCheck) {
										if(message != null && message.length > 0) {
											messager.alert(message.join("<br/>"),"Info","info");
										}
										return;
									}

									var options = {
										url : "<spring:url value='/display/displayCornerItemSave.do' />"
										, data : data
										, callBack : function(data) {
											// 영상+배너 그리드 리로드
											reloadDisplayVdBnrGrid($("#displayCornerItemForm #dispClsfCornNo").val());
										}
									};

									ajax.call(options);
								}
							}
						}
					layerPetTvMainLayer.create(options);
				} else if("${adminConstants.DISP_CORN_TP_74}" == dispCornTpCd
					   || "${adminConstants.DISP_CORN_TP_132}" == dispCornTpCd ) {
					var options = {
							multiselect : true
							, dispCornTpCd : dispCornTpCd
							, itemLength : $("#displayCornerItemList").jqGrid('getDataIDs').length
							, callBack : function(result) {
								if(result != null) {
									var idCheck = false;
									var message = new Array();
									var displayCornerItemPOList = new Array();
									
										// 영상 중복 체크
											for(var i=0; i < result.length; i++) {
												var rowids = $("#displayCornerItemList").jqGrid('getDataIDs');
													for(var j = 0; j < rowids.length; j++) {
														var rowdata = $("#displayCornerItemList").getRowData(rowids[j]);
															if(result[i].srisNo == rowdata.srisNo) {
																idCheck = true;
																message.push("[" + result[i].srisId + "] 가 중복입니다.");
															}
													}
													
													displayCornerItemPOList.push({
														srisNo : result[i].srisNo
														, srisId : result[i].srisId
														, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
														, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
														, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
														, dispPriorRank : rowids.length + (i+1)
														, dispStrtdt : "${frame:toDate('yyyy-MM-dd')}"
														, dispEnddt : "${frame:addMonth('yyyy-MM-dd', 1)}"
													});
												}
												if(idCheck) {
													if(message != null && message.length > 0) {
														messager.alert(message.join("<br/>"),"Info","info");
													}

													return;
												}
											
										}
								
									var sendData = {
						 				displayCornerItemPOList : JSON.stringify(displayCornerItemPOList)
					 				};
									
									var options = {
										url : "<spring:url value='/display/displayCornerItemSave.do' />"
										, data : sendData 
										, callBack : function(data) {
											// 시리즈 그리드 리로드
											reloadDisplaySeriesGrid($("#displayCornerItemForm #dispClsfCornNo").val());
										}
									};

									ajax.call(options);
								}
							}
					layerSeriesList.create(options);
				} else if("${adminConstants.DISP_CORN_TP_75}" == dispCornTpCd) {
					if(dispCnrItemNo == null) {
						var options = {
								dispCornTpCd : "${adminConstants.DISP_CORN_TP_75}"
								, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
								, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
								, dispCnrItemNo : dispCnrItemNo
								, callBack : function(result) {
									if(result != null) {
										var sendData = new Array();
										var idCheck = false;
										var message = new Array();
										var displayCornerItemPOList = new Array();

										// 콘텐츠 중복 체크
											var rowids = $("#displayCornerItemList").jqGrid('getDataIDs');
	 										for(var j = 0; j < rowids.length; j++) {
												var rowdata = $("#displayCornerItemList").getRowData(rowids[j]);

												if(result.bnrNo == rowdata.bnrNo) {
													idCheck = true;
													message.push("배너 번호 [" + result.bnrNo + "] 가 중복입니다.");
												}
											}
											
	 										data = {
												bnrNo : result.bnrNo
												, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
												, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
												, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
												, dispPriorRank : rowids.length + 1
												, bnrLinkUrl : $("#displayCornerItemPopForm #bnrLinkUrl").val()
												, bnrMobileLinkUrl : $("#displayCornerItemPopForm #bnrMobileLinkUrl").val()
												, bnrImgPath : $("#displayCornerItemPopForm #bnrImgPath").val()
												, bnrMobileImgPath : $("#displayCornerItemPopForm #bnrMobileImgPath").val()
												, bnrDscrt : $("#displayCornerItemPopForm #bnrDscrt").val()
												, dispStrtdt : $("#displayCornerItemPopForm #dispStrtdt").val()
												, dispEnddt : $("#displayCornerItemPopForm #dispEnddt").val()
												, dispCornerItemStrtdt : $("#displayCornerItemPopForm #dispStrtdt").val()
												, dispCornerItemEnddt : $("#displayCornerItemPopForm #dispEnddt").val()
	 										}
											
										if(idCheck) {
											if(message != null && message.length > 0) {
												messager.alert(message.join("<br/>"),"Info","info");
											}
											return;
										}
										
										/* var sendData = {
								 				displayCornerItemPOList : JSON.stringify(displayCornerItemPOList)
							 				}; */

										var options = {
											url : "<spring:url value='/display/displayCornerItemSave.do' />"
											, data : data
											, callBack : function(data) {
												// 영상+배너+태그 그리드 리로드
												reloadDisplayCornerBnrVodTagGrid($("#displayCornerItemForm #dispClsfCornNo").val());
											}
										};

										ajax.call(options);
										}
									}
								}
					} else {
						var options = {
								dispCornTpCd : "${adminConstants.DISP_CORN_TP_75}"
								, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
								, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
								, dispCnrItemNo : dispCnrItemNo
								, dispBnrNo : dispBnrNo
								, callBack : function(result) {
									if(result != null) {
										var sendData = new Array();
										var idCheck = false;
										var message = new Array();
										var displayCornerItemPOList = new Array();

											data = {
												bnrNo : result.bnrNo
												, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
												, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
												, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
												, dispStrtdt : $("#displayCornerItemPopForm #dispStrtdt").val()
												, dispEnddt : $("#displayCornerItemPopForm #dispEnddt").val()
												, bnrLinkUrl : $("#displayCornerItemPopForm #bnrLinkUrl").val()
												, bnrMobileLinkUrl : $("#displayCornerItemPopForm #bnrMobileLinkUrl").val()
												, bnrImgPath : $("#displayCornerItemPopForm #bnrImgPath").val()
												, bnrMobileImgPath : $("#displayCornerItemPopForm #bnrMobileImgPath").val()
												, bnrDscrt : $("#displayCornerItemPopForm #bnrDscrt").val()
												, dispCornerItemStrtdt : $("#displayCornerItemPopForm #dispStrtdt").val()
												, dispCornerItemEnddt : $("#displayCornerItemPopForm #dispEnddt").val()
												, dispCnrItemNo : dispCnrItemNo
												, dispBnrNo : dispBnrNo
											}
											
										/* var sendData = {
								 				displayCornerItemPOList : JSON.stringify(displayCornerItemPOList)
							 				}; */

										var options = {
											url : "<spring:url value='/display/displayCornerItemSave.do' />"
											, data : data
											, callBack : function(data) {
												// 영상+배너+태그 그리드 리로드
												reloadDisplayCornerBnrVodTagGrid($("#displayCornerItemForm #dispClsfCornNo").val());
											}
										};

										ajax.call(options);
										}
									}
								}
					}
					
					layerPetTvMainLayer.create(options);
				}
 			}			

			// 전시 코너 아이템 화면
			function displayCornerItemListView(dispClsfNo, dispClsfCornNo, dispCornTpCd) {
				var data = {
					dispClsfNo : dispClsfNo
					, dispClsfCornNo : dispClsfCornNo
					, dispCornTpCd : dispCornTpCd
				}

				var options = {
					url : "<spring:url value='/display/displayCornerItemListView.do' />"
					, data : data
					, dataType : "html"
					, callBack : function(result) {
						$("#displayCornerItemListView").html(result);

						// 전시 코너 아이템 리스트
						if("${adminConstants.DISP_CORN_TP_60}" == dispCornTpCd) {
							// 상품
							createDisplayCornerGoodsGrid();
						}else if("${adminConstants.DISP_CORN_TP_20}" == dispCornTpCd) {
							// 배너 TEXT
							createDisplayCornerBnrTextGrid();
						}else if( "${adminConstants.DISP_CORN_TP_30}" == dispCornTpCd  // 이미지+TEXT
								|| "${adminConstants.DISP_CORN_TP_71}" == dispCornTpCd 	// 배너 이미지/동영상/태그
								|| "${adminConstants.DISP_CORN_TP_72}" == dispCornTpCd 	// 배너 이미지/동영상/태그
								|| "${adminConstants.DISP_CORN_TP_73}" == dispCornTpCd 	// 배너 이미지/동영상
								|| "${adminConstants.DISP_CORN_TP_74}" == dispCornTpCd 	//시리즈 목록
								|| "${adminConstants.DISP_CORN_TP_75}" == dispCornTpCd 	// 배너 이미지/동영상/태그
								|| "${adminConstants.DISP_CORN_TP_80}" == dispCornTpCd 	//태그 리스트	
								|| "${adminConstants.DISP_CORN_TP_90}" == dispCornTpCd 	//펫로그 회원
								|| "${adminConstants.DISP_CORN_TP_100}" == dispCornTpCd //펫로그 리스트
								|| "${adminConstants.DISP_CORN_TP_130}" == dispCornTpCd	// 시리즈TAG
								|| "${adminConstants.DISP_CORN_TP_131}" == dispCornTpCd // 동영상TAG
								|| "${adminConstants.DISP_CORN_TP_132}" == dispCornTpCd // 시리즈미고정
								|| "${adminConstants.DISP_CORN_TP_133}" == dispCornTpCd // 동영상미고정
								){
							createDisplayCornerBnrItemView();
						} else if("${adminConstants.DISP_CORN_TP_10}" == dispCornTpCd){
							// 배너 HTMl
							createDisplayCornerBnrHtmlView();
						}
					}
				};
				ajax.call(options);
			}
		
			function createDisplayCornerBnrVodTagGrid() {
				var options = {
						url : "<spring:url value='/display/listDisplayCornerBnrVodTagGrid.do' />"
							, height : 200
							, multiselect : true
							, paging : false
							, rownumbers : true
							, searchParam : {
									dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
									, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
									, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val() 
						}
						, colModels : [
							// 아이템 번호
							{name:"dispCnrItemNo", label:'<spring:message code="column.item_no" />', width:"100", align:"center", hidden:true}
							// 전시 분류 코너 번호
							, {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"150", align:"center", hidden:true}
							// 전시 코너 타입 코드
						    , {name:"dispCornTpCd", label:'<spring:message code="column.disp_corn_tp_cd" />', width:"150", align:"center", hidden:true, formatter: function() {
								return $("#displayCornerItemForm #dispCornTpCd").val();
							}}
							// 전시 배너 번호
							, {name:"dispBnrNo", label:'<spring:message code="column.disp_bnr_no" />', width:"100", align:"center", formatter:'integer', hidden:true}
							// 상세보기
							, {name:"button", label:'배너 상세 보기', width:"100", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
								var str = '<button type="button" onclick="displayCornerItemViewPop(' + rowObject.dispCnrItemNo + ', ' + rowObject.dispBnrNo + ')" class="btn_h25_type1">배너 상세</button>';
								return str;
							}}
							// 전시 우선 순위
							, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"100", align:"center", formatter:'integer'}
							// 이미지(PC)
							, {name:"bnrImgPath", label:'<spring:message code="column.display_view.pc_img" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
									if(rowObject.bnrImgPath != "") {
										return '<img src="${frame:imagePath( "'+rowObject.bnrImgPath+'" )}" style="width:100px; height:100px;" alt="' + rowObject.bnrImgNm + '" />';
									} else {
										return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
									}
								}
							}
							// 이미지(모바일)
							, {name:"bnrMobileImgPath", label:'<spring:message code="column.display_view.mobile_img" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
									if(rowObject.bnrMobileImgPath != "") {
										return '<img src="${frame:imagePath( "'+rowObject.bnrMobileImgPath+'" )}" style="width:100px; height:100px;" alt="' + rowObject.bnrMobileImgNm + '" />';
									} else {
										return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
									}
								}
							}
							// 제목
							, {name:"bnrText", label:'<spring:message code="column.ttl" />', width:"200", align:"center"}
							// 내용
							, {name:"bnrDscrt", label:'<spring:message code="column.content" />', width:"200", align:"center"}
							// 태그
							, {name:"tagList", label:'<spring:message code="column.tag" />', width:"200", align:"center", formatter: function(cellvalue, colModel, rowObject) {
								var html = '';
								for(var i = 0; i < cellvalue.length; i++) {
									html += '#'+cellvalue[i].tagNm+"&nbsp;"
								}
								return html;
							}}
							// LINK URL
							, {name:"bnrLinkUrl", label:'<spring:message code="column.display_view.bnr_link_url" />', width:"300", align:"center"}
							// 모바일 LINK URL
							, {name:"bnrMobileLinkUrl", label:'<spring:message code="column.display_view.bnr_mobile_link_url" />', width:"300", align:"center"}
							// 전시 시작일자
							, {name:"dispStrtdt", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
							// 전시 종료일자
							, {name:"dispEnddt", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
						]
					};

					grid.create("displayCornerItemList", options);
					dispCornerItemDragAndDrop("displayCornerItemList");
			}
			
			//시리즈 그리드 검색
			function reloadDisplayCornerBnrVodTagGrid(dispClsfCornNo) {
				var options = {
						searchParam : { dispClsfCornNo : dispClsfCornNo }
				};

				grid.reload("displayCornerItemList", options);
			}
			
			function createDisplayCornerBnrVodTagGrid() {
				var options = {
						url : "<spring:url value='/display/listDisplayCornerBnrVodTagGrid.do' />"
							, height : 200
							, multiselect : true
							, paging : false
							, rownumbers : true
							, searchParam : {
									dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
									, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
									, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val() 
						}
						, colModels : [
							// 아이템 번호
							{name:"dispCnrItemNo", label:'<spring:message code="column.item_no" />', width:"100", align:"center", hidden:true}
							// 전시 분류 코너 번호
							, {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"150", align:"center", hidden:true}
							// 전시 코너 타입 코드
						    , {name:"dispCornTpCd", label:'<spring:message code="column.disp_corn_tp_cd" />', width:"150", align:"center", hidden:true, formatter: function() {
								return $("#displayCornerItemForm #dispCornTpCd").val();
							}}
							// 전시 배너 번호
							, {name:"dispBnrNo", label:'<spring:message code="column.disp_bnr_no" />', width:"100", align:"center", formatter:'integer', hidden:true}
							// 상세보기
							, {name:"button", label:'배너 상세 보기', width:"100", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
								var str = '<button type="button" onclick="displayCornerItemViewPop(' + rowObject.dispCnrItemNo + ', ' + rowObject.dispBnrNo + ')" class="btn_h25_type1">배너 상세</button>';
								return str;
							}}
							// 전시 우선 순위
							, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"100", align:"center", formatter:'integer'}
							// 이미지(PC)
							, {name:"bnrImgPath", label:'<spring:message code="column.display_view.pc_img" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
									if(rowObject.bnrImgPath != "") {
										return '<img src="${frame:imagePath( "'+rowObject.bnrImgPath+'" )}" style="width:100px; height:100px;" alt="' + rowObject.bnrImgNm + '" />';
									} else {
										return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
									}
								}
							}
							// 이미지(모바일)
							, {name:"bnrMobileImgPath", label:'<spring:message code="column.display_view.mobile_img" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
									if(rowObject.bnrMobileImgPath != "") {
										return '<img src="${frame:imagePath( "'+rowObject.bnrMobileImgPath+'" )}" style="width:100px; height:100px;" alt="' + rowObject.bnrMobileImgNm + '" />';
									} else {
										return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
									}
								}
							}
							// 제목
							, {name:"bnrText", label:'<spring:message code="column.ttl" />', width:"200", align:"center"}
							// 내용
							, {name:"bnrDscrt", label:'<spring:message code="column.content" />', width:"200", align:"center"}
							// 태그
							, {name:"tagList", label:'<spring:message code="column.tag" />', width:"200", align:"center", formatter: function(cellvalue, colModel, rowObject) {
								var html = '';
								for(var i = 0; i < cellvalue.length; i++) {
									html += '#'+cellvalue[i].tagNm+"&nbsp;"
								}
								return html;
							}}
							// LINK URL
							, {name:"bnrLinkUrl", label:'<spring:message code="column.display_view.bnr_link_url" />', width:"300", align:"center"}
							// 모바일 LINK URL
							, {name:"bnrMobileLinkUrl", label:'<spring:message code="column.display_view.bnr_mobile_link_url" />', width:"300", align:"center"}
							// 전시 시작일자
							, {name:"dispStrtdt", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
							// 전시 종료일자
							, {name:"dispEnddt", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
						]
					};

					grid.create("displayCornerItemList", options);
					dispCornerItemDragAndDrop("displayCornerItemList");
			}
			
			function createDisplayCornerSeriesGrid() {
				var _lebel = "<spring:message code='column.sys_reg_dt' /><br/>(<spring:message code='column.sys_upd_dt' />)";
				var options = {
					  url : "<spring:url value='/display/displayCornerSeriesListGrid.do' />"	
	 				, height : 400 				
	 				, searchParam : {
						dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
						, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
						, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
					}
					, colModels : [
						// 아이템 번호
						{name:"dispCnrItemNo", label:'<spring:message code="column.item_no" />', width:"100", align:"center", hidden:true}
						// 전시 분류 코너 번호
						, {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"150", align:"center", hidden:true}
						// 전시 코너 타입 코드
					    , {name:"dispCornTpCd", label:'<spring:message code="column.disp_corn_tp_cd" />', width:"150", align:"center", hidden:true, formatter: function() {
							return $("#displayCornerItemForm #dispCornTpCd").val();
						}}
						// 전시 우선 순위
						, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"60", align:"center", formatter:'integer', editable:true}
					    , {name:"srisNo", label:'<spring:message code="column.no" />', hidden:true,	width:"60", 	align:"center", sortable:false}/* 번호 */
						, {name:"srisId", label:'<spring:message code="column.sris_id" />', width:"100", 	align:"center", sortable:false, classes:'pointer fontbold'}/* 시리즈ID */
						, {name:"srisPrflImgPath", 	label:'<spring:message code="column.sris_profile" />',	width:"150", align:"center", classes:'pointer fontbold', sortable:false, formatter: function(cellvalue, options, rowObject) {
							if(rowObject.srisPrflImgPath != "" && rowObject.srisPrflImgPath != null) {
								return '<img src="${frame:imagePath( "'+rowObject.srisPrflImgPath+'" )}" style="width:100px; height:100px;" onError="this.src=\'/images/noimage.png\'"  />';
							} else {
								return '<img src="/images/noimage.png" style="width:70px; height:60px;" alt="NoImage" />';
							}
							} /* 시리즈프로필 */
						}
						, {name:"srisNm", label:"<spring:message code='column.sris_nm' />", width:"150", 	align:"left", sortable:false, classes:'pointer fontbold'} /* 시리즈명 */
						, {name:"sesnCnt",			label:"<spring:message code='column.sesn_cnt' />", 		width:"100", 	align:"center", sortable:false} /* 시즌수 */						
						, {name:"tpNm", 			label:"<spring:message code='column.type' />",  		align:"center", 	sortable:false, width:"100"} /* 타입 */						
						, {name:"dispYn", label:"<spring:message code='column.vod.disp' />", align:"center", sortable:false, width:"180"
							, editable:true, edittype:'select', formatter:'select', editoptions : {value:"<frame:gridSelect grpCd='${adminConstants.DISP_STAT}' showValue='false' />"}} /* 전시 */
						// 전시 시작일자
						, {name:"dispStrtdt", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
						// 전시 종료일자
						, {name:"dispEnddt", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
						, {name:"regModDtm", label:_lebel,  align:"center", width:"200", sortable:false} /* 등록수정일 */
						]

					, multiselect : true
					, gridComplete : function (){
						jQuery("#seriesList").jqGrid( 'setGridWidth', $(".mModule").width() );
					}
				}
				grid.create("displayCornerItemList", options);
				dispCornerItemDragAndDrop("displayCornerItemList");
			}
			
			//시리즈 그리드 검색
			function reloadDisplaySeriesGrid(dispClsfCornNo) {
				var options = {
						searchParam : { dispClsfCornNo : dispClsfCornNo }
				};

				grid.reload("displayCornerItemList", options);
			}
			
			//전시 코너 아이템 (영상) 그리드
			function createDisplayCornerVodGrid() {
				var options = {
						url : "<spring:url value='/display/displayCornerVdListGrid.do' />"
						, height : 400
						, searchParam : {
								dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
								, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
								, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
						}
						, sortname : 'sysRegDtm'
						, sortorder : 'DESC'
						, multiselect : true
						, colModels : [
							{name:"dispCnrItemNo", label:'<spring:message code="column.item_no" />', width:"80", align:"center", hidden:true}
							// 전시 분류 코너 번호
							, {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"150", align:"center", hidden:true}
							// 전시 코너 타입 코드
						    , {name:"dispCornTpCd", label:'<spring:message code="column.disp_corn_tp_cd" />', width:"150", align:"center", hidden:true, formatter: function() {
								return $("#displayCornerItemForm #dispCornTpCd").val();
							}}
						 	// 배너 번호
							, {name:"bnrNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"150", align:"center", hidden:true}
							// 상세보기
							, {name:"button", label:'배너 상세 보기', width:"100", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
								var str = '<button type="button" onclick="displayCornerItemViewPop(' + rowObject.dispCnrItemNo + ')" class="btn_h25_type1">영상 상세</button>';
								return str;
							}}
							// 전시 우선 순위
							, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"60", align:"center", formatter:'integer', editable:true}
							  /* 영상 Id */
							, {name:"vdId", label:'<spring:message code="column.vd_id" />', width:"150", align:"center", classes:'cursor_default', sortable:false}
							  /* 썸네일 */
							, {name:"thumPath", 	label:'<spring:message code="column.thum" />',	width:"150", align:"center", classes:'pointer fontbold', sortable:false, formatter: function(cellvalue, options, rowObject) {
								if(rowObject.thumPath != "" && rowObject.thumPath != null) {
									return '<img src='+rowObject.thumPath+' style="width:100px; height:100px;" onError="this.src=\'/images/noimage.png\'"  />';
								} else {
									return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
								}
								}
							}
							  /* 제목  */
							, {name:"ttl", label:'<spring:message code="column.ttl" />', width:"300", align:"left", classes:'pointer vodTtlColor', sortable:false}
							  //시리즈
							, {name:"srisNm", label:'<spring:message code="column.sris_nm" />', width:"110", align:"center", classes:'cursor_default', sortable:false}  
							  /* 공유수 */
							//, {name:"shareCnt", label:'<spring:message code="column.vod.share_cnt" />', width:"110", align:"center", classes:'cursor_default', sortable:false}
							  /* 조회수 */
							//, {name:"hits", label:'<spring:message code="column.vod.hits" />', width:"110", align:"center", classes:'cursor_default', sortable:false, formatter:'integer'}
							  /* 좋아요 */
							//, {name:"likeCnt", label:'<spring:message code="column.vod.like" />', width:"110", align:"center", classes:'cursor_default', sortable:false, formatter:'integer'}
							  /* 댓글수 */
							//, {name:"replyCnt", label:'<spring:message code="column.vod.reply_cnt" />', width:"110", classes:'cursor_default', align:"center", sortable:false, formatter:'integer'}
							  /* 전시 */
							//, {name:"dispYn", label:"<spring:message code='column.vod.disp' />", width:"60", align:"center", classes:'cursor_default', sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.DISP_STAT }' showValue='false' />" } }
							  /* 등록일(수정일) */
							/* , {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_upd_dt" />', width:"145", align:"center", classes:'cursor_default', sortable:false, formatter: function(rowId, val, rawObject, cm) {
								return new Date(rawObject.sysRegDtm).format("yyyy-MM-dd HH:mm:ss") + '\r\n<p style="font-size:11px;">(' + new Date(rawObject.sysRegDtm).format("yyyy-MM-dd HH:mm:ss")+ ')</p>';
								}
							} */
							// 전시 시작일자
							, {name:"dispStrtdt", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
							// 전시 종료일자
							, {name:"dispEnddt", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
						]
					};
					grid.create("displayCornerItemList", options);
					dispCornerItemDragAndDrop("displayCornerItemList");
			}
			
			//영상 그리드 검색
			function reloadDisplayVdGrid(dispClsfCornNo) {
				var options = {
						searchParam : { dispClsfCornNo : dispClsfCornNo }
				};

				grid.reload("displayCornerItemList", options);
			}
			
			// 전시 코너 아이템(배너) 그리드
	 		function createDisplayBannerGrid() {
				var options = {
					url : "<spring:url value='/display/displayCornerBannerListGrid.do' />",
					multiselect : true,
					height : 400,
					searchParam : {
						dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
						, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
						, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val() 
					},
					colModels : [
						// 아이템 번호
						{name:"dispCnrItemNo", label:'<spring:message code="column.item_no" />', width:"80", align:"center", hidden:true}
						// 전시 분류 코너 번호
						, {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"150", align:"center"}
						// 전시 코너 타입 코드
					    , {name:"dispCornTpCd", label:'<spring:message code="column.disp_corn_tp_cd" />', width:"150", align:"center", hidden:true, formatter: function() {
							return $("#displayCornerItemForm #dispCornTpCd").val();
						}}
						, {name : "dispBnrNo",label : "<spring:message code='column.bnr_no' />" ,width : "80", align : "center"}
						, {name : "bnrNo",label : "<spring:message code='column.bnr_no' />" ,width : "80", align : "center", hidden:true}
						, {name : "bnrId",label : "<spring:message code='column.bnr_id' />" ,width : "100", align : "center"}
						, {name : "bnrMobileImgPath",label : "<spring:message code='column.bnr_mo_img_path' />", width : "180", align : "center", formatter : function(cellvalue, options, rowObject) {
								if(rowObject.bnrMobileImgPath != "" && rowObject.bnrMobileImgPath != undefined) {
									   return '<img src="'+ rowObject.bnrMobileImgPath + '" style="width:70px; height:60px;" alt="" />';
								} else {
									return '<img src="/images/noimage.png" style="width:70px; height:60px;" alt="NoImage" />';
								}
							}
						}
						, {name : "bnrTtl",label : "<spring:message code='column.bnr_ttl' />",width : "400", align : "center"}
						, {name : "useYn",label : "<spring:message code='column.bnr_use_yn' />",width : "100", align : "center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.USE_YN}" />"}}
						// 전시 우선 순위
						, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"60", align:"center", formatter:'integer', editable:true}
						// 전시 시작일자
						, {name:"dispStrtdt", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
						// 전시 종료일자
						, {name:"dispEnddt", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
						]
				};
				grid.create("displayCornerItemList", options);
				dispCornerItemDragAndDrop("displayCornerItemList");
			}
			
			//배너 그리드 검색
			function reloadDisplayBnrGrid(dispClsfCornNo) {
				var options = {
						searchParam : { dispClsfCornNo : dispClsfCornNo }
				};

				grid.reload("displayCornerItemList", options);
			}
			
			// 전시 코너 아이템 (영상 + 배너) 그리드
			function createDisplayCornerVdBnrGrid() {
				var options = {
						url : "<spring:url value='/display/displayCornerVdBnrListGrid.do' />"
							, height : 200
							, multiselect : true
							, paging : false
							, rownumbers : true
							, searchParam : {
									dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
									, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
									, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val() 
						}
						, colModels : [
							// 아이템 번호
							{name:"dispCnrItemNo", label:'<spring:message code="column.item_no" />', width:"100", align:"center", hidden:true}
							// 전시 분류 코너 번호
							, {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"150", align:"center", hidden:true}
							// 전시 코너 타입 코드
						    , {name:"dispCornTpCd", label:'<spring:message code="column.disp_corn_tp_cd" />', width:"150", align:"center", hidden:true, formatter: function() {
								return $("#displayCornerItemForm #dispCornTpCd").val();
							}}
							// 전시 배너 번호
							, {name:"dispBnrNo", label:'<spring:message code="column.disp_bnr_no" />', width:"100", align:"center", formatter:'integer', hidden:true}
							// 상세보기
							, {name:"button", label:'배너 상세 보기', width:"100", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
								var str = '<button type="button" onclick="displayCornerItemViewPop(' + rowObject.dispCnrItemNo + ', ' + rowObject.dispBnrNo + ')" class="btn_h25_type1">배너 상세</button>';
								return str;
							}}
							// 전시 우선 순위
							, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"100", align:"center", formatter:'integer'}
							// 이미지(PC)
							, {name:"bnrImgNm", label:'<spring:message code="column.display_view.pc_img" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
									if(rowObject.bnrImgPath != "") {
										return '<img src="${frame:imagePath( "'+rowObject.bnrImgPath+'" )}" style="width:100px; height:100px;" alt="' + rowObject.bnrImgNm + '" />';
									} else {
										return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
									}
								}
							}
							// 이미지(모바일)
							, {name:"bnrMobileImgNm", label:'<spring:message code="column.display_view.mobile_img" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
									if(rowObject.bnrMobileImgPath != "") {
										return '<img src="${frame:imagePath( "'+rowObject.bnrMobileImgPath+'" )}" style="width:100px; height:100px;" alt="' + rowObject.bnrMobileImgNm + '" />';
									} else {
										return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
									}
								}
							}
							// LINK URL
							, {name:"bnrLinkUrl", label:'<spring:message code="column.display_view.bnr_link_url" />', width:"300", align:"center"}
							// 모바일 LINK URL
							, {name:"bnrMobileLinkUrl", label:'<spring:message code="column.display_view.bnr_mobile_link_url" />', width:"300", align:"center"}
							// 전시 시작일자
							, {name:"dispStrtdt", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
							// 전시 종료일자
							, {name:"dispEnddt", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
						]
					};

					grid.create("displayCornerItemList", options);
					dispCornerItemDragAndDrop("displayCornerItemList");
			}
			
			// 영상 + 배너 그리드 검색
			function reloadDisplayVdBnrGrid(dispClsfCornNo) {
				var options = {
						searchParam : { dispClsfCornNo : dispClsfCornNo }
				};

				grid.reload("displayCornerItemList", options);
			}

			// 전시 코너 아이템 리스트(상품)
			function createDisplayCornerGoodsGrid() {
				var options = {
					url : "<spring:url value='/display/displayCornerGoodsListGrid.do' />"
					, height : 200
					, cellEdit : true
					, multiselect : true
					, paging : false
					, sortname : "DISP_PRIOR_RANK"
					, sortorder : "ASC"
					, searchParam : { 
						dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
						, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
					}
					, colModels : [
						// 아이템 번호
						{name:"dispCnrItemNo", label:'<spring:message code="column.item_no" />', width:"80", align:"center", hidden:true}
						// 전시 분류 코너 번호
						, {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"100", align:"center", hidden:true}
						// 전시 우선 순위
						, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"60", align:"center", formatter:'integer', editable:true}
						// 상품 번호
						, {name:"goodsId", label:'<spring:message code="column.goods_id" />', width:"100", align:"center"}
                        // 상품 홍보 문구
                        , {name:"goodsText", label:'<spring:message code="column.display_view.goods_text" />', width:"300", align:"center", editable:true,  hidden:true}						
                        // 브랜드 명 국문
                        , {name:"bndNmKo", label:"<spring:message code='column.bnd_nm' />", width:"150", align:"center", sortable:false } /* 브랜드명 */						
						// 상품명
						, {name:"goodsNm", label:'<spring:message code="column.display_view.goods_nm" />', width:"250", align:"center"}
						// 전시 시작일자
						, {name:"dispStrtdt", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
						// 전시 종료일자
						, {name:"dispEnddt", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
						// 상품 상태 코드
						, {name:"goodsStatCd", label:"<spring:message code='column.goods_stat_cd' />", width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_STAT }' showValue='false' />" } } /* 상품 상태 */
						// 상품 유형 코드
						, {name:"goodsTpCd", label:"<spring:message code='column.goods_tp_cd' />", width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_TP }' showValue='false' />" } } /* 상품 유형 */
						// 판매가
						, {name:"saleAmt", label:"<spring:message code='column.sale_prc' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
						// 업체명
						, {name:"compNm", label:"<spring:message code='column.goods.comp_nm' />", width:"120", align:"center", sortable:false } /* 업체명 */
						// 제조사
						, {name:"mmft", label:"<spring:message code='column.mmft' />", width:"120", align:"center", sortable:false } /* 제조사 */
						// 노출여부
						, {name:"showYn", label:"<spring:message code='column.show_yn' />", width:"60", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.SHOW_YN }' showValue='false' />" } } /* 노출여부 */
						// 판매 시작 일시
						, {name:"saleStrtDtm", label:'<spring:message code="column.sale_strt_dtm" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						// 판매 종료 일시
						, {name:"saleEndDtm", label:'<spring:message code="column.sale_end_dtm" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
					]
				};

				grid.create("displayCornerItemList", options);
				dispCornerItemDragAndDrop("displayCornerItemList");
				
			}

			// 전시 코너 아이템 리스트(상품평)
			function createDisplayCornerGoodsEstmGrid() {
				var options = {
					url : "<spring:url value='/display/displayCornerGoodsEstmListGrid.do' />"
					, height : 200
					, cellEdit : true
					, multiselect : true
					, paging : false
					, searchParam : {
						dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
						, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
					}
					, colModels : [
						// 아이템 번호
						{name:"dispCnrItemNo", label:'<spring:message code="column.item_no" />', width:"100", align:"center", hidden:true}
						// 전시 분류 코너 번호
						, {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"100", align:"center", hidden:true}
						// 전시 우선 순위
						, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"100", align:"center", formatter:'integer', editable:true}
						// 상품 번호
						, {name:"goodsId", label:'<spring:message code="column.goods_id" />', width:"100", align:"center"}
						// 상품명
						, {name:"goodsNm", label:'<spring:message code="column.display_view.goods_nm" />', width:"200", align:"center"}
						// 상품평 번호
						, {name:"goodsEstmNo", label:'<spring:message code="column.display_view.goods_estm_no" />', width:"100", align:"center"}
						// 상품평 제목
						, {name:"ttl", label:'<spring:message code="column.display_view.ttl" />', width:"200", align:"center"}
						// 회원 ID
						, {name:"estmId", label:'<spring:message code="column.display_view.estm_id" />', width:"100", align:"center"}
						// 이미지 여부
						, {name:"imgRegYn", label:'<spring:message code="column.display_view.img_reg_yn" />', width:"100", align:"center"}
						// 조회수
						, {name:"hits", label:'<spring:message code="column.hits" />', width:"100", align:"center"}
						// 전시 시작일자
						, {name:"dispStrtdt", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
						// 전시 종료일자
						, {name:"dispEnddt", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
					]
				};

				grid.create("displayCornerItemList", options);
			}

			// 전시 코너 아이템 리스트(배너 TEXT)
			function createDisplayCornerBnrTextGrid() {
				var options = {
					url : "<spring:url value='/display/displayCornerBnrItemListGrid.do' />"
					, height : 200
					, cellEdit : true
					, multiselect : true
					, paging : false
					, searchParam : {
						dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
						, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
						, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val() 
					}
					, colModels : [
						// 아이템 번호
						{name:"dispCnrItemNo", label:'<spring:message code="column.item_no" />', width:"100", align:"center", hidden:true}
						// 전시 분류 코너 번호
						, {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"150", align:"center", hidden:false}
						// 전시 배너 번호
						, {name:"dispBnrNo", label:'<spring:message code="column.disp_bnr_no" />', width:"100", align:"center", hidden:true}
						// 전시 코너 타입 코드
						, {name:"dispCornTpCd", label:'<spring:message code="column.disp_corn_tp_cd" />', width:"100", align:"center", hidden:true, formatter: function() {
							return $("#displayCornerItemForm #dispCornTpCd").val();
						}}
						// 전시 우선 순위
						, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"100", align:"center", formatter:'integer', editable:true}
						// 배너 TEXT
						, {name:"bnrText", label:'<spring:message code="column.display_view.bnr_text" />', width:"200", align:"center", editable:true}
						// LINK URL
// 						, {name:"bnrLinkUrl", label:'<spring:message code="column.display_view.bnr_link_url" />', width:"200", align:"center", editable:true}
						// 모바일 LINK URL
// 						, {name:"bnrMobileLinkUrl", label:'<spring:message code="column.display_view.bnr_mobile_link_url" />', width:"200", align:"center", editable:true}
						// 전시 시작일자
						, {name:"dispStrtdt", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
						// 전시 종료일자
						, {name:"dispEnddt", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
					]
				};

				grid.create("displayCornerItemList", options);
				dispCornerItemDragAndDrop("displayCornerItemList");
			}

			// 전시 코너 아이템 리스트(배너 HTML)
			function createDisplayCornerBnrHtmlView() {
				var data = {
					dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
					, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
					, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
				}

				var options = {
					url : "<spring:url value='/display/displayCornerBnrHtmlView.do' />"
					, data : data
					, dataType : "html"
					, callBack : function(result) {
						$("#displayCornerItemListView").html(result);

						EditorCommon.setSEditor("bnrHtml", '${adminConstants.DISPLAY_IMAGE_PATH}');
					}
				};

				ajax.call(options);
			}

			// 전시 코너 아이템(배너 이미지 / 배너 복합 / 배너 이미지 큐브 / 10초 동영상 / 브랜드 콘텐츠) 화면
			function createDisplayCornerBnrItemView() {
				var data = {
					dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
					, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
					, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
				}

				var options = {
						url : "<spring:url value='/display/displayCornerBnrItemView.do' />"
						, data : data
						, dataType : "html"
						, callBack : function(result) {
							$("#displayCornerItemListView").html(result);

							if("${adminConstants.DISP_CORN_TP_30}" == data.dispCornTpCd)  {	// 이미지+TEXT
								createDisplayCornerBnrImgGrid();
	 						} else if("${adminConstants.DISP_CORN_TP_71}" == data.dispCornTpCd
	 								|| "${adminConstants.DISP_CORN_TP_133}" == data.dispCornTpCd) {	// 영상
	 							createDisplayCornerVodGrid();
	 						} else if("${adminConstants.DISP_CORN_TP_72}" == data.dispCornTpCd) {	// 배너 이미지/동영상/태그
	 							createDisplayCornerBnrVodTagGrid();
	 						} else if("${adminConstants.DISP_CORN_TP_73}" == data.dispCornTpCd) {	// 배너 이미지/동영상
	 							createDisplayCornerVdBnrGrid();
							} else if("${adminConstants.DISP_CORN_TP_74}" == data.dispCornTpCd
									|| "${adminConstants.DISP_CORN_TP_132}" == data.dispCornTpCd) {	// 시리즈 목록
								createDisplayCornerSeriesGrid();
							} else if("${adminConstants.DISP_CORN_TP_75}" == data.dispCornTpCd) {	// 배너
	 							createDisplayCornerBnrGrid();
	 						} else if("${adminConstants.DISP_CORN_TP_80}" == data.dispCornTpCd		// 태그 리스트 
	 								|| "${adminConstants.DISP_CORN_TP_130}" == data.dispCornTpCd	// 시리즈TAG
									|| "${adminConstants.DISP_CORN_TP_131}" == data.dispCornTpCd) {	// 영상TAG
								createDisplayCornerTagsGrid();
							} else if("${adminConstants.DISP_CORN_TP_90}" == data.dispCornTpCd) {	// 펫로그 회원
	 							createDisplayCornerPetLogMemberGrid();
	 						} else if("${adminConstants.DISP_CORN_TP_100}" == data.dispCornTpCd) {	// 펫로그 리스트
	 							createDisplayCornerLogsGrid();
	 						}
						}
					};
				ajax.call(options);
			}
			
			// 전시 코너 아이템(배너) 그리드
	 		function createDisplayCornerBnrGrid() {
				var options = {
					url : "<spring:url value='/display/displayCornerBannerListGrid.do' />",
					multiselect : true,
					height : 400,
					searchParam : {
						dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
						, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
						, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val() 
					},
					colModels : [
						// 아이템 번호
						{name:"dispCnrItemNo", label:'<spring:message code="column.item_no" />', width:"80", align:"center", hidden:true}
						// 전시 분류 코너 번호
						, {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"150", align:"center", hidden:true}
						// 전시 코너 타입 코드
					    , {name:"dispCornTpCd", label:'<spring:message code="column.disp_corn_tp_cd" />', width:"150", align:"center", hidden:true, formatter: function() {
							return $("#displayCornerItemForm #dispCornTpCd").val();
						}}
					 	// 상세보기
						, {name:"button", label:'배너 상세 보기', width:"100", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
							var str = '<button type="button" onclick="displayCornerItemViewPop(' + rowObject.dispCnrItemNo + ', ' + rowObject.dispBnrNo + ')" class="btn_h25_type1">배너 상세</button>';
							return str;
						}}
						// 전시 우선 순위
						, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"60", align:"center", formatter:'integer', editable:true}
						, {name : "bnrNo",label : "<spring:message code='column.bnr_no' />" ,width : "80", align : "center", hidden:true}
						//, {name : "bnrId",label : "<spring:message code='column.bnr_id' />" ,width : "100", align : "center"}
						, {name : "bnrImgPath",label : "<spring:message code='column.bnr_pc_img' />", width : "180", align : "center", formatter : function(cellvalue, options, rowObject) {
							if(rowObject.bnrImgPath != "" && rowObject.bnrImgPath != null) {
								return '<img src="${frame:imagePath( "'+rowObject.bnrImgPath+'" )}" style="width:100px; height:100px;" onError="this.src=\'/images/noimage.png\'"  />';
							} else {
								return '<img src="/images/noimage.png" style="width:70px; height:60px;" alt="NoImage" />';
							}
						}
						}
						, {name : "bnrMobileImgPath",label : "<spring:message code='column.bnr_mo_img' />", width : "180", align : "center", formatter : function(cellvalue, options, rowObject) {
								if(rowObject.bnrMobileImgPath != "" && rowObject.bnrMobileImgPath != null) {
									return '<img src="${frame:imagePath( "'+rowObject.bnrMobileImgPath+'" )}" style="width:100px; height:100px;" onError="this.src=\'/images/noimage.png\'"  />';
								} else {
									return '<img src="/images/noimage.png" style="width:70px; height:60px;" alt="NoImage" />';
								}
							}
						}
						, {name : "bnrTtl",label : "<spring:message code='column.bnr_ttl' />",width : "400", align : "center"}
						, {name : "useYn",label : "<spring:message code='column.bnr_use_yn' />",width : "100", align : "center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.USE_YN}" />"}}
						// 전시 시작일자
						, {name:"dispStrtdt", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
						// 전시 종료일자
						, {name:"dispEnddt", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
						]
				};
				grid.create("displayCornerItemList", options);
				dispCornerItemDragAndDrop("displayCornerItemList", options);
			}
			
			// 전시 코너 아이템 리스트(배너 이미지)
			function createDisplayCornerBnrImgGrid() {
				var options = {
					url : "<spring:url value='/display/displayCornerBnrItemListGrid.do' />"
					, height : 400
					, multiselect : true
					, paging : false
					, searchParam : {
						dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
						, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
						, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val() 
					}
					, colModels : [
						// 아이템 번호
						{name:"dispCnrItemNo", label:'<spring:message code="column.item_no" />', width:"100", align:"center", hidden:true}
						// 전시 분류 코너 번호
						, {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"120", align:"center", hidden:true}
						// 전시 배너 번호
						, {name:"dispBnrNo", label:'<spring:message code="column.disp_bnr_no" />', width:"100", align:"center", formatter:'integer', hidden:true}
						// 전시 코너 타입 코드
						, {name:"dispCornTpCd", label:'<spring:message code="column.disp_corn_tp_cd" />', width:"150", align:"center", hidden:true, formatter: function() {
							return $("#displayCornerItemForm #dispCornTpCd").val();
						}}
						// 상세보기
						, {name:"button", label:'배너 상세 보기', width:"100", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
							var str = '<button type="button" onclick="displayCornerItemViewPop(' + rowObject.dispCnrItemNo + ', ' + rowObject.dispBnrNo + ')" class="btn_h25_type1">배너 상세</button>';
							return str;
						}}
						// 전시 우선 순위
						, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"80", align:"center", formatter:'integer'}
						// 배너 TEXT
						, {name:"bnrText", label:'<spring:message code="column.bnr_text" />', width:"100", align:"center"}
						// 이미지(PC)
						, {name:"bnrImgNm", label:'<spring:message code="column.display_view.pc_img" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
								if(rowObject.bnrImgPath != "") {
									return '<img src="${frame:imagePath( "'+rowObject.bnrImgPath+'" )}" style="width:100px; height:100px;" alt="' + rowObject.bnrImgNm + '" />';
								} else {
									return rowObject.bnrImgNm;
								}
							}
						}
						// 이미지(모바일)
// 						, {name:"bnrMobileImgNm", label:'<spring:message code="column.display_view.mobile_img" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
// 								if(rowObject.bnrMobileImgPath != "") {
// 									return '<img src="<frame:imgUrl />' + rowObject.bnrMobileImgPath + '" style="width:100px; height:100px;" alt="' + rowObject.bnrMobileImgNm + '" />';
// 								} else {
// 									return rowObject.bnrMobileImgNm;
// 								}
// 							}
// 						}
						// LINK URL
						, {name:"bnrLinkUrl", label:'<spring:message code="column.display_view.bnr_link_url" />', width:"300", align:"center"}
						// 모바일 LINK URL
						, {name:"bnrMobileLinkUrl", label:'<spring:message code="column.display_view.bnr_mobile_link_url" />', width:"300", align:"center"}
						// 전시 시작일자
						, {name:"dispStrtdt", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
						// 전시 종료일자
						, {name:"dispEnddt", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
					]
				};

				grid.create("displayCornerItemList", options);
				dispCornerItemDragAndDrop("displayCornerItemList");
			}

			// 전시 코너 아이템 리스트(배너 복합)
			function createDisplayCornerBnrMixGrid() {
				var options = {
					url : "<spring:url value='/display/displayCornerBnrItemListGrid.do' />"
					, height : 400
					, multiselect : true
					, paging : false
					, searchParam : {
						dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
						, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
					}
					, colModels : [
						// 아이템 번호
						{name:"dispCnrItemNo", label:'<spring:message code="column.item_no" />', width:"100", align:"center", hidden:true}
						// 전시 분류 코너 번호
						, {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"100", align:"center", hidden:true}
						// 전시 배너 번호
						, {name:"dispBnrNo", label:'<spring:message code="column.disp_bnr_no" />', width:"100", align:"center", formatter:'integer', hidden:true}
						// 상세보기
						, {name:"button", label:'배너 상세 보기', width:"100", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
							var str = '<button type="button" onclick="displayCornerItemViewPop(' + rowObject.dispCnrItemNo + ', ' + rowObject.dispBnrNo + ')" class="btn_h25_type1">배너 상세</button>';
							return str;
						}}
						// 전시 우선 순위
						, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"50", align:"center", formatter:'integer'}
						// 이미지(PC)
						, {name:"bnrImgNm", label:'<spring:message code="column.display_view.pc_img" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
								if(rowObject.bnrImgPath != "") {
									return '<img src="${frame:imagePath( "'+rowObject.bnrImgPath+'" )}" style="width:100px; height:100px;" alt="' + rowObject.bnrImgNm + '" />';
								} else {
									return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
								}
							}
						}
						// 이미지(모바일)
						, {name:"bnrMobileImgNm", label:'<spring:message code="column.display_view.mobile_img" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
								if(rowObject.bnrMobileImgPath != "") {
									return '<img src="<frame:imgUrl />' + rowObject.bnrMobileImgPath + '" style="width:100px; height:100px;" alt="' + rowObject.bnrMobileImgNm + '" />';
								} else {
									return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
								}
							}
						}
						// 배너 TEXT
						, {name:"bnrText", label:'<spring:message code="column.display_view.bnr_text" />', width:"200", align:"center"}
						// LINK URL
						, {name:"bnrLinkUrl", label:'<spring:message code="column.display_view.bnr_link_url" />', width:"300", align:"center"}
						// 모바일 LINK URL
						, {name:"bnrMobileLinkUrl", label:'<spring:message code="column.display_view.bnr_mobile_link_url" />', width:"300", align:"center"}
						// 전시 시작일자
						, {name:"dispStrtdt", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
						// 전시 종료일자
						, {name:"dispEnddt", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
					]
				};

				grid.create("displayCornerItemList", options);
			}

			// 전시 코너 아이템 리스트(배너 이미지 큐브)
			function createDisplayCornerBnrCubeGrid() {
				var options = {
					url : "<spring:url value='/display/displayCornerBnrItemListGrid.do' />"
					, height : 400
					, multiselect : true
					, paging : false
					, searchParam : {
						dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
						, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
					}
					, colModels : [
						// 아이템 번호
						{name:"dispCnrItemNo", label:'<spring:message code="column.item_no" />', width:"100", align:"center", hidden:true}
						// 전시 분류 코너 번호
						, {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"100", align:"center", hidden:true}
						// 전시 배너 번호
						, {name:"dispBnrNo", label:'<spring:message code="column.disp_bnr_no" />', width:"100", align:"center", formatter:'integer', hidden:true}
						// 상세보기
						, {name:"button", label:'배너 상세 보기', width:"100", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
							var str = '<button type="button" onclick="displayCornerItemViewPop(' + rowObject.dispCnrItemNo + ', ' + rowObject.dispBnrNo + ')" class="btn_h25_type1">배너 상세</button>';
							return str;
						}}
						// 전시 우선 순위
						, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"50", align:"center", formatter:'integer'}
						// 배너 TEXT
						, {name:"bnrText", label:'<spring:message code="column.ttl" />', width:"200", align:"center", editable:true}
						// 이미지(PC)
						, {name:"bnrImgNm", label:'<spring:message code="column.display_view.pc_img" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
								if(rowObject.bnrImgPath != "") {
									return '<img src="${frame:imagePath( "'+rowObject.bnrImgPath+'" )}" style="width:100px; height:100px;" alt="' + rowObject.bnrImgNm + '" />';
								} else {
									return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
								}
							}
						}
						// 이미지(모바일)
						, {name:"bnrMobileImgNm", label:'<spring:message code="column.display_view.mobile_img" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
								if(rowObject.bnrMobileImgPath != "") {
									return '<img src="<frame:imgUrl />' + rowObject.bnrMobileImgPath + '" style="width:100px; height:100px;" alt="' + rowObject.bnrMobileImgNm + '" />';
								} else {
									return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
								}
							}
						}
						// LINK URL
						, {name:"bnrLinkUrl", label:'<spring:message code="column.display_view.bnr_link_url" />', width:"280", align:"center"}
						// 모바일 LINK URL
						, {name:"bnrMobileLinkUrl", label:'<spring:message code="column.display_view.bnr_mobile_link_url" />', width:"280", align:"center"}
						// 전시 시작일자
						, {name:"dispStrtdt", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
						// 전시 종료일자
						, {name:"dispEnddt", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
					]
				};

				grid.create("displayCornerItemList", options);
			}

			// 전시 코너 아이템 리스트(10초 동영상)
			function createDisplayCornerTenSecVideoGrid() {
				var options = {
					url : "<spring:url value='/display/displayCornerBnrItemListGrid.do' />"
					, height : 400
					, multiselect : true
					, paging : false
					, searchParam : {
						dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
						, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
						, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
					}
					, colModels : [
						// 아이템 번호
						{name:"dispCnrItemNo", label:'<spring:message code="column.item_no" />', width:"100", align:"center", hidden:true}
						// 전시 분류 코너 번호
						, {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"100", align:"center", hidden:true}
						// 전시 배너 번호
						, {name:"dispBnrNo", label:'<spring:message code="column.disp_bnr_no" />', width:"100", align:"center", formatter:'integer', hidden:true}
						// 상세보기
						, {name:"button", label:'배너 상세 보기', width:"100", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
							var str = '<button type="button" onclick="displayCornerItemViewPop(' + rowObject.dispCnrItemNo + ', ' + rowObject.dispBnrNo + ')" class="btn_h25_type1">배너 상세</button>';
							return str;
						}}
						// 전시 우선 순위
						, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"100", align:"center", formatter:'integer'}
						// 배너 구분 코드
						, {name:"bnrGbCd", label:'<spring:message code="column.bnr_gb_cd" />', width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.BNR_GB }' showValue='false' />" } }
						// 이미지(PC)
						, {name:"bnrImgNm", label:'<spring:message code="column.display_view.pc_img" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
								if(rowObject.bnrImgPath != "") {
									return '<img src="${frame:imagePath( "'+rowObject.bnrImgPath+'" )}" style="width:100px; height:100px;" alt="' + rowObject.bnrImgNm + '" />';
								} else {
									return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
								}
							}
						}
						// 이미지(모바일)
						, {name:"bnrMobileImgNm", label:'<spring:message code="column.display_view.mobile_img" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
								if(rowObject.bnrMobileImgPath != "") {
									return '<img src="<frame:imgUrl />' + rowObject.bnrMobileImgPath + '" style="width:100px; height:100px;" alt="' + rowObject.bnrMobileImgNm + '" />';
								} else {
									return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
								}
							}
						} 
						// 배너 동영상 URL(PC)
						, {name:"bnrAviPath", label:'<spring:message code="column.display_view.bnr_avi_path" />', width:"280", align:"center"}
						// 배너 동영상 URL(MOBILE)
						, {name:"bnrMobileAviPath", label:'<spring:message code="column.display_view.bnr_mobile_avi_path" />', width:"280", align:"center"}
						// LINK URL
						, {name:"bnrLinkUrl", label:'<spring:message code="column.display_view.bnr_link_url" />', width:"280", align:"center"}
						// 모바일 LINK URL
						, {name:"bnrMobileLinkUrl", label:'<spring:message code="column.display_view.bnr_mobile_link_url" />', width:"280", align:"center"}
						// 전시 시작일자
						, {name:"dispStrtdt", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
						// 전시 종료일자
						, {name:"dispEnddt", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
					]
				};

				grid.create("displayCornerItemList", options);
			}

			// 전시 코너 아이템 리스트(브랜드 콘텐츠)
			function createDisplayCornerbrandCntsGrid() {
				var options = {
					url : "<spring:url value='/display/displayCornerBnrItemListGrid.do' />"
					, height : 400
					, multiselect : true
					, paging : false
					, searchParam : {
						dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
						, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
					}
					, colModels : [
						// 아이템 번호
						{name:"dispCnrItemNo", label:'<spring:message code="column.item_no" />', width:"100", align:"center", hidden:true}
						// 전시 분류 코너 번호
						, {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"100", align:"center", hidden:true}
						// 전시 배너 번호
						, {name:"dispBnrNo", label:'<spring:message code="column.disp_bnr_no" />', width:"100", align:"center", formatter:'integer', hidden:true}
						// 상세보기
						, {name:"button", label:'배너 상세 보기', width:"100", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
							var str = '<button type="button" onclick="displayCornerItemViewPop(' + rowObject.dispCnrItemNo + ', ' + rowObject.dispBnrNo + ')" class="btn_h25_type1">배너 상세</button>';
							return str;
						}}
						// 전시 우선 순위
						, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"100", align:"center", formatter:'integer'}
						// 브랜드 콘텐츠 번호
						, {name:"bndCntsNo", label:"<spring:message code='column.bnd_cnts_no' />", width:"100", align:"center"}
						// 타이틀
	 					, {name:"cntsTtl", label:'<spring:message code="column.cnts_ttl" />', width:"200", align:"center"}
					]
				};
				grid.create("displayCornerItemList", options);
			}
			
			// 전시 코너 아이템 리스트(태그 리스트)
			function createDisplayCornerTagsGrid() {
				var options = {
					url : "<spring:url value='/display/displayCornerTagsListGrid.do' />"
					, height : 400
					, multiselect : true
					, paging : false
					, searchParam : { 
						dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
						, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
						, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
					}
					, colModels : [
						// 아이템 번호
						{name:"dispCnrItemNo", label:'<spring:message code="column.item_no" />', width:"100", align:"center", hidden:true}
						// 전시 분류 코너 번호
						, {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"150", align:"center", hidden:true}
						// 전시 코너 타입 코드
					    , {name:"dispCornTpCd", label:'<spring:message code="column.disp_corn_tp_cd" />', width:"150", align:"center", hidden:true, formatter: function() {
							return $("#displayCornerItemForm #dispCornTpCd").val();
						}}
						// 전시 우선 순위
						, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"80", align:"center", formatter:'integer', editable:true}
						// 태그 번호
						, {name:"tagNo", label:'<spring:message code="column.tag_no" />', width:"100", align:"center"}
						//태그 네임
						, {name:"tagNm", label:'<spring:message code="column.tag_name" />', width:"200", align:"center"}
						//관련 컨텐츠 수
						, {name:"rltCntsCnt", label:'<spring:message code="column.rlt_tag_cnts_cnt" />', width:"200", align:"center"}
						//관련 태그 수
						, {name:"rltTagCnt", label:'<spring:message code="column.rlt_tag_cnt" />', width:"200", align:"center"}
						// 전시 시작일자
						, {name:"dispStrtdt", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd", hidden:false}
						// 전시 종료일자
						, {name:"dispEnddt", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd", hidden:false}
					]
				};
				grid.create("displayCornerItemList", options);
				dispCornerItemDragAndDrop("displayCornerItemList");
			}
			
			// 전시 코너 아이템 리스트(펫로그 회원)
			function createDisplayCornerPetLogMemberGrid() {
				var options = {
					url : "<spring:url value='/display/displayCornerPetLogMemberGrid.do' />"
					, height : 400
					, multiselect : true
					, paging : false
					, searchParam : { 
						dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
						, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
						, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
					}
					, colModels : [
						// 아이템 번호
						{name:"dispCnrItemNo", label:'<spring:message code="column.item_no" />', width:"100", align:"center", hidden:true}
						// 전시 분류 코너 번호
						, {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"150", align:"center", hidden:true}
						// 전시 코너 타입 코드
					    , {name:"dispCornTpCd", label:'<spring:message code="column.disp_corn_tp_cd" />', width:"150", align:"center", hidden:true, formatter: function() {
							return $("#displayCornerItemForm #dispCornTpCd").val();
						}}
						// 전시 우선 순위
						, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"60", align:"center", formatter:'integer', editable:true}
						// ID
						, {name:"loginId", label:'<spring:message code="column.user_id" />', width:"200", align:"center"}
						// User No
						, {name:"mbrNo", label:'<spring:message code="column.mbr_no" />', width:"100", align:"center"}
						// 회원 구분 코드
						, {name:"mbrGbCd", label:'<spring:message code="column.order_common.cs_member_gbn" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MBR_GB_CD}" />"}}
						// 펫로그 수
						, {name:"petLogCnt", label:'<spring:message code="column.display.petlog_cnt" />', width:"100", align:"center"}
						// 전시 시작일자
						, {name:"dispStrtdt", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd", hidden:false}
						// 전시 종료일자
						, {name:"dispEnddt", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd", hidden:false}
					]
				};
				grid.create("displayCornerItemList", options);
				dispCornerItemDragAndDrop("displayCornerItemList");
			}

			// 전시 코너 아이템 리스트(펫로그 리스트)
			function createDisplayCornerLogsGrid() {
				var options = {
					url : "<spring:url value='/display/displayCornerLogsGrid.do' />"
					, height : 400
					, multiselect : true
					, paging : false
					, searchParam : { 
						dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
						, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
						, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
					}
					, colModels : [
						// 아이템 번호
						{name:"dispCnrItemNo", label:'<spring:message code="column.item_no" />', width:"100", align:"center", hidden:true}
						// 전시 분류 코너 번호
						, {name:"dispClsfCornNo", label:'<spring:message code="column.disp_clsf_corn_no" />', width:"150", align:"center", hidden:true}
						// 전시 코너 타입 코드
					    , {name:"dispCornTpCd", label:'<spring:message code="column.disp_corn_tp_cd" />', width:"150", align:"center", hidden:true, formatter: function() {
							return $("#displayCornerItemForm #dispCornTpCd").val();
						}}
						// 펫로그 번호
					    , {name:"petLogNo", label:'<spring:message code="column.display.petlog_url" />', width:"100", align:"center", hidden:true}
						// 전시 우선 순위
						, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"60", align:"center", formatter:'integer', editable:true}
						// 펫로그 URL
// 						, {name:"petLogUrl", label:'<spring:message code="column.display.petlog_url" />', width:"350", align:"center", formatter: function(cellvalue, options, rowObject) {
//  						return  'https://www.aboutPet.co.kr/'+ rowObject.petLogUrl +'/'+ rowObject.petLogNo
//  					}}
						, {name:"srtPath", label:'<spring:message code="column.display.petlog_url" />', width:"300", align:"center"}
						// ID
						, {name:"loginId", label:'<spring:message code="column.user_id" />', width:"200", align:"center"}
						// User No
						, {name:"mbrNo", label:'<spring:message code="column.mbr_no" />', width:"100", align:"center"}
						// 회원 구분 코드
						, {name:"mbrGbCd", label:'<spring:message code="column.order_common.cs_member_gbn" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MBR_GB_CD}" />"}}
						// 전시 시작일자
						, {name:"dispStrtdt", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd", hidden:false}
						// 전시 종료일자
						, {name:"dispEnddt", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd", hidden:false}
					]
				};
				grid.create("displayCornerItemList", options);
				dispCornerItemDragAndDrop("displayCornerItemList");
			}
			// 코너아이템 리로드
			function reloadDisplayCornerItemGrid(dispClsfNo, dispClsfCornNo, dispCornTpCd) {
				var options = {
						searchParam : { 
							dispClsfNo : dispClsfNo
							, dispClsfCornNo : dispClsfCornNo
							, dispCornTpCd : dispCornTpCd
						}
				};
				grid.reload("displayCornerItemList", options);
			}
			
			// 전시 코너 아이템 전시 기간 적용
			function displayCornerItemDateApply() {
				var dispStrtDtm = $("#dispStrtdtApply").val().replace(/-/gi, "");
				var dispEndDtm = $("#dispEnddtApply").val().replace(/-/gi, "");
				var diffMonths = getDiffMonths(dispStrtDtm, dispEndDtm);
				
				if(parseInt(dispStrtDtm) > parseInt(dispEndDtm)){
					messager.alert("전시 시작일은 종료일과 같거나 이전이여야 합니다.", "Info", "info");
					return;
				}
				
				var dispStrtdt = $("#dispStrtdtApply").val();	// 전시 시작일
				var dispEnddt = $("#dispEnddtApply").val();		// 전시 종료일

				var grid = $("#displayCornerItemList");
				var rowids = grid.jqGrid('getGridParam', 'selarrrow');

				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.display_view.message.no_select' />","Info","info");
					return;
				}

				for(var i = rowids.length - 1; i >= 0; i--) {
					grid.setCell(rowids[i], "dispStrtdt", dispStrtdt);
					grid.setCell(rowids[i], "dispEnddt", dispEnddt);
				}
			}

			// 전시 코너 아이템 추가
			function displayCornerItemAddPop() {
				displayCornerItemViewPop();
			}

			// 전시 코너 아이템 삭제
			function displayCornerItemDelete() {
				var grid = $("#displayCornerItemList");
				var cornerItems = new Array();

				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.display_view.message.no_select' />","Info","info");
					return;
				} else {
					for(var i = 0; i < rowids.length; i++) {
						var data = $("#displayCornerItemList").getRowData(rowids[i]);

						$.extend(data, {
							dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
							, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
						});

						cornerItems.push(data);
					}

					sendData = {
		 				displayCornerItemPOList : JSON.stringify(cornerItems)
	 				};
				}
				
				messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/display/displayCornerItemDelete.do' />"
								, data : sendData
								, callBack : function(data ) {
									messager.alert("<spring:message code='column.display_view.message.delete'/>","Info","info",function(){
										// 전시 코너 아이템 화면
										displayCornerItemListView($("#displayCornerItemForm #dispClsfNo").val(), $("#displayCornerItemForm #dispClsfCornNo").val(), $("#displayCornerItemForm #dispCornTpCd").val());
									});									
								}
							};

							ajax.call(options);				
					}
				});
			}

			// 전시 코너 아이템 저장
			function displayCornerItemSave() {
				var url = "";
				var grid = $("#displayCornerItemList");
				var cornerItems = new Array();
				
				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.display_view.message.no_select' />","Info","info");
					return;
				} else {
					for(var i = 0; i < rowids.length; i++) {
						var data = $("#displayCornerItemList").getRowData(rowids[i]);
						$.extend(data, {
							dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
// 							, dispShowTpCd : $("#dispShowTpCd option:selected").val()
							, dispCornerItemStrtdt : data.dispStrtdt
							, dispCornerItemEnddt : data.dispEnddt
						});
						cornerItems.push(data);
					}

					sendData = {
		 				displayCornerItemPOList : JSON.stringify(cornerItems)
	 				};
				}

				messager.confirm("<spring:message code='column.display_view.message.confirm_save' />",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/display/displayCornerItemSave.do' />"
								, data : sendData
								, callBack : function(data) {
									messager.alert("<spring:message code='column.display_view.message.save'/>","Info","info",function(){
										// 전시 코너 아이템 화면
										displayCornerItemListView($("#displayCornerItemForm #dispClsfNo").val(), $("#displayCornerItemForm #dispClsfCornNo").val(), $("#displayCornerItemForm #dispCornTpCd").val());
									});
								}
							};
							ajax.call(options);										
					}
				});
			}
			
			// 전시 코너 배너 HTML 저장
			function displayCornerBnrHtmlSave() {
				var cornerItems = new Array();
				oEditors.getById["bnrHtml"].exec("UPDATE_CONTENTS_FIELD", []);

				sendData = {
						  bnrHtml : $("#bnrHtml").val()
						, dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
						, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
						, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
						, dispBnrNo : $("#displayCornerItemForm #dispBnrNo").val()
						, dispCnrItemNo : $("#displayCornerItemForm #dispCnrItemNo").val()
						, dispCornerItemStrtdt : $("#dispStrtdtApply").val()
						, dispCornerItemEnddt : $("#dispEnddtApply").val()
	 					, displayCornerItemPOList : ""
 				};
				
				var message = '<spring:message code="column.common.confirm.insert" />';
				if(sendData.dispCnrItemNo != null){
					message = '<spring:message code="column.common.confirm.update" />';
				}
				
				messager.confirm(message,function(r){
					if(r){
						var options = {
								url : "<spring:url value='/display/displayCornerItemSave.do' />"
								, data : sendData
								, callBack : function(data ) {
									messager.alert("<spring:message code='column.display_view.message.save'/>","Info","info",function(){
										// 전시 코너 아이템 화면
										displayCornerItemListView($("#displayCornerItemForm #dispClsfNo").val(), $("#displayCornerItemForm #dispClsfCornNo").val(), $("#displayCornerItemForm #dispCornTpCd").val());
									});
								}
							};

							ajax.call(options);				
					}
				});
			}
			// 전시 구좌 배너 HTML 삭제
			function displayCornerBnrHtmlDelete() {
				var sendData = new Array();
				sendData.push({
						 dispClsfNo : $("#displayCornerItemForm #dispClsfNo").val()
						, dispClsfCornNo : $("#displayCornerItemForm #dispClsfCornNo").val()
						, dispCornTpCd : $("#displayCornerItemForm #dispCornTpCd").val()
						, dispCnrItemNo : $("#displayCornerItemForm #dispCnrItemNo").val()
				});

				messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/display/displayCornerItemDelete.do' />"
								, data : {
									displayCornerItemPOList : JSON.stringify(sendData)
								}
								, callBack : function(data ) {
									messager.alert("<spring:message code='column.display_view.message.delete'/>","Info","info",function(){
										createDisplayCornerBnrHtmlView();
										//oEditors.getById["bnrHtml"].exec("PASTE_HTML","");
									});
								}
							};

							ajax.call(options);				
					}
				});
			}
			// 전시 상품 화면
			function displayGoodsListView(dispClsfNo) {
				var options = {
					url : "<spring:url value='/display/displayGoodsListView.do' />"
					, data : {
						dispClsfNo : dispClsfNo
					  , dispClsfCd : $("#displayBaseForm #dispClsfCd").val()
					}
					, dataType : "html"
					, callBack : function(result){
						$("#displayGoodsListView").html(result);

						// 전시 상품 리스트
						createDisplayGoodsGrid(dispClsfNo, $("#displayBaseForm #dispClsfCd").val());
					}
				};

				ajax.call(options);
			}

			// 전시 상품 리스트
			function createDisplayGoodsGrid(dispClsfNo, dispClsfCd) {
				var dlgtDispYnHidden = true;
				// 기획전인 경우, 대표전시여부 비노출
				if("${adminConstants.DISP_CLSF_10}" == dispClsfCd) {
					dlgtDispYnHidden = false;
				}
				var options = {
					url : "<spring:url value='/display/displayGoodsListGrid.do' />"
					, height : 300
					, cellEdit : true
					, multiselect : true
					, searchParam : { dispClsfNo : dispClsfNo }
					, paging : false
					, colModels : [
						//전시 분류 번호
						{name:"dispClsfNo", label:'<spring:message code="column.disp_clsf_no" />', width:"100", align:"center", hidden:true}
						// 전시 우선 순위
						, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"60", align:"center", formatter:'integer', editable:true}
						// 상품 번호
						, {name:"goodsId", label:'<spring:message code="column.goods_id" />', width:"120", align:"center"}
                        // 브랜드 명 국문
                        , {name:"bndNmKo", label:"<spring:message code='column.bnd_nm' />", width:"150", align:"center", sortable:false } /* 브랜드명 */
						// 상품명
						, {name:"goodsNm", label:'<spring:message code="column.display_view.goods_nm" />', width:"300", align:"center"}
						// 대표 전시 여부
						, {name:"dlgtDispYn", label:'<spring:message code="column.dlgt_disp_yn" />', width:"80", hidden:dlgtDispYnHidden,  align:"center", formatter:'checkbox', editoptions: { value: "Y:N" }, formatoptions: { disabled: false}}
						// 상품 상태 코드
						, {name:"goodsStatCd", label:"<spring:message code='column.goods_stat_cd' />", width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_STAT }' showValue='false' />" } } /* 상품 상태 */
						// 상품 유형 코드
						, {name:"goodsTpCd", label:"<spring:message code='column.goods_tp_cd' />", width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_TP }' showValue='false' />" } } /* 상품 유형 */
						// 판매가
						, {name:"saleAmt", label:"<spring:message code='column.sale_prc' />", width:"100", align:"center", formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
						// 업체명
						, {name:"compNm", label:"<spring:message code='column.goods.comp_nm' />", width:"120", align:"center", sortable:false } /* 업체명 */
						// 제조사
						, {name:"mmft", label:"<spring:message code='column.mmft' />", width:"120", align:"center", sortable:false } /* 제조사 */
						// 노출여부
						, {name:"showYn", label:"<spring:message code='column.show_yn' />", width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.SHOW_YN }' showValue='false' />" } } /* 노출여부 */
						// 판매 시작 일시
						, {name:"saleStrtDtm", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						// 판매 종료 일시
						, {name:"saleEndDtm", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
					]
				};

				grid.create("displayGoodsList", options);
			}

			// 전시 상품 검색
			function reloadDisplayGoodsGrid(dispClsfNo) {
				var options = {
					searchParam : { dispClsfNo : dispClsfNo }
				};

				grid.reload("displayGoodsList", options);
			}

			// 쇼룸 전시 상품 화면
			function displayShowRoomGoodsListView(dispClsfNo) {
				
				var options = {
					url : "<spring:url value='/display/displayShowRoomGoodsListView.do' />"
					, data : {
						dispClsfNo : dispClsfNo
					  , dispClsfCd : $("#displayBaseForm #dispClsfCd").val()
					}
					, dataType : "html"
					, callBack : function(result){
						$("#displayShowRoomGoodsListView").html(result);

						// 전시 상품 리스트
						createDisplayShowRoomGoodsGrid(dispClsfNo, $("#displayBaseForm #dispClsfCd").val());
					}
				};

				ajax.call(options);
			}

			// 쇼룸 전시 상품 리스트
			function createDisplayShowRoomGoodsGrid(dispClsfNo, dispClsfCd) {
				var dlgtDispYnHidden = true;
				var options = {
					url : "<spring:url value='/display/displayShowRoomGoodsListGrid.do' />"
					, height : 300
					, cellEdit : true
					, multiselect : true
					, searchParam : { srDispClsfNo : dispClsfNo, dispClsfCd : dispClsfCd }
					, paging : false
					, colModels : [
						//전시 분류 번호
						{name:"dispClsfNo", label:'<spring:message code="column.disp_clsf_no" />', width:"100", align:"center", hidden:true}
						//전시 분류 번호
						, {name:"dispClsfNm", label:'<spring:message code="column.disp_clsf_nm" />', width:"200", align:"center"}
 						// 상품 번호
						, {name:"goodsId", label:'<spring:message code="column.goods_id" />', width:"120", align:"center"}
                        // 브랜드 명 국문
                        , {name:"bndNmKo", label:"<spring:message code='column.bnd_nm' />", width:"150", align:"center", sortable:false } /* 브랜드명 */ 						
						// 상품명
						, {name:"goodsNm", label:'<spring:message code="column.display_view.goods_nm" />', width:"300", align:"center"}
						// 상품 상태 코드
						, {name:"goodsStatCd", label:"<spring:message code='column.goods_stat_cd' />", width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_STAT }' showValue='false' />" } } /* 상품 상태 */
						// 상품 유형 코드
						, {name:"goodsTpCd", label:"<spring:message code='column.goods_tp_cd' />", width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_TP }' showValue='false' />" } } /* 상품 유형 */
						// 판매가
						, {name:"saleAmt", label:"<spring:message code='column.sale_prc' />", width:"100", align:"center", formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
						// 업체명
						, {name:"compNm", label:"<spring:message code='column.goods.comp_nm' />", width:"120", align:"center", sortable:false } /* 업체명 */
						// 제조사
						, {name:"mmft", label:"<spring:message code='column.mmft' />", width:"100", align:"center", sortable:false } /* 제조사 */
						// 노출여부
						, {name:"showYn", label:"<spring:message code='column.show_yn' />", width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.SHOW_YN }' showValue='false' />" } } /* 노출여부 */
						// 판매 시작 일시
						, {name:"saleStrtDtm", label:'<spring:message code="column.display_view.disp_strtdt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						// 판매 종료 일시
						, {name:"saleEndDtm", label:'<spring:message code="column.display_view.disp_enddt" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
					]
				};
				
				grid.create("displayShowRoomGoodsList", options);
			}

			// 전시 상품 검색
			function reloadDisplayShowRoomGoodsGrid(dispClsfNo, dispClsfCd) {
				var options = {
					searchParam : { srDispClsfNo : dispClsfNo, dispClsfCd : dispClsfCd }
				};

				grid.reload("displayShowRoomGoodsList", options);
			}

			// 전시 상품 추가 팝업
 			function displayGoodsViewPop() {
 				var options = {
					  multiselect : true
					, callBack : function(result) {
						if(result != null && result.length > 0) {
							var sendData = new Array();
							var goodsId = new Array();
							var goodsCheck = false;
							var message = new Array();

							for(var i in result) {
								// 중복 상품 체크
								var rowids = $("#displayGoodsList").jqGrid('getDataIDs');
								for(var j = 0; j < rowids.length; j++) {
									var rowdata = $("#displayGoodsList").getRowData(rowids[j]);

									if(result[i].goodsId == rowdata.goodsId) {
										goodsCheck = true;
										message.push("[ " + result[i].goodsNm + " ] 중복된 상품입니다.");
									}
								}

								sendData.push({
									  goodsId : result[i].goodsId
									, dispClsfNo : $("#displayGoodsForm #dispClsfNo").val()
									, dlgtDispYn : 'N'
									, goodsTpCd : $("#displayGoodsForm #goodsTpCd").val()
									, dispPriorRank : '99'
								});
							}

							if(goodsCheck) {
								if(message != null && message.length > 0) {
									messager.alert(message.join("<br/>"),"Info","info");
								}

								return;
							}

							var options = {
								url : "<spring:url value='/display/displayGoodsInsert.do' />"
								, data : {
									displayGoodsStr : JSON.stringify(sendData)
								}
								, callBack : function(data) {
									// 전시 상품 검색
									reloadDisplayGoodsGrid($("#displayGoodsForm #dispClsfNo").val());
								}
							};

							ajax.call(options);
						}
					}
				}

				layerGoodsList.create(options);
 			}

 			// 전시 상품 저장
			function displayGoodsSave() {
				var url = "";
				var grid = $("#displayGoodsList");
				var cornerItems = new Array();
				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.display_view.message.no_select' />","Info","info");
					return;
				} else {
					for(var i = 0; i < rowids.length; i++) {
						var data = $("#displayGoodsList").getRowData(rowids[i]);
						var goodsId = data.goodsId;
						var srDispClsfNoArr = new Array();

						// 쇼룸 전시 분류 번호
						$("#dispShowRoomGoods" + goodsId).find("input[name=srDispClsfNoChk]:checked").each(function(e) {
							srDispClsfNoArr.push($(this).val());
						});

						$.extend(data, {
							  dispClsfNo : $("#displayGoodsForm #dispClsfNo").val()
							, srDispClsfNoArr : srDispClsfNoArr.join(",")
						});

						cornerItems.push(data);
					}

					sendData = {
		 				displayGoodsPOList : JSON.stringify(cornerItems)
	 				};
				}

				messager.confirm("<spring:message code='column.display_view.message.confirm_save' />",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/display/displayGoodsSave.do' />"
								, data : sendData
								, callBack : function(data ) {
									messager.alert("<spring:message code='column.display_view.message.save'/>","Info","info",function(){
										// 전시 상품 화면
										displayGoodsListView($("#displayGoodsForm #dispClsfNo").val());
									});
								}
							};

							ajax.call(options);				
					}
				});
			}

			// 전시 상품 삭제
			function displayGoodsDelete() {
				var grid = $("#displayGoodsList");
				var cornerItems = new Array();
				var arrSrDispClsfNo = new Array();

				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.display_view.message.no_select' />","Info","info");					
					return;
				} else {
					for(var i = 0; i < rowids.length; i++) {
						var data = $("#displayGoodsList").getRowData(rowids[i]);

						$.extend(data, {
							dispClsfNo : $("#displayGoodsForm #dispClsfNo").val()
						});

						cornerItems.push(data);
					}

					sendData = {
						displayGoodsPOList : JSON.stringify(cornerItems)
	 				};
				}

				messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/display/displayGoodsDelete.do' />"
								, data : sendData
								, callBack : function(data ) {
									messager.alert("<spring:message code='column.display_view.message.delete'/>","Info","info",function(){
										// 전시 상품 화면
										displayGoodsListView($("#displayGoodsForm #dispClsfNo").val());
									});
								}
							};

							ajax.call(options);				
					}
				});
			}
			
			// 쇼룸 전시 상품 추가 팝업
 			function displayShowRoomGoodsViewPop() {
 				var options = {
					  multiselect : true
					, callBack : function(result) {
						if(result != null && result.length > 0) {
							var sendData = new Array();
							var goodsId = new Array();
							var goodsCheck = false;
							var message = new Array();

							for(var i in result) {
								// 중복 상품 체크
								var rowids = $("#displayShowRoomGoodsList").jqGrid('getDataIDs');
								for(var j = 0; j < rowids.length; j++) {
									var rowdata = $("#displayShowRoomGoodsList").getRowData(rowids[j]);

									if(result[i].goodsId == rowdata.goodsId) {
										goodsCheck = true;
										message.push("[ " + result[i].goodsNm + " ] 중복된 상품입니다.");
									}
								}

								sendData.push({
									  goodsId : result[i].goodsId
									, srDispClsfNo : $("#displayShowRoomGoodsForm #dispClsfNo").val()
									, dlgtDispYn : 'N'
									, dispPriorRank : '99'
								});
							}

							if(goodsCheck) {
								if(message != null && message.length > 0) {
									messager.alert(message.join("<br/>"),"Info","info");
								}

								return;
							}

							var options = {
								url : "<spring:url value='/display/displayShowRoomGoodsInsert.do' />"
								, data : {
									displayGoodsStr : JSON.stringify(sendData)
								}
								, callBack : function(data) {
									// 쇼룸 전시 상품 검색
									reloadDisplayShowRoomGoodsGrid($("#displayShowRoomGoodsForm #dispClsfNo").val());
								}
							};

							ajax.call(options);
						}
					}
				}

				layerGoodsList.create(options);
 			}

			// 쇼룸 전시 상품 삭제
			function displayShowRoomGoodsDelete() {
				var grid = $("#displayShowRoomGoodsList");
				var cornerItems = new Array();

				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.display_view.message.no_select' />","Info","info");					
					return;
				} else {
					for(var i = 0; i < rowids.length; i++) {
						var data = $("#displayShowRoomGoodsList").getRowData(rowids[i]);

						$.extend(data, {
							srDispClsfNo : $("#displayShowRoomGoodsForm #dispClsfNo").val()
						});

						cornerItems.push(data);
					}

					sendData = {
						displayGoodsPOList : JSON.stringify(cornerItems)
	 				};
				}

				messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/display/displayShowRoomGoodsDelete.do' />"
								, data : sendData
								, callBack : function(data ) {
									messager.alert("<spring:message code='column.display_view.message.delete'/>","Info","info",function(){
										// 전시 상품 화면
										displayShowRoomGoodsListView($("#displayShowRoomGoodsForm #dispClsfNo").val());
									});
								}
							};

							ajax.call(options);				
					}
				});
			}
			
			// 관련 브랜드 화면
			function displayBrandListView(dispClsfNo) {
				var options = {
					url : "<spring:url value='/display/displayBrandListView.do' />"
					, data : {
						  dispClsfNo : dispClsfNo
					}
					, dataType : "html"
					, callBack : function(result) {
						$("#displayBrandListView").html(result);

						// 관련 브랜드 리스트
						createDisplayBrandGrid(dispClsfNo);
					}
				};

				ajax.call(options);
			}

			// 관련 브랜드 리스트
			function createDisplayBrandGrid(dispClsfNo) {
				var options = {
					url : "<spring:url value='/display/displayBrandListGrid.do' />"
					, height : 300
					, cellEdit : true
					, multiselect : true
					, searchParam : {
						  dispClsfNo : dispClsfNo
					}
					, colModels : [
						//전시 분류 번호
						{name:"dispClsfNo", label:'<spring:message code="column.disp_clsf_no" />', width:"100", align:"center", hidden:true}
						// 전시 우선 순위
						, {name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"100", align:"center", formatter:'integer', editable:true}
						// 브랜드 번호
						, {name:"bndNo", label:'<spring:message code="column.bnd_no" />', width:"80", align:"center"}
						// 브랜드 명
						, {name:"bndNmKo", label:'<spring:message code="column.bnd_nm" />', width:"250", align:"center"}
					]
				};

				grid.create("displayBrandList", options);
			}

			// 관련 브랜드 추가 팝업
 			function displayBrandViewPop() {
 				var options = {
 					  multiselect : true
					, callBack : function(result) {
						if(result != null && result.length > 0) {
							var sendData = new Array();
							var bndNo = new Array();
							var bndNoCheck = false;
							var bndGbCdCheck = false;
							var message = new Array();

							for(var i in result) {
								// 대표 브랜드 체크
								if(result[i].bndGbCd == "${adminConstants.BND_GB_30}") {
									bndGbCdCheck = true;
								}

								var rowids = $("#displayBrandList").jqGrid('getDataIDs');

								for(var j = 0; j < rowids.length; j++) {
									var rowdata = $("#displayBrandList").getRowData(rowids[j]);

									// 중복 브랜드 체크
									if(result[i].bndNo == rowdata.bndNo) {
										bndNoCheck = true;
										message.push("[ " + result[i].bndNmKo + " ] 중복된 브랜드입니다.");
									}
								}

								sendData.push({
									  bndNo : result[i].bndNo
									, dispClsfNo : $("#displayBrandForm #dispClsfNo").val()
									, dispPriorRank : '99'
								});
							}

							// 대표 브랜드
							if(bndGbCdCheck) {
								messager.alert("<spring:message code='column.display_view.message.dlgt_bnds_fail' />","Info","info");
								return;
							}

							// 중복 브랜드
							if(bndNoCheck) {
								if(message != null && message.length > 0) {
									messager.alert(message.join("<br/>"),"Info","info");
								}

								return;
							}

							var options = {
								url : "<spring:url value='/display/displayBrandInsert.do' />"
								, data : {
									displayBrandPOList : JSON.stringify(sendData)
								}
								, callBack : function(data) {
									// 관련 브랜드 화면
									displayBrandListView($("#displayBrandForm #dispClsfNo").val());
								}
							};

							ajax.call(options);
						}
					}
				}

 				layerBrandList.create(options);
 			}

			// 관련 브랜드 저장
			function displayBrandSave() {
				var url = "";
				var grid = $("#displayBrandList");
				var cornerItems = new Array();

				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.display_view.message.no_select' />","Info","info");					
					return;
				} else {
					for(var i = 0; i < rowids.length; i++) {
						var data = $("#displayBrandList").getRowData(rowids[i]);

						$.extend(data, {
							dispClsfNo : $("#displayBrandForm #dispClsfNo").val()
						});

						cornerItems.push(data);
					}

					sendData = {
		 				displayBrandPOList : JSON.stringify(cornerItems)
	 				};
				}

				messager.confirm("<spring:message code='column.display_view.message.confirm_save' />",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/display/displayBrandSave.do' />"
								, data : sendData
								, callBack : function(data) {
									messager.alert("<spring:message code='column.display_view.message.save'/>","Info","info",function(){
										// 관련 브랜드 화면
										displayBrandListView($("#displayBrandForm #dispClsfNo").val());
									});									
								}
							};

							ajax.call(options);				
					}
				});
			}

			// 관련 브랜드 삭제
			function displayBrandDelete() {
				var grid = $("#displayBrandList");
				var cornerItems = new Array();

				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.display_view.message.no_select' />","Info","info");					
					return;
				} else {
					for(var i = 0; i < rowids.length; i++) {
						var data = $("#displayBrandList").getRowData(rowids[i]);

						$.extend(data, {
							dispClsfNo : $("#displayBrandForm #dispClsfNo").val()
						});

						cornerItems.push(data);
					}

					sendData = {
						displayBrandPOList : JSON.stringify(cornerItems)
	 				};
				}

				messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/display/displayBrandDelete.do' />"
								, data : sendData
								, callBack : function(data) {
									messager.alert("<spring:message code='column.display_view.message.delete'/>","Info","info",function(){
										// 관련 브랜드 화면
										displayBrandListView($("#displayBrandForm #dispClsfNo").val());
									});
								}
							};

							ajax.call(options);					
					}
				});
			}

			// 전시 코너 아이템 리스트(상품평) 추가 Layer 기간 변경
			function searchDateChange () {
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "" ) {
					$("#sysRegDtmStart").val("" );
					$("#sysRegDtmEnd").val("" );
				} else {
					setSearchDate(term, "sysRegDtmStart", "sysRegDtmEnd" );
				}
			}

			// 전시 코너 아이템 리스트(상품평) 추가 Layer 업체 검색
			function searchCompany () {
				var options = {
					multiselect : false
					, callBack : searchCompanyCallback
				}
				layerCompanyList.create (options );
			}

			// 전시 코너 아이템 리스트(상품평) 추가 Layer 업체 검색 콜백
			function searchCompanyCallback(compList) {
				if(compList.length > 0) {
					$("#displayGoodsCommentListForm #compNo").val(compList[0].compNo);
					$("#displayGoodsCommentListForm #compNm").val(compList[0].compNm);
				}
			}

			// 기획전 상품 일괄등록 템플릿 다운로드
			function displayGoodsTemplateDownload() {
				createFormSubmit("templateDownload", "/display/displayGoodsTemplateDownload.do", {});
			}

			// 기획전 상품 일괄업로드 팝업
			function displayGoodsUploadPop() {
				var options = {
					url : '/display/displayGoodsUploadPop.do'
					, data : {dispClsfNo : $("#displayGoodsForm #dispClsfNo").val()}
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "goodsImgReview"
							, width : 800
							, height : 600
							, top : 200
							, title : "상품 일괄등록"
							, body : data
							, button : "<button type=\"button\" onclick=\"displayGoodsUpload();\" class=\"btn btn-ok\">저장</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options );
			}

			// 전시카테고리 추가
			function getCategoryInfoPop() {
 				var resultDispClsfNo;
				var resultDispClsfNm;
				var resultCtgPath;
				var resultStId;
				var resultStNm;

				var options = {
					multiselect : true
					, stId : 1
					, dispClsfCd : "${adminConstants.DISP_CLSF_10}"
					, plugins : [ "themes" ]

					, callBack : function(result) {
						if(result != null && result.length > 0) {
							data = result[0];
							resultDispClsfNo = data.dispNo;
							resultDispClsfNm = data.dispNm;
							resultCtgPath = data.dispPath;
							resultStId = data.stId;
							resultStNm = data.stNm;
						}
						alert(resultDispClsfNo + " : " + resultDispClsfNm + " : " + resultCtgPath);
					}
				}

				layerCategoryList.create(options);
			}

			// SEO 정보 등록/수정
			function fnSeoInfoDetailView(upDispClsfNo) {
				var paramSeoInfoNo = $("#seoInfoNo").val();
				var seoSvcGbCd = "";
				var paramDispClsfNo = $("#dispClsfNo").val();
 				var buttonText = '';
 				if (paramSeoInfoNo != '') {
 					buttonText = "수정";
				} else {
					buttonText = "등록";
				}
 				
 				if (upDispClsfNo == '${adminConstants.DISP_CLSF_NO_PETSHOP}') {
 					seoSvcGbCd = '10';
				} else if (upDispClsfNo == '${adminConstants.DISP_CLSF_NO_PETTV}') {
					seoSvcGbCd = '20';
				} else if (upDispClsfNo == '${adminConstants.DISP_CLSF_NO_PETLOG}') {
					seoSvcGbCd = '30';
				}
 				
 				var options = {
 					url : '/display/seoInfoPop.do'
					, data : {seoInfoNo : paramSeoInfoNo, seoSvcGbCd : seoSvcGbCd, seoTpCd : '${adminConstants.SEO_TP_30}', dispClsfNo : paramDispClsfNo}
					, dataType : "html"
					, callBack : function (result) {
 						var config = {
 							id : "seoInfoDetail"
							, width : 960
							, height : 700
							, top : 70
							, title : "SEO 상세정보"
							, button : "<button type=\"button\" onclick=\"updateSeoInfoPopup();\" class=\"btn btn-ok\">" + buttonText + "</button>"
							, body : result
						};
						layer.create(config);
					}
				};
				ajax.call(options);
			}

			// SEO 정보 등록/수정 후 callBack
			function callBackSaveSeoInfo(seoInfoNo) {
 				$("#seoInfoNo").val(seoInfoNo);
			}
			
			// 미리보기
			function displayPreview(dispClsfNo) {
				var options = {
					url : '/display/previewPage.do'
					, dataType : 'html'
					, callBack : function (data ) {
						var config = {
							id : "previewPage"
							, width : 500
							, height : 250
							, top : 200
							, title : "미리보기"
							, body : data
							, button : "<button type=\"button\" onclick=\"previewDate("+dispClsfNo+");\" class=\"btn btn-ok\">미리보기</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options );
 			}
			
			
			//펫tv 미리보기
			/* preViewPetTv() {
				var adminYn = 'Y'
				var previewDate;
				
				var options = {
						url : "<spring:url value='/tv/home/' />",
						data : {
							adminYn : adminYn
							, previewDate : previewDate
						},
						callBack : function(data) {
							window.open('/tv/home?adminYn="'+adminYn+'"&previewDate="'+previewDate+'"/');
						}
				}
			} */

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="row">
			<div class="col-md-3">
				<div class="mTitle">
					<h2>전시 목록</h2>
					<div class="buttonArea">
						<button type="button" onclick="displayAddView();" class="btn btn-add" id="categoryAdd" style="display: none;"><span>추가</span></button>
					</div>
				</div>
<%--			사이트 선택 셀렉트박스 비노출처리
				<div class="mTitle">
					<h2>사이트</h2>
					<div class="buttonArea">
						<select name="selectStId" id="selectStId" title="사이트 조건" >
						</select>
					</div>
				</div>--%>

				<div class="tree-menu">
					<div class="gridTree" id="displayTree"></div>
				</div>
			</div>
			
			<div class="col-md-9 bar-left">
				<!-- 기본 정보 -->
				<div id="displayBaseView">
					<jsp:include page="/WEB-INF/view/display/displayBaseView.jsp" />
				</div>
				
				<!-- 전시 코너 -->
				<div id="displayCornerListView">
				</div>
					
				<!-- 전시 분류 코너 -->
				<div id="displayClsfCornerListView">
				</div>
				
				<!-- 전시 코너 아이템 -->
				<div id="displayCornerItemListView">
				</div>
				
				<!-- 전시 상품 -->
				<div id="displayGoodsListView">
				</div>
				
				<!-- 쇼룸 전시 상품 -->
				<div id="displayShowRoomGoodsListView">
				</div>

				<!-- 관련 브랜드 -->
				<div id="displayBrandListView">
				</div>
			</div>
		</div>		
	</t:putAttribute>
</t:insertDefinition>