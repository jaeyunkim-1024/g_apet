<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
		var mode =  '${mode}';
		
		$(document).ready(function() {
			
			userMessageListGrid();
		});

		// 쪽지 목록
		function userMessageListGrid(){
		var options = {
				url : "<spring:url value='/common/userMessageListGrid.do' />"
				, height : 400
				, searchParam : {
					mode : mode
				}
				, colModels : [
                      {name:"noteNo", label:'<b><u><tt><spring:message code="column.note_no" /></tt></u></b>', width:"60", align:"center", formatter:'integer', classes:'pointer fontbold'}
					, {name:"ttl", label:'<spring:message code="column.ttl" />', width:"250", align:"center"  }
					, {name:"sndrNm", label:'<spring:message code="column.sndr_nm" />', width:"100", align:"center"  }
					, {name:"usrNm", label:'<spring:message code="column.rcvr_nm" />', width:"100", align:"center" }
					, {name:"rcvYn", label:'<spring:message code="column.rcv_yn" />', width:"60", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.COMM_YN}"/>"} }
					, {name:"sysRegDtm", label:'<spring:message code="column.snd_dtm" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss" }					
					, {name:"rcvDtm", label:'<spring:message code="column.rcv_dtm" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"  }
					
					, {name:"usrNo", label:'<spring:message code="column.rcvr_no" />', width:"100", align:"center", formatter:'integer', hidden:true }
					, {name:"sndrNo", label:'<spring:message code="column.sndr_no" />', width:"200", align:"center", hidden:true }
				//	, {name:"delYn", label:'<spring:message code="column.del_yn" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.COMM_YN}"/>"}, hidden:true}
				//	, {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"120", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", hidden:true }
				
				//	, {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"120", align:"center", hidden:true}
				//	, {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"120", align:"center", hidden:true}
				]
				, paging : true
				, onSelectRow : function(ids) {
					var rowdata = $("#userMessageList").getRowData(ids);
					//코드관리_그룹 상세 조회
					userMessage(rowdata.noteNo,rowdata.usrNo);
				}
			};
			grid.create("userMessageList", options);
		}
		
		// 받은 메시지, 보낸 메시지 탭
        function fnUserMessageList(index) {
			if (index == 0)
				mode = 'RCV'
			else
				mode = 'SND';
			
			$('.tabMenu li').removeClass('active');
			$('.tabMenu li:eq(' + index + ')').addClass('active');
            
			var options = {
				searchParam : {mode : mode}
			};
			grid.reload("userMessageList", options);
        }
		
		// 메시지 쓰기
		function userMessage(noteNo, usrNo) {
			var title = '메세지 보내기';
			var btn = "<button type=\"button\" onclick=\"fnMessageSend();\" class=\"btn btn-ok\">발송</button>";
			if (noteNo != 0 && mode == 'RCV') {
				title = '받은메세지 상세'; 
				btn = "<button type=\"button\" onclick=\"fnMessageDelete();\" class=\"btn btn-ok\">받은메세지 삭제</button>";
			}
			if (noteNo != 0 && mode == 'SND') {
				title = '보낸메세지 상세';
				btn = "<button type=\"button\" onclick=\"fnMessageDelete();\" class=\"btn btn-ok\">보낸메세지 삭제</button>";
			}
			
			var options = {
				url : '/common/userMessageViewPop.do'
				, data : {
					 usrNo : usrNo
					,noteNo : noteNo
					,mode : mode
				}
				, dataType : "html"
				, callBack : function (data ) {
					var config = {
						id : "userMessageView"
						, width : 900
						, height : 600
						, top : 200
						, title : title
						, body : data
						, button : btn
					}
					layer.create(config);
				}
			}
			ajax.call(options );
		}
		
   
		</script>
		    <div class="mTab">
                <ul class="tabMenu">
                    <li ${empty mode or 'RCV' eq mode ? 'class="active"' : ''}><a href="javascript:fnUserMessageList(0)">받은 메시지</a></li>
                    <li ${'SND' eq mode ? 'class="active"' : ''}><a href="javascript:fnUserMessageList(1)">보낸 메시지</a></li>
                </ul>
            </div>
            <div class="mTitle">
                <h2>메시지 목록</h2>
            </div>
			<div class="mModule no_m">
				<table id="userMessageList" ></table>
				<div id="userMessageListPage"></div>
			</div>
				
		