<%@ page contentType="text/html;charset=UTF-8" %>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=wc9MXEi8tywGkXNDgQF2OvXT"></script>
<script name="baidu-tc-cerfication" type="text/javascript" charset="utf-8" src="http://apps.bdimg.com/cloudaapi/lightapp.js"></script>
<script>
    var city={
        1:"北京市",
        2:"上海市",
        3:"天津市",
        4:"无锡市",
        5:"杭州市",
        6:"石家庄市",
        7:"沈阳市",
        8:"合肥市",
        9:"呼和浩特市",
        10:"南京市",
        11:"南通市",
        12:"常州市",
        13:"郑州市",
        14:"太原市",
        15:"青岛市",
        16:"济南市",
        17:"哈尔滨市",
        18:"大连市",
        19:"南昌市",
        20:"苏州市",
        21:"武汉市",
        22:"长沙市",
        23:"西安市",
        24:"南宁市",
        25:"深圳市",
        26:"昆明市",
        27:"重庆市",
        28:"延安市",
        29:"乌鲁木齐市",
        30:"广州市",
        31:"攀枝花市",
        32:"成都市",
        33:"内江市",
        34:"西昌市",
        35:"贵阳市",
        36:"厦门市",
        37:"福州市",
        38:"绵阳市",
        39:"兰州市",
        40:"长春市",
        41:"宁波市"
//        ,
//        42:"克拉玛依市"
    };
    var citys={},c=$.cookie("c"),l=$.cookie("l"),ll=$.cookie("ll");
    $(function(){
        var geolocation = new BMap.Geolocation();
        $("A").each(function(i,o){
            $(this).attr("hf", $(this).attr("href"));
        })
        function setCity(ci) {
            $("A").each(function(i,o){
                var h = $(this).attr("hf");
                !!h&&$(this).attr("href",h.replace("{city}",ci));
//                var h = $(this).attr("href");
//                !!h&&$(this).attr("href",h.replace("{city}",ci));
//                $("input[name=cid]").val(c) ;
            })
        }
        for(var i in city) {
            citys[i]=city[i];
            citys[city[i]]=i;
        }
        if(c==null) {
            c=1;
            $.cookie("c",1,{path:"/"});
        }
        setCity(c);
        //start locate,定位成功 c==l ,最近，else c
        $.ajax({
            url: "http://api.map.baidu.com/location/ip?ak=wc9MXEi8tywGkXNDgQF2OvXT&coor=bd09ll",
            dataType:"jsonp",
            success: function (o) {
                l=o.content.address_detail.city;
                $.cookie("l",l,{path:"/"});
                if($.cookie("q")==null) {
                    setCity(citys[l]||1);
                    $.cookie("c",citys[l]||1,{path:"/"});
                }
            }
        });
        clouda.lightInit({
            ak:"gbpQXmChVG7YUwuSPoaI7GU4",
            module:["geolocation"]
        });
        clouda.device.geolocation.startListen({
            onsuccess:function(data) {
                ll = [data.latitude,data.longitude].join(",");
                $.cookie("ll",ll,{path:"/"});
            }
        });
//        function locate() {
//            geolocation.getCurrentPosition(function(r){   //定位结果对象会传递给r变量
//                if(this.getStatus() == BMAP_STATUS_SUCCESS){  //通过Geolocation类的getStatus()可以判断是否成功定位。
//                    ll = [r.point.lat,r.point.lng].join(",");
//                    $.cookie("ll",ll,{path:"/"});
//                }
//            },{enableHighAccuracy: true});
//        }
//        locate();
//        window.setInterval(function(){          //
//            locate();
//        },10*60*1000)
    })

</script>