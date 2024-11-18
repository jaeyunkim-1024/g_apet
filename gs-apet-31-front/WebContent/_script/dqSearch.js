$(document)
		.ready(
				function() {
					$(".search_wrap .close").on("click", function() {
						$(this).prev("input").val("");
					});

					// 검색시 검색한 필터노출.
					// displayDetailTotal();

					// 검색시 소카테고리 div노출
					var showId = $("#sCateShow").val();
					$("#" + showId).show();

					// 중카테 클릭시 소카테고리 노출 여부
					$(".categorySub .subCate label").on("click", function() {
						var mCateVal = $(this).data('value');

						$(".categorySub .lastCate_wrap").hide();
						$("#" + mCateVal).show();
					});

					// 카테고리 노출 여부
					$(".tab_content_wrap .cate .tab_result_list").each(
							function(i) {
								// var target = $(this).data('value');
								if (i > 0) {
									$(this).hide();
								}
							});

					// 추천어 검색
					$(".recommand_keyword_wrap").find("ul > li").on("click",
							function() {
								var query = $(this).data("value");
								goDirectSearch(query);
							});

					// 상세검색 탭 선택
					$(".tab_search_container li")
							.find("a")
							.on(
									"click",
									function() {
										// var target = $(this).data('role');
										$(
												".tab_content_wrap .brand .sub_tab_container .sub_tab li")
												.removeClass("active");
										$(
												".tab_content_wrap .brand .sub_tab_container .sub_tab li:eq(0)")
												.addClass("active");
										$(
												".tab_content_wrap .brand .init_list_container .sub_tab li")
												.removeClass("active");

										$(
												".tab_content_wrap .brand .tab_result_list li")
												.each(function(i) {
													$(this).show();
												});

										$(
												".tab_content_wrap .premium .init_list_container .sub_tab li")
												.removeClass("active");
										$(
												".tab_content_wrap .premium .tab_result_list li")
												.each(function(i) {
													$(this).show();
												});

										$(
												".tab_content_wrap .store .init_list_container .sub_tab li")
												.removeClass("active");
										$(
												".tab_content_wrap .store .tab_result_list li")
												.each(function(i) {
													$(this).show();
												});

										$(
												".tab_content_wrap .designer .init_list_container .sub_tab li")
												.removeClass("active");
										$(
												".tab_content_wrap .designer .tab_result_list li")
												.each(function(i) {
													$(this).show();
												});
									});

					// 대 카테고리 선택 시
					$(".tab_content_wrap .cate .sub_tab li").on(
							"click",
							function() {
								var target = $(this).data('value');
								$(".tab_content_wrap .cate .sub_tab li")
										.removeClass("active");
								$(this).addClass("active");

								$(".tab_content_wrap .cate .tab_result_list")
										.hide();
								$("#" + target).show();
							});

					// 브랜드 노출 여부
					$(".tab_content_wrap .brand .sub_tab_container .sub_tab li")
							.on(
									"click",
									function() {
										var target = $(this).data('value');
										$(
												".tab_content_wrap .brand .sub_tab_container .sub_tab li")
												.removeClass("active");
										$(this).addClass("active");
										$(
												".tab_content_wrap .brand .init_list_container .sub_tab li")
												.removeClass("active");

										$(
												".tab_content_wrap .brand .tab_result_list li")
												.each(
														function(i) {
															var brand = $(this)
																	.data(
																			'value');
															if (target === "N") {
																$(this).show();
															} else {
																if (brand !== "N") {
																	$(this)
																			.show();
																} else {
																	$(this)
																			.hide();
																}
															}

														});
									});

					// 브랜드 초성 선택(KOR)
					$(".brandSub .lang_wrap .kor .lang_list li")
							.on(
									"click",
									function() {
										var target = $(this).data('value');
										$(
												".brandSub .lang_wrap .kor .lang_list li")
												.removeClass("active");
										$(this).addClass("active");
										var brand = $(
												".searchMenuContent .searchBrand .active")
												.data('value');
										$(".brandSubResult .subCate li")
												.each(
														function(i) {
															var cho = $(this)
																	.data('cho');
															var value = $(this)
																	.data(
																			'value');
															if (brand === value) {
																if (target !== "ETC"
																		&& target !== "ALL") {
																	if (target === cho) {
																		$(this)
																				.show();
																	} else {
																		$(this)
																				.hide();
																	}
																} else if (target === "ALL") {
																	$(
																			".brandSubResult .subCate li")
																			.show();
																} else {
																	var choType = /^[ㄱ-ㅎa-zA-Z]+$/;
																	if (choType
																			.test(cho)) { // 한글/영문이
																		// 아닌경우
																		$(this)
																				.hide();
																	} else {
																		$(this)
																				.show();
																	}
																}
															}
														});
									});

					// 브랜드 초성 선택(ENG)
					$(".brandSub .lang_wrap .eng .lang_list li")
							.on(
									"click",
									function() {
										var target = $(this).data('value');
										$(
												".brandSub .lang_wrap .eng .lang_list li")
												.removeClass("active");
										$(this).addClass("active");
										var brand = $(
												".searchMenuContent .searchBrand .active")
												.data('value');
										$(".brandSubResult .subCate li")
												.each(
														function(i) {
															var cho = $(this)
																	.data('cho');
															var value = $(this)
																	.data(
																			'value');
															if (brand === value) {
																if (target !== "ETC"
																		&& target !== "ALL") {
																	if (target === cho) {
																		$(this)
																				.show();
																	} else {
																		$(this)
																				.hide();
																	}
																} else if (target === "ALL") {
																	$(
																			".brandSubResult .subCate li")
																			.show();
																} else {
																	var choType = /^[ㄱ-ㅎa-zA-Z]+$/;
																	if (choType
																			.test(cho)) { // 한글/영문이
																		// 아닌경우
																		$(this)
																				.hide();
																	} else {
																		$(this)
																				.show();
																	}
																}
															}
														});
									});

					// 브랜드 초성 선택(KOR)
					$(".brandSub .lang_wrap .kor .lang_list2 li")
							.on(
									"click",
									function() {
										var target = $(this).data('value');
										$(
												".brandSub .lang_wrap .kor .lang_list2 li")
												.removeClass("active");
										$(this).addClass("active");
										var brand = $(
												".searchMenuContent .searchBrand .active")
												.data('value');
										$(".brandSubResult2 .subCate li")
												.each(
														function(i) {
															var cho = $(this)
																	.data('cho');
															var value = $(this)
																	.data(
																			'value');
															if (brand === value) {
																if (target !== "ETC"
																		&& target !== "ALL") {
																	if (target === cho) {
																		$(this)
																				.show();
																	} else {
																		$(this)
																				.hide();
																	}
																} else if (target === "ALL") {
																	$(
																			".brandSubResult2 .subCate li")
																			.show();
																} else {
																	var choType = /^[ㄱ-ㅎa-zA-Z]+$/;
																	if (choType
																			.test(cho)) { // 한글/영문이
																		// 아닌경우
																		$(this)
																				.hide();
																	} else {
																		$(this)
																				.show();
																	}
																}
															}
														});
									});

					// 브랜드 초성 선택(ENG)
					$(".brandSub .lang_wrap .eng .lang_list2 li")
							.on(
									"click",
									function() {
										var target = $(this).data('value');
										$(
												".brandSub .lang_wrap .eng .lang_list2 li")
												.removeClass("active");
										$(this).addClass("active");
										var brand = $(
												".searchMenuContent .searchBrand .active")
												.data('value');
										$(".brandSubResult2 .subCate li")
												.each(
														function(i) {
															var cho = $(this)
																	.data('cho');
															var value = $(this)
																	.data(
																			'value');
															// if(brand ==
															// value){
															if (target !== "ETC"
																	&& target !== "ALL") {
																if (target === cho) {
																	$(this)
																			.show();
																} else {
																	$(this)
																			.hide();
																}
															} else if (target === "ALL") {
																$(
																		".brandSubResult2 .subCate li")
																		.show();
															} else {
																var choType = /^[ㄱ-ㅎa-zA-Z]+$/;
																if (choType
																		.test(cho)) { // 한글/영문이
																	// 아닌경우
																	$(this)
																			.hide();
																} else {
																	$(this)
																			.show();
																}
															}
															// }
														});
									});

					// 스토어 초성 선택(KOR)
					$(".store .lang_wrap .kor .lang_list li").on(
							"click",
							function() {
								var target = $(this).data('value');
								$(".store .lang_wrap .kor .lang_list li")
										.removeClass("active");
								$(this).addClass("active");
								// var brand = $(".searchMenuContent
								// .searchBrand .active").data('value');
								$(".storeSub .subCate li").each(function(i) {
									var cho = $(this).data('cho');
									var value = $(this).data('value');

									if (target !== "ETC" && target !== "ALL") {
										if (target === cho) {
											$(this).show();
										} else {
											$(this).hide();
										}
									} else if (target === "ALL") {
										$(".storeSub .subCate li").show();
									} else {
										var choType = /^[ㄱ-ㅎa-zA-Z]+$/;
										if (choType.test(cho)) { // 한글/영문이
											// 아닌경우
											$(this).hide();
										} else {
											$(this).show();
										}
									}

								});
							});

					// 스토어 초성 선택(ENG)
					$(".store .lang_wrap .eng .lang_list li").on(
							"click",
							function() {
								var target = $(this).data('value');
								$(".store .lang_wrap .eng .lang_list li")
										.removeClass("active");
								$(this).addClass("active");
								// var brand = $(".searchMenuContent
								// .searchBrand .active").data('value');
								$(".storeSub .subCate li").each(function(i) {
									var cho = $(this).data('cho');
									var value = $(this).data('value');

									if (target !== "ETC" && target !== "ALL") {
										if (target === cho) {
											$(this).show();
										} else {
											$(this).hide();
										}
									} else if (target === "ALL") {
										$(".storeSub .subCate li").show();
									} else {
										var choType = /^[ㄱ-ㅎa-zA-Z]+$/;
										if (choType.test(cho)) { // 한글/영문이
											// 아닌경우
											$(this).hide();
										} else {
											$(this).show();
										}
									}

								});
							});

					// 디자이너 초성 선택(KOR)
					$(".designer .lang_wrap .kor .lang_list li").on(
							"click",
							function() {
								var target = $(this).data('value');
								$(".designer .lang_wrap .kor .lang_list li")
										.removeClass("active");
								$(this).addClass("active");
								// var brand = $(".searchMenuContent
								// .searchBrand .active").data('value');
								$(".designerSub .subCate li").each(function(i) {
									var cho = $(this).data('cho');
									var value = $(this).data('value');

									if (target !== "ETC" && target !== "ALL") {
										if (target === cho) {
											$(this).show();
										} else {
											$(this).hide();
										}
									} else if (target === "ALL") {
										$(".designerSub .subCate li").show();
									} else {
										var choType = /^[ㄱ-ㅎa-zA-Z]+$/;
										if (choType.test(cho)) { // 한글/영문이
											// 아닌경우
											$(this).hide();
										} else {
											$(this).show();
										}
									}

								});
							});

					// 디자이너 초성 선택(ENG)
					$(".designer .lang_wrap .eng .lang_list li").on(
							"click",
							function() {
								var target = $(this).data('value');
								$(".designer .lang_wrap .eng .lang_list li")
										.removeClass("active");
								$(this).addClass("active");
								// var brand = $(".searchMenuContent
								// .searchBrand .active").data('value');
								$(".designerSub .subCate li").each(function(i) {
									var cho = $(this).data('cho');
									var value = $(this).data('value');

									if (target !== "ETC" && target !== "ALL") {
										if (target === cho) {
											$(this).show();
										} else {
											$(this).hide();
										}
									} else if (target === "ALL") {
										$(".designerSub .subCate li").show();
									} else {
										var choType = /^[ㄱ-ㅎa-zA-Z]+$/;
										if (choType.test(cho)) { // 한글/영문이
											// 아닌경우
											$(this).hide();
										} else {
											$(this).show();
										}
									}

								});
							});

					// 프리미엄 초성 선택(KOR)
					$(".premium .lang_wrap .kor .lang_list li").on(
							"click",
							function() {
								var target = $(this).data('value');
								$(".premium .lang_wrap .kor .lang_list li")
										.removeClass("active");
								$(this).addClass("active");
								// var brand = $(".searchMenuContent
								// .searchBrand .active").data('value');
								$(".premiumSub .subCate li").each(function(i) {
									var cho = $(this).data('cho');
									var value = $(this).data('value');

									if (target !== "ETC" && target !== "ALL") {
										if (target === cho) {
											$(this).show();
										} else {
											$(this).hide();
										}
									} else if (target === "ALL") {
										$(".premiumSub .subCate li").show();
									} else {
										var choType = /^[ㄱ-ㅎa-zA-Z]+$/;
										if (choType.test(cho)) { // 한글/영문이
											// 아닌경우
											$(this).hide();
										} else {
											$(this).show();
										}
									}

								});
							});

					// 프리미엄 초성 선택(ENG)
					$(".premium .lang_wrap .eng .lang_list li").on(
							"click",
							function() {
								var target = $(this).data('value');
								$(".premium .lang_wrap .eng .lang_list li")
										.removeClass("active");
								$(this).addClass("active");
								// var brand = $(".searchMenuContent
								// .searchBrand .active").data('value');
								$(".premiumSub .subCate li").each(function(i) {
									var cho = $(this).data('cho');
									var value = $(this).data('value');

									if (target !== "ETC" && target !== "ALL") {
										if (target === cho) {
											$(this).show();
										} else {
											$(this).hide();
										}
									} else if (target === "ALL") {
										$(".premiumSub .subCate li").show();
									} else {
										var choType = /^[ㄱ-ㅎa-zA-Z]+$/;
										if (choType.test(cho)) { // 한글/영문이
											// 아닌경우
											$(this).hide();
										} else {
											$(this).show();
										}
									}

								});
							});

					// 상세검색 닫기
					$(".blank_title .close").on("click", function(e) {

						$(".wrap").show();
						$(".unified_search_wrap").show();
						$(".blank_container").hide();
						$("#detailBtn").removeClass("fixed");

						displayOptionView();

					});
					/*
					 * //카테고리/브랜드/프리미엄/스토어/디자이너 선택 $(".tab_content_wrap
					 * .tab_result_list li").on("click", function(){ if(
					 * $(this).find("input").length > 0){
					 * if($(this).find("input").is(":checked")){
					 * $(this).find("input").prop("checked",false); }else{
					 * $(this).find("input").prop("checked",true); } }
					 * displayOptionChkView(); });
					 */

					/*
					 * $(".tab_content_wrap .tab_result_list
					 * .cate_title").on("click", function(){
					 * $(this).parent().toggleClass('active');
					 * displayOptionChkView(); }); $(".tab_content_wrap
					 * .tab_result_list .scate li").on("click", function(){
					 * $(this).toggleClass('active'); displayOptionChkView();
					 * });
					 */

					// 초기화
					$(".blank_content_wrap .btnArea .ty01").on(
							"click",
							function() {

								$("#searchStartPrice").val("");
								$("#searchEndPrice").val("");
								$("#searchDetail").find(
										"input[name='searchMcate']").remove();
								$("#searchDetail").find(
										"input[name='searchScate']").remove();

								$(".tab_content_wrap .tab_result_list input")
										.each(function(i) {
											$(this).prop("checked", false);
										});
								$(".tab_content_wrap .tab_result_list li")
										.removeClass('active');
								$("#searchDetail").submit();
							});

					// 상세검색
					$(".blank_content_wrap .btnArea .ty02")
							.on(
									"click",
									function() {
										var startPrice = Number($(
												"#searchStartPrice").val()
												.replace(/,/g, ""));
										var endPrice = Number($(
												"#searchEndPrice").val()
												.replace(/,/g, ""));
										if (startPrice <= endPrice) {
											$("#searchDetail")
													.find(
															"input[name='searchMcate']")
													.remove();
											$("#searchDetail")
													.find(
															"input[name='searchScate']")
													.remove();
											$(
													".tab_content_wrap .tab_result_list .active")
													.each(
															function(i) {
																var livalue = $(
																		this)
																		.data(
																				"value");
																var livalueArr = livalue
																		.split(">");

																var mformList = $("<input type='hidden' name='searchMcate'></input>");
																var sformList = $("<input type='hidden' name='searchScate'></input>");
																if (livalueArr.length > 2) {
																	sformList
																			.val(livalue);
																	$(
																			"#searchDetail")
																			.append(
																					sformList);
																} else {
																	mformList
																			.val(livalue);
																	$(
																			"#searchDetail")
																			.append(
																					mformList);
																}
															});

											$("#searchDetail").submit();
										} else {
											alert("가격의 조건이 올바르지 않습니다.");
											return false;
										}
										return true;
									});

					// 상세검색 조건 검색
					$("body")
							.on(
									"click",
									".option_list a",
									function(e) {
										var type = $(this).parent()
												.data("type");
										var value = $(this).parent().data(
												"value");

										if (type === "benefit") {
											$("#searchStartPrice").val("");
											$("#searchEndPrice").val("");
											$("#searchDetail")
													.find(
															"input[name='searchMcate']")
													.remove();
											$("#searchDetail")
													.find(
															"input[name='searchScate']")
													.remove();
											$(
													".tab_content_wrap .tab_result_list input:checked")
													.each(
															function(i) {
																$(this)
																		.prop(
																				"checked",
																				false);
															});
										} else if (type === "price") {
											$("#searchBenefitDetail").val("");
											$("#searchDetail")
													.find(
															"input[name='searchMcate']")
													.remove();
											$("#searchDetail")
													.find(
															"input[name='searchScate']")
													.remove();
											$(
													".tab_content_wrap .tab_result_list input:checked")
													.each(
															function(i) {
																$(this)
																		.prop(
																				"checked",
																				false);
															});
										} else if (type === "mcate") {
											$("#searchBenefitDetail").val("");
											$("#searchStartPrice").val("");
											$("#searchEndPrice").val("");
											$("#searchDetail")
													.find(
															"input[name='searchScate']")
													.remove();
											$("#searchDetail")
													.find(
															"input[name='searchMcate']")
													.each(
															function(i) {
																if (value !== $(
																		this)
																		.val()) {
																	$(this)
																			.remove();
																}
															});
											$(
													".tab_content_wrap .tab_result_list input:checked")
													.each(
															function(i) {
																$(this)
																		.prop(
																				"checked",
																				false);
															});
										} else if (type === "scate") {
											$("#searchBenefitDetail").val("");
											$("#searchStartPrice").val("");
											$("#searchEndPrice").val("");
											$("#searchDetail")
													.find(
															"input[name='searchMcate']")
													.remove();
											$("#searchDetail")
													.find(
															"input[name='searchScate']")
													.each(
															function(i) {
																if (value !== $(
																		this)
																		.val()) {
																	$(this)
																			.remove();
																}
															});
											$(
													".tab_content_wrap .tab_result_list input:checked")
													.each(
															function(i) {
																$(this)
																		.prop(
																				"checked",
																				false);
															});
										} else {
											$("#searchBenefitDetail").val("");
											$("#searchStartPrice").val("");
											$("#searchEndPrice").val("");
											$("#searchDetail")
													.find(
															"input[name='searchMcate']")
													.remove();
											$("#searchDetail")
													.find(
															"input[name='searchScate']")
													.remove();
											$(
													".tab_content_wrap .tab_result_list input:checked")
													.each(
															function(i) {
																var t = $(this)
																		.data(
																				"type");
																var v = $(this)
																		.val();

																if (!(type === t && value === v)) {
																	$(this)
																			.prop(
																					"checked",
																					false);
																}
															});
										}
										$("#searchDetail").submit();
									});

					// 상세검색 조건 노출 삭제
					$("body")
							.on(
									"click",
									".option_list .del",
									function(e) {
										var type = $(this).parent()
												.data("type");
										var value = $(this).parent().data(
												"value");
										if (type === "benefit") {
											$("#searchBenefitDetail").val("");
										} else if (type === "price") {
											$("#searchStartPrice").val("");
											$("#searchEndPrice").val("");
										} else if (type === "mcate") {
											$("#searchDetail")
													.find(
															"input[name='searchMcate']")
													.each(
															function(i) {
																if (value === $(
																		this)
																		.val()) {
																	$(this)
																			.remove();
																}
															});
										} else if (type === "scate") {
											$("#searchDetail")
													.find(
															"input[name='searchScate']")
													.each(
															function(i) {
																if (value === $(
																		this)
																		.val()) {
																	$(this)
																			.remove();
																}
															});
										} else {

											$(
													".tab_content_wrap .tab_result_list input:checked")
													.each(
															function(i) {
																var t = $(this)
																		.data(
																				"type");
																var v = $(this)
																		.val();

																if (type === t
																		&& value === v) {
																	$(this)
																			.prop(
																					"checked",
																					false);
																}
															});
										}
										$("#searchDetail").submit();

									});
					$("body")
							.on(
									"click",
									".prd_area .prd_box a",
									function(e) {
										var id = $(this).data("id");
										location.href = "/goods/indexGoodsDetail?goodsId="
												+ id;
									});

					// 전체,스토어,디자이너,프리미엄 ui효과
					$(".searchList .menuList").click(
							function() {
								$(this).addClass("active")
										.siblings(".menuList").removeClass(
												"active");

								var sortvalue = $(this).val();
							});

					// 가격대버튼 클릭
					$("body")
							.on(
									"click",
									".price_btn",
									function(e) {
										if ($(".search_price_content").css(
												"display") === "none") {
											$(".search_price_content").show();
										} else {
											$(".search_price_content").hide();
										}
									});

					// 가격대버튼 외부클릭처리
					$('body')
							.click(
									function(e) {
										if ($(".search_price_content").css(
												"display") === "block") {
											if (!$(".search_price_wrap").has(
													e.target).length) {
												$(".search_price_content")
														.hide();
											}
										}
									});

					// 가격대버튼 가격범위버튼 클릭
					$("body")
							.on(
									"click",
									".price_in_btn",
									function(e) {
										$("#searchStartPrice").val('');
										$("#searchEndPrice").val('');

										$("#dd").attr("checked", false);

										if ($(this).attr("class") === "price_in_btn active") {
											$(this).removeClass("active");
										} else if ($(this).attr("class") === "price_in_btn  active") {
											$(this).removeClass("active");
										} else {
											$(this).addClass("active");
										}
									});

					// 가격대버튼 직접입력 체크박스 클릭시
					$("body").on("click", "#dd", function(e) {
						$(".price_box .price_in_btn").removeClass("active");
					});

					// 가격대버튼 적용버튼 클릭시
					$("body")
							.on(
									"click",
									".search_direct_btn",
									function(e) {
										if ($("#dd").is(":checked")) {
											// var startPrice2 =
											// number_format($("#searchStartPrice").val());
											// var endPrice2 =
											// number_format($("#searchEndPrice").val());
											var startPrc = Number($(
													"#searchStartPrice").val()
													.replace(/,/g, ""));
											var endPrc = Number($(
													"#searchEndPrice").val()
													.replace(/,/g, ""));

											var target = $(".keyword_wrap");
											var text = "";

											if (startPrc <= endPrc) {
												$("#searchStartPriceDetail")
														.val(startPrc);
												$("#searchEndPriceDetail").val(
														endPrc);
												$("#searchDetail")
														.find(
																"input[name='buttonPrice']")
														.remove();
												$(".price_box .price_in_btn")
														.removeClass("active");

												$(".keyword_wrap #allReset")
														.each(function(i) {
															$(this).remove();
														});

												$(".keyword_wrap span")
														.each(
																function(i) {
																	if ($(this)
																			.data(
																					"type") === "price") {
																		$(this)
																				.remove();
																	}
																});

												text += "<span id=\"soloReset\" data-type=\"price\" data-value=\""
														+ startPrc
														+ "~"
														+ endPrc
														+ "\" class=\"word\">"
														+ startPrc
														+ "~"
														+ endPrc
														+ "<button type=\"button\" class=\"close\" style=\"outline:none\"><span>닫기</span></button></span>";
												text += "<button type=\"button\" id=\"allReset\" class=\"close\" style=\"outline:none\">초기화<span>닫기</span></button>";

												target.append(text.trim());
												if (target.html() === "") {
													$(".keyword_wrap").hide();
												} else {
													$(".keyword_wrap").show();
												}
												$(".search_price_wrap").hide();
												ajaxShopList("1");
												return false;
												// displayDetailTotal();

												// $("#searchMove").submit();
											} else {
												alert("가격의 조건이 올바르지 않습니다.");
												return false;
											}
										} else if ($(".price_box").find(
												".active").length > 0) {
											$("#searchDetail")
													.find(
															"input[name='buttonPrice']")
													.remove();
											$("#searchStartPriceDetail")
													.val('');
											$("#searchEndPriceDetail").val('');
											$(".price_box .active")
													.each(
															function(i) {
																var btnvalue = $(
																		this)
																		.val();
																var btnList = $("<input type='hidden' name='buttonPrice'></input>");
																btnList
																		.val(btnvalue);
																$(
																		"#searchDetail")
																		.append(
																				btnList);
															});
											$(".search_price_wrap").hide();
											ajaxShopList("1");
											return false;
											// displayDetailTotal();

											// $("#searchDetail").submit();
										} else {
											alert("선택한 값이 없습니다");
											return false;
										}
									});

					// 가격대버튼 선택해제 클릭시
					$("body").on("click", "#prc_btn_cancle", function(e) {
						$("#dd").attr("checked", false);
						$(".price_box .price_in_btn").removeClass("active");
						$("#searchStartPrice").val('');
						$("#searchEndPrice").val('');
						return false;
					});

					// 브랜드ㄱㄴㄷ순
					$("#korBrand").click(function() {
						$("#korBrandDisplay").show();
						$("#engBrandDisplay").hide();
					});

					// 브랜드ABC순
					$("#engBrand").click(function() {
						$("#korBrandDisplay").hide();
						$("#engBrandDisplay").show();
					});

					// 브랜드ㄱㄴㄷ순(style DCG)
					$("#korBrand2").click(function() {
						$("#korBrandDisplay2").show();
						$("#engBrandDisplay2").hide();
					});

					// 브랜드ABC순(style DCG)
					$("#engBrand2").click(function() {
						$("#korBrandDisplay2").hide();
						$("#engBrandDisplay2").show();
					});

					// 스토어ㄱㄴㄷ순
					$("#korStr").click(function() {
						$("#korStrDisplay").show();
						$("#engStrDisplay").hide();
					});

					// 스토어ABC순
					$("#engStr").click(function() {
						$("#korStrDisplay").hide();
						$("#engStrDisplay").show();
					});

					// 디자이너ㄱㄴㄷ순
					$("#korDsr").click(function() {
						$("#korDsrDisplay").show();
						$("#engDsrDisplay").hide();
					});

					// 디자이너ABC순
					$("#engDsr").click(function() {
						$("#korDsrDisplay").hide();
						$("#engDsrDisplay").show();
					});

					// 프리미엄ㄱㄴㄷ순
					$("#korPri").click(function() {
						$("#korPriDisplay").show();
						$("#engPriDisplay").hide();
					});

					// 프리미엄ABC순
					$("#engPri").click(function() {
						$("#korPriDisplay").hide();
						$("#engPriDisplay").show();
					});

					// 중카테고리 클릭시 검색!
					$(".categorySub .subCate :checkbox")
							.on(
									"click",
									function() {
										if ($(this).prop("checked") === true) {
											var ChkVal = $(this).data("value");
											$("#sCateShow").val(ChkVal);
										} else {
											$("#sCateShow").val('');
										}

										var type = $(this).parent()
												.data("type");
										var avalue = $(this).parent().data(
												"value");
										var target = $(".keyword_wrap");
										var text = "";

										$(".keyword_wrap span").each(
												function(i) {
													var ovalue = $(this).data(
															"value");
													if (avalue === ovalue) {
														$(this).remove();
													}
												});

										if (type === "M") {
											if ($(this).is(":checked") === true) {
												$(".keyword_wrap #allReset")
														.each(function(i) {
															$(this).remove();
														});

												var valueArr = avalue
														.split(">");
												text += "<span data-type=\"M\" id=\"soloReset\" data-value=\""
														+ avalue
														+ "\" class=\"word\">"
														+ valueArr[1]
														+ "<button type=\"button\" class=\"close\" style=\"outline:none\"><span>닫기</span></button></span>";
												text += "<button type=\"button\" id=\"allReset\" class=\"close\" style=\"outline:none\">초기화<span>닫기</span></button>";
											}
										}

										target.append(text.trim());

										if ($("#soloReset").length === 0) {
											$(".keyword_wrap").html("");
											$(".keyword_wrap").hide();
										} else {
											$(".keyword_wrap").show();
										}

										// displayDetailTotal();
										ajaxShopList("1");
										// $("#searchDetail").submit();
									});

					// 소카테고리 클릭시 검색!
					$(".lastCate_wrap .lastCate :checkbox")
							.click(
									function() {
										if ($(this).prop("checked") === true) {
											var ChkVal = $(this).data("value");
											$("#sCateShow").val(ChkVal);
										} else {
											$("#sCateShow").val('');
										}

										var type = $(this).parent()
												.data("type");
										var avalue = $(this).parent().data(
												"value");
										var target = $(".keyword_wrap");
										var text = "";

										$(".keyword_wrap span").each(
												function(i) {
													var ovalue = $(this).data(
															"value");
													if (avalue === ovalue) {
														$(this).remove();
													}
												});

										if (type === "S") {
											if ($(this).is(":checked") === true) {
												$(".keyword_wrap #allReset")
														.each(function(i) {
															$(this).remove();
														});

												var valueArr = avalue
														.split(">");
												text += "<span data-type=\"S\" id=\"soloReset\" data-value=\""
														+ avalue
														+ "\" class=\"word\">"
														+ valueArr[2]
														+ "<button type=\"button\" class=\"close\" style=\"outline:none\"><span>닫기</span></button></span>";
												text += "<button type=\"button\" id=\"allReset\" class=\"close\" style=\"outline:none\">초기화<span>닫기</span></button>";
											}
										}

										target.append(text.trim());
										if ($("#soloReset").length === 0) {
											$(".keyword_wrap").html("");
											$(".keyword_wrap").hide();
										} else {
											$(".keyword_wrap").show();
										}

										// displayDetailTotal();
										ajaxShopList("1");
										// $("#searchDetail").submit();
									});

					// 브랜드 클릭시 검색!
					$(".brandSubResult .subCate li")
							.on(
									"click",
									function() {

										var type = $(this).children().data(
												"type");
										var avalue = $(this).children().data(
												"value");
										var target = $(".keyword_wrap");
										var text = "";

										$(".keyword_wrap span").each(
												function(i) {
													var ovalue = $(this).data(
															"value");
													if (avalue === ovalue) {
														$(this).remove();
													}
												});

										if (type === "brand") {
											if ($(this).children().is(
													":checked") === true) {
												$(".keyword_wrap #allReset")
														.each(function(i) {
															$(this).remove();
														});

												var valueArr = avalue
														.split("$");
												text += "<span id=\"soloReset\" data-type=\"brand\" data-value=\""
														+ avalue
														+ "\" class=\"word\">"
														+ valueArr[1]
														+ "<button type=\"button\" class=\"close\" style=\"outline:none\"><span>닫기</span></button></span>";
												text += "<button type=\"button\" id=\"allReset\" class=\"close\" style=\"outline:none\">초기화<span>닫기</span></button>";
											}
										}
										target.append(text.trim());
										if ($("#soloReset").length === 0) {
											$(".keyword_wrap").html("");
											$(".keyword_wrap").hide();
										} else {
											$(".keyword_wrap").show();
										}

										// displayDetailTotal();
										ajaxShopList("1");
										// $("#searchDetail").submit();
									});

					// 스토어 클릭시 검색!
					$(".storeSub .subCate li")
							.on(
									"click",
									function() {

										var type = $(this).children().data(
												"type");
										var avalue = $(this).children().data(
												"value");
										var target = $(".keyword_wrap");
										var text = "";

										$(".keyword_wrap span").each(
												function(i) {
													var ovalue = $(this).data(
															"value");
													if (avalue === ovalue) {
														$(this).remove();
													}
												});

										if (type === "store") {
											if ($(this).children().is(
													":checked") === true) {
												$(".keyword_wrap #allReset")
														.each(function(i) {
															$(this).remove();
														});

												var valueArr = avalue
														.split("$");
												text += "<span id=\"soloReset\" data-type=\"store\" data-value=\""
														+ avalue
														+ "\" class=\"word\">"
														+ valueArr[0]
														+ "<button type=\"button\" class=\"close\" style=\"outline:none\"><span>닫기</span></button></span>";
												text += "<button type=\"button\" id=\"allReset\" class=\"close\" style=\"outline:none\">초기화<span>닫기</span></button>";
											}
										}

										target.append(text.trim());
										if ($("#soloReset").length === 0) {
											$(".keyword_wrap").html("");
											$(".keyword_wrap").hide();
										} else {
											$(".keyword_wrap").show();
										}

										// displayDetailTotal();
										ajaxShopList("1");
										// $("#searchDetail").submit();
									});

					// 디자이너 클릭시 검색!
					$("#searchDesignerSub .designerLi")
							.on(
									"click",
									function(e) {
										e.stopPropagation();
										var type = $(this).children().data(
												"type");
										var avalue = $(this).children().data(
												"value");
										var target = $(".keyword_wrap");
										var text = "";

										if (type === "designer") {
											if ($(this).children().is(
													":checked") === true) {
												$(".keyword_wrap #allReset")
														.remove();
												var valueArr = avalue
														.split("$");
												text += "<span id=\"soloReset\" data-type=\"designer\" data-value=\""
														+ avalue
														+ "\" class=\"word\">"
														+ valueArr[0]
														+ "<button type=\"button\" class=\"close\" style=\"outline:none\"><span>닫기</span></button></span>";
												text += "<button type=\"button\" id=\"allReset\" class=\"close\" style=\"outline:none\">초기화<span>닫기</span></button>";
											} else {
												$(".keyword_wrap span")
														.each(
																function(i) {
																	var ovalue = $(
																			this)
																			.data(
																					"value");
																	if (avalue === ovalue) {
																		$(this)
																				.remove();
																	}
																});
											}
										}

										target.append(text.trim());
										if ($("#soloReset").length === 0) {
											$(".keyword_wrap").html("");
											$(".keyword_wrap").hide();
										} else {
											$(".keyword_wrap").show();
										}

										// displayDetailTotal();
										ajaxShopList("1");
										// $("#searchDetail").submit();
									});

					// 프리미엄 클릭시 검색!
					$(".premiumSub .subCate li")
							.on(
									"click",
									function() {

										var type = $(this).children().data(
												"type");
										var avalue = $(this).children().data(
												"value");
										var target = $(".keyword_wrap");
										var text = "";

										$(".keyword_wrap span").each(
												function(i) {
													var ovalue = $(this).data(
															"value");
													if (avalue === ovalue) {
														$(this).remove();
													}
												});

										if (type === "premium") {
											if ($(this).children().is(
													":checked") === true) {
												$(".keyword_wrap #allReset")
														.each(function(i) {
															$(this).remove();
														});

												var valueArr = avalue
														.split("$");
												text += "<span id=\"soloReset\" data-type=\"premium\" data-value=\""
														+ avalue
														+ "\" class=\"word\">"
														+ valueArr[0]
														+ "<button type=\"button\" class=\"close\" style=\"outline:none\"><span>닫기</span></button></span>";
												text += "<button type=\"button\" id=\"allReset\" class=\"close\" style=\"outline:none\">초기화<span>닫기</span></button>";
											}
										}

										target.append(text.trim());
										if ($("#soloReset").length === 0) {
											$(".keyword_wrap").html("");
											$(".keyword_wrap").hide();
										} else {
											$(".keyword_wrap").show();
										}

										// displayDetailTotal();
										ajaxShopList("1");
										// $("#searchDetail").submit();
									});

					// 혜택 체크박스 클릭

					$("body")
							.on(
									"click",
									".search_sort .sort_condition .searchBenefit :checkbox",
									function(e) {
										var type = $(this).data("type");
										var avalue = $(this).data("value");
										var target = $(".keyword_wrap");
										var text = "";
										var benefit = "";
										if ($(this).is(":checked") === true) {
											$(".keyword_wrap #allReset").each(
													function(i) {
														$(this).remove();
													});

											if (avalue === "deal")
												benefit = "딜";
											else if (avalue === "free")
												benefit = "무료배송";
											else if (avalue === "coupon")
												benefit = "쿠폰";
											text += "<span id=\"soloReset\" data-type=\"benefit\" data-value=\""
													+ avalue
													+ "\" class=\"word\">"
													+ benefit
													+ "<button type=\"button\" class=\"close\" style=\"outline:none\"><span>닫기</span></button></span>";
											text += "<button type=\"button\" id=\"allReset\" class=\"close\" style=\"outline:none\">초기화<span>닫기</span></button>";
										} else {
											$(".keyword_wrap span").each(
													function(i) {
														var ovalue = $(this)
																.data("value");
														if (avalue === ovalue) {
															$(this).remove();
														}
													});
										}

										target.append(text.trim());
										if ($("#soloReset").length === 0) {
											$(".keyword_wrap").html("");
											$(".keyword_wrap").hide();
										} else {
											$(".keyword_wrap").show();
										}

										ajaxShopList("1");

									});

					// 히스토리 선택 초기화버튼
					$("body")
							.on(
									"click",
									".word .close",
									function(e) {
										var cvalue = $(this).parent().data(
												"value");
										var ctype = $(this).parent().data(
												"type");

										if (ctype === "M" || ctype === "S") {
											cvalue = cvalue.replace(/\$/g, ">");
										}
										$(".keyword_wrap span")
												.each(
														function(i) {
															var t = $(this)
																	.data(
																			"type");
															var v = $(this)
																	.data(
																			"value");
															if (t === "M"
																	|| t === "S") {
																v = $(this)
																		.data(
																				"value")
																		.replace(
																				/\$/g,
																				">");
															}
															if (ctype === t
																	&& cvalue === v) {
																$(this)
																		.remove();
															}
														});

										if (ctype === "benefit") {
											$(
													".search_sort .sort_condition .searchBenefit input:checked")
													.each(
															function(i) {
																var v = $(this)
																		.data(
																				"value");
																if (cvalue === v) {
																	$(this)
																			.prop(
																					"checked",
																					false);
																}
															});
										} else if (ctype === "price") {
											$("#searchStartPriceDetail")
													.val("");
											$("#searchEndPriceDetail").val("");

											$(".price_box button").each(
													function(i) {
														$(this).removeClass(
																"active");
													});

											$("#searchStartPrice").val(
													$("#resultStartPriceMove")
															.val());
											$("#searchEndPrice").val(
													$("#resultEndPriceMove")
															.val());

										} else if (ctype === "M") {
											$(
													".categorySub .subCate input:checked")
													.each(
															function(i) {
																var t = $(this)
																		.data(
																				"type");
																var v = $(this)
																		.val();
																if (ctype === t
																		&& cvalue === v) {
																	$(this)
																			.prop(
																					"checked",
																					false);
																}
															});
										} else if (ctype === "S") {
											$(
													".lastCate_wrap .lastCate input:checked")
													.each(
															function(i) {
																var t = $(this)
																		.data(
																				"type");
																var v = $(this)
																		.val();
																if (ctype === t
																		&& cvalue === v) {
																	$(this)
																			.prop(
																					"checked",
																					false);
																}
															});
										} else {
											$(
													".searchMenuContainer .subCate input:checked")
													.each(
															function(i) {
																var t = $(this)
																		.data(
																				"type");
																var v = $(this)
																		.val();
																if (ctype === t
																		&& cvalue === v) {
																	$(this)
																			.prop(
																					"checked",
																					false);
																}
															});
										}

										if ($("#soloReset").length === 0) {
											$(".keyword_wrap").html("");
											$(".keyword_wrap").hide();
										} else {
											$(".keyword_wrap").show();
										}

										ajaxShopList("1");
									});

					// 히스토리 전체 초기화버튼
					$("body")
							.on(
									"click",
									"#allReset",
									function(e) {

										$(".keyword_wrap").html("");
										$(".keyword_wrap").hide();

										// 혜택초기화
										$(
												".search_sort .sort_condition .searchBenefit input:checked")
												.each(
														function(i) {
															$(this).prop(
																	"checked",
																	false);
														});

										// 가격초기화
										$("#searchStartPriceDetail").val("");
										$("#searchEndPriceDetail").val("");
										$("#searchStartPrice").val(
												$("#resultStartPriceMove")
														.val());
										$("#searchEndPrice").val(
												$("#resultEndPriceMove").val());

										$(".price_box button").each(
												function(i) {
													$(this).removeClass(
															"active");
												});

										// 중카테초기화
										$(".categorySub .subCate input:checked")
												.each(
														function(i) {
															$(this).prop(
																	"checked",
																	false);
														});

										// 소카테초기화
										$(
												".lastCate_wrap .lastCate input:checked")
												.each(
														function(i) {
															$(this).prop(
																	"checked",
																	false);
														});

										// 브랜드/스토어/프리미엄/디자이너 초기화
										$(
												".searchMenuContainer .subCate input:checked")
												.each(
														function(i) {
															$(this).prop(
																	"checked",
																	false);
														});

										$("#sCateShowMove").val('');

										ajaxShopList("1");
										// $("#searchMove").submit();

									});

					// 메뉴탭 클릭시 active 값 기억해줌
					$(".search_menu_box .searchMenu li").on("click",
							function() {
								var active = $(this).data('value');

								$("#menuActive").val(active);
								$("#menuActiveMove").val(active);

							});

				});

/* 페이지네비 */
function movePage(num) {
	// $("#pageNumberMove").val(num);
	// $("#searchMove").submit();
	ajaxShopList(num);
}

/* 카테고리 SelectBox */
function cateChange(val) {
	$("#searchCategoryDetail").val(val);

	ajaxShopList("1");
	/*
	 * $("#searchMove input[name='searchType']").val(""); $("#searchMove
	 * input[name='pageNumber']").val("1"); $("#searchMove").submit();
	 */
}

/*
 * 혜택선택 SelectBox* 모바일/ function benefitChange(val){
 * //$("#searchBenefitMove").val(val); $("#searchMove
 * input[name='searchType']").val(""); $("#searchMove
 * input[name='pageNumber']").val("1"); $("#searchMove").submit(); }
 *
 * /*정렬순서 SelectBox
 */
function sortChange(val) {
	$("#searchSort").val(val);
	ajaxShopList("1");
}

/* 페이지크기 SelectBox */
function pageChange(val) {
	$("#searchDisplayDetail").val(val);
	ajaxShopList("1");
}

/* 재검색 버튼적용 */
function goReSearch() {
	var search = $("#research").val();
	if (search !== "") {
		$("#researchQueryDetail").val(search);
		$("#searchStartPrice").val('');
		$("#searchEndPrice").val('');
		$("#searchType").val('');
		$("#searchDetail").submit();
	} else {
		alert("검색어를 입력해주세요.");
		$("#research").focus();
		return false;
	}
	return true;

}

/* 가격 버튼적용 */
function goPriceSearch() {

	var startPrice = Number($("#searchStartPrice").val().replace(/,/g, ""));
	var endPrice = Number($("#searchEndPrice").val().replace(/,/g, ""));
	if (startPrice <= endPrice) {
		$("#searchDetail").find("input[name='searchMcate']").remove();
		$("#searchDetail").find("input[name='searchScate']").remove();

		$(".tab_content_wrap .tab_result_list input").each(function(i) {
			$(this).prop("checked", false);
		});
		$("#searchDetail").submit();
	} else {
		alert("가격의 조건이 올바르지 않습니다.");
		return false;
	}
	return true;
}

/*
 * 상세검색 선택 시 노출
 */
function displayOptionChkView() {
	var target = $(".option_list");
	var text = "";

	var startPrice = $("#searchStartPriceMove").val().replace(/,/g, "");
	var endPrice = $("#searchEndPriceMove").val().replace(/,/g, "");

	if ($("#searchBenefitDetail").val() !== "") {
		var benefit = "";
		if ($("#searchBenefitDetail").val() === "deal")
			benefit = "딜";
		else if ($("#searchBenefitDetail").val() === "free")
			benefit = "무료배송";
		else if ($("#searchBenefitDetail").val() === "coupon")
			benefit = "쿠폰";

		text += "<li data-type=\"benefit\" data-value=\"benefit\"><a href=\"#\">"
				+ benefit
				+ "</a><button type=\"button\" class=\"del close\"><span>삭제</span></button></li>";
	}

	if (startPrice !== ""
			&& endPrice !== ""
			&& (startPrice !== $("#resultStartPriceMove").val() || endPrice !== $(
					"#resultEndPriceMove").val())) {
		text += "<li data-type=\"price\" data-value=\"price\"><a href=\"#\">"
				+ $("#searchStartPriceMove").val()
				+ "~"
				+ $("#searchEndPriceMove").val()
				+ "</a><button type=\"button\" class=\"del close\"><span>삭제</span></button></li>";
	}

	$(".tab_content_wrap .tab_result_list input:checked")
			.each(
					function(i) {
						var value = $(this).val().split("$");
						var type = $(this).data("type");
						var name = value[0];
						if (value.length > 2) {
							name = value[1];
						}
						text += "<li data-type=\""
								+ type
								+ "\" data-value=\""
								+ $(this).val()
								+ "\"><a href=\"#\">"
								+ name
								+ "</a><button type=\"button\" class=\"del close\"><span>삭제</span></button></li>";
					});
	$(".tab_content_wrap .tab_result_list .active")
			.each(
					function(i) {
						var value = $(this).data("value").split(">");
						var name = value[1];
						var type = "mcate";
						if (value.length > 2) {
							name = value[2];
							type = "scate";
						}
						text += "<li data-type=\""
								+ type
								+ "\" data-value=\""
								+ $(this).data("value")
								+ "\"><a href=\"#\">"
								+ name
								+ "</a><button type=\"button\" class=\"del close\"><span>삭제</span></button></li>";
					});

	target.html(text);
}

/*
 * 상세검색 조건 노출
 */
function displayOptionView() {
	var target = $(".option_list");
	var text = "";
	var startPrice = $("#searchStartPriceMove").val().replace(/,/g, "");
	var endPrice = $("#searchEndPriceMove").val().replace(/,/g, "");

	if ($("#searchBenefitMove").val() !== "") {
		var benefit = "";
		if ($("#searchBenefitMove").val() === "deal")
			benefit = "딜";
		else if ($("#searchBenefitMove").val() === "free")
			benefit = "무료배송";
		else if ($("#searchBenefitMove").val() === "coupon")
			benefit = "쿠폰";

		text += "<li data-type=\"benefit\" data-value=\"benefit\"><a href=\"#\">"
				+ benefit
				+ "</a><button type=\"button\" class=\"del close\"><span>삭제</span></button></li>";
	}

	if (startPrice !== ""
			&& endPrice !== ""
			&& (startPrice !== $("#resultStartPriceMove").val() || endPrice !== $(
					"#resultEndPriceMove").val())) {
		text += "<li data-type=\"price\" data-value=\"price\"><a href=\"#\">"
				+ $("#searchStartPriceMove").val()
				+ "~"
				+ $("#searchEndPriceMove").val()
				+ "</a><button type=\"button\" class=\"del close\"><span>삭제</span></button></li>";
	}
	$("#searchMove")
			.find("input[name='searchMcate']")
			.each(
					function(i) {
						var value = $(this).val().split(">");
						text += "<li data-type=\"mcate\" data-value=\""
								+ $(this).val()
								+ "\"><a href=\"#\">"
								+ value[1]
								+ "</a><button type=\"button\" class=\"del close\"><span>삭제</span></button></li>";
					});
	$("#searchMove")
			.find("input[name='searchScate']")
			.each(
					function(i) {
						var value = $(this).val().split(">");
						text += "<li data-type=\"scate\" data-value=\""
								+ $(this).val()
								+ "\"><a href=\"#\">"
								+ value[2]
								+ "</a><button type=\"button\" class=\"del close\"><span>삭제</span></button></li>";
					});
	$("#searchMove")
			.find("input[name='searchBrand']")
			.each(
					function(i) {
						var value = $(this).val().split("$");
						text += "<li data-type=\"brand\" data-value=\""
								+ $(this).val()
								+ "\"><a href=\"#\">"
								+ value[1]
								+ "</a><button type=\"button\" class=\"del close\"><span>삭제</span></button></li>";
					});
	$("#searchMove")
			.find("input[name='searchPremium']")
			.each(
					function(i) {
						var value = $(this).val().split("$");
						text += "<li data-type=\"premium\" data-value=\""
								+ $(this).val()
								+ "\"><a href=\"#\">"
								+ value[0]
								+ "</a><button type=\"button\" class=\"del close\"><span>삭제</span></button></li>";
					});
	$("#searchMove")
			.find("input[name='searchStore']")
			.each(
					function(i) {
						var value = $(this).val().split("$");
						text += "<li data-type=\"store\" data-value=\""
								+ $(this).val()
								+ "\"><a href=\"#\">"
								+ value[0]
								+ "</a><button type=\"button\" class=\"del close\"><span>삭제</span></button></li>";
					});
	$("#searchMove")
			.find("input[name='searchDesigner']")
			.each(
					function(i) {
						var value = $(this).val().split("$");
						text += "<li data-type=\"designer\" data-value=\""
								+ $(this).val()
								+ "\"><a href=\"#\">"
								+ value[0]
								+ "</a><button type=\"button\" class=\"del close\"><span>삭제</span></button></li>";
					});

	target.html(text);
}

/*
 * 상품 페이지네비게이션
 */
function ajaxShopList(number) {
	$("#searchDetail input[name='pageNumber']").val(number);
	$("#searchDetail input[name='searchType']").val("view");

	$.ajax({
		type : "post",
		url : "/search_new/searchGoodsList",
		dataType : "html",
		data : $("#searchDetail").serialize(),
		async : false,
		beforeSend : function() {
		},
		complete : function() {
		},
		success : function(data) {
			// console.log(data);
			$("#search_list_wrap").html(data);
		},
		error : function(data) {
			console.log("에러입니다" + data);
		},
		afterShow : function(current) {

		}
	});
}

// 필터링한 내용들 보여주는 함수
function displayDetailTotal() {

	var count = 0;
	var text = "";

	// 카테고리
	$(".categorySub .subCate input:checked")
			.each(
					function() {
						text += "<span data-type=\"mcate\" data-value=\""
								+ (this.value)
								+ "\" class=\"word\">"
								+ (this.value)
								+ "<button type=\"button\" class=\"close\" style=\"outline:none\"><span>닫기</span></button></span>";
						count++;
					});

	// 소카테고리
	$(".lastCate_wrap .lastCate input:checked")
			.each(
					function() {
						text += "<span data-type=\"scate\" data-value=\""
								+ (this.value)
								+ "\" class=\"word\">"
								+ (this.value)
								+ "<button type=\"button\" class=\"close\" style=\"outline:none\"><span>닫기</span></button></span>";
						count++;
					});

	// 브랜드
	$(".brandSubResult .subCate input:checked")
			.each(
					function() {
						text += "<span data-type=\"brand\" data-value=\""
								+ (this.value)
								+ "\" class=\"word\">"
								+ (this.value).substring((this.value)
										.indexOf("$") + 1,
										(this.value).length - 2)
								+ "<button type=\"button\" class=\"close\" style=\"outline:none\"><span>닫기</span></button></span>";
						count++;
					});

	// 스토어
	$(".storeSub .subCate input:checked")
			.each(
					function() {
						text += "<span data-type=\"store\" data-value=\""
								+ (this.value)
								+ "\" class=\"word\">"
								+ (this.value).substring(0,
										(this.value).length - 2)
								+ "<button type=\"button\" class=\"close\" style=\"outline:none\"><span>닫기</span></button></span>";
						count++;
					});

	// 디자이너
	$(".designerSub .subCate input:checked")
			.each(
					function() {
						text += "<span data-type=\"designer\" data-value=\""
								+ (this.value)
								+ "\" class=\"word\">"
								+ (this.value).substring(0,
										(this.value).length - 2)
								+ "<button type=\"button\" class=\"close\" style=\"outline:none\"><span>닫기</span></button></span>";
						count++;
					});

	// 프리미엄
	$(".premiumSub .subCate input:checked")
			.each(
					function() {
						text += "<span data-type=\"prmt\" data-value=\""
								+ (this.value)
								+ "\" class=\"word\">"
								+ (this.value).substring(0,
										(this.value).length - 2)
								+ "<button type=\"button\" class=\"close\" style=\"outline:none\"><span>닫기</span></button></span>";
						count++;
					});

	// 혜택(딜,무료배송,쿠폰)
	$(".search_sort .sort_condition .searchBenefit input:checked")
			.each(
					function() {
						text += "<span data-type=\"benefit\" data-value=\""
								+ (this.value)
								+ "\" class=\"word\">"
								+ $(this).data('value')
								+ "<button type=\"button\" class=\"close\" style=\"outline:none\"><span>닫기</span></button></span>";
						count++;
					});

	// 가격범위버튼
	$(".price_box .active")
			.each(
					function() {
						text += "<span data-type=\"prc_Btn\" data-value=\""
								+ (this.value)
								+ "\" class=\"word\">"
								+ (this.value)
								+ "<button type=\"button\" class=\"close\" style=\"outline:none\"><span>닫기</span></button></span>";
						count++;
					});

	// 가격직접입력
	var startPrc = Number($("#searchStartPriceMove").val());
	var endPrc = Number($("#searchEndPriceMove").val());
	text += "<span data-type=\"direct_btn\" data-value=\""
			+ startPrc
			+ "~"
			+ endPrc
			+ "\" class=\"word\">"
			+ startPrc
			+ "~"
			+ endPrc
			+ "<button type=\"button\" class=\"close\" style=\"outline:none\"><span>닫기</span></button></span>";
	count++;

	if (count > 0) {
		text += "<button type=\"button\" id=\"allReset\" class=\"close\" style=\"outline:none\">초기화<span>닫기</span></button>";
	}

	$(".keyword_wrap").html(text);

	if (count === 0) {
		$(".keyword_wrap").hide();
	} else {
		$(".keyword_wrap").show();
	}
}

// 가격대 직접입력시 자동체크 밑 엑티브제거(pc)
function prcAutoChk() {
	// $("#price_in_btn").removeClass("active");
	$(".price_box li button").removeClass("active");
	var startPrc = $("#searchStartPrice").val();
	var endPrc = $("#searchEndPrice").val();
	if (startPrc !== "" || endPrc !== "") {
		$("#dd").prop("checked", true);
	} else {
		$("#dd").prop("checked", false);
	}
}

function goShopView(id) {
	$("#searchDetail #shopView").val("Y");
	var pageNm = $("#pageNumberDetail").val();
	var shopView = $("#searchDetail #shopView").val();
	document.location.hash = "#" + pageNm + "^" + shopView;
	location.href = "/goods/indexGoodsDetail?goodsId=" + id;
}
