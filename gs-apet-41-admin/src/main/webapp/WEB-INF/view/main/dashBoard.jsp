<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">

		<link rel="stylesheet" type="text/css" href="/tools/bower_components/tui-chart/dist/tui-chart.css" />
		<script src="/tools/bower_components/tui-code-snippet/dist/tui-code-snippet.js"></script>
		<script src="/tools/bower_components/raphael/raphael.js"></script>
		<script src="/tools/bower_components/tui-chart/dist/tui-chart-all.js"></script>

<style>
#sortable li {
	list-style-type: none;
	margin: 0;
	padding: 10;
}

#sortable .sortli {
	margin: 3px 3px 3px 0;
	padding: 1px;
	float: left;
	width: 480px;
	height: 380px;
	font-size: 4em;
	text-align: center;
	cursor: move;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {

		$('.page-title-breadcrumb').hide();
		$('.panel-tool-max').hide();
		$('.panel-tool-min').hide();
		
		$('.easyui-datagrid').datagrid('resize', {
			width : 465
		});
		
		$('.easyui-datagrid').datagrid({
			fitColumns: true,
			fit: true
		});
		
		$('.ui-state-default').css('background', 'none');
		$('.ui-state-default').css('border', 'none');

		toSalStNumChart();  //금일 매출 현황(건수) Data Chart 출력
		toSalStPrcChart();  //금일 매출 현황(금액) Data Chart 출력
		odStChart(); 		//주문 현황 Data Chart 출력
		clStChart(); 		//클레임 현황 Data Chart 출력
		pdtRgtrStChat(); 	//상품 등록 현황 Data Chart 출력
		ehbtStChart(); 		//기획전 현황 Data Chart 출력
		mbsStChart(); 		//회원 현황 Data Chart 출력
		csStChart(); 		//CS 현황 Data Chart 출력
	});
	
	$(function() {
		$("#sortable").sortable();
		$("#sortable").disableSelection();
	});

	function companyNoticeList() {
		addTab('업체 공지사항 목록', '/company/noticeListView.do');
	}
	
	function companyNoticeView() {
		var row = $('#dg9').datagrid('getSelected');
		addTab('업체 공지사항 상세', '/company/noticeView.do?compNtcNo='
				+ row.compNtcNo);
	}

	function noticeList() {
		addTab('사내 공지사항 목록', '/bonotice/bbsLetterListView.do');
	}
	function noticeView(bbsId, obj) {
		var row = $(eval(obj)).datagrid('getSelected');
		addTab('사내 공지사항 상세', '/' + bbsId
				+ '/bbsLetterDetailView.do?lettNo=' + row.lettNo);
	}

	function formatDate(val, row) {
		var d = new Date(val);
		var curr_date = pad(d.getDate());
		var curr_month = pad(d.getMonth() + 1); //Months are zero based
		var curr_year = d.getFullYear();
		return curr_year + "-" + curr_month + "-" + curr_date;
	}

	function pad(numb) {
		return (numb < 10 ? '0' : '') + numb;
	}

	//금일 매출 현황(건수) Data 가져오기
	function toSalStNumChart(reload) {
		var dbData = $.ajax({
			url : "/main/getDashBoardSales.do",
			type : "post",
			dataType : "json",
			success : function(ids) {
				dataContainer0(ids, reload);
			}
		});
	}

	function dataContainer0(ids, reload) {
		var container0 = document.getElementById('todaySalesStatusNum');
		var data0 = {
			categories : [ '통합몰', '입점업체' ],
			series : [ {
				name : '주문건수',
				data : [ ids.rows[0].ordCnt, ids.rows[1].ordCnt ]
			}, {
				name : '결제건수',
				data : [ ids.rows[0].payCnt, ids.rows[1].payCnt ]
			}, {
				name : '취소건수',
				data : [ ids.rows[0].cancelCnt, ids.rows[1].cancelCnt ]
			} ]
		}, options = {
			chart : {
				width : 460,
				height : 330,
				title : '금일 매출 현황(건수)'
			},
			yAxis : {
				title : '건수'
			}
		};
		var theme = {
			series : {
				series : {
					colors : [ '#c0eaf6', '#ffffb2', '#b2d8b2' ]
				},
				label : {
					color : '#808080'
				}
			},
			title : {
				fontSize : 13,
				fontWeight : 'bold'
			}
		};

		tui.chart.registerTheme('myTheme', theme);
		options.theme = 'myTheme';

		if (reload)
			$("#todaySalesStatusNum").empty();
		tui.chart.columnChart(container0, data0, options);
	}

	//주문 현황 Data 가져오기
	function odStChart(reload) {

		var dbData = $.ajax({
			url : "/main/getDashBoardOrders.do",
			type : "post",
			dataType : "json",
			success : function(ids) {
				datacontainer1(ids, reload);
			}
		});
	}

	function datacontainer1(ids, reload) {
		var container1 = document.getElementById('orderStatus'), data1 = {
			categories : [ '통합몰', '입점업체' ],
			series : [
					{
						name : '<frame:codeName grpCd="${adminConstants.ORD_DTL_STAT}" dtlCd="${adminConstants.ORD_DTL_STAT_110 }"/>',
						data : [ ids.rows[0].cnt01, ids.rows[1].cnt01 ]
					},
					{
						name : '<frame:codeName grpCd="${adminConstants.ORD_DTL_STAT}" dtlCd="${adminConstants.ORD_DTL_STAT_120 }"/>',
						data : [ ids.rows[0].cnt02, ids.rows[1].cnt02 ]
					},
					{
						name : '<frame:codeName grpCd="${adminConstants.ORD_DTL_STAT}" dtlCd="${adminConstants.ORD_DTL_STAT_130 }"/>',
						data : [ ids.rows[0].cnt03, ids.rows[1].cnt03 ]
					},
					{
						name : '<frame:codeName grpCd="${adminConstants.ORD_DTL_STAT}" dtlCd="${adminConstants.ORD_DTL_STAT_140 }"/>',
						data : [ ids.rows[0].cnt04, ids.rows[1].cnt04 ]
					},
					{
						name : '<frame:codeName grpCd="${adminConstants.ORD_DTL_STAT}" dtlCd="${adminConstants.ORD_DTL_STAT_150 }"/>',
						data : [ ids.rows[0].cnt05, ids.rows[1].cnt05 ]
					},
					{
						name : '<frame:codeName grpCd="${adminConstants.ORD_DTL_STAT}" dtlCd="${adminConstants.ORD_DTL_STAT_160 }"/>',
						data : [ ids.rows[0].cnt06, ids.rows[1].cnt06 ]
					},
					{
						name : '<frame:codeName grpCd="${adminConstants.ORD_DTL_STAT}" dtlCd="${adminConstants.ORD_DTL_STAT_170 }"/>',
						data : [ ids.rows[0].cnt07, ids.rows[1].cnt07 ]
					} ]
		}, options = {
			chart : {
				width : 460,
				height : 330,
				title : '주문 현황'
			},
			yAxis : {
				title : '건수'
			}
		};
		var theme = {
			series : {
				series : {
					colors : [ '#c0eaf6', '#ffffb2', '#b2d8b2',
							'#ffe4b2', '#ffb4b4', '#ffcda0', '#ffd9cc' ]
				},
				label : {
					color : '#808080'
				}
			},
			title : {
				fontSize : 13,
				fontWeight : 'bold'
			}
		};

		tui.chart.registerTheme('myTheme', theme);
		options.theme = 'myTheme';

		if (reload)
			$("#orderStatus").empty();
		tui.chart.columnChart(container1, data1, options);
	}

	//상품 등록 현황 Data 가져오기
	function pdtRgtrStChat(reload) {
		var dbData = $.ajax({
			url : "/main/getDashBoardGoods.do",
			type : "post",
			dataType : "json",
			success : function(ids) {
				dataContainer3(ids, reload);
			}
		});
	}

	function dataContainer3(ids, reload) {
		var container3 = document
				.getElementById('productRegistrationStatus'), data3 = {
			categories : [ '통합몰', '입점업체' ],
			series : [
					{
						name : '<frame:codeName grpCd="${adminConstants.GOODS_STAT}" dtlCd="${adminConstants.GOODS_STAT_10 }" />',
						data : [ ids.rows[0].cnt10, ids.rows[1].cnt10 ]
					},
					{
						name : '<frame:codeName grpCd="${adminConstants.GOODS_STAT}" dtlCd="${adminConstants.GOODS_STAT_20 }" />',
						data : [ ids.rows[0].cnt20, ids.rows[1].cnt20 ]
					},
					{
						name : '<frame:codeName grpCd="${adminConstants.GOODS_STAT}" dtlCd="${adminConstants.GOODS_STAT_30 }" />',
						data : [ ids.rows[0].cnt30, ids.rows[1].cnt30 ]
					},
					{
						name : '<frame:codeName grpCd="${adminConstants.GOODS_STAT}" dtlCd="${adminConstants.GOODS_STAT_40 }" />',
						data : [ ids.rows[0].cnt40, ids.rows[1].cnt40 ]
					},
					{
						name : '<frame:codeName grpCd="${adminConstants.GOODS_STAT}" dtlCd="${adminConstants.GOODS_STAT_50 }" />',
						data : [ ids.rows[0].cnt50, ids.rows[1].cnt50 ]
					},
					{
						name : '<frame:codeName grpCd="${adminConstants.GOODS_STAT}" dtlCd="${adminConstants.GOODS_STAT_60 }" />',
						data : [ ids.rows[0].cnt60, ids.rows[1].cnt60 ]
					} ]
		}, options = {
			chart : {
				width : 460,
				height : 330,
				title : '상품 등록 현황'
			},
			yAxis : {
				title : '건수'
			}
		};
		var theme = {
			series : {
				series : {
					colors : [ '#c0eaf6', '#ffffb2', '#b2d8b2',
							'#ffe4b2', '#ffb4b4', '#ffcda0' ]
				},
				label : {
					color : '#808080'
				}
			},
			title : {
				fontSize : 13,
				fontWeight : 'bold'
			}
		};

		tui.chart.registerTheme('myTheme', theme);
		options.theme = 'myTheme';

		if (reload)
			$("#productRegistrationStatus").empty();
		tui.chart.columnChart(container3, data3, options);
	}

	//기획전 현황 Data 가져오기
	function ehbtStChart(reload) {
		var dbData = $.ajax({
			url : "/main/getDashExhibition.do",
			type : "post",
			dataType : "json",
			success : function(ids) {
				datacontainer4(ids, reload);
			}
		});
	}

	function datacontainer4(ids, reload) {
		var container4 = document.getElementById('exhibitionStatus'), data4 = {
			series : [
					{
						name : '<frame:codeName grpCd="${adminConstants.EXHBT_STAT}" dtlCd="${adminConstants.EXHBT_STAT_10}" />',
						data : [ ids.rows[0].stat10 ]
					},
					{
						name : '<frame:codeName grpCd="${adminConstants.EXHBT_STAT}" dtlCd="${adminConstants.EXHBT_STAT_20}" />',
						data : [ ids.rows[0].stat20 ]
					},
					{
						name : '<frame:codeName grpCd="${adminConstants.EXHBT_STAT}" dtlCd="${adminConstants.EXHBT_STAT_30}" />',
						data : [ ids.rows[0].stat30 ]
					},
					{
						name : '<frame:codeName grpCd="${adminConstants.EXHBT_STAT}" dtlCd="${adminConstants.EXHBT_STAT_40}" />',
						data : [ ids.rows[0].stat40 ]
					} ]
		}, options = {
			chart : {
				width : 460,
				height : 330,
				title : '기획전 현황'
			},
			series : {
				showLabel : true,
				showLegend : true,
				labelAlign : 'inner'
			}
		};
		var theme = {
			series : {
				series : {
					colors : [ '#c0eaf6', '#b2d8b2', '#ffe4b2',
							'#ffb4b4' ]
				},
				label : {
					color : '#fff',
					fontFamily : 'sans-serif'
				}
			},
			title : {
				fontSize : 13,
				fontWeight : 'bold'
			}
		};

		tui.chart.registerTheme('myTheme', theme);
		options.theme = 'myTheme';

		if (reload)
			$("#exhibitionStatus").empty();
		tui.chart.pieChart(container4, data4, options);
	}

	//회원 현황 Data 가져오기
	function mbsStChart(reload) {
		var dbData = $.ajax({
			url : "/main/getDashBoardMembers.do",
			type : "post",
			dataType : "json",
			success : function(ids) {
				datacontainer5(ids, reload);
			}
		});
	}

	function datacontainer5(ids, reload) {
		var container5 = document.getElementById('membershipStatus'), data5 = {
			series : [ {
				name : '전체회원',
				data : [ ids.rows[0].useCnt ]
			}, {
				name : '휴면회원',
				data : [ ids.rows[0].humanCnt ]
			}, {
				name : '탈퇴회원',
				data : [ ids.rows[0].withdrawCnt ]
			}, {
				name : '신규회원(금일)',
				data : [ ids.rows[0].newCnt ]
			} ]
		}, options = {
			chart : {
				width : 460,
				height : 330,
				title : '회원 현황'
			},
			series : {
				showLabel : true,
				showLegend : true,
				labelAlign : 'inner'
			}
		};
		var theme = {
			series : {
				series : {
					colors : [ '#c0eaf6', '#b2d8b2', '#ffe4b2',
							'#ffb4b4' ]
				},
				label : {
					color : '#fff',
					fontFamily : 'sans-serif'
				}
			},
			title : {
				fontSize : 13,
				fontWeight : 'bold'
			}
		};
		tui.chart.registerTheme('myTheme', theme);
		options.theme = 'myTheme';

		if (reload)
			$("#membershipStatus").empty();
		tui.chart.pieChart(container5, data5, options);
	}

	//클레임 현황 Data 가져오기
	function clStChart(reload) {
		var dbData = $.ajax({
			url : "/main/getDashBoardClaims.do",
			type : "post",
			dataType : "json",
			success : function(ids) {
				datacontainer2(ids, reload);
			}
		});
	}

	function datacontainer2(ids, reload) {
		var container2 = document.getElementById('claimStatus');
		var data2 = {
			categories : [ "통합몰", "입점업체" ],
			series : [ {
				name : '반품접수',
				data : [ ids.rows[0].cnt210, ids.rows[1].cnt210 ],
				stack : '반품'
			}, {
				name : '반품회수지시',
				data : [ ids.rows[0].cnt220, ids.rows[1].cnt220 ],
				stack : '반품'
			}, {
				name : '반품회수중',
				data : [ ids.rows[0].cnt230, ids.rows[1].cnt230 ],
				stack : '반품'
			}, {
				name : '교환회수접수',
				data : [ ids.rows[0].cnt310, ids.rows[1].cnt310 ],
				stack : '교환'
			}, {
				name : '교환회수지시',
				data : [ ids.rows[0].cnt320, ids.rows[1].cnt320 ],
				stack : '교환'
			}, {
				name : '교환회수완료',
				data : [ ids.rows[0].cnt340, ids.rows[1].cnt340 ],
				stack : '교환'
			} ]
		};
		var options = {
			chart : {
				width : 460,
				height : 330,
				title : '클레임 현황'

			},
			series : {
				stackType : 'normal',
				pointWidth : 35
			},
			legend : {
				align : 'right'
			},
			tooltip : {
				grouped : false,

			}
		};
		var theme = {
			series : {
				series : {
					colors : [ '#83b14e', '#458a3f', '#295ba0',
							'#2a4175', '#289399', '#289399' ]
				}
			},
			title : {
				fontSize : 13,
				fontWeight : 'bold'
			}
		};

		tui.chart.registerTheme('myTheme', theme);
		options.theme = 'myTheme';

		if (reload)
			$("#claimStatus").empty();

		tui.chart.columnChart(container2, data2, options);
	}

	//금일 매출 현황(금액) Data 가져오기
	function toSalStPrcChart(reload) {
		var dbData = $.ajax({
			url : "/main/getDashBoardSales.do",
			type : "post",
			dataType : "json",
			success : function(ids) {
				dataContainer00(ids, reload);
			}
		});
	}

	function dataContainer00(ids, reload) {
		var container00 = document
				.getElementById('todaySalesStatusprice'), data00 = {
			categories : [ '통합몰', '입점업체' ],
			series : [ {
				name : '주문금액',
				data : [ ids.rows[0].ordAmt, ids.rows[1].ordAmt ]
			}, {
				name : '결제금액',
				data : [ ids.rows[0].payAmt, ids.rows[1].payAmt ]
			}, {
				name : '취소금액',
				data : [ ids.rows[0].cancelAmt, ids.rows[1].cancelAmt ]
			} ]
		}, options = {
			chart : {
				width : 460,
				height : 330,
				title : '금일 매출 현황(금액)',
				format : '1,000'
			},
			yAxis : {
				title : '금액'
			}
		};
		var theme = {
			series : {
				series : {
					colors : [ '#c0eaf6', '#ffffb2', '#b2d8b2' ]
				},
				label : {
					color : '#808080'
				}
			},
			title : {
				fontSize : 13,
				fontWeight : 'bold'
			}
		};

		tui.chart.registerTheme('myTheme', theme);
		options.theme = 'myTheme';

		if (reload)
			$("#todaySalesStatusprice").empty();
		tui.chart.columnChart(container00, data00, options);
	}

	//CS 현황 Data 가져오기
	function csStChart(reload) {
		var dbData = $.ajax({
			url : "/main/getDashBoardCS.do",
			type : "post",
			dataType : "json",
			success : function(ids) {
				datacontainer6(ids, reload);
			}
		});
	}

	function datacontainer6(ids, reload) {
		var container6 = document.getElementById('csStatus'), data6 = {
			series : [ {
				name : '1대1문의(미답변)',
				data : [ ids.rows[0].inquiryCnt ]
			}, {
				name : '증명요청',
				data : [ ids.rows[0].fileCnt ]
			} ]
		}, options = {
			chart : {
				width : 460,
				height : 330,
				title : 'CS 현황'
			},
			series : {
				showLabel : true,
				showLegend : true,
				labelAlign : 'inner'
			}
		};
		var theme = {
			series : {
				series : {
					colors : [ '#c0eaf6', '#b2d8b2' ]
				},
				label : {
					color : '#fff',
					fontFamily : 'sans-serif'
				}
			},
			title : {
				fontSize : 13,
				fontWeight : 'bold'
			}
		};

		tui.chart.registerTheme('myTheme', theme);
		options.theme = 'myTheme';

		if (reload)
			$("#csStatus").empty();
		tui.chart.pieChart(container6, data6, options);
	}
</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<ul id="sortable" style="width:1600px;">
			<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
				<li class="ui-state-default sortli" id="todaySalesStatusNumli">
					<div id="w1" class="easyui-panel" title="금일 매출 현황(건수)"
						style="width: 470px; height: 380px;"
						data-options="fitColumns:true,border:'thin',cls:'c2',closable:true,
                					collapsible:true,minimizable:true,maximizable:true,
									tools:[{
     								iconCls:'icon-reload',
      								handler:function(){
      									$('#w1').click('reload');
				                      	toSalStNumChart(true);
      									}
				              		}],
				              		onClose:function(){
									$('#todaySalesStatusNumli').remove();
									}">

						<div id="todaySalesStatusNum"></div>
					</div>
				</li>
			</c:if>
			<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
				<li class="ui-state-default sortli" id="todaySalesStatuspriceli">
					<div id="w5" class="easyui-panel" title="금일 매출 현황(금액)"
						style="width: 470px; height: 380px;"
						data-options="fitColumns:true,border:'thin',cls:'c2',closable:true,
                					collapsible:true,minimizable:true,maximizable:true,
									tools:[{
				                  		iconCls:'icon-reload',
				                  		handler:function(){
				                      		$('#w5').click('reload');
				                      		toSalStPrcChart(true);
				                  		}
				              		}],
				              		onClose:function(){
									$('#todaySalesStatuspriceli').remove();
									}">

						<div id="todaySalesStatusprice"></div>
					</div>
				</li>
			</c:if>
			<li class="ui-state-default sortli" id="orderStatusli">
				<div id="w2" class="easyui-panel" title="주문 현황"
					style="width: 470px; height: 380px;"
					data-options="fitColumns:true,border:'thin',cls:'c2',closable:true,
                					collapsible:true,minimizable:true,maximizable:true,
									tools:[{
				                  		iconCls:'icon-reload',
				                  		handler:function(){
				                      		$('#w2').click('reload');
				                      		odStChart(true);
				                  		}
				              		}],
				              		onClose:function(){
									$('#orderStatusli').remove();
									}">

					<div id="orderStatus"></div>
				</div>
			</li>
			<li class="ui-state-default sortli" id="claimStatusli">
				<div id="w3" class="easyui-panel" title="클레임 현황"
					style="width: 470px; height: 380px;"
					data-options="fitColumns:true,border:'thin',cls:'c2',closable:true,
                					collapsible:true,minimizable:true,maximizable:true,
									tools:[{
				                  		iconCls:'icon-reload',
				                  		handler:function(){
				                      		$('#w3').click('reload');
				                      		clStChart(true);
				                  		}
				              		}],
				              		onClose:function(){
									$('#claimStatusli').remove();
									}">

					<div id="claimStatus"></div>
				</div>
			</li>

			<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
				<li class="ui-state-default sortli" id="membershipStatusli">
					<div id="w6" class="easyui-panel" title="회원 현황"
						style="width: 470px; height: 380px;"
						data-options="fitColumns:true,border:'thin',cls:'c2',closable:true,
                					collapsible:true,minimizable:true,maximizable:true,
									tools:[{
				                  		iconCls:'icon-reload',
				                  		handler:function(){
				                      		$('#w6').click('reload');
				                      		mbsStChart(true);
				                  		}
				              		}],
				              		onClose:function(){
									$('#membershipStatusli').remove();
									}">

						<div id="membershipStatus"></div>
					</div>
				</li>
			</c:if>
			<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
				<li class="ui-state-default sortli" id="exhibitionStatusli">
					<div id="w8" class="easyui-panel" title="기획전 현황"
						style="width: 470px; height: 380px;"
						data-options="fitColumns:true,border:'thin',cls:'c2',closable:true,
                					collapsible:true,minimizable:true,maximizable:true,
									tools:[{
				                  		iconCls:'icon-reload',
				                  		handler:function(){
				             		   		$('#w8').click('reload');
				                      		ehbtStChart(true);
				                  		}
				              		}],
				              		onClose:function(){
									$('#exhibitionStatusli').remove();
									}">

						<div id="exhibitionStatus"></div>
					</div>
				</li>
			</c:if>
			<li class="ui-state-default sortli" id="productRegistrationStatusli">
				<div id="w4" class="easyui-panel" title="상품 등록 현황"
					style="width: 470px; height: 380px;"
					data-options="fitColumns:true,border:'thin',cls:'c2',closable:true,
                					collapsible:true,minimizable:true,maximizable:true,
									tools:[{
				                  		iconCls:'icon-reload',
				                  		handler:function(){
				                      		$('#w4').click('reload');
				                      		pdtRgtrStChat(true);
				                  		}
				              		}],
				              		onClose:function(){
									$('#productRegistrationStatusli').remove();
									}">

					<div id="productRegistrationStatus"></div>
				</div>
			</li>

			<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
				<li class="ui-state-default sortli" id="csStatusli">
					<div id="w7" class="easyui-panel" title="CS 현황"
						style="width: 470px; height: 380px;"
						data-options="fitColumns:true,border:'thin',cls:'c2',closable:true,
                					collapsible:true,minimizable:true,maximizable:true,
									tools:[{
				                  		iconCls:'icon-reload',
				                  		handler:function(){
				                      		$('#w7').click('reload');
				                      		csStChart(true);
				                  		}
				              		}],
				              		onClose:function(){
									$('#csStatusli').remove();
									}">

						<div id="csStatus"></div>
					</div>
				</li>
			</c:if>
			<c:if test="${adminConstants.USR_GRP_20 eq adminSession.usrGrpCd}">
			<li class="ui-state-default sortli" id="companyNoticeli">
				<div id="w9" class="easyui-panel" title="업체 공지사항"
					style="width: 470px; height: 380px;"
					data-options="fitColumns:true,border:'thin',cls:'c2',closable:true,
                					collapsible:true,minimizable:true,maximizable:true,
									tools:[{
			                    		iconCls:'icon-reload',
			                    		handler:function(){
			                        		$('#dg9').datagrid('reload');
			                    		}
			                    	},{
			                    		iconCls:'icon-add',
			                    		handler:function(){
			                    			companyNoticeList();	
			                    		}
			                		}],
			                		onClose:function(){
			                			$('#companyNoticeli').remove();
			                		}">

					<table id="dg9" class="easyui-datagrid"
						data-options="fitColumns:true,singleSelect:true ,collapsible:true,url:'/main/getDashBoardComNotice.do',
									onDblClickRow:function(){
										companyNoticeView();
									}">
						<thead>
							<tr>
								<th data-options="field:'compNtcNo',hidden:true">compNtcNo</th>
								<th
									data-options="field:'sysUpdDtm',width:100,align:'center',halign:'center',formatter:formatDate">등록일</th>
								<th
									data-options="field:'content',width:400,align:'center',halign:'center'">제목</th>
								<th
									data-options="field:'compNm',width:100,align:'center',halign:'center'">업체명</th>
							</tr>
						</thead>
					</table>
				</div>
			</li>
			</c:if>
			<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
				<li class="ui-state-default sortli" id="noticeli">
					<div id="w8" class="easyui-panel" title="사내 공지사항"
						style="width: 470px; height: 380px;"
						data-options="fitColumns:true,border:'thin',cls:'c2',closable:true,
                					collapsible:true,minimizable:true,maximizable:true,
									tools:[{
			                    		iconCls:'icon-reload',
			                    		handler:function(){
			                        		$('#dg8').datagrid('reload');
			                    		}
			                    	},{
			                    		iconCls:'icon-add',
			                    		handler:function(){
			                    			noticeList();	
			                    		}
			                		}],
			                		onClose:function(){
			                			$('#noticeli').remove();
			                		}">
						<table id="dg8" class="easyui-datagrid"
							data-options="fitColumns:true,singleSelect:true,collapsible:true,url:'/main/getDashBoardBoNotice.do',
									onDblClickRow:function(){
										noticeView('bonotice', 'dg8');
									}">


							<thead>
								<tr>
									<th data-options="field:'lettNo',hidden:true">lettNo</th>
									<th
										data-options="field:'sysUpdDtm',width:100,align:'center',halign:'center',formatter:formatDate">등록일</th>
									<th
										data-options="field:'ttl',width:400,align:'center',halign:'center'">제목</th>
									<th
										data-options="field:'sysRegrNm',width:100,align:'center',halign:'center'">작성자</th>
								</tr>
							</thead>
						</table>
					</div>
				</li>
			</c:if>
		</ul>


	</t:putAttribute>

</t:insertDefinition>





