//*-----------------------------------------------------------------------------
//* 화면 ID  : SPH_REV00.JS
//* 화면명   : 소프트폰(AVAYA) 이벤트 핸들링 클래스
//* 작성자   : EIT-박준연(jypark@enovationit.com)
//*----------------------------------------------------------------------------
//* 이력사항
//*----------------------------------------------------------------------------
// 2009, 04, 30 EIT-박준연 최초 구성
//*----------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------------
// 1. 이벤트 에러 핸들링
//--------------------------------------------------------------------------------------------------
//==================================================================================================
//함수 : f_CTIErrorHandler
//인자 : ERRCD - 에러코드, ERRMSG - 에러메세지
//반환 :
//==================================================================================================
function f_CTIErrorHandler(ERRCD, ERRMSG)
{
	try
	{
		alert("f_CTIErrorHandler() :" + ERRCD + " // " + ERRMSG);//에러메세지 표기
	}
	catch(err)
	{
		alert("f_CTIErrorHandler() :" + err.description);
	}
}

//--------------------------------------------------------------------------------------------------
// 2. 전화 인입시 고객정보 처리
//--------------------------------------------------------------------------------------------------
//==================================================================================================
//함수 : f_CTIRingingHandler
//인자 : ANI - 인입전화번호, UDATA - 유저데이터
//반환 :
//==================================================================================================
function f_CTIRingingHandler(ANI, CALLTYPE, UDATA)
{
	try
	{
		
		//유저데이터 파싱하기
		f_UDATA(ANI, UDATA);

		// 유저데이터로부터 고객센터 전화번호 조회
		var csCallNum = f_UDATA_get(UDATA, "DNIS");
		if(csCallNum != ""){
			csCallNum = csCallNum.split("-").join("");
		}
		
		//CS전화번호 설정
		$("#tckCsTelNo").val(csCallNum);
		// 인입전화번호 설정
		$("#tckTelNo").val(ANI);
		
		f_RingingAction(CALLTYPE);

		// INBOUND 전화가 인입되었을 경우 CS접수화면 호출 처리
		if(CALLTYPE == "2"){
			tck.getSite(csCallNum ,ANI);
		}
		
	}
	catch(err)
	{
		alert("f_CTIRingingHandler() :" + err.description);
	}
}

//--------------------------------------------------------------------------------------------------
// 3. CTI이벤트 핸들링
//--------------------------------------------------------------------------------------------------
//==================================================================================================
//함수 : f_CTIEventHandler
//인자 : CTICODE - CTI코드
//반환 : 
//==================================================================================================
function f_CTIEventHandler(CTICODE, CALLTYPE)
{
	try
	{
		//var status_msg = "";
		switch (CTICODE)
		{
			case "50":	 //_EventServerConnected
				status_msg = "T-Server에 접속되었습니다.";
				break;			
			case "51":   //_EventServerDisconnected
				status_msg = "T-Server접속해제되었습니다.";
				break;
			case "52":   //_EventError
				break;
			case "53":   //_EventRegistered
				status_msg = "Register되었습니다.";
				f_ButtonStatus("NOTREADY");
				break;
			case "54":   //_EventUnregistered 
				status_msg = "UnRegister되었습니다.";
				break;
			case "55":   //_EventRegisteredAll
				break;
			case "56":   //_EventUnregisteredAll
				break;
			case "57":   //_EventQueued
				break;
			case "58":   //_EventDiverted
				break;
			case "591":   //_EventAbandoned 확장
				status_msg = "상담 요청 전화가 끊어졌습니다.";
				break; 
			case "592":   //_EventAbandoned	확장
				status_msg = "고객이 전화를 끊었습니다.";
				break;
			case "60":   //_EventRinging 
				f_ButtonStatus("RING");
				status_msg = "전화가 왔습니다.";
				break;
			case "61":   //_EventDialing
				f_ButtonStatus("DIAL");
				status_msg = "전화를 걸고 있습니다.";
				break;
			case "62":   //_EventNetworkReached
				break;
			case "63":   //_EventDestinationBusy
				status_msg = "해당 고객이 통화중입니다.";
				f_ButtonStatus("DIAL");
				alert("해당 고객이 통화중입니다.");
				break;
			case "641":   //_EventEstablished 확장
				status_msg = "전화가 연결되었습니다.";
				f_EstablishAction();
				f_ButtonStatus("ESTABLISH");
				break;
			case "642":   //_EventEstablished 확장
				status_msg = "상담원과 연결되었습니다.";
				f_ButtonStatus("ESTABLISH");
				break;
			case "65":   //_EventReleased
				status_msg = "전화를 끊었습니다.";
				break;
			case "66":   //_EventHeld 
				status_msg = "통화 보류 중입니다.";
				f_ButtonStatus("HOLD");
				break;
			case "67":   //_EventRetrieved
				status_msg = "고객과 통화중입니다.";
				f_ButtonStatus("ESTABLISH");
				break;
			case "681":   //_EventPartyChanged 확장
				status_msg = "호전환이 완료 되었습니다.";
				f_EstablishAction();
				break;
			case "682":   //_EventPartyChanged	확장
				status_msg = "3자통화가 완료 되었습니다.";
				f_EstablishAction();
				break;
			case "691":   //_EventPartyAdded 확장
				status_msg = "호전환이 완료 되었습니다.";
				f_EstablishAction();
				break;
			case "692":   //_EventPartyAdded 확장
				status_msg = "3자통화가 완료 되었습니다.";
				f_EstablishAction();
				break;
			case "701":   //_EventPartyDeleted 확장
				status_msg = "3자통화중 상담원이 끊었습니다.";
				break;
			case "702":   //_EventPartyDeleted	확장
				status_msg = "3자통화중 고객이 끊었습니다.";
				break;
			case "71":   //_EventRouteRequest
				break;
			case "72":   //_EventRouteUsed
				break;
			case "73":   //_EventAgentLogin
				status_msg = "로그인되었습니다.";
				break;
			case "74":   //_EventAgentLogout
				status_msg = "로그아웃되었습니다.";
				f_ButtonStatus("INIT");
				break;
			case "75":   //_EventAgentReady
				f_Clear(); //데이터 초기화
				status_msg = "대기 상태입니다.";
				f_ButtonStatus("READY");
				break;
			case "76":   //_EventAgentNotReady 휴식중
				status_msg = "휴식상태입니다."; 
				f_ButtonStatus("NOTREADY");
				break;
			case "760":   //_EventAgentNotReady 후처리
				status_msg = "통화후 작업 중입니다.";
				f_ButtonStatus("WORK");
				break; 
			case "761":   //_EventAgentNotReady 휴식중
				status_msg = "휴식상태입니다."; 
				f_ButtonStatus("NOTREADY");
				break;
			case "762":   //_EventAgentNotReady 교육중
				status_msg = "교육상태입니다.";
				f_ButtonStatus("NOTREADY");
				break;
			case "77":   //_EventDNDOn
				break;
			case "78":   //_EventDNDOff
				break;
			case "79":   //_EventMailBoxLogin
				break;
			case "80":   //_EventMailBoxLogout
				break;
			case "81":   //_EventVoiceFileOpened
				break;
			case "82":   //_EventVoiceFileClosed
				break;
			case "83":   //_EventVoiceFileEndPlay
				break;
			case "84":   //_EventDigitsCollected
				break;
			case "85":   //_EventAttachedDataChanged
				break;
			case "86":   //_EventOffHook
				break;
			case "87":   //_EventOnHook
				break;
			case "88":   //_EventForwardSet
				break;
			case "89":   //_EventForwardCancel
				break;
			case "90":   //_EventMessageWaitingOn
				break;
			case "91":   //_EventMessageWaitingOff
				break;
			case "92":   //_EventAddressInfo
				break;
			case "93":   //_EventServerInfo
                               status_msg = "";
				break;
			case "94":   //_EventLinkDisconnected
				break;
			case "95":   //_EventLinkConnected
				status_msg = "CTI 접속 성공";
				break;
			case "96":   //_EventUserEvent
				break;
			case "98":   //_EventDTMFSent
				break;
			case "99":   //_EventResourceAllocated
				break;
			case "100":  //_EventResourceFreed
				break;
			case "101":  //_EventRemoteConnectionSuccess
				break;
			case "102":  //_EventRemoteConnectionFailed
				break;
			case "106":  //_EventListenDisconnected
				break;
			case "107":  //_EventListenReconnected
				break;
			case "109":  //_EventPartyInfo
				break;
			case "112":  //_EventCallInfoChanged
				break;
			case "114":  //_EventTreatmentApplied
				break;
			case "115":  //_EventTreatmentNotApplied
				break;
			case "116":  //_EventTreatmentEnd
				break;
			case "117":  //_EventHardwareError
				break;
			case "118":  //_EventAgentAfterCallWork
				break;
			case "119":  //_EventTreatmentRequired
				break;
			case "122":  //_EventSwitchInfo
				break;
			case "125":  //_EventAnswerAccessNumber
				break;
			case "126":  //_EventReqGetAccessNumberCanceled
				break;
			case "128":  //_EventAgentReserved
				break;
			case "131":  //_EventAgentIdleReasonSet
				break;
			case "132":  //_EventRestoreConnection
				break;
			case "133":  //_EventPrimaryChanged
				break;
			case "137":  //_EventLocationInfo
				break;
			case "138":  //_EventACK
				break;
			case "141":  //_EventMonitoringNextCall
				break;
			case "142":  //_EventMonitoringCancelled
				break;
			case "145":  //_EventMuteOn
				break;
			case "146":  //_EventMuteOff
				break;
			case "147":  //_EventDNOutOfService
				break;
			case "148":  //_EventDNBackInService
				break;
			case "150":  //_EventPrivateInfo
				break;
			case "151":  //_EventBridged
				break;
			case "152":  //_EventQueueLogout
				break;
			case "153":  //_EventReserved_1
				break;
			case "154":  //_EventReserved_2
				break;
			case "155":  //_EventReserved_3
				break;
			case "156":  //_EventReserved_4
				break;
			case "157":  //_EventReserved_5
				break;
			case "158":  //_EventReserved_6
				break;
			case "159":  //_EventReserved_7
				break;
			case "160":  //_EventCallCreated
				break;
			case "161":  //_EventCallDataChanged
				break;
			case "162":  //_EventCallDeleted
				break;
			case "163":  //_EventCallPartyAdded
				break;
			case "164":  //_EventCallPartyState
				break;
			case "165":  //_EventCallPartyMoved
				break;
			case "166":  //_EventCallPartyDeleted
				break;

			case "920":  //_EventAddressInfo-agent logged out
                                alert("상담원상태 : 로그아웃");
				break;
			case "921":  //_EventAddressInfo-agent logged in
                                alert("상담원상태 : 로그인");
				break;
			case "922":  //_EventAddressInfo-agent ready
                                alert("상담원상태 : 대기");
				break;
			case "923":  //_EventAddressInfo-agent not_ready
                                alert("상담원상태 : 이석");
				break;
			case "924":  //_EventAddressInfo-agent 4 acw
                                 alert("상담원상태 : 후처리");
				break;
			case "925":  //_EventAddressInfo-agent 5 walkaway
                                 alert("상담원상태 : 상태변경중");
				break;
			case "927":  //_EventAddressInfo-agent 5 walkaway
                                 alert("상담원상태 : 통화중");
				break;

			case "928":  //_EventAddressInfo-queue wait call
                                 alert("대기콜 : ");
				break;



			default:
				break;
		}
		
		if(status_msg != "") 
		{
			document.frmSp.spStatus.value = status_msg;
		}
	}	
	catch(err)
	{
		alert("f_CTIEventHandler() :" + err.description);
	}
}


function f_CTIEventHandler2(CTICODE, CALLTYPE)
{
	try
	{
		//var status_msg = "";
		switch (CTICODE)
		{
			case "50":	 //_EventServerConnected
				break;			
			case "51":   //_EventServerDisconnected
				break;
			case "52":   //_EventError
				break;
			case "53":   //_EventRegistered
				break;
			case "54":   //_EventUnregistered 
				break;
			case "55":   //_EventRegisteredAll
				break;
			case "56":   //_EventUnregisteredAll
				break;
			case "57":   //_EventQueued
				break;
			case "58":   //_EventDiverted
				break;
			case "591":   //_EventAbandoned 확장
				break; 
			case "592":   //_EventAbandoned	확장
				break;
			case "60":   //_EventRinging 
				break;
			case "61":   //_EventDialing
				break;
			case "62":   //_EventNetworkReached
				break;
			case "63":   //_EventDestinationBusy
				break;
			case "641":   //_EventEstablished 확장
				break;
			case "642":   //_EventEstablished 확장
				break;
			case "65":   //_EventReleased
				break;
			case "66":   //_EventHeld 
				break;
			case "67":   //_EventRetrieved
				break;
			case "681":   //_EventPartyChanged 확장
				break;
			case "682":   //_EventPartyChanged	확장
				break;
			case "691":   //_EventPartyAdded 확장
				break;
			case "692":   //_EventPartyAdded 확장
				break;
			case "701":   //_EventPartyDeleted 확장
				break;
			case "702":   //_EventPartyDeleted	확장
				break;
			case "71":   //_EventRouteRequest
				break;
			case "72":   //_EventRouteUsed
				break;
			case "73":   //_EventAgentLogin
				break;
			case "74":   //_EventAgentLogout
				break;
			case "75":   //_EventAgentReady
				break;
			case "76":   //_EventAgentNotReady 휴식중
				break;
			case "760":   //_EventAgentNotReady 후처리
				break; 
			case "761":   //_EventAgentNotReady 휴식중
				break;
			case "762":   //_EventAgentNotReady 교육중
				break;
			case "77":   //_EventDNDOn
				break;
			case "78":   //_EventDNDOff
				break;
			case "79":   //_EventMailBoxLogin
				break;
			case "80":   //_EventMailBoxLogout
				break;
			case "81":   //_EventVoiceFileOpened
				break;
			case "82":   //_EventVoiceFileClosed
				break;
			case "83":   //_EventVoiceFileEndPlay
				break;
			case "84":   //_EventDigitsCollected
				break;
			case "85":   //_EventAttachedDataChanged
				break;
			case "86":   //_EventOffHook
				break;
			case "87":   //_EventOnHook
				break;
			case "88":   //_EventForwardSet
				break;
			case "89":   //_EventForwardCancel
				break;
			case "90":   //_EventMessageWaitingOn
				break;
			case "91":   //_EventMessageWaitingOff
				break;
			case "92":   //_EventAddressInfo
				break;
			case "93":   //_EventServerInfo
                               status_msg = "";
				break;
			case "94":   //_EventLinkDisconnected
				break;
			case "95":   //_EventLinkConnected
				break;
			case "96":   //_EventUserEvent
				break;
			case "98":   //_EventDTMFSent
				break;
			case "99":   //_EventResourceAllocated
				break;
			case "100":  //_EventResourceFreed
				break;
			case "101":  //_EventRemoteConnectionSuccess
				break;
			case "102":  //_EventRemoteConnectionFailed
				break;
			case "106":  //_EventListenDisconnected
				break;
			case "107":  //_EventListenReconnected
				break;
			case "109":  //_EventPartyInfo
				break;
			case "112":  //_EventCallInfoChanged
				break;
			case "114":  //_EventTreatmentApplied
				break;
			case "115":  //_EventTreatmentNotApplied
				break;
			case "116":  //_EventTreatmentEnd
				break;
			case "117":  //_EventHardwareError
				break;
			case "118":  //_EventAgentAfterCallWork
				break;
			case "119":  //_EventTreatmentRequired
				break;
			case "122":  //_EventSwitchInfo
				break;
			case "125":  //_EventAnswerAccessNumber
				break;
			case "126":  //_EventReqGetAccessNumberCanceled
				break;
			case "128":  //_EventAgentReserved
				break;
			case "131":  //_EventAgentIdleReasonSet
				break;
			case "132":  //_EventRestoreConnection
				break;
			case "133":  //_EventPrimaryChanged
				break;
			case "137":  //_EventLocationInfo
				break;
			case "138":  //_EventACK
				break;
			case "141":  //_EventMonitoringNextCall
				break;
			case "142":  //_EventMonitoringCancelled
				break;
			case "145":  //_EventMuteOn
				break;
			case "146":  //_EventMuteOff
				break;
			case "147":  //_EventDNOutOfService
				break;
			case "148":  //_EventDNBackInService
				break;
			case "150":  //_EventPrivateInfo
				break;
			case "151":  //_EventBridged
				break;
			case "152":  //_EventQueueLogout
				break;
			case "153":  //_EventReserved_1
				break;
			case "154":  //_EventReserved_2
				break;
			case "155":  //_EventReserved_3
				break;
			case "156":  //_EventReserved_4
				break;
			case "157":  //_EventReserved_5
				break;
			case "158":  //_EventReserved_6
				break;
			case "159":  //_EventReserved_7
				break;
			case "160":  //_EventCallCreated
				break;
			case "161":  //_EventCallDataChanged
				break;
			case "162":  //_EventCallDeleted
				break;
			case "163":  //_EventCallPartyAdded
				break;
			case "164":  //_EventCallPartyState
				break;
			case "165":  //_EventCallPartyMoved
				break;
			case "166":  //_EventCallPartyDeleted
				break;
			case "920":  //_EventAddressInfo-agent logged out
                                alert("상담원상태2 : 로그아웃");
				break;
			case "921":  //_EventAddressInfo-agent logged in
                                alert("상담원상태2 : 로그인");
				break;
			case "922":  //_EventAddressInfo-agent ready
                                alert("상담원상태2 : 대기");
				break;
			case "923":  //_EventAddressInfo-agent not_ready
                                alert("상담원상태2 : 이석");
				break;
			case "924":  //_EventAddressInfo-agent 4 acw
                                 alert("상담원상태2 : 후처리");
				break;
			case "925":  //_EventAddressInfo-agent 5 walkaway
                                 alert("상담원상태2 : 상태변경중");
				break;
			case "927":  //_EventAddressInfo-agent 5 walkaway
                                 alert("상담원상태 2: 통화중");
				break;
			case "928":  //_EventAddressInfo-queue wait call
                                 alert("대기콜 2: ");
				break;



			default:
				break;
		}
		
		if(status_msg != "") 
		{
			document.frmSp.spStatus.value = status_msg;
		}
	}	
	catch(err)
	{
		alert("f_CTIEventHandler() :" + err.description);
	}
}


//--------------------------------------------------------------------------------------------------
// 4. 전화벨이 울렸을때의 액션
//--------------------------------------------------------------------------------------------------
//==================================================================================================
//함수 : f_RingingAction
//인자 : CALLTYPE - 콜타입
//반환 : 
//==================================================================================================
function f_RingingAction(CALLTYPE)
{
	try
	{
		v_callType = "";
		
		//인입콜 타입 시작
		switch(CALLTYPE)
		{
			case "0":	//Unknown
				v_callType = "전화가 왔습니다!.";
			break;
			case "1":	//Internel
				v_callType = "[내선]전화가 왔습니다!.";
			break;
			case "2":	//Inbound
				v_callType = "[INBOUND]전화가 왔습니다!.";
			break;
			case "3":	//Outbound
				v_callType = "[OUTBOUND]전화가 연결되었습니다!.";
			break;
			case "4":	//Consult
				v_callType = "[CONSULT]전화가 왔습니다!.";
			break;
		}
		//인입콜 타입 끝
		
		document.frmSp.spStatus.value = v_callType;
	}	
	catch(err)
	{
		alert("f_RingingAction() :" + err.description);
	}
}


//--------------------------------------------------------------------------------------------------
// 4. 전화가 연결되었을 때 액션
//--------------------------------------------------------------------------------------------------
//==================================================================================================
//함수 : f_EstablishAction
//인자 : 
//반환 : 
//==================================================================================================
function f_EstablishAction() 
{
	try
	{
		;
	}	
	catch(err)
	{
		alert("f_EstablishAction() :" + err.description);
	}
}

//--------------------------------------------------------------------------------------------------
// 5. 초기화
//--------------------------------------------------------------------------------------------------
//==================================================================================================
//함수 : f_Clear
//인자 : 
//반환 : 
//==================================================================================================
function f_Clear()
{ 
	try
	{
		; //유저데이터 초기화 및 화면기초 정보 초기화
	}	
	catch(err)
	{
		alert("f_CTIRingingHandler() :" + err.description);
	}
}


//--------------------------------------------------------------------------------------------------
// 6. 이벤트에서 데이터 받아와 파싱시작
//--------------------------------------------------------------------------------------------------
//==================================================================================================
//함수 :f_UDATA
//인자 : v_aninum - 인입번호, v_userdata - 유저데이터
//반환 : 
//==================================================================================================
function f_UDATA(v_aninum, v_userdata)
{
	try
	{
		ANI = v_aninum;
		
		var splitdata = v_userdata.split("&");
		f_UDATAParser(splitdata, "=");
	}	
	catch(err)
	{
		alert("f_UDATA() :" + err.description);
	}
}

//--------------------------------------------------------------------------------------------------
// 7. USERDATA전문 파싱 시작
//--------------------------------------------------------------------------------------------------
//==================================================================================================
//함수 :f_UDATAParser
//인자 : splitdata - 유저데이터 배열, delimeter = 구분자
//반환 : 
//==================================================================================================
function f_UDATAParser(splitdata, delimeter)
{
	try
	{
		var length = splitdata.length;	
		var index = "";
		var key = "";
		var values = "";
		
		for( var i  =0 ; i < length ; i++ )
		{
			index = splitdata[i].indexOf( delimeter );
			key = splitdata[i].substring( 0 , index );		
			values = splitdata[i].substr( index+1 );
			//trace( "key=[" + key + "] , value = [" + value + "]");		
			f_UDATASet(key, values);
		}	
	}	
	catch(err)
	{
		alert("f_UDATAParser() :" + err.description);
	}
}

//--------------------------------------------------------------------------------------------------
// 8. USERDATA변수 설정
//--------------------------------------------------------------------------------------------------
//==================================================================================================
//함수 :f_UDATASet
//인자 : key - 키 , value = 값
//반환 : 
//==================================================================================================
function f_UDATASet(key, values)
{
	if( values == null || values == "UNDEFINED" || values == "undefined" ) values ="";
	
	try
	{
		switch(key)
		{
			case "GRP_CD":
				//GRP_CD = values;	//그룹코드
			break;
			case "Merong":
				alert(values);
			case "Event":
				alert(values);
			break;
		}
	}	
	catch(err)
	{
		alert("f_UDATASet() :" + err.description);
	}
}

function f_UDATA_get(v_userdata, keyName){
	var keyValue = "";
	
	var splitdata = v_userdata.split("&");
	
	var length = splitdata.length;	
	var index = "";
	var key = "";
	var values = "";
	
	for( var i  =0 ; i < length ; i++ )
	{
		index = splitdata[i].indexOf( "=" );
		key = splitdata[i].substring( 0 , index );		
		values = splitdata[i].substr( index+1 );
		//trace( "key=[" + key + "] , value = [" + value + "]");		
		if(key == keyName){
			keyValue = values;
			break;
		}
	}	
	
	return keyValue;
}

//--------------------------------------------------------------------------------------------------
// 9. f_CTIUserEventHandler 이벤트 핸들링
//--------------------------------------------------------------------------------------------------
//==================================================================================================
//함수 : f_CTIUserEventHandler
//인자 : v_userdata
//반환 : 
//==================================================================================================
function f_CTIUserEventHandler(v_userdata)
{
	alert(v_userdata)
	try
	{
		var splitdata = v_userdata.split("&");
		f_UDATAParser(splitdata, "=");
	}	
	catch(err)
	{
		alert("f_CIUserEventHandler() :" + err.description);
	}
} 