<%--	
 - Class Name	: /sample/sampleCheckView.jsp
 - Description	: 디바이스 / OS / 넓이로 MO및PC 구분 예시
 - Since		: 2020.12.17
 - Author		: KKB
--%>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="content">	
	<script>
		function chgDeviceGb(deviceGb) {
			let returnUrl =  window.location.href
			location.href = "/common/chgDeviceGb?returnUrl="+returnUrl+"&deviceGb="+deviceGb;
		}
		
		function openOkCertPop() {
			okCertPopup();
		}	
		
	</script>
	<div class="content">
		<br/>
		<br/>
		<!-- 기기구분 [PC, MO, APP] -->
		<h2 style="display: inline;">■ 기기구분 : <span class="blue">${view.deviceGb} </span></h2>
		<c:if test="${ view.deviceGb eq 'PC'}">
		&emsp;<button type="button" onclick="chgDeviceGb('MO')" class="btn" style="display: inline;">모바일 버젼 보기</button>
		</c:if>
		<c:if test="${ view.deviceGb eq 'MO'}">
		&emsp;<button type="button" onclick="chgDeviceGb('PC')" class="btn" style="display: inline;">PC 버젼 보기</button>	
		</c:if>
		
		<!-- OS 구분 [DEVICE_TYPE(PC), ANDROID:10, IOS:20] -->
		<h2>■ OS 구분(DEVICE_TYPE(PC), ANDROID:10, IOS:20) : <span class="blue">${view.os}</span></h2>
		
		<!-- 서비스 구분 [펫샵:10, 펫TV:20(default), 펫로그:30] -->
		<h2>■ 서비스 구분(펫샵:10, 펫TV:20(default), 펫로그:30) : <span class="blue">${view.seoSvcGbCd}</span></h2>
		
		<!-- 펫 구분 [강아지:10(default), 고양이: 20, 기타:30] -->
		<h2>■ 펫 구분(강아지:10(default), 고양이: 20, 기타:30) :<span class="blue">${view.petGb}</span></h2>
		<br/>
		<br/>
		<br/>
		<button type="button" onclick="openOkCertPop();" class="btn" style="display: inline;">본인 인증 팝</button>
	</div>
	<style type="text/css">
        .blue {
            color: blue;
        }
    </style>
	</tiles:putAttribute>
</tiles:insertDefinition>