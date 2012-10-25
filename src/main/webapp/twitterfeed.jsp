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
        url = new URL("http://search.twitter.com/search.json?q=netbiscuitsmemorygame&rpp=10&include_entities=false&result_type=recent");
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
