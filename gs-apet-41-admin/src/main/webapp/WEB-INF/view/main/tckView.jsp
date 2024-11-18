<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="frame" uri="frame.tag"%>

<frame:useConstants var="adminConstants" className="framework.admin.constants.AdminConstants"/>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" CONTENT="0">
	<meta http-equiv="Cache-Control" content="no-cache" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

	<link rel="stylesheet" type="text/css" href="/css/tck.css">
	<script type="text/javascript" src="/tools/jquery/jquery-1.12.1.min.js" charset="utf-8"></script>
	
	<!-- EIT-박준연 ::: 2009, 05, 22 ::: request 자바스크립트 -->
	<script language="javascript" src="/tools/tck/SPH_REQ00.js"></script>
	<script language="javascript" src="/tools/tck/SPH_REV00.js"></script>
	<!-- EIT-박준연 ::: 2009, 05, 22 ::: event handler 자바스크립트 -->
	
	<!-- EIT-박준연 ::: 2009, 06, 23 ::: ocx event 시작 -->
	<script language="javascript" for="o_CTI" event="evCTIErrCode(errno, errmsg)">
		f_CTIErrorHandler(errno, errmsg);
	</script>
	
	<script language="javascript" for="o_CTI" event="evCTIEvent(cticode, calltype)">
		f_CTIEventHandler(cticode, calltype);
	</script>
	<script language="javascript" for="o_CTI" event="evCTIEvent2(cticode, calltype)">
		f_CTIEventHandler2(cticode, calltype);
	</script>
	<script language="javascript" for="o_CTI" event="evRingData(ani, calltype, userdata)">
		f_CTIRingingHandler(ani, calltype, userdata);
	</script>
	<script language="javascript" for="o_CTI" event="evCTIUserEvent(userdata)">
		f_CTIUserEventHandler(userdata);
	</script>
	<script language="javascript" for="o_CTI" event="evConID(conid)">
		;
	</script>
	<!-- EIT-박준연 ::: 2009, 06, 23 ::: ocx event 끝 -->

	<script type="text/javascript">
	
	    $(document).ready(function(){
			f_JobStart();
	    });
	    
	    var tck = {
	    	// CS 접수화면 호출 및 인입정보 설정
	    	counselView : function(stId, stNm, inCallNum, cusTp){
	    		
		    	var inCallType = "M";
		    	
		    	if(inCallNum.substring(0, 2) != "01"){
		    		inCallType = "T";
		    	}
		    	
		    	if(this.checkMainView()){
		    		top.mainView.ctiConnect.setCtiInfo(stId, stNm, inCallType, inCallNum, cusTp);
		    	}else{
		    		// 2018. 01. 17. wyjeong
		    		// tab add로 변경해야 됨
		    		//top.mainView.location.href = "/counsel/cc/counselCcAcceptView.do?stId=" + stId + "&stNm="+ stNm + "&inCallNum=" + inCallNum + "&inCallType=" + inCallType +"&cusTp=" + cusTp ;
		    	}
	    	}
	    	// 메인 창이 CSVIEW 창인지 확인
	    	, checkMainView : function(){
	    		var mainViewPathName = top.mainView.location.pathname;
	    		
	    		if("/counsel/cc/counselCcAcceptView.do" == mainViewPathName){
		    		return true;
		    	}else{
					return false;
		    	}
	    	}
	    	// 콜센터 번호에 대한 사이트 번호 조회
			, getSite : function(csCallNum, inCallNum){

				$.ajax({
					url : "<spring:url value='/main/getSiteCheck.do' />"
					, type : "POST"
					, dataType : "json"
					, contentType : "application/x-www-form-urlencoded;charset=UTF-8"
					, cache : false
					, data : {csTelNo : csCallNum}
					, async: true
				})
				.done(function(data, textStatus, jqXHR){
					var siteInfo  = data.siteInfo;
					var stId = "";
					var stNm = "";
					
					if(siteInfo != null){
						stId = siteInfo.stId;
						stNm = siteInfo.stNm;
					}

					$("#tckStid").val(stId);
					tck.counselView(stId, stNm, inCallNum, "${adminConstants.CUS_TP_10}");
				})
				.fail(function( xhr, status, error ){
					$("#tckStid").val("");
					tck.counselView("", "", inCallNum, "${adminConstants.CUS_TP_10}");
				});
			}		    	
	    	// 전화걸기 설정
	    	, setCall : function(siteId, telNo){
	    		
	    		$("#tckStid").val(siteId);
	    		
	    		telNo = telNo.split("-").join("");
	    		$("#tckTelNo").val(telNo);
	    		
	    		this.call();
	    	}
	    	// CTI를 이용한 전화걸기
	    	, call : function(){
	    		
	    		var telno = $("#tckTelNo").val();
	    		if(telno == "")
	    		{
	    			messager.alert("전화번호를 입력하여 주십시오.", "Info", "info", function(){
	    				$("#tckTelNo").focus();
					});
	    		}
	    		
	    		var stId = $("#tckStid").val();
	    		
	    		if(stId == ""){
	    			
	    			messager.alert("사이트를 선택하여 주십시오.", "Info", "info", function(){
	    				$("#tckStid").focus();
					});
	    		}
	    		
	    		if(stId == "1"){
	    			telno = "8044" + telno;
	    		}else if(stId == "2"){
	    			telno = "8044" + telno;
	    		}else if(stId == "4"){
	    			telno = "8046" + telno;
	    		}
	    		
	    		f_Dial(telno);
	    		
	    		return true;
	    		
	    	}
	    	// Out Bound 콜
	    	, obCall : function(){
	    		
	    		if(this.checkMainView()){
					messager.confirm("상담이력 저장을 확인하시기 바랍니다. \전화걸기를 진행하시겠습니까?",function(r){
						if(!r){
							return;
						}
					});
	    		}

	    		if(this.call()){
		    		var stId = $("#tckStid").val();
		    		var stNm = $("#tckStid option:selected").text();
		    		var inCallNum = $("#tckTelNo").val();
	
		    		this.counselView(stId, stNm, inCallNum, "${adminConstants.CUS_TP_20}");
	    		}
	    	}
	    	// 대기 상태 전환 시 체크
	    	, ready : function(){
	    		
	    		if(this.checkMainView()){
					messager.confirm("상담이력 저장을 확인하시기 바랍니다. <br>대기상태로 전환시 기 상담이력은 저장되지 않습니다. <br>대기상태로 전환하시겠습니까?",function(r){
						if(r){
							f_Ready();
						}
					});
	    		}else{
		    		f_Ready();
	    		}
	    	}
	    };
	    

	 </script>
 
</HEAD>

<BODY bgColor=#FFFFFF onload="" onunload="f_JobStop()">



	<form name="frmSp" onsubmit="return(false);">
	
		<div class="area">
			<table style="width:1250px">
				<colgroup>
					<col width="60px" />
					<col width="100px" />
					<col width="80px" />
					<col width="130px" />
					<col width="80px" />
					<col width="130px" />
					<col width="70px" />
					<col width="100px" />
					<col width="700px" />
				</colgroup>
				<tbody>
					<tr>
						<th>상&nbsp;&nbsp;&nbsp;&nbsp;태</th>
						<td colspan="5">
							<input type="text" name="spStatus" size="80" class="iptL2" readonly="readonly" value="">
							<input type="hidden" id="agtId" name="agtId" size="10" class="iptL2" readonly="readonly" value="${adminSession.ctiId}">
						</td>
						<th>내선번호</th>
						<td><input type="text" id="agtExt" name="agtExt" size="10" class="iptL2" readonly="readonly" value="${adminSession.ctiExtNo}"></td>
						<td>
							<input type="button" width="82" height="22" value="로그인" name="btnJobStart" onclick="return f_JobStart();">
							<input type="button" width="82" height="22" value="로그아웃" name="btnJobStop" onclick="return f_JobStop();">
							<select id="usrNo" name="usrNo" class="ml20">
								<c:forEach items="${userList}" var="user">
									<option value="${user.ctiId}"><c:out value="${user.usrNm}" /></option>
								</c:forEach>
							</select>
							<input type="button" width="82" height="22" value="상담원상태보기" name="btnJobStat" onclick="return f_AgentStatus();">
							<!-- <input type="button" width="82" height="22" value="TAC 코드 변경" name="btnJobCode" onclick="return f_setPrefix('8099')"> -->
							<!-- <input type="button" width="82" height="22" value="테스트" name="btnJobTest" onclick="return tck.getSite('15885898', '01091185897');"> -->
						</td>
					</tr>
					<tr>
						<th>사이트</th>
						<td>
							<select id="tckStid">
								<option value="">-- 선택 --</option>
								<c:forEach items="${stList}" var="st">
									<option value="${st.stId}">${st.stNm}</option>
								</c:forEach>
							</select>
						</td>
						<th>CS전화번호</th>
						<td><input type="text"  id="tckCsTelNo" size="15" class="iptL" readonly="readonly"></td>
						<th>고객전화번호</th>
						<td><input type="text" name="txtTelno"  id="tckTelNo" size="15" class="iptL"></td>
						<td colspan="3">
							<input type="image" src="/images/tck/bt_02.gif" width="82" height="22" value="" name="btnReady" onclick="return tck.ready();">
							<input type="image" src="/images/tck/bt_03.gif" width="82" height="22" value="" name="btnNotReady" onclick="return f_NotReady('');">
							<input type="image" src="/images/tck/bt_07.gif" width="82" height="22" value="" name="btnDial" onclick="return tck.obCall();">
							<input type="image" src="/images/tck/bt_08.gif" width="82" height="22" value="" name="btnTransfer" onclick="return f_TransferInit(document.all.txtTelno.value);">
							<input type="image" src="/images/tck/bt_04.gif" width="82" height="22" value="" name="btnHold" onclick="return fncHold_Click();">
							<input type="image" src="/images/tck/bt_09.gif" width="82" height="22" value="" name="btnConfer" onclick="return f_ConferenceInit(document.all.txtTelno.value);">
							<input type="image" src="/images/tck/bt_05.gif" width="82" height="22" value="" name="btnAnswer" onclick="return f_Answer();">
							<input type="image" src="/images/tck/bt_01.gif" width="82" height="22" value="" name="btnComplete" onclick="return f_Complete();">
							<input type="image" src="/images/tck/bt_06.gif" width="82" height="22" value="" name="btnRelease" onclick="return f_Release();">
							<input type="image" src="/images/tck/bt_10.gif" width="82" height="22" value="" name="btnReConnect" onclick="return f_Reconnect();">
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div style="clear:both;"></div>
	
	</form>

<!-- 솔루비스-김진찬 ::: 2017, 03, 16 ::: OCX 시작 classid 변경됨 -->
<object id="o_CTI" name="o_CTI" classid="clsid:25C33CBA-9397-4E1C-B00F-7332BB6954D7" codebase="/tools/tck/HM.CAB#version=1,2,0,1" width="0px" height="0px"></object>
<!-- 솔루비스-김진찬 ::: 2017, 03, 16 ::: OCX 끝 classid 변경됨 -->


</BODY>
</HTML>
