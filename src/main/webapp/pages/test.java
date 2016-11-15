	<div class="adDescDiv">
		<h2>Price corner</h2>
		<p><label>If for rent, rental charges : </label>${shownAd.priceRent} CHF per month</p>
		<p><label>If for sale :</label></p>
		<p><label>- price for a direct sale : </label>${shownAd.priceSale} CHF</p>
		<p><label>- current bid (auction) : </label>${shownAd.currentBid} CHF</p>
		
		<br/>
		
		<p id="timeLeft">Expiry date of the auction: <fmt:formatDate value="${shownAd.expireDate}" pattern="dd.MM.yyyy HH:mm:ss"/></p>
		<br/>
		<p><label for="field-currentBid">Make a higher bid :</label>
		
		<c:choose>
        	<c:when test="${loggedIn}">
            	<c:if test="${loggedInUserEmail != shownAd.user.username }">
              		<div id="bidErrorDiv" style="color: #cc0000"></div>
                    	<form>
                        	<input class="bidInput" type="number" id="inputBid" value="${shownAd.currentBid}+${shownAd.increment}"/>
                            	<br>
                                    <button type="button" id="makeBid" class="bidButton">Let's go !</button>
                       	</form>

                       	<c:choose>
                        	<c:when test="${shownAd.priceSale > 0}">
                            	<script type="text/javascript">
                                	$(document).ready(function () {
                                   		$("#directSale").click(function () {
                                        	$.post("/directSale", {id: "${shownAd.id}".done(function () {
                                            	location.reload();
                                           	});
                                      	});
                                     })
                             	</script>
                               	<br/>
                                <p><button type="button" id="directSale" class="btn bidButton">Direct Sale</button> for CHF ${shownAd.priceSale}</p>
                         	</c:when>
                      	</c:choose>

                        <br/>

           		</c:if>
      		</c:when>
      	</c:choose>
 	</div>
                
    <table id="bids" style='display:none'>
    	<c:forEach items="${bids }" var="bid">
         	<tr>
             	<td>
                	<fmt:formatDate value="${bid.timestamp}" pattern="dd-MM-yyyy "/>
                    <fmt:formatDate value="${bid.timestamp}" pattern=" HH:mm "/>
                     	${bid.user.firstName}
                        ${bid.user.lastName}
                        ${bid.amount} CHF
                 </td>

             </tr>
          </c:forEach>
     </table>
	</div>