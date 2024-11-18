(function($){
    $.fn.validationEngineLanguage = function(){
    };
    $.validationEngineLanguage = {
        newLang: function(){
            $.validationEngineLanguage.allRules = {
                "required": { // Add your regex rules here, you can take telephone as an example
                    "regex": "none",
                    "alertText": "* 필수입력입니다.",
                    "alertTextCheckboxMultiple": "* 옵션을 선택해주십시오.",
                    "alertTextCheckboxe": "* 이 체크박스는 필수입니다.",
                    "alertTextDateRange": "* Both date range fields are required"
                },
                "requiredInFunction": {
                    "func": function(field, rules, i, options){
                        return (field.val() == "test") ? true : false;
                    },
                    "alertText": "* Field must equal test"
                },
                "dateRange": {
                    "regex": "none",
                    "alertText": "* 종료일자가 ",
                    "alertText2": "시작일자보다 빠릅니다. "
                },
                "dateTimeRange": {
                    "regex": "none",
                    "alertText": "* 종료일시가 ",
                    "alertText2": "시작일시보다 빠릅니다."
                },
                "minSize": {
                    "regex": "none",
                    "alertText": "* 최소 ",
                    "alertText2": " 문자(현재)가 필요합니다."
                },
                "maxSize": {
                    "regex": "none",
                    "alertText": "* 최대 ",
                    "alertText2": " 이하로 작성하십시오."
                },
                "maxSizeNonUtf8": {
                    "regex": "none",
                    "alertText": "* 최대 ",
                    "alertText2": " 이하로 작성하십시오."
                },
                "groupRequired": {
                    "regex": "none",
                    "alertText": "* You must fill one of the following fields"
                },
                "min": {
                    "regex": "none",
                    "alertText": "* 최소값은 "
                },
                "max": {
                    "regex": "none",
                    "alertText": "* 최대값은 "
                },
                "past": {
                    "regex": "none",
                    "alertText": "* Date prior to "
                },
                "future": {
                    "regex": "none",
                    "alertText": "* Date past "
                },
                "maxCheckbox": {
                    "regex": "none",
                    "alertText": "* 최대 ",
                    "alertText2": " 개이하로 선택하십시오."
                },
                "minCheckbox": {
                    "regex": "none",
                    "alertText": "*  ",
                    "alertText2": " 개이상 선택하십시오."
                },
                "equals": {
                    "regex": "none",
                    "alertText": "* 입력값이 동일하지 않습니다."
                },
                "creditCard": {
                    "regex": "none",
                    "alertText": "* Invalid credit card number"
                },
                "loginid": {
                	//"regex":/^[a-z][a-z0-9A-Z\d]{4,19}$/,
                	"regex":/^[0-9a-zA-z~`!@#$%^&*()_+=-]{4,12}$/,
                    "alertText": "* 아이디는 영문, 숫자, 특수문자 입력이 가능하며 최소 4자 ~ 최대 12자 이내로 입력해야 합니다."
                },
                "password": {
                	"regex":/^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/,
                    "alertText": "* 비밀번호형식이 아닙니다. (6~20자리, 영문/숫자 혼용)"
                },
                "bizNo": {
                	"regex" : /^\d{3}-?\d{2}-?\d{5}$/,
                    "alertText": "* 사업자등록번호형식이 아닙니다."
                },
                "cprNo": {
                    "regex": /^\d{6}-?\d{7}$/,
                    "alertText": "* 법인등록번호형식이 아닙니다."
                },
                "tel": {
                	"regex" : /^(\d{2,3}-?\d{3,4}-?\d{4})|(\d{4}-?\d{4})$/,
                    "alertText": "* 전화번호형식이 아닙니다."
                },
                "mobile": {
                    "regex": /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/,
                    "alertText": "* 휴대번호형식이 아닙니다."
                },
                "post": {
                    "regex": /^\d{3}-?\d{3}$/,
                    "alertText": "* 우편번호형식이 아닙니다."
                },
                "email": {
                    // HTML5 compatible email regex ( http://www.whatwg.org/specs/web-apps/current-work/multipage/states-of-the-type-attribute.html#    e-mail-state-%28type=email%29 )
                	"regex": /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i,
                    "alertText": "* 이메일 주소형식이 아닙니다."
                },
                "integer": {
                    "regex": /^[\-\+]?\d+$/,
                    "alertText": "* Not a valid integer"
                },
                "number": {
                    // Number, including positive, negative, and floating decimal. credit: orefalo
                    "regex": /^[\-\+]?((([0-9]{1,3})([,][0-9]{3})*)|([0-9]+))?([\.]([0-9]+))?$/,
                    "alertText": "* Invalid floating decimal number"
                },
                "date": {
                    //	Check if date is valid by leap year
	                "func": function (field) {
						var pattern = new RegExp(/^(\d{4})[\/\-\.](0?[1-9]|1[012])[\/\-\.](0?[1-9]|[12][0-9]|3[01])$/);
						var match = pattern.exec(field.val());
						if (match == null)
						   return false;

						var year = match[1];
						var month = match[2]*1;
						var day = match[3]*1;
						var date = new Date(year, month - 1, day); // because months starts from 0.

						return (date.getFullYear() == year && date.getMonth() == (month - 1) && date.getDate() == day);
					},
					"alertText": "* 날짜형식오류 : YYYY-MM-DD"
                },
                "ipv4": {
                    "regex": /^((([01]?[0-9]{1,2})|(2[0-4][0-9])|(25[0-5]))[.]){3}(([0-1]?[0-9]{1,2})|(2[0-4][0-9])|(25[0-5]))$/,
                    "alertText": "* IP(V4) 형식이 아닙니다."
                },
                "url": {
                    "regex": /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i,
                    "alertText": "* URL형식이 아닙니다.(http 또는 https 사용)"
                },
                "onlyNum": {
                    "regex": /^[0-9\ ]+$/,
                    "alertText": "* 숫자만 가능합니다."
                },
                "onlyDecimal": {
                    "regex": /^\d+\.?\d*$/,
                    "alertText": "* 숫자만 가능합니다."
                },
                "onlyEng": {
                    "regex": /^[a-zA-Z\ \']+$/,
                    "alertText": "* 영문만 가능합니다."
                },
                "onlyEngB": {
                    "regex": /^[A-Z\ \']+$/,
                    "alertText": "* 영문(대문자)만 가능합니다."
                },
                "onlyEngS": {
                    "regex": /^[a-z\ \']+$/,
                    "alertText": "* 영문(소문자)만 가능합니다."
                },
                "onlyEngNum": {
                    "regex": /^[0-9a-zA-Z]+$/,
                    "alertText": "* 영문자/숫자만 가능합니다."
                },
                "onlyEngNumSpace": {
                    "regex": /^[0-9a-zA-Z\s]+$/,
                    "alertText": "* 영문자/숫자/공백만 가능합니다."
                },
                "onlyEngNumHyphen": {
                    "regex": /^[0-9a-zA-Z\-]+$/,
                    "alertText": "* 영문자/숫자/'-'만 가능합니다."
                },
                "onlyNumComma": {
                    "regex": /^[0-9,]+$/,
                    "alertText": "* 숫자와 , 만 가능합니다."
                },
                "hexColorCode": {
	            	"regex": /^#(?:[0-9a-f]{3}){1,2}$/i,
	            	"alertText": "* hex color code 형식이 아닙니다."
	            },
                "version": {
                    "regex": /^[0-9].[0-9].[0-9]$/,
                    "alertText": "'1.0.0' 형식으로 입력하세요."
                },
                // --- CUSTOM RULES -- Those are specific to the demos, they can be removed or changed to your likings
                "ajaxUserCall": {
                    "url": "ajaxValidateFieldUser",
                    // you may want to pass extra data on the ajax call
                    "extraData": "name=eric",
                    "alertText": "* This user is already taken",
                    "alertTextLoad": "* Validating, please wait"
                },
				"ajaxUserCallPhp": {
                    "url": "phpajax/ajaxValidateFieldUser.php",
                    // you may want to pass extra data on the ajax call
                    "extraData": "name=eric",
                    // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                    "alertTextOk": "* This username is available",
                    "alertText": "* This user is already taken",
                    "alertTextLoad": "* Validating, please wait"
                },
                "ajaxNameCall": {
                    // remote json service location
                    "url": "ajaxValidateFieldName",
                    // error
                    "alertText": "* This name is already taken",
                    // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                    "alertTextOk": "* This name is available",
                    // speaks by itself
                    "alertTextLoad": "* Validating, please wait"
                },
				 "ajaxNameCallPhp": {
	                    // remote json service location
	                    "url": "phpajax/ajaxValidateFieldName.php",
	                    // error
	                    "alertText": "* This name is already taken",
	                    // speaks by itself
	                    "alertTextLoad": "* Validating, please wait"
	                },
                "validate2fields": {
                    "alertText": "* Please input HELLO"
                },
	            //tls warning:homegrown not fielded
                "dateFormat":{
                    "regex": /^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$|^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(?:(?:0?[1-9]|1[0-2])(\/|-)(?:0?[1-9]|1\d|2[0-8]))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(0?2(\/|-)29)(\/|-)(?:(?:0[48]00|[13579][26]00|[2468][048]00)|(?:\d\d)?(?:0[48]|[2468][048]|[13579][26]))$/,
                    "alertText": "* Invalid Date"
                },
                //tls warning:homegrown not fielded
				"dateTimeFormat": {
	                "regex": /^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])\s+(1[012]|0?[1-9]){1}:(0?[1-5]|[0-6][0-9]){1}:(0?[0-6]|[0-6][0-9]){1}\s+(am|pm|AM|PM){1}$|^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^((1[012]|0?[1-9]){1}\/(0?[1-9]|[12][0-9]|3[01]){1}\/\d{2,4}\s+(1[012]|0?[1-9]){1}:(0?[1-5]|[0-6][0-9]){1}:(0?[0-6]|[0-6][0-9]){1}\s+(am|pm|AM|PM){1})$/,
                    "alertText": "* Invalid Date or Date Format",
                    "alertText2": "Expected Format: ",
                    "alertText3": "mm/dd/yyyy hh:mm:ss AM|PM or ",
                    "alertText4": "yyyy-mm-dd hh:mm:ss AM|PM"
	            },
                "onlyKoAndEn": {
                	"regex":/^[가-힣a-zA-z]+$/,
                    "alertText": "* 한글,영문만 가능합니다."
                },
                "loginidFO": {
                	"regex":/^[0-9a-zA-z~`!@#$%^&*()_+=-]{6,20}$/,
                    "alertText": "* 아이디는 영문, 숫자, 특수문자 입력이 가능하며 최소 6자 ~ 최대 20자 이내로 입력해야 합니다."
                },
                "rowItrdc": {
                	"regex":/^.{0,20}$/,
                    "alertText": "* 최대 20자 이하로 작성하십시오."
                },
                "email2": {
                	"regex": /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z-_\.])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.(?!(co)$)[a-zA-Z]{2,}$/,
                    "alertText": "* 이메일 주소형식이 아닙니다."
                },
                "onlyKoAndNmAndEn": {
                	"regex":/^[가-힣0-9a-zA-z]+$/,
                    "alertText": "* 한글, 숫자, 영문 대소문자만 입력 가능합니다."
                }
            };

        }
    };

    $.validationEngineLanguage.newLang();

})(jQuery);
