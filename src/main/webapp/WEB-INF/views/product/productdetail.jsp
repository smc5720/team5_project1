<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<style>
.detail-title {
	padding-left: 0;
	width: 100px;
}

a:hover {
	color: black;
	text-decoration: none;
}
</style>

<div class="container">
	<div class="row">
		<div class="col-6">
			<img src="${productimage1}" alt="" style="width: inherit;"> <img
				src="${productimage2}" alt="" style="width: inherit;"> <img
				src="${productimage3}" alt="" style="width: inherit;">
		</div>
		<div class="col-6">
			<table class="table">
				<tr>
					<td class="border-bottom">
						<h5>${product.bname}</h5>
						<h3>${product.pname}</h3>
						<h5>${product.pprice}원</h5>
						<p>상품번호 : ${product.pcode}</p>
						<div class="bg-light rounded p-3">"${product.pdetail}"</div>
					</td>

				</tr>
				<tr>
					<td class="border-bottom d-flex justify-content-between"><span>더보기</span>
						<span>+</span></td>
				</tr>
				<tr>
					<td class="border-bottom">
						<div>
							<span class="detail-title"><small>한섬마일리지</small></span><span><small>
									${mileage} M (5%)</small></span>
						</div>
						<div>
							<span class="detail-title"><small>H.Point</small></span><span><small>
									${hpoint}P (0.1%)</small></span>
						</div>
						<div>
							<span class="detail-title"><small>배송비</small></span><span><small>
									30,000원 이상 무료배송 (실결제 기준)</small></span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="border-bottom">
						<p>
							<small class="detail-title">색상</small>
							<c:forEach var="color" items="${colors}">
								<a
									href="productdetail?pcode=${product.pcode}&cproductcolor=${color.cproductcolor}">
									<img src="${color.ccolorchipimage}"
									style="margin: 0px 2px; width: 26px; height: 26px;" />
								</a>
							</c:forEach>
						</p>
						<p class="d-inline">
							<small class="detail-title">사이즈</small>
							<c:forEach var="size" items="${sizes}">
								<input type="button" class="btn btn-light btn-sm border"
									onclick="checkStock(this)" value="${size.sproductsize}"></input>
							</c:forEach>
						</p>
						<p>
							<small class="detail-title">수량</small> <input id="product-amount-input"
								class="mb-2 text-center" type="number" size="1"
								style="width: 50px" value="0"
								onchange="changeAmount(this, ${product.pprice})"
								max="0"  min="0"/>
						</p>
						<p id="product-stock-amount">
							
						</p> <script>
							const url = new URL(window.location.href);
							const urlParams = url.searchParams;
							
							function changeAmount(amount, product_price) {
								let tmp = product_price * amount.value;
								tmp += "원";
								$("#product-total-price").html(tmp);
							}
							
							function checkStock(amount) {
								$.ajax({
									url: "/product/getProductStock?pcode=${product.pcode}&color=" + urlParams.get("cproductcolor") + "&size=" + amount.value
								}).done((data) => {
									$("#product-amount-input").val(Math.min($("#product-amount-input").val(), data.amount));
									$("#product-amount-input").attr("max", data.amount);
									$("#product-stock-amount").html("<small class='detail-title' style='color: red;'>남은 수량 <span>" + data.amount + "개</span></small>");
								});
							}
						</script>
					</td>
				</tr>
				<tr>
					<td>
						<div class="d-flex justify-content-between mb-4">
							<h6>총 합계</h6>
							<h5 id="product-total-price">${product.pprice}원</h5>
						</div>

						<div class="d-flex justify-content-between">
							<button class="btn btn-white btn-lg col-2">♡</button>
							<button onclick="location.href='shoppingbag'"
								class="btn btn-outline-secondary btn-lg col-5">쇼핑백 담기</button>
							<a href="order" class="btn btn-secondary btn-lg col-5">바로주문</a>
						</div>
					</td>
				</tr>
				<tr>
					<td class="border-bottom d-flex justify-content-between"><span>상품상세정보</span>
						<span>+</span></td>
				</tr>
				<tr>
					<td class="border-bottom d-flex justify-content-between"><span>실측사이즈</span>
						<span>+</span></td>
				</tr>
				<tr>
					<td class="border-bottom d-flex justify-content-between"><span>배송
							및 교환/반품</span> <span>+</span></td>
				</tr>
				<tr>
					<td class="border-bottom d-flex justify-content-between"><span>상품평(0)</span>
						<span>+</span></td>
				</tr>
			</table>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>