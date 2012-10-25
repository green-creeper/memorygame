<%-- 
    Document   : twittesfeed
    Created on : 24.10.2012, 16:07:25
    Author     : akorlyuk
--%>

<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%
    URL url;
    HttpURLConnection conn;
    BufferedReader rd;
    String line;
    String result = "";
    try {
        url = new URL("https://api.instagram.com/v1/media/popular?client_id=7546f2129d5347f98e8d18324c459c55");
        conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        while ((line = rd.readLine()) != null) {
            result += line;
        }
        rd.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    out.print(result);
%>
