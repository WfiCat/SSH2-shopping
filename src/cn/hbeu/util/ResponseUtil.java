package cn.hbeu.util;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;


public class ResponseUtil {

	public static void write(HttpServletResponse response,Object o)throws Exception{
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		System.out.println(o.toString()+"dddddddddddddddddd");
		out.println(o.toString());
		out.flush();
		out.close();
	}
}
