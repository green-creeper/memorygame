<?xml version="1.0" encoding="utf-8"?>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/xml" pageEncoding="UTF-8"%>
<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" output-encoding="UTF-8" title="Memory Game" xsi:noNamespaceSchemaLocation="http://www.netbiscuits.com/schema/netbiscuits-tactile.xsd">
    <external type="css" file="css/memorygame.css"/>
    <external type="script" file="js/memorygame.js"/>
    <layout id="root" class="root" width="100%" height="100%" top="0" left="0">
        <layout class="titlebar" height="Math.round(parent.height*.1)" width="landscape:Math.round(parent.width*.35),portrait:Math.round(parent.width*.9)" top="landscape:Math.round(parent.height*.05),portrait:Math.round(parent.height*.025)" left="landscape:Math.round(parent.width*.025),portrait:Math.round(parent.width*.05)">
            <layout id="timerbar" class="timerbar" height="Math.round(parent.height*.5)" width="landscape:Math.round(parent.width*.2),portrait:Math.round(parent.width*.4)" top="Math.round(parent.height*.25)" left="landscape:Math.round(parent.width*.025),portrait:Math.round(parent.width*.05)">
                <view id="timeview" class="titlebar" height="100%" width="100%">
                    <PLAINHTML>
                        <span id="time"><span id="minutes">00</span>:<span id="seconds">00</span></span>
                    </PLAINHTML>
                </view>
            </layout>
            <layout id="titlebar" class="titlebar" height="Math.round(parent.height)" width="landscape:Math.round(parent.width*.25),portrait:Math.round(parent.width*.6)" top="landscape:Math.round(parent.height*.05),portrait:Math.round(parent.height*.025)" left="landscape:Math.round(parent.width*.70),portrait:Math.round(parent.width*.35)" >
                <view id="titlebarview" class="titlebar" height="100%" width="100%" float="right" >
                    <IMAGE id="logo" >
                    <img src="images/pixel.jpg" altsrc="images/nb_logo.jpg" format="jpg"/>
                    </IMAGE>
                </view>
            </layout>
        </layout>
        <layout id="sidebar" class="sidebar" height="Math.round(parent.height*.71)" width="Math.round(parent.width*.35)" top="Math.round(parent.height*.17)" left="Math.round(parent.width*.025)" visible="landscape:true,portrait:false">
            <flexview id="tweetfeed" width="Math.round(parent.width)" height="Math.round(parent.height*.95)" flexitems-height="Math.round(parent.height*.2)" flexitems-width="Math.round(parent.width*1)" flexitems-gap="5" scroll="true">

                <!--<cforEach var="i" begin="1" end="10">
                    <item  id="tweet${i}" class="tweet"></item>
                </cforEach>-->
            </flexview>
        </layout>
        <layout id="playfield" width="landscape:Math.round(parent.height*.9),portrait:Math.round(parent.width*.9)" height="landscape:Math.round(parent.height*.9),portrait:Math.round(parent.width*.9)" top="landscape:Math.round(parent.height * .05),portrait:Math.round(parent.height * .15)" left="landscape:Math.round(parent.width * .4),portrait:Math.round(parent.width * .05)">
            <gridview id="gridview" class="gamefield" gridflow="horizontal" width="100%" height="100%" top="0" left="0" opacity="100" zindex="1" items-height="(parent.height - 25) * .25" items-width="(parent.height - 25) * .25" items-hgap="5" items-vgap="5">
                <c:forEach var="i" begin="1" end="16">
                    <item id="item${i}" class="photoback" ontap="#memorygame.photoTapped('photogrid${i}')">
                        <view id="photogrid${i}" class="loadingmask" width="100%" height="100%" display="none">
                            <IMAGE id="photo${i}">
                            <img src="images/pixel.jpg" altsrc="GAMEPIECE" format="jpg"/>
                            </IMAGE>
                        </view>
                    </item>
                </c:forEach>
            </gridview>
        </layout>
        <layout id="footerbar" class="footerbar" height="Math.round(parent.height*.05)" width="landscape:Math.round(parent.width*.35),portrait:Math.round(parent.width*.9)" top="landscape:Math.round(parent.height*.9),portrait:Math.round(parent.height*.92)" left="landscape:Math.round(parent.width*.025),portrait:Math.round(parent.width * .05)">
            <view id="footerbarview" class="footerbar" height="100%" width="100%" top="0" left="0">
            </view>
        </layout>
        <layout id="maskinglayer" class="maskinglayer" height="parent.height" width="parent.width" zindex="1000" opacity="50" display="none">
        </layout>
        <layout id="gameover" class="gameover" height="60%" width="80%" top="Math.round(parent.height*.2)" left="Math.round(parent.width*.1)" display="none" zindex="2000" effect-type="slide" effect-duration="3000" effect-transition="easeInOut">
            <view id="gameoverview" class="gameover" height="100%" width="100%" >
                <TEXT>
                <styles><style name="color" value="#000000"/></styles>
                <richtext>[br][b]Congratulations, You won![/b]</richtext>
                </TEXT>
                <PLAINHTML>
                    <span id="elapsedtime">Elapsed time: <span id="elpminutes">00</span>minutes, <span id="elpseconds">00</span> seconds</span>
                </PLAINHTML>
                <SHARE id="sharegame" orientation="horizontal" style="large" counters="true" socialnetworks="facebook, twitter, googleplus">
                    <url id="shareurl">REPLACEURL</url>
                    <text id="sharetext">REPLACETXT</text>
                </SHARE>
            </view>
            <layout width="100%" height="50%" top="Math.round(parent.height*.8)" left="0">
                <view  height="100%" width="100%" ontap="#memorygame.gameOverTapped()">
                    <TEXT>
                    <styles><style name="color" value="#000000"/></styles>
                    <richtext>[br][br][p]Tap here to play another game.[/p]</richtext>
                    </TEXT>
                </view>
            </layout>
        </layout>
        <layout id="gamelost" class="gameover" height="60%" width="80%" top="Math.round(parent.height*.2)" left="Math.round(parent.width*.1)" display="none" zindex="2000" effect-type="slide" effect-duration="3000" effect-transition="easeInOut">
            <view id="gamelostview" class="gameover" height="100%" width="100%" ontap="#memorygame.gameLostTapped()">
                <TEXT>
                <styles><style name="color" value="#000000"/></styles>
                <richtext>[br][b]Unfortunately, you lost![/b][br][br][p]Tap here to play again.[/p]</richtext>
                </TEXT>
            </view>
        </layout>
        <layout id="loading" class="gameover" height="40%" width="80%" top="Math.round(parent.height*.2)" left="Math.round(parent.width*.1)" display="none" zindex="2000">
            <view id="loadingview" class="gameover" height="100%" width="100%">

                <TEXT>
                <styles><style name="color" value="#000000"/></styles>
                <richtext>[br][br][b]Loading... please wait a few seconds[/b]</richtext>
                </TEXT>
                <IMAGE id="load" >
                <img src="images/ajax-loader.gif" format="gif"/>
                </IMAGE>
            </view>
        </layout>
    </layout>
</page>
