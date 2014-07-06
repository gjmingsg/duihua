/* 
* JS Document for 对画
* Date: 2014-05-xx
*/

$(function () {
    //搜索切换
    $(".search_t span").click(function () {
        $(this).addClass("current").siblings("span").removeClass("current");

    });

    $('#search_btn').click(function () {

    });

    //$('.header').height($(window).height() - 80);
    BindGotoTop();
    //导航
    if ($(".nav").offset())
    var navT = $(".nav").offset().top;
    var additionH = $(".nav").height();
    var sectionCount = $("section").size();
    var sectionH = [], section_n = sectionCount, section_i = 1, i1 = 0, scrollEv = true;
    for (; section_i <= section_n; section_i++) {

        var sectionH_s = $(".section" + section_i).offset().top;
        //var t1 = $(window).height() - 110;
        //var t2 = $(".section" + section_i).height();
        //if (t1 > t2) $(".section" + section_i).height(t1);
        var sectionH_l = sectionH_s + $(".section" + section_i).height();
        sectionH.push([sectionH_s, sectionH_l]);
    }
    $(".nav_m li a").on("click", function () {
        scrollEv = false;
        var index = $(this).parents("li").index();
        $(".nav_m li").removeClass("current");
        $(this).parents("li").addClass("current");
        var goElem = $(this).attr("data-fixed");
        if (!$(goElem).offset()) return;
        var goT = $(goElem).offset().top - additionH;
        $("html,body").animate({
            scrollTop: goT
        }, 1000, 'easeInOutQuint', function () {
            scrollEv = true;
            if (index == 3) {
                $(goElem).find(".teamDWAD_ico img").addClass("animated rotateIn");
                $(goElem).find(".teamDWAD_teachers").addClass("animated fadeInLeft");
                $(goElem).find(".teamDWAD_core").addClass("animated fadeInRight");
            }
        });
        $(goElem).find(".module_title h1").addClass("animated fadeInLeft");

        return false;
    });
    $(window).scroll(function () {
        var t = $(window).scrollTop();
        if (t > navT) {
            $(".nav").addClass("nav_fixed");
        } else {
            $(".nav").removeClass("nav_fixed");
            if (!!scrollEv) {
                $(".nav_m li").removeClass("current");
            }
        }
        if (!!scrollEv) {
            for (; i1 < section_n; i1++) {
                if (t >= sectionH[i1][0] && t <= sectionH[i1][1]) {
                    if (!$(".nav_m li").eq(i1).hasClass("current")) {
                        $(".nav_m li").removeClass("current");
                        $(".nav_m li").eq(i1).addClass("current");
                    }
                }
                if (t + 768 > $(".section" + (i1 + 1)).offset().top && t < $(".section" + (i1 + 1)).offset().top) {
                    $(".section" + (i1 + 1)).find(".module_title h1").addClass("animated fadeInLeft");
                    if (i1 == 3) {
                        $(".section" + (i1 + 1)).find(".teamDWAD_ico img").addClass("animated rotateIn");
                        $(".section" + (i1 + 1)).find(".teamDWAD_teachers").addClass("animated fadeInLeft");
                        $(".section" + (i1 + 1)).find(".teamDWAD_core").addClass("animated fadeInRight");
                    }
                }
            }
            i1 == section_n ? i1 = 0 : i1;
        }
    });

    //内容1区图片切换
    $("#content1_play").wen_play({
        show_n: "1",
        page_show: "num_opacity",
        speed: 1000,
        autospeed: 4000,
        autoplay: true
    });
    //对画成绩切换
    $("#resultsDWAD_play").wen_play({
        show_n: "1",
        page_show: "pre_next",
        speed: 1000,
        autoplay: false
    });

    //视频和tab切换
    $(".informationDWAD_video li").click(function () {
        $(this).addClass("current").siblings("li").removeClass("current");
    });

    //高亮区
    $(".module_light a").hover(function () {
        if (!$(this).find(".vertical").is(":animated")) {
            $(this).find(".vertical").animate({ width: '100%' }, 100);
            $(this).find(".moduleLight_ico").addClass("current");
            $(this).find("p").css({ "color": "#3e3e3e" });
        }
    }, function () {
        $(this).find(".vertical").animate({ width: '10px' }, 100);
        $(this).find(".moduleLight_ico").removeClass("current");
        $(this).find("p").css({ "color": "#a4a4a4" });
    });

    //返回顶部
    $("#goTop").click(function () {
        $("html,body").animate({
            scrollTop: 0
        }, 1000, 'easeInOutQuint');
        return false;
    });
});

function BindGotoTop() {
    $(window).scroll(function () {
        if ($(window).scrollTop() > 0)
            $('.float_ico').show();
        else
            $('.float_ico').hide();

    });
}