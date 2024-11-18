<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 

<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js" charset="utf-8"></script>
<script type="text/javascript">

	$(document).ready(function(){
		 searchDaumPost();
	}); // End Ready

	$(function() {
		
		
	});
	
	function searchDaumPost() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                /* var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                } */
                
                // 지번 여러개인 경우 체크
				var roadAddress = '', jibunAddress = '';
				if (data.roadAddress != '')
					roadAddress = data.roadAddress;
				else
					roadAddress = data.autoRoadAddress;
                
				if (data.jibunAddress != '')
					jibunAddress = data.jibunAddress;
				else
					jibunAddress = data.autoJibunAddress;
				
                // 빌딩 명 추가
            	if (data.buildingName !== '') {
            		jibunAddress += ' (' + data.buildingName +')';
            		roadAddress += ' (' + data.buildingName +')';
				}

        		var postData = {
       				postNoOld : data.postcode1 + "-" + data.postcode2,
       				postNoNew : data.zonecode,
       				prclAddr : jibunAddress,
       				roadAddr : roadAddress,
       				roadCode : data.bcode,
       				buildingCode : data.buildingCode
       			};
        		
        		returnPostInfo(postData);

            },
            width : '100%',
            height : '100%'
        }).embed(document.getElementById('daum_search'));
    }
    
	/*
	 * 팝업 콜백 처리
	 */
	function returnPostInfo(data){

		<c:out value="${param.callBackFnc}" />(data);
		
		pop.close("<c:out value="${param.popId}" />");
	}

	
</script>

<div id="daum_search" style="overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;width:100%;height:460px;">
</div>

