//tactile.logger.setConfig({
// 	level: tactile.logger.level.info
// });
var memorygame = {
    taplimit: 20,
    totalSeconds: 0,
    lastTappedItemIndex: -1,
    imageToHide1: null,
    imageToHide2: null,
    //imageArray: ["image1.jpg", "image2.jpg", "image3.jpg", "image4.jpg", "image5.jpg", "image6.jpg", "image7.jpg", "image8.jpg", "image1.jpg", "image2.jpg", "image3.jpg", "image4.jpg", "image5.jpg", "image6.jpg", "image7.jpg", "image8.jpg"],
    imageArray: [],
    instaArray:[],
    pairsMatched: 0,
    
    init: function() {
        memorygame.loadImages();
        
        memorygame.loadTweets();
        
    //tactile.EventManager.addResizeListener(rotated);
    },

    photoTapped: function(itemId) {
        var tappedItem = tactile.page.getComponent(itemId);       
        if (! tappedItem.isVisible()) {
            if (memorygame.imageToHide1 != null) {
                memorygame.imageToHide1.hide();
            }
            if (memorygame.imageToHide2 != null) {
                memorygame.imageToHide2.hide();
            }
            
            var tappedItemIndex = itemId.replace("photogrid", "");
            tappedItem.show();

            if (memorygame.lastTappedItemIndex == -1) {
                memorygame.lastTappedItemIndex = tappedItemIndex;
            } else {
                if (memorygame.imageArray[tappedItemIndex - 1] == memorygame.imageArray[memorygame.lastTappedItemIndex - 1]) {
                    memorygame.imageToHide1 = null;
                    memorygame.imageToHide2 = null;
                    memorygame.pairsMatched = memorygame.pairsMatched + 1;
                    
                    if (memorygame.pairsMatched == 8) {
                        m = tactile.page.getComponent('minutes').elem.innerHTML;
                        s = tactile.page.getComponent('seconds').elem.innerHTML;
                        tactile.page.getComponent('elpminutes').elem.innerHTML = m;
                        tactile.page.getComponent('elpseconds').elem.innerHTML = s;
                        tactile.page.getComponent('sharegame').elem.innerHTML = tactile.page.getComponent('sharegame').elem.innerHTML.replace("REPLACEURL", window.location, "g");
                        tactile.page.getComponent('sharegame').elem.innerHTML = tactile.page.getComponent('sharegame').elem.innerHTML.replace("REPLACETXT", encodeURIComponent("“I just beat the #netbiscuitsmemorygame in " + m + " minutes "+s+" seconds moves, play here!"), "g");
                        tactile.page.getComponent('maskinglayer').show();
                        tactile.page.getComponent('gameover').show();
                    }
                } else {
                    //Decrease taplimit if pair don't match
                    memorygame.taplimit--;
                    //Taplimit exeeded
                    if(memorygame.taplimit==0){
                        memorygame.gameLost();
                    }
                    memorygame.imageToHide1 = tappedItem;
                    memorygame.imageToHide2 = tactile.page.getComponent("photogrid" + memorygame.lastTappedItemIndex);
                }
                memorygame.lastTappedItemIndex = -1;	
            }
        }
    },
    
    newGame : function() {
       
        memorygame.imageArray.sort(function() {
            return 0.5 - Math.random()
        });
        
        for (n = 0; n < 16; n++) {
            var photo = tactile.page.getComponent("photo" + (n+1));
            photo.elem.innerHTML = photo.elem.innerHTML.replace("GAMEPIECE", memorygame.imageArray[n]);
        }
        memorygame.startTimer();
        tactile.foundation.ImageScaler.run();
    },
    gameLost : function() {
        tactile.page.getComponent('maskinglayer').show();
        tactile.page.getComponent('gamelost').show();
    },
    gameOverTapped : function() {
        window.location.href = window.location.href;
    },
    
    gameLostTapped : function() {
        window.location.href = window.location.href;
    },
    
    loadTweets : function() {
        //Add tweets to flex view
        function appendTweet(id, content, imgUrl){
            var div = document.createElement("div");
            div.id = id;
            div.className = "tweet";
            div.innerHTML = "<div class='innerTweet'><img src='"+imgUrl+"'/>"+content+"</div>";
            tactile.page.getComponent("tweetfeed").append(
                new tactile.FlexItem(div, {
                    parent: tactile.page.getComponent("tweetfeed")
                })
                );
        }
        var ajax = new tactile.AjaxLoader();
        ajax.load({
            url: 'twitterfeed.jsp',
            method: 'GET',
            params: ''
        });
       
        ajax.onsuccess.subscribe(function(response){
            tweets = eval('('+response.loader.getResponseText()+')');
            for(i=0; i< tweets.results.length; i++){
                appendTweet("tweet"+i, tweets.results[i].text, tweets.results[i].profile_image_url);
            }
        });
        ajax.onerror.subscribe(function(){
            appendTweet("error1", "Something went wrong. Can't load feed", "");
        });
    },
    
    loadImages: function(){
        var ajax = new tactile.AjaxLoader();
        ajax.load({
            url: 'instagram.jsp',
            method: 'GET',
            params: ''
        });
        
        ajax.onsuccess.subscribe(function(response){
            photos = eval('('+response.loader.getResponseText()+')');
            for(i=0; i<8; i++){
                imgurl = photos.data[i].images.low_resolution.url;
                memorygame.imageArray[i]= imgurl;
                memorygame.imageArray[15-i] = imgurl;
            }
            memorygame.newGame();
        });
        
        ajax.onerror.subscribe(function(){
            console.log('error', attributes);
        });
    },
    //Count up timer of elapsed time
    startTimer: function(){
        function pad(val)
        {
            var valString = val + "";
            if(valString.length < 2)
            {
                return "0" + valString;
            }
            else
            {
                return valString;
            }
        }


        var min = tactile.page.getComponent("minutes");
        var sec = tactile.page.getComponent("seconds");
        setInterval(function()
        {
            ++memorygame.totalSeconds;
            //If game duration is 5 minutes, than game lost
            if(memorygame.totalSeconds==300){
                memorygame.gameLost();
            }
            sec.elem.innerHTML = pad(memorygame.totalSeconds%60);
            min.elem.innerHTML = pad(parseInt(memorygame.totalSeconds/60));
        }
        , 1000);
    }
//    rotated : function(){
//        var time = tactile.page.getComponent("time");
//        if(e.width > e.height){
//            time.swapClass("timeportrait", "timelandscape");
//        } else{
//            time.swapClass("timelandscape", "timeportrait");
//        }
//    }
}

tactile.page.onready(memorygame.init);