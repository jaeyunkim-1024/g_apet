<%--	
 - Class Name	: /sample/samplePetlogTagView.jsp
 - Description	: 펫로그 실시간 태그감지 예시
 - Since		: 2021.3.8
 - Author		: VLF
--%>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="content">	
	<div class="content" style="padding-left: 20%;">
		<br/>
		<br/>
		<span>펫로그를 위한 실시간 태그 감지&nbsp;&nbsp;</span><textarea rows="10" cols="80" id="contentArea" name="contentArea" ></textarea>
		&emsp;#hashtag&nbsp;<span style="font-size: 20px;font-weight: bold;">☞</span>&emsp;<input type="text" id="realTimeTag" disabled="disabled" style="width: 200px;" >
		&emsp;@metion&nbsp;<span style="font-size: 20px;font-weight: bold;">☞</span>&emsp;<input type="text" id="realTimeMention" disabled="disabled" style="width: 200px;" >
		<br/>
		<!-- tag 셀렉터 부분 -->
		<div class="lttbTagArea" style="display:none;margin-left:12%">
			<ul id="add_tag_list" style="width: 583px;">
			</ul>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		펫로그 게시글 태그 링크(textarea blur되면 값이 들어옵니다.)
		<div class="lcbConTxt_content" id="lcbConTxt_content" style="width:800px;height: 100px;border: solid;">
			
		</div>
	</div>
	<br/>
	<script>
		// event type은 변경하셔도 됩니다. 
		var gb = '';
		$(document).on("input", "textarea[name=contentArea]", function(e) {
			$("#realTimeTag").val("");// <- 예시를 위한 input 태그입니다. 실사용시에는 삭제
			let element = document.getElementById('contentArea');
			let strOriginal = element.value;
			let strOrginal2 = strOriginal.substring(0, element.selectionStart);
			let index = strOrginal2.lastIndexOf('\#');
			if (index < strOrginal2.lastIndexOf('\@') && element.selectionStart > strOrginal2.lastIndexOf('\@')) {
				index = strOrginal2.lastIndexOf('\@');
			}
			/* if (strOrginal2.substring(element.selectionStart - 1) == '\#') {
				gb = '';
				gb = '\#';
			}
			if (strOrginal2.substring(element.selectionStart - 1) == '\@') {
				gb = '';
				gb = '\@';
			} */

			let txt = strOrginal2.substring(index, element.selectionStart);
			txt = txt.substring(0, 1);

			gb = txt;
			// hashtag
			if (gb.indexOf('\#') > -1) {
				let iStartPos = element.selectionStart;
				let iEndPos = element.selectionEnd;
				let strFront = "";
				let strEnd = "";
				if(iStartPos == iEndPos) {
					String.prototype.startsWith = function(str) {
						if (this.length < str.length) { return false; }
						return this.indexOf(str) == 0;
					}
					strFront = strOriginal.substring(0, iStartPos);
					strFrontArr = strFront.split('\#');
					let tagTxt = strFrontArr[strFrontArr.length - 1];
					strEnd = strOriginal.substring(iStartPos, strOriginal.length);
					strEnd = strEnd.split(' ')[0];
					strEnd = strEnd.split('#')[0];
					let searchTagTxt = '';
					if (tagTxt != undefined) {
						if (tagTxt.length > 0) {
							let lastStr = tagTxt.slice(tagTxt.length-1, tagTxt.length);
							let regTxt = /^[ㄱ-ㅎㅏ-ㅣ|가-힣|a-z|A-Z|0-9|\*]+$/;
							if (regTxt.test(lastStr) && tagTxt.split(' ').length == 1) {
								searchTagTxt = tagTxt.split(' ')[0];
							}
						} else if (strEnd != '') {
							searchTagTxt = strEnd;
						}
					}
					
					//////////////////////////////////////////////////
					// xhr 통신 추가 start
					// searchTagTxt 로 태그검색하시면 됩니다.
					console.log('searchTagTxt', searchTagTxt);
					console.log('searchTagTxt.substring(0, 1)', searchTagTxt.substring(searchTagTxt.length -1, searchTagTxt.length));
					if( searchTagTxt != '' && searchTagTxt.substring(0, 1).search(/['><&]/gi) == -1){
						$("#realTimeTag").val(searchTagTxt);// <- 예시를 위한 input 태그입니다. 실사용시에는 삭제
						let options  = {
				                url : "/log/getAutocomplete"
				            ,   data : {
				            	searchText : searchTagTxt
				            	, label : "pet_log_autocomplete"
				            	, size : "30"
				            }
				        	, async:false
				            ,   done : function(result){
			                    let resBody = JSON.parse(result);					
			                    $("#add_tag_list").html("");
			                    
								if(resBody.STATUS.CODE != "200"){
									alert("Error = " + resBody.STATUS.MESSAGE);
								}else{
									if(resBody.DATA.TOTAL > 0){
										let addHtml = "";
										for (let i = 0; i < resBody.DATA.TOTAL; i++) {
											let item = resBody.DATA.ITEMS;
											//alert(item);
											addHtml += '<li><a href="javascript:selectTag(\''+searchTagTxt.trim() + '\', \'' + item[i].KEYWORD + '\');">#' + item[i].KEYWORD + '</a></li>';
										}		
										$("#add_tag_list").append(addHtml);
										$(".lttbTagArea").css("display", "block");
									}else{
										//alert("검색 결과값이 없습니다.");
									}
								}
				            }
				        };
				        ajax.call(options);
					} else{ 
						 $("#add_tag_list").html("");
					}
					// xhr 통신 추가 end
					//////////////////////////////////////////////////
				} else return;
			}
			
			// mention
			if (gb.indexOf('\@') > -1) {
				let iStartPos = element.selectionStart;
				let iEndPos = element.selectionEnd;
				let strFront = "";
				let strEnd = "";
				if(iStartPos == iEndPos) {
					String.prototype.startsWith = function(str) {
						if (this.length < str.length) { return false; }
						return this.indexOf(str) == 0;
					}
					strFront = strOriginal.substring(0, iStartPos);
					strFrontArr = strFront.split('\@');
					let mentionTxt = strFrontArr[strFrontArr.length - 1];
					strEnd = strOriginal.substring(iStartPos, strOriginal.length);
					strEnd = strEnd.split(' ')[0];
					strEnd = strEnd.split('@')[0];
					let searchMentionTxt = '';
					if (mentionTxt != undefined) {
						if (mentionTxt.length > 0) {
							let lastStr = mentionTxt.slice(mentionTxt.length-1, mentionTxt.length);
							let regTxt = /^[ㄱ-ㅎㅏ-ㅣ|가-힣|a-z|A-Z|0-9|\*]+$/;
							if (regTxt.test(lastStr) && mentionTxt.split(' ').length == 1) {
								searchMentionTxt = mentionTxt.split(' ')[0];
							}
						} else if (strEnd != '') {
							searchMentionTxt = strEnd;
						}
					}
					
					//////////////////////////////////////////////////
					// xhr 통신 추가 start
					// searchMentionTxt 로 멘션검색하시면 됩니다.
					if( searchMentionTxt != '' && searchMentionTxt.substring(0, 1).search(/['><&]/gi) == -1){
						$("#realTimeMention").val(searchMentionTxt);// <- 예시를 위한 input 태그입니다. 실사용시에는 삭제
						let options  = {
				                url : "/common/getNickNameList"
				            ,   data : {
				            	nickNm : searchMentionTxt
				            }
				        	, async:false
				            ,   done : function(result){
			                    $("#add_tag_list").html("");
								if(result.list.length > 0){
									let addHtml = "";
									for(let i = 0; i < result.list.length; i++){
										let pic = '${frame:optImagePath("'+ result.list[i].prflImg +'", frontConstants.IMG_OPT_QRY_550)}';
										if (result.list[i].prflImg == null || result.list[i].prflImg == '') {
											
											pic = '../../_images/common/icon-img-profile-default-b@2x.png'
										}
										addHtml += '<li><a href="javascript:selectTag(\''+searchMentionTxt.trim() + '\', \'' + result.list[i].nickNm + '\');"><div class="pic"><img src="'+ pic + '" style="margin:9px 5px 0px 5px;float:left;width:28px;height:28px;border-radius:100%;overflow:hidden;background:#c7cdd5 no-repeat center;background-size:38px auto;"></div>' + result.list[i].nickNm + '</a></li>';
									};
									$("#add_tag_list").append(addHtml);
									$(".lttbTagArea").css("display", "block");
								}else{
									//alert("검색 결과값이 없습니다.");
								}
				            }
				        };
				        ajax.call(options);
					} else{ 
						 $("#add_tag_list").html("");
					}
					// xhr 통신 추가 end
					//////////////////////////////////////////////////
				} else return;
			}
		});
		
		$(document).on("blur", "textarea[name=contentArea]", function(e) {
			let element = document.getElementById('contentArea');
			let strOriginal = element.value;
			//strOriginal = strOriginal.replace(/(?:\r\n|\r|\n)/g, '<br/>');
			let inputString = strOriginal;
			inputString = inputString.replace(/#[^#\s'><&]+|@[^@\s~'><&]+/gm, function (tag){
				return (tag.indexOf('#')== 0) ? '<a href="/log/indexPetLogTagList?tag=' + encodeURIComponent(tag.replace('#','')) + '" style="color:#669aff;">' + tag + '</a>' : '<a href="/' + tag.replace('@','') + '" style="color:#faa802;">' + tag + '</a>';
			});
			//$("#lcbConTxt_content").html(inputString);
			$("#lcbConTxt_content").html('<pre>' + inputString + '</pre>');
			$("#lcbConTxt_content").trigger('change');

		});
		$(document).on("change", "#lcbConTxt_content", function(e) {
		});
		
		function selectTag(searchText, selTag ){
			let element = document.getElementById('contentArea');
			let strOriginal = element.value;
			let iStartPos = element.selectionStart;
			let iEndPos = element.selectionEnd;
			let strFront = "";
			let strEnd = "";
			let pos = '';
			if (searchText != '') {
				let space = element.value.substring(iStartPos + searchText.length -2).substring(0, 1) == ' ' ? '' : ' ';
				pos = (element.value.substring(0, iStartPos - searchText.length) + selTag + space);
				let serchTxtLen = 2;
				if (searchText.length == 1) {
					serchTxtLen = 1;
				}
				element.value = element.value.substring(0, iStartPos - searchText.length) + selTag + space + element.value.substring(iStartPos + searchText.length - serchTxtLen);
			}
			$("#add_tag_list").html("");
			$(".lttbTagArea").css("display", "none");
			$("#contentArea").trigger('blur');
			//var afterStr = $("#contentArea").val().replace("#"+searchText, "#"+selTag);
			//$("#contentArea").val( afterStr );
			$('#contentArea').prop('selectionEnd',pos.length);
			$("#contentArea").focus();
		};
	</script>
	</tiles:putAttribute>
</tiles:insertDefinition>