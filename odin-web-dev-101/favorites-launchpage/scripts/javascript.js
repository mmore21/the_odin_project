$(function() {
    var curPage = "page4";
    $("#page4").show();
    $("#menu a").click(function() {
        if (curPage.length) {
            $("#" + curPage).hide();
        }
        curPage = $(this).data("page");
        $("#" + curPage).show();
    });
});