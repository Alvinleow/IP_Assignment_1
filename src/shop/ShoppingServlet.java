package shop;

import java.io.IOException;
import java.util.StringTokenizer;
import java.util.Vector;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ShoppingServlet")
public class ShoppingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        RequestDispatcher dispatcher;
        switch (action) {
            case "VIEW":
                dispatcher = request.getRequestDispatcher("viewCart.jsp");
                dispatcher.forward(request, response);
                break;
            case "LOGOUT":
                session.invalidate();
                dispatcher = request.getRequestDispatcher("logout.jsp");
                dispatcher.forward(request, response);
                break;
            default:
                response.sendRedirect("index.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        String action = request.getParameter("action");

        @SuppressWarnings("unchecked")
        Vector<VCDBean> buylist = (Vector<VCDBean>) session.getAttribute("cart");
        if (buylist == null) {
            buylist = new Vector<>();
        }

        if ("ADD".equals(action)) {
            VCDBean vcd = getVCD(request);
            boolean match = false;
            for (VCDBean aVCD : buylist) {
                if (aVCD.getTitle().equals(vcd.getTitle())) {
                    aVCD.setQuantity(aVCD.getQuantity() + vcd.getQuantity());
                    match = true;
                    break;
                }
            }
            if (!match) {
                buylist.addElement(vcd);
            }
            session.setAttribute("cart", buylist);
            request.setAttribute("addedItem", vcd);
            RequestDispatcher dispatcher = request.getRequestDispatcher("addItem.jsp");
            dispatcher.forward(request, response);
        } else if ("DELETE".equals(action)) {
            String delIndex = request.getParameter("delindex");
            int index = Integer.parseInt(delIndex);
            String deletedTitle = null;
            
            if (index < buylist.size()) {
            	 VCDBean vcd = (VCDBean) buylist.elementAt(index);
                 deletedTitle = vcd.getTitle().trim();
                buylist.removeElementAt(index);
            }
            session.setAttribute("cart", buylist);
            request.setAttribute("deletedTitle", deletedTitle);
            RequestDispatcher dispatcher = request.getRequestDispatcher("deleteItem.jsp");
            dispatcher.forward(request, response);
        } else if ("CHECKOUT".equals(action)) {
            buylist.clear();
            session.setAttribute("cart", buylist);

            RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
            dispatcher.forward(request, response);
        }
    }

    private VCDBean getVCD(HttpServletRequest request) {
        String myVCD = request.getParameter("VCD");
        String qty = request.getParameter("qty");
        StringTokenizer t = new StringTokenizer(myVCD, "|");
        String title = t.nextToken();
        String actor = t.nextToken();
        String price = t.nextToken();
        price = price.replace('R', ' ').trim();
        price = price.replace('M', ' ').trim();

        VCDBean vcd = new VCDBean();
        vcd.setTitle(title);
        vcd.setActor(actor);
        vcd.setPrice(Float.parseFloat(price));
        vcd.setQuantity(Integer.parseInt(qty));
        return vcd;
    }
}
