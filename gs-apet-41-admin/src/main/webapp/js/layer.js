var layer = {
	create : function(config) {
		var width = config.width ? config.width : 800;
		var height = config.height ? config.height : 600;
		var id = config.id ? config.id : 'layerPopup';
		var title = config.title ? config.title : '';
		if ($("#" + id).length === 0) {
			$("body").append("<div id=\"" + id + "\"></div>");
			$("#" + id).after("<div id=\"" + id + "_dlg-buttons\" class=\"dlg_btn_area\"></div>");
		}

		var btn = "";
		if (config.button)
			btn = config.button + "<button type=\"button\" class=\"ml10 btn btn-cancel\" onclick=\"layer.close('" + id + "');\">닫기</button>";
		else
			btn = "<button type=\"button\" class=\"btn btn-cancel\" onclick=\"layer.close('" + id + "');\">닫기</button>";

		$('#' + id + '_dlg-buttons').html(btn);

		if(config.scroll) {
			if(config.scroll == 'N') {
				$('#'+id).css('overflow', 'hidden');
			}
		}
		$('#'+id).dialog({
			title: title,
			width: width,
			height: height,
			closed: false,
			modal: true,
			buttons: '#' + id + '_dlg-buttons'
		});

		if (config.body) {
			$('#'+id).dialog({content: config.body});
		}

		if (config.init)
			$("#" + id).trigger(config.init);
	}
	,close : function(id) {
		//html 남아있어 문제있음. close -> destroy
		$('#'+id).dialog('destroy');
	}
	,post : function(callBack) {

		$('#postLayer').remove();
		var config = {
			  id : "postLayer"
			, width : 700
			, height : 500
			, top : 200
			, title : "우편번호"
			, body : ''
		}
		layer.create(config);

		// ====================================================================================
		// http://postcode.map.daum.net/guide 참조
		// zonecode : 우편번호
		// address : 기본주소
		// addressEnglish : 기본 영문 주소
		// roadAddress : 도로명 주소
		// roadAddressEnglish : 영문 도로명 주소
		// jibunAddress : 지번 주소
		// jibunAddressEnglish : 영문 지번 주소
		// postcode : 구 우편번호
		// ====================================================================================
		new daum.Postcode({
			oncomplete: function(data) {

				//빌딩 명 추가
            	if(data.buildingName !== ''){
					data.jibunAddress += '(' + data.buildingName +')';
					data.roadAddress += '(' + data.buildingName +')';
				}
				callBack(data);
				layer.close('postLayer');
			}
			, width : '100%'
			, height : '100%'
		}).embed(document.getElementById('postLayer'));
	}
}
