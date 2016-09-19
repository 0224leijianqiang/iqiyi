<%@ page contentType="text/html;charset=UTF-8" %>
<script>
    $(function(){
        $(".sp-city-select>span,.bu-header-select").bind("click",function(e){
            if($(".sp-city-panel").is(":hidden")) {
                $(".sp-city-panel").slideDown("fast");
            } else {
                $(".sp-city-panel").slideUp("fast");
            }
            e.stopPropagation();
        });
        $(document).click(function(e){
            if(!$(e.target).hasClass("sp-city-panel")) {
                $(".sp-city-panel").slideUp("fast");
            }
        });
        $(".sp-city-panel").bind("click",function(e){
            e.stopPropagation();
        })
        $(".sp-city-panel").delegate("a","click",function(){
            var id=$(this).attr("id");
            if(id=="0") { //最近
                $.cookie("q","0",{path:"/"});
                $.cookie("c",citys[l],{path:"/"});
            }else{
                $.cookie("q","1",{path:"/"});
                $.cookie("c",id,{path:"/"});
            }
            window.location.href =  window.location.href.replace(/\d*$/,$.cookie("c"));
        });
        (function init() {
            var n= 0,ul=$(".sp-city-row").empty();
            $.each(city,function(i,c){
                $("<a id=@>&</a>".replace("@",i).replace("&",c)).appendTo(n%4==0?$("<li>").appendTo(ul):$(".sp-city-row>li:last"));
                n++;
            })
        })();

    })
</script>

<div class="sp-city-panel">
    <div class="sp-up-row"></div>
    <ul class="sp-city-row" >
        <li>
            <a id="1">
                北京
            </a><a id="2">
            上海
        </a><a id="30">
            广州
        </a><a id="3">
            天津
        </a>
        </li>
        <li>
            <a id="4">
                无锡
            </a><a id="5">
            杭州
        </a><a id="6">
            石家庄
        </a><a id="7">
            沈阳
        </a>
        </li>
        <li>
            <a id="8">
                合肥
            </a><a id="9">
            呼和浩特
        </a><a id="10">
            南京
        </a><a id="11">
            南通
        </a>
        </li>
        <li>
            <a id="12">
                常州
            </a><a id="13">
            郑州
        </a><a id="14">
            太原
        </a><a id="15">
            青岛
        </a>
        </li>
        <li>
            <a id="16">
                济南
            </a><a id="17">
            哈尔滨
        </a><a id="18">
            大连
        </a><a id="19">
            南昌
        </a>
        </li>
        <li>
            <a id="20">
                苏州
            </a><a id="21">
            武汉
        </a><a id="22">
            长沙
        </a><a id="23">
            西安
        </a>
        </li>
        <li>
            <a id="24">
                南宁
            </a><a id="25">
            深圳
        </a><a id="26">
            昆明
        </a><a id="27">
            重庆
        </a>
        </li>
        <li>
            <a id="28">
                延安
            </a><a id="29">
            乌鲁木齐
        </a><a id="31">
            攀枝花
        </a><a id="32">
            成都
        </a>
        </li>
        <li>
            <a id="33">
                内江
            </a><a id="34">
            西昌
        </a><a id="35">
            贵阳
        </a><a id="36">
            厦门
        </a>
        </li>
        <li>
            <a id="37">
                福州
            </a><a id="38">
            绵阳
        </a><a id="39">
            兰州
        </a><a id="40">
            长春
        </a>
        </li>
        <li>
            <a id="41">
                宁波
            </a><a id="42">
            克拉玛依
        </a>

        </li>
    </ul>
</div>