/*global google, $, window */
/*jslint browser:true, devel:true, this:true */

// マップの高さを画面サイズに合わせる
function resizeHeight() {
    'use strict';
    var windowInnerHeight = $(window).innerHeight(),
        headerHeight = $("#header").height(),
        footerHeight = $("#footer").height(),
        uiContentPadding = 180;
    $("#map-canvas").css("height", windowInnerHeight - headerHeight - footerHeight - uiContentPadding);
}

$(window).on("resize", function () {
    resizeHeight();
});
