var count = 1;
var interval;
var playing = true;

$(document).ready(function() {
  startSlider();
  leftClick();
  rightClick();
  stopSlider();
  playSlider();
  chooseImage();
})

function startSlider() {
  $('#play').hide();
  $('#pause').show();
  $('.' + count).css("display", "block")
  interval = setInterval(function() {
    $('.' + count).fadeOut(500, function() {
      count++;
      if (count > $(".slider > img").length) {
        count = 1;
      }
      $('.' + count).fadeIn(500);
    });
  }, 5000)
}

function leftClick() {
  $('#left-arrow').click(function() {
    window.clearInterval(interval);
    $('#pause').hide();
    $('#play').show();
    $('.' + count).fadeOut(500, function() {
      count--;
      if (count < 1) {
        count = $(".slider > img").length;
      }
      $('.' + count).fadeIn(500);
    });
  });
}

function rightClick() {
  $('#right-arrow').click(function() {
    window.clearInterval(interval);
    $('#pause').hide();
    $('#play').show();
    $('.' + count).fadeOut(500, function() {
      count++;
      if (count > $(".slider > img").length) {
        count = 1;
      }
      $('.' + count).fadeIn(500);
    });
  });
}

function stopSlider() {
  $('#pause').click(function () {
    window.clearInterval(interval);
    $('#pause').hide();
    $('#play').show();
  })
}

function playSlider() {
  $('#play').click(function() {
    startSlider();
  })
}

function chooseImage() {
  $('#img-1').click(function() {
    window.clearInterval(interval)
    $('#pause').hide();
    $('#play').show();
    $('.' + count).fadeOut(500, function() {
      count = 1;
      $('.' + count).fadeIn(500);
    });
  })
  $('#img-2').click(function() {
    window.clearInterval(interval)
    $('#pause').hide();
    $('#play').show();
    $('.' + count).fadeOut(500, function() {
      count = 2;
      $('.' + count).fadeIn(500);
    });
  })
  $('#img-3').click(function() {
    window.clearInterval(interval)
    $('#pause').hide();
    $('#play').show();
    $('.' + count).fadeOut(500, function() {
      count = 3;
      $('.' + count).fadeIn(500);
    });
  })
}
