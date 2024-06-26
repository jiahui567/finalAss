/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Cart;
import entity.CartItem;
import entity.Products;
import entity.Promotion;
import entity.Users;
import jakarta.annotation.Resource;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.UserTransaction;
import java.util.List;

/**
 *
 * @author Ong
 */
public class Checkout extends HttpServlet {
   @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            HttpSession session = request.getSession();
            Users customer = (Users) session.getAttribute("customer");
            Query query = em.createNamedQuery("Cart.findByUserId");
            query.setParameter("userId", customer);
            Cart cart = (Cart) query.getSingleResult();
            query = em.createNamedQuery("CartItem.findByCartId");
            query.setParameter("cartId", cart);
            List<CartItem> cartItem = query.getResultList();
            boolean enough = true;
            try {
            utx.begin();
            for (CartItem item : cartItem) {
                Products prod = em.find(Products.class, item.getProductid().getProductId());
                prod.setStockCount(prod.getStockCount()-item.getQuantity());
                em.merge(prod);
                em.flush();
                if(prod.getStockCount() < 0){
                    enough = false;
                    utx.rollback();
                    response.sendRedirect("Customer/home.jsp");
                }
            }
            utx.rollback();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
            if(request.getParameter("coupon")!= null){
            Promotion userPromote = em.find(Promotion.class,Integer.parseInt(request.getParameter("coupon")));
            request.setAttribute("coupon", userPromote); 
            }
            if(enough){
            request.setAttribute("cart", cartItem); 
            request.getRequestDispatcher("Customer/paypay.jsp").forward(request, response);
            }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
