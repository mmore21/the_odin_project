$(document).ready(function() {
    start_timer();
    show_time();
});

var count = 1500;
stop_counter = false;
function start_timer() {
    $("#add_time").click(function() {
        count += 60;
        show_time();
    });

    $("#subtract_time").click(function() {
        count -= 60;
        show_time();
    });

    $("#session").click(function() {
        count = 1500;
        show_time();
    });

    $("#break").click(function() {
        count = 300;
        show_time();
    });

    $("#stop_timer").click(function() {
        stop_counter = true;
    });

    $("#start_timer").click(function() {
    stop_counter = false;
    var counter = setInterval(timer, 1000);

    function timer() {
                if (stop_counter == true) {
            clearInterval(counter);
        }
        else if (count <= 0) {
            clearInterval(counter);
            alert("Time is up!");
            count = 1500;
            stop_counter = true;
            show_time();
            return;
        }
        else {
        count --;
        show_time();
        }
    }
})};

function show_time() {
        var minutes = Math.floor(count / 60);
        var seconds = count % 60;
        if (minutes < 10) {
            minutes = "0" + minutes;
        }
        if (seconds < 10) {
            seconds = "0" + seconds;
        }
        document.getElementById("timer").innerHTML = minutes + ":" + seconds;
        
}