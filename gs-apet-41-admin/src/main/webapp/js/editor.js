var oEditors = [];

var EditorCommon = {
	/**
	 * Smart Editor 설정
	 */
	setSEditor : function(holder, imgPath, disableYn, photoYn) {
		if(validation.isNull(imgPath)) {
			imgPath = _IMG_COMMON_PATH
		}
		
		var usePhoto = true;
		if(photoYn == "N"){
			usePhoto = false;
		}

		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: holder,
			sSkinURI: "/tools/smartEditor/SmartEditor2Skin.html",
			fCreator: "createSEditor2",
			htParams : {
				imgPath : imgPath,
				bUsePhoto : usePhoto
			},
			fOnAppLoad : function(){
				if(disableYn == "Y"){
					/**
					 * Smart Editer Disable 처리
					 */
					var editor = oEditors.getById[holder];
					editor.exec("DISABLE_WYSIWYG");
					editor.exec("DISABLE_ALL_UI");
				}
			}
		});
	},
	/**
	 * 스마트 에디터 사진 첨부 함수
	 * @param p_editor_url
	 */
	pasteHTML : function(id, editorUrl) {
		var imgHtml = '<img src="'+ _IMG_CDN_URL + editorUrl + '" alt="img" />';
		oEditors.getById[id].exec("PASTE_HTML", [imgHtml]);
	}
};

