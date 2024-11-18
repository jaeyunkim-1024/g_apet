<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
	<script type="text/javascript">
	window.onload = function(){
		var targetObj = $(location).attr('hostname');
	}
	</script>
	<script type="text/javascript">
		var MessageSearch = 0 ;
		var myTimer;
		var interval = 30000;

		$(document).ready(function(){
			// 30초마다 메세지확인
			fnMessageSearch();

			// myTimer = setInterval("fnMessageSearch()", interval);
		});
		function fnMessageSearch(){
			var existsUserMessageCnt = 0;
			var options = {
				url : "<spring:url value='/common/existsUserMessage.do' />"
				, data : {usrNo : '${adminSession.usrNo}' }
				, wait : false
				, noAlert : true
				, callBack : function(result){
					var sanHtml ;
					if (result.existsUserMessageCnt > 0){
						$("#messageStat").text(esult.existsUserMessageCnt);
						$("#messageStat").addClass('badge-active');
					}else{
						$("#messageStat").text('0');
						$("#messageStat").removeClass('badge-active');
						$("#messageStat").addClass('badge-active');
					}
				}
			};
			ajax.call(options);
		}

		$(document).ajaxError(function( event, request, settings ) {
	        //When XHR Status code is 0 there is no connection with the server
	        /*
	        if (request.status == 0){

	            if(confirm("쪽지확인이 지연되고 있습니다. 쪽지확인을 중지하시겠습니까?\n\n다시 로그인하시면 쪽지확인을 시작합니다.")) {
	            	clearInterval(myTimer);
	            	myTimer = null;

	            	var sanHtml = '<a href="#" onclick="restartUserMessage();return false;" class="btn_h23_type1"><strong class="red">쪽지확인 중지</strong></a> ';
                    $("#messageStat").html(sanHtml);
	            } else {
	            	if (myTimer == null) {
	            		myTimer = setInterval("fnMessageSearch()", interval);
	            	}
	            }

	        	myTimer = setInterval("fnMessageSearch()", interval);

	        }
	        */
	    });

		function restartUserMessage() {
			
			messager.confirm("<spring:message code='column.order_common.confirm.order_info_update' />",function(r){
				if(r){
					myTimer = setInterval("fnMessageSearch()", interval);
			        fnMessageSearch();
				}
			});
		}

		function userMessageList() {
			layerMessageList.create('RCV', '${adminSession.usrNo}');
		}

		function updateUser() {
			$('.dropdown-menu').hide();
			layerUserInfo.create();
		}
		
		function logOut(){
			messager.confirm("로그아웃 하시겠습니까?",  function(flag){
       			if(flag) top.location.href="/login/logout.do"; // 비밀번호 화면으로 이동.
       		});
		}

		function toggleMenu() {
			$('.dropdown-menu').toggle();
		}
		
	/* 	function twcTestBtn() {
			var options = {
				url : "<spring:url value='/common/twcTest.do' />"
				,data : {
					loginId : "test001",
					userNo : "900000001"
				}
				,callBack : function(data) {
					let loginId = data.loginId.replaceAll("+", "%2B");
					let userNo = data.userNo.replaceAll("+", "%2B");
					window.open("http://35.216.83.167:9090/check-bo?loginId=" + loginId + "&userNo=" + userNo);
				}
			}
			ajax.call(options);
		} */
	</script>
		<% if(framework.common.constants.CommonConstants.USR_GRP_10.equals(framework.admin.util.AdminSessionUtil.getSession().getUsrGrpCd())) { %>
			<div id="header" data-options="region:'north'">
		<%} else if(framework.common.constants.CommonConstants.USR_GRP_20.equals(framework.admin.util.AdminSessionUtil.getSession().getUsrGrpCd())) { %>
			<div id="header" data-options="region:'north'" style="background-color: #1167b1">
		<%} %>
				<a href="/main/mainView.do" style="display: inline-block;text-align: center;height: 100%;">
					<img src="/images/ci.png" alt="aboutPet" style="margin: 5px 0px 0px 9px;width: 74%;height: auto;display: inline-block;vertical-align: middle;" />
				</a>
				
				<ul class="nav">
					<!-- <li><a href="javascript:twcTestBtn();"><span>TWC</span></a></li> -->
					<li><a href="javascript:userMessageList();"><i class="fa fa-envelope"></i><span id="messageStat" class="badge">0</span></a></li>
					<li class="dropdown"><a href="javascript:toggleMenu();">${adminSession.usrNm} <i class="fa fa-caret-down"></i></a>
						<ul class="dropdown-menu">
							<li><a href="javascript:updateUser();"><i class="fa fa-user"></i>정보변경</a></li>
							<li class="divider"></li>
							<li><a href="javascript:logOut();"><i class="fa fa-power-off"></i>로그아웃</a></li>
						</ul>
					</li>
				</ul>
            	
				<div class="gnb">
					<ul>
						<c:forEach var="item" items="${topMenuList}">
							<li data-menu-no="${item.menuNo}">
							<c:if test="${empty item.url}"><a href="#">${item.menuNm}</a></c:if>
							<c:if test="${not empty item.url}"><a onclick="javascript:goMenu(this, '${item.url}');">${item.menuNm}</a></c:if>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>