/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Orders;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author Isaacweng
 */
public class Loaddashboard extends HttpServlet {
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
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            HttpSession session = request.getSession();
        Query query = em.createNamedQuery("Orders.findAll");
                    List<Orders> order = query.getResultList();
                    Query query2 = em.createNamedQuery("Feedbacklog.countAll");
                    int feedbackCount = Integer.parseInt(query2.getSingleResult().toString());
                    System.out.println(feedbackCount);
                    session.setAttribute("feedbackcount",feedbackCount);
                    Query query3 = em.createNamedQuery("Orders.countAll");
                    int orderCount = Integer.parseInt(query3.getSingleResult().toString());
                    Query query4 = em.createNamedQuery("Users.countAll");
                    int userCount = Integer.parseInt(query4.getSingleResult().toString());
                    session.setAttribute("userCount",userCount);
                    session.setAttribute("feedbackCount",feedbackCount);
                    session.setAttribute("orderCount",orderCount);
                    session.setAttribute("OrderRecord",order);
                    response.sendRedirect(request.getContextPath()+"/Staff/dashboard.jsp");
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
