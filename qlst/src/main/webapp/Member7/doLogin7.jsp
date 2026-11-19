<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,dao.*,model.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String username = request.getParameter("inUsername");
    String password = request.getParameter("inPassword");

    Member7 member = new Member7();
    member.setUsername(username);
    member.setPassword(password);

    MemberDAO7 memberDAO = new MemberDAO7();
    boolean kq = memberDAO.checkLogin(member);

    if (kq && "CUSTOMER".equalsIgnoreCase(member.getRole())) {
        Customer7 customer = memberDAO.getCustomerById(member.getId());
        session.setAttribute("customer", customer);
        response.sendRedirect("../Customer7/CustomerHomeUI7.jsp");
    } else if (kq && "WAREHOUSE_STAFF".equalsIgnoreCase(member.getRole())) {
        WarehouseStaff7 staff = memberDAO.getWarehouseStaffById(member.getId());
        session.setAttribute("warehouseStaff", staff);
        response.sendRedirect("../WarehouseStaff7/WarehouseHomeUI7.jsp");
    } else {
        response.sendRedirect("LoginUI7.jsp?err=fail");
    }
%>
