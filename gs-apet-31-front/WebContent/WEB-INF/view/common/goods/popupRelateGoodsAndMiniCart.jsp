<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<script type="text/javascript" 	src="/_script/cart/cart.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$(".petTabContent .uiTab a").on("click", function(){
			var id = $(this).data("id");
			if(id == "relate"){
				
			}else{
				cartGoods.reloadMiniCart();
			}
		})
		
	});
	
</script>

<div class="commentBoxAp type01 handHead" data-priceh="100%">
	<div class="head h2 bnone">
		<div class="con">
			<div class="tit">
				댓글 4개
			</div>
			<a href="javascript:;" class="close" onClick="ui.commentBox.close(this)"></a>
		</div>
	</div>
	<div class="con">
		<!-- tab -->
		<section class="sect petTabContent">
			<!-- tab header -->
			<ul class="uiTab b">
				<li class="active">
					<a class="bt" data-id="relate" href="javascript:;" data-content="" data-url="">연관상품</a>
				</li>
				<li class="">
					<a class="bt active" data-id="cart" href="javascript:;" data-content="" data-url="">장바구니</a>
				</li>
			</ul>
			<!-- // tab header -->
			<!-- tab content -->
			<div class="uiTab_content">
				<ul>
					<li>
						<!-- 연관 상품 -->
						<div class="product-area" style="padding:20px 20px 0;">
							<div class="item">
								<div class="img-box">
									<img src="/../_images/tv/@temp01.jpg" alt="">
									<button class="keep">보관하기</button>
									<button class="cart">장바구니</button>
								</div>
								<div class="tit">반려견 습식사료 아미로 후코이단 홀리티 20개 set</div>
								<div class="price">
									<strong class="num">23,000</strong>
									<span>원</span>
									<strong class="discount">10%</strong>
								</div>
							</div>
							<div class="item">
								<div class="img-box">
									<img src="/../_images/tv/@temp01.jpg" alt="">
									<button class="keep">보관하기</button>
									<button class="cart">장바구니</button>
								</div>
								<div class="tit">반려견 습식사료 아미로 후코이단 홀리티 20개 set</div>
								<div class="price">
									<strong class="num">23,000</strong>
									<span>원</span>
									<strong class="discount">10%</strong>
								</div>
							</div>
							<div class="item">
								<div class="img-box">
									<img src="/../_images/tv/@temp01.jpg" alt="">
									<button class="keep">보관하기</button>
									<button class="cart">장바구니</button>
								</div>
								<div class="tit">반려견 습식사료 아미로 후코이단 홀리티 20개 set</div>
								<div class="price">
									<strong class="num">23,000</strong>
									<span>원</span>
									<strong class="discount">10%</strong>
								</div>
							</div>
							<div class="item">
								<div class="img-box">
									<img src="/../_images/tv/@temp01.jpg" alt="">
									<button class="keep">보관하기</button>
									<button class="cart">장바구니</button>
								</div>
								<div class="tit">반려견 습식사료 아미로 후코이단 홀리티 20개 set</div>
								<div class="price">
									<strong class="num">23,000</strong>
									<span>원</span>
									<strong class="discount">10%</strong>
								</div>
							</div>
							<div class="item">
								<div class="img-box">
									<img src="/../_images/tv/@temp01.jpg" alt="">
									<button class="keep">보관하기</button>
									<button class="cart">장바구니</button>
								</div>
								<div class="tit">반려견 습식사료 아미로 후코이단 홀리티 20개 set</div>
								<div class="price">
									<strong class="num">23,000</strong>
									<span>원</span>
									<strong class="discount">10%</strong>
								</div>
							</div>
							<div class="item">
								<div class="img-box">
									<img src="/../_images/tv/@temp01.jpg" alt="">
									<button class="keep">보관하기</button>
									<button class="cart">장바구니</button>
								</div>
								<div class="tit">반려견 습식사료 아미로 후코이단 홀리티 20개 set</div>
								<div class="price">
									<strong class="num">23,000</strong>
									<span>원</span>
									<strong class="discount">10%</strong>
								</div>
							</div>
							<div class="item">
								<div class="img-box">
									<img src="/../_images/tv/@temp01.jpg" alt="">
									<button class="keep">보관하기</button>
									<button class="cart">장바구니</button>
								</div>
								<div class="tit">반려견 습식사료 아미로 후코이단 홀리티 20개 set</div>
								<div class="price">
									<strong class="num">23,000</strong>
									<span>원</span>
									<strong class="discount">10%</strong>
								</div>
							</div>
							<div class="item">
								<div class="img-box">
									<img src="/../_images/tv/@temp01.jpg" alt="">
									<button class="keep">보관하기</button>
									<button class="cart">장바구니</button>
								</div>
								<div class="tit">반려견 습식사료 아미로 후코이단 홀리티 20개 set</div>
								<div class="price">
									<strong class="num">23,000</strong>
									<span>원</span>
									<strong class="discount">10%</strong>
								</div>
							</div>
						</div>
						<!-- // 연관 상품 -->
					</li>
					<li id="miniCart">
					</li>
				</ul>
			</div>
			<!-- // tab content -->
		</section>
		<!-- // tab -->
	</div>
</div>
<!-- //drop pop -->