package com.codingrecipe.bom.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.do")
public class hscodeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // 요청 확인
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String cmd = requestURI.substring(contextPath.length());

        MemberService service = new MemberServiceImpl();
        List<MemberVO> list = null;
        StringBuffer sb = new StringBuffer();

        // 추가 부분 (response가 다시 index.jsp 돌아가기 때문에)
        PrintWriter out = response.getWriter();
        String result = null;

        // cmd에 따른 구분
        switch (cmd) {
            case "/csv.do":
                list = service.getList();
                for (MemberVO vo : list) {
                    sb.append(vo.getmIdx()+","+vo.getmId()+","+vo.getmName()+","+vo.getmEmail()+","+vo.getmPhone()+","+vo.getmAddr()+"/");
                }
                sb.deleteCharAt(sb.length()-1);
                result = sb.toString();
                break;
                // 마지막에 포함된 쉼표 제거 : substring(0, sb.toString().length() - 1)
                result = sb.toString().substring(0, sb.toString().length() - 1) + "]";
                break;
        }

        out.print(result);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
