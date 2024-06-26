/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.*;
import entity.UserType;
import entity.Users;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Isaacweng
 */
public class Filter extends HttpServlet {

    @PersistenceContext
    EntityManager em;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String page = request.getParameter("page");

        if (action.equals("Role")) {

            int role = Integer.parseInt(request.getParameter("Role"));

            if (role == 0) {
                Query query = em.createNamedQuery("Users.findAll");
                List<Users> users = query.getResultList();
                if (users != null) {
                    session.setAttribute("adminList", users);
                }
                response.sendRedirect(request.getContextPath() + "/Staff/editstaff.jsp");
            } else {
                UserType user2 = new UserType(role);
                Query query = em.createNamedQuery("Users.findByUserType").setParameter("typeId", user2);
                List<Users> users = query.getResultList();
                session.setAttribute("adminList", users);
                response.sendRedirect(request.getContextPath() + "/Staff/editstaff.jsp?Role=" + user2.getTypeId());
            }
        } else if (action.equals("Product")) {

            int product = Integer.parseInt(request.getParameter("Product"));
            if (product == 0) {
                Query query = em.createNamedQuery("Products.findAll");
                List<Products> products = query.getResultList();
                session.setAttribute("productList", products);
                if (page.equals("admin")) {
                    response.sendRedirect(request.getContextPath() + "/Staff/productAdmin.jsp");
                } else if (page.equals("customer")) {
                    response.sendRedirect("Customer/product.jsp");
                }
            } else {
                Category category = new Category(product);
                Query query = em.createNamedQuery("Products.findByCategory").setParameter("categoryId", category);
                List<Products> products = query.getResultList();
                session.setAttribute("productList", products);
                if (page.equals("admin")) {
                    response.sendRedirect(request.getContextPath() + "/Staff/productAdmin.jsp");
                } else if (page.equals("customer")) {
                    response.sendRedirect(request.getContextPath() + "/Customer/product.jsp");
                }
            }
        } else if (action.equals("Report")) {
            String startDate = request.getParameter("date");
            String endDate = request.getParameter("enddate");
            if (startDate.isEmpty() && endDate.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/Staff/report.jsp");
            } else {
                Query query = em.createNativeQuery("SELECT SUM(ORDER_ITEM.quantity) AS total,ORDER_ITEM.PRODUCT_ID, sum(ORDER_ITEM.PRICE) as revenue,PRODUCTS.PRODUCT_NAME\n"
                        + "FROM ORDER_ITEM \n"
                        + "JOIN PRODUCTS ON PRODUCTS.PRODUCT_ID = ORDER_ITEM.PRODUCT_ID JOIN PAYMENT ON PAYMENT.ORDER_ID = ORDER_ITEM.ORDER_ID\n"
                        + "WHERE PAYMENT.PAYMENT_DATE BETWEEN ? AND ?\n"
                        + "GROUP BY ORDER_ITEM.PRODUCT_ID,PRODUCTS.PRODUCT_NAME\n"
                        + "ORDER BY total DESC \n"
                        + "FETCH FIRST 10 ROWS ONLY"
                );
                query.setParameter(1, LocalDate.parse(startDate));
                query.setParameter(2, LocalDate.parse(endDate));
                List<Object[]> prod = query.getResultList();
                List<Products> salesMonth = new ArrayList<>();
                for (Object[] row : prod) {
                    int sum = (int) row[0];
                    int id = (int) row[1];
                    double revenue = (double) row[2];
                    String name = (String) row[3];
                    Products topProd = new Products();
                    topProd.setStockCount(sum);
                    topProd.setProductId(id);
                    topProd.setPrice(revenue);
                    topProd.setProductName(name);
                    salesMonth.add(topProd);
                }
                session.setAttribute("sales", salesMonth);
                response.sendRedirect(request.getContextPath() + "/Staff/report.jsp");
            }

        }
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
