<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 직배송지역 리스트
			createDirectDeliverAreaGrid();
		});

		// 직배송지역 리스트
		function createDirectDeliverAreaGrid() {
			var gridOptions = {
				url : "<spring:url value='/system/directDeliverAreaListGrid.do'/>"
				, multiselect : true
				, paging : false
				, height : 600
				, searchParam : $("#directDeliverAreaListForm").serializeJson()
				, colModels : [
					// 아이디
					  {name:"areaId", label:"<spring:message code='column.area_id' />", width:"250", key: true, align:"center", hidden:true}
					// 상세보기
					, {name:"button", label:'상세 보기', width:"120", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
						var str = '<button type="button" onclick="directDeliverAreaViewPop(' + rowObject.areaId + ')" class="btn_h25_type1">직배송지역 상세</button>';
						return str;
					}}
					// 지역구분
					, {name:"areaCd", label:"<spring:message code='column.display_view.area_gubun' />", width:"250", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.AREA}' showValue='false'/>"}}
					// 지역명
					, {name:"areaName", label:"<spring:message code='column.area_name' />", width:"250", align:"center", sortable:false}
					// 출고창고
					, {name:"outgoStorageNm", label:"<spring:message code='column.display_view.outgo_storage' />", width:"250", align:"center"}
					// AS창고1
					, {name:"asStorageNm1", label:"<spring:message code='column.as_storage_id1' />", width:"250", align:"center"}
					// AS창고2
					, {name:"asStorageNm2", label:"<spring:message code='column.as_storage_id2' />", width:"250", align:"center"}
					// 등록지역
					, {name:"button", label:'등록지역', width:"250", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
						var str = '<button type="button" onclick="zipCodeViewPop()" class="btn">등록지역 수정</button>';
						return str;
					}}
				]
			}

			grid.create("directDeliverAreaList", gridOptions);
		}

		// 직배송지역 추가/수정 팝업
		function directDeliverAreaViewPop(areaId) {
			var options = {
				url : "<spring:url value='/system/directDeliverAreaViewPop.do' />"
				, data : {areaId : typeof(areaId) == "undefined" ? "" : areaId }
				, dataType : "html"
				, callBack : function (data ) {
					var config = {
						id : "directDeliverAreaView"
						, width : 800
						, height : 400
						, top : 200
						, title : "직배송지역"
						, body : data
						, button : "<button type=\"button\" onclick=\"directDeliverAreaSave();\" class=\"btn btn-ok\">저장</button>"
					}
					layer.create(config);
				}
			}
			ajax.call(options );
		}

		// 직배송지역 리스트 검색
		function reloadDirectDeliverAreaGrid() {
			grid.reload("directDeliverAreaList", {});
		}

		// 직배송지역 삭제
		function directDeliverAreaDelete() {
			var grid = $("#directDeliverAreaList");
			var deliverItems = new Array();

			var rowids = grid.jqGrid('getGridParam', 'selarrrow');
			if(rowids.length <= 0 ) {
				messager.alert("<spring:message code='column.display_view.message.no_select' />", "Info", "info");
				return;
			} else {
				for(var i = 0; i < rowids.length; i++) {
					var data = $("#directDeliverAreaList").getRowData(rowids[i]);
					deliverItems.push(data);
				}

				sendData = {
					directDeliverAreaPOList : JSON.stringify(deliverItems)
 				};
			}

			messager.confirm("<spring:message code='column.common.confirm.delete' />", function(r){
				if(r){
					var options = {
						url : "<spring:url value='/system/directDeliverAreaDelete.do' />"
						, data : sendData
						, callBack : function(data ) {
							messager.alert("<spring:message code='column.display_view.message.delete'/>", "Info", "info", function(){
								// 직배송지역 리스트 검색
								reloadDirectDeliverAreaGrid();	
							});
						}
					};

					ajax.call(options);	
				}
			})
		}

		// 등록지역 수정 팝업
		function zipCodeViewPop() {
			var options = {
				url : "<spring:url value='/system/deliverAreaZipCodeViewPop.do' />"
				, data : {mappingCd : '20' }
				, dataType : "html"
				, callBack : function (data ) {
					var config = {
						id : "deliverAreaZipCodeView"
						, width : 900
						, height : 850
						, top : 200
						, title : "우편번호 검색"
						, body : data
						, button : "<button type=\"button\" onclick=\"layer.post(zipcodePost);\" class=\"btn btn-ok\">우편번호</button>"
					}
					layer.create(config);
				}
			}
			ajax.call(options );
		}

	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<div class="mTitle">
			<h2>직배송지역 목록</h2>
			<div class="buttonArea">
				<button type="button" onclick="zipCodeViewPop();" class="btn btn-add">추가</button>
				<button type="button" onclick="directDeliverAreaDelete();" class="btn btn-add">삭제</button>
			</div>
		</div>

		<div class="mModule no_m">
			<table id="directDeliverAreaList" ></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>