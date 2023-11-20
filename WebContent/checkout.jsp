<%@ page import="shop.VCDBean" %>
<%@ page import="java.util.Vector" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shopping Checkout</title>
    
    <style>
    	table {
    		border: 0px;
    		cellpadding: 0;
    		width: 100%;
            background-color: #FFFFFF;
            font-weight: bold;
    	}
    	
    	th {
    		text-align: left;
    	}
    	
    	.center {
		  text-align: center;
		}
    </style>
    
</head>
<body bgcolor="#33CCFF">
<!--     <center> -->
		
		<script>
			function checkout() {
			    var xhr = new XMLHttpRequest();
			    xhr.open("POST", "ShoppingServlet", true);
			    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			    xhr.onreadystatechange = function() {
			        if (xhr.readyState === 4 && xhr.status === 200) {
	
			        	window.location.href = "index.jsp";
			        }
			    };
			
			    var data = "action=CHECKOUT";
			
			    xhr.send(data);
			}
		</script>
		
		<%!
        // Helper method placed within a declaration block
        @SuppressWarnings("unchecked")
        private Vector<VCDBean> safeCastToVectorOfVCDBean(Object obj) {
            if (obj instanceof Vector<?>) {
                Vector<?> vec = (Vector<?>) obj;
                if (!vec.isEmpty() && vec.get(0) instanceof VCDBean) {
                    return (Vector<VCDBean>) vec;
                }
            }
            return new Vector<>();
        }
    	%>

        <%
        	Vector<VCDBean> buylist = safeCastToVectorOfVCDBean(session.getAttribute("cart"));
            if (buylist != null && !buylist.isEmpty()) {
                float total = 0;
                // Display the checkout items
        %>
        		<div class="center">
			        <h1>VCD Shopping Checkout</h1>
			        <hr><p>
    			</div>
    			
                <table>
                    <tr>
                        <th>VCD TITLE</th>
                        <th>ACTOR</th>
                        <th>PRICE</th>
                        <th>QUANTITY</th>
                    </tr>
                    <%
                        for(VCDBean item : buylist) {
                            float subtotal = item.getPrice() * item.getQuantity();
                            total += subtotal;
                    %>
                        <tr>
                            <td><%= item.getTitle() %></td>
                            <td><%= item.getActor() %></td>
                            <td><%= item.getPrice() %></td>
                            <td><%= item.getQuantity() %></td>
                        </tr>
                    <%
                        }
                    %>
                    <tr>
                    	<td> </td>
                        <td>Total</td>
                        <td><%= total %></td>
                        <td> </td>
                    </tr>
                </table>
                
				<div class="center">
			    	<br>
			    	<a href="#" onclick="checkout();">Shop some more!</a>
				</div>
        <%
            } else {
        %>
                <div class="center">
                	<b>Shopping Cart Empty!</b>
			    	<br><br>
			        <a href="index.jsp">continue shopping?</a>
				</div>
        <%
            }
        %>
<!--     </center> -->
</body>
</html>
