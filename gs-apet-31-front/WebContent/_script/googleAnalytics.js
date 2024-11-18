/*
 *	데이터 입력 
 */

//			name: null, 		// string, Required, The ID of an item. *One of id or name is required.
//			brand: null, 		// string, Not required, The brand of the item.
//			category: null, 	// string, Not required, The category to which the item belongs. Use / as a delimiter to specify up to five levels of hierarchy.
//			coupon: null, 		// string, Not required, The coupon code associated with an item.
//			list_name: null,	// string, Not required, The name of the list the item appeared in.
//			list_position: null,// number, Not required, The item's position in a list or collection.
//			price: null,		// number, Not required, The price of the item.
//			quantity: null,		// number, Not required, The quantity of the item.
//			variant: null		// string, Not required, The variant of the item.

// 회원가입 데이터
var sign_up_data = {
	method: null 				// string, Not required, The method used for sign up.
	
}
var sign_up_data_reset = JSON.parse(JSON.stringify(sign_up_data));

// 로그인 데이터
var login_data = {
	method: null 				// string, Not required, The method used to login.
}
var login_data_reset = JSON.parse(JSON.stringify(login_data));

// 장바구니 데이터
var add_to_cart_data = {
	currency: null, 			// string, Not required, Currency of the items associated with the event, in 3-letter ISO 4217 format.
	items: [
		{
			item_id: null, 		// string, Required, Item ID (context-specific). *One of item_id or item_name is required for product or impression data.
			item_name: null, 	// string, Required, Item Name (context-specific). *One of item_id or item_name is required for product or impression data.
			quantity: null,		// number, Not required, Item quantity.
			affiliation : null, // string, Not required, A product affiliation to designate a supplying company or brick and mortar store location.
			coupon: null, 		// string, Not required, The coupon code associated with an item.
			discount : null,    // number, Not required, Monetary value of discount associated with a item.
			item_brand: null, 	// string, Not required, Item brand.
			item_category: null,// string, Not required, Item Category (context-specific). item_category2 through item_category5 can also be used if the item has many categories.
			item_variant: null,	// string, Not required, The variant of the item.
			price: null,		// number, Not required, The monetary price of the item, in units of the specified currency parameter.
			currency: null,		// string, Not required, The currency, in 3-letter ISO 4217 format.
		}
	],
	value: null 				// number, Not required, The monetary value of the event.
}
var add_to_cart_data_reset = JSON.parse(JSON.stringify(add_to_cart_data));

// 구매 데이터
var purchase_data = {
	affiliation: null,			// string, Not required, A product affiliation to designate a supplying company or brick and mortar store location.
	coupon: null,  				// string, Not required, Coupon code used for a purchase.
	currency: null,				// string, Not required, Currency of the purchase or items associated with the event, in 3-letter ISO 4217 format.
	shipping: null,				// number, Not required, Shipping cost associated with a transaction.
	tax: null,					// number, Not required, Tax cost associated with a transaction.
	transaction_id: null,		// string, Not required, The unique identifier of a transaction.
	value: null,				// number, Not required, The monetary value of the event, in units of the specified currency parameter.
	items: [
		{
			item_id: null, 		// string, Required, Item ID (context-specific). *One of item_id or item_name is required for product or impression data.
			item_name: null, 	// string, Required, Item Name (context-specific). *One of item_id or item_name is required for product or impression data.
			quantity: null,		// number, Not required, Item quantity.
			affiliation : null, // string, Not required, A product affiliation to designate a supplying company or brick and mortar store location.
			coupon: null, 		// string, Not required, The coupon code associated with an item.
			discount : null,    // number, Not required, Monetary value of discount associated with a item.
			item_brand: null, 	// string, Not required, Item brand.
			item_category: null,// string, Not required, Item Category (context-specific). item_category2 through item_category5 can also be used if the item has many categories.
			item_variant: null,	// string, Not required, The variant of the item.
			tax	: null,			// number, Not required, Tax cost associated with a transaction.
			price: null,		// number, Not required, The monetary price of the item, in units of the specified currency parameter.
			currency: null,		// string, Not required, The currency, in 3-letter ISO 4217 format.
		}
	]
}
var purchase_data_reset = JSON.parse(JSON.stringify(purchase_data));

// 환불 데이터
var refund_data = {
	affiliation : null,			// string, Not required, A product affiliation to designate a supplying company or brick and mortar store location.
	coupon: null,  				// string, Not required, Coupon code used for a purchase.
	currency: null,				// string, Not required, Currency of the purchase or items associated with the event, in 3-letter ISO 4217 format.
	shipping: null,				// number, Not required, Shipping cost associated with a transaction.
	tax: null,					// number, Not required, Tax cost associated with a transaction.
	transaction_id: null,		// string, Not required, The unique identifier of a transaction
	value: null,				// number, Not required, The monetary value of the event, in units of the specified currency parameter.
	items: [
		{
			item_id: null, 		// string, Required, Item ID (context-specific). *One of item_id or item_name is required for product or impression data.
			item_name: null, 	// string, Required, Item Name (context-specific). *One of item_id or item_name is required for product or impression data.
			quantity: null,		// number, Not required, Item quantity.
			affiliation : null, // string, Not required, A product affiliation to designate a supplying company or brick and mortar store location.
			coupon: null, 		// string, Not required, The coupon code associated with an item.
			discount : null,    // number, Not required, Monetary value of discount associated with a item.
			item_brand: null, 	// string, Not required, Item brand.
			item_category: null,// string, Not required, Item Category (context-specific). item_category2 through item_category5 can also be used if the item has many categories.
			item_variant: null,	// string, Not required, The variant of the item.
			tax	: null,			// number, Not required, Tax cost associated with a transaction.
			price: null,		// number, Not required, The monetary price of the item, in units of the specified currency parameter.
			currency: null,		// string, Not required, The currency, in 3-letter ISO 4217 format.
		}
	]
}
var refund_data_reset = JSON.parse(JSON.stringify(refund_data));

// 검색 데이터
var search_data = {
	search_term: null 			// string, Required, The term that was searched for.
}
var search_data_reset = JSON.parse(JSON.stringify(search_data));


/*
 *	호출 (funcNm : 회원가입-sign_up, 로그인-login, 장바구니-add_to_cart, 구매-purchase, 환불-refund, 검색-search )
 */
function sendGtag(funcNm, paramData) {
	if(paramData == null || paramData == ''){ // paramData 없을 경우 상위에 정의된 변수 사용(한번 보낸후 데이터 리셋)
		let thisData = eval(funcNm+"_data");
		gtag('event', funcNm, thisData);
		window[funcNm+"_data"] = JSON.parse(JSON.stringify(eval(funcNm+"_data_reset")));		
	}else{ // 파람 직접 입력
		gtag('event', funcNm, paramData);
	}
}