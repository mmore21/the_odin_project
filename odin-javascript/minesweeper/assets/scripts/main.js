$(document).contextmenu(function() {
    return false;
});

// grid module
var grid = (function() {
  var cells = [];
  var interval;

  return {
    cells,
    gameOver:function(message) {
      $('.grid > div').off('click');
      $('.grid *').show();
      clearInterval(interval);
      alert(message);
    },
    trackTime:function() {
      var start = new Date;
      var time = 0;
      $('.timer').text("Time: " + time + " seconds");
      interval = setInterval(function() {
        time = Math.floor((new Date - start) / 1000)
        $('.timer').text("Time: " + time + " seconds");
      }, 1000);
    },
    createCells:function() {
      for (var i = 0; i < 9; i++) {
        for (var j = 0; j < 9; j++) {
          cells.push([j, i]);
        }
      }
    },
    drawCells:function() {
      for (var i = 0; i < cells.length; i++) {
        $('.grid').append('<div class="h' + cells[i][0] + 'v' + cells[i][1] + '"></div>');
      }
    },
    // calculates how many nearby cells and adds that amount to the cell
    addNumbersToCells:function() {
      var cells = $('.grid > div').not('.mine');
      for (var i = 0; i < cells.length; i++) {
        var cellClass = cells[i].className;
        cells[i] = [Number(cellClass.charAt(1)), Number(cellClass.charAt(3))];
      }
      for (var i = 0; i < cells.length; i++) {
        var borderingMines = 0;
        cellDistances = [[0, -1], [-1, 0], [0, 1], [1, 0], [-1, -1], [-1, 1], [1, -1], [1, 1]];
        for (var j = 0; j < cellDistances.length; j++) {
          if ($('.h' + (cells[i][0] + cellDistances[j][0]) + 'v' + (cells[i][1] + cellDistances[j][1])).hasClass('mine')) {
            borderingMines++;
          }
          if (borderingMines > 0) {
            $('.h' + cells[i][0] + 'v' + cells[i][1]).html('<span>' + borderingMines + '</span>');
            $('.h' + cells[i][0] + 'v' + cells[i][1] + ' > span').hide();
          }
        }
      }
    },
    withinBoundaries:function(coordinate) {
      if (coordinate[0] < 0 || coordinate[0] > 8 || coordinate[1] < 0 || coordinate [1] > 8) {
        return false;
      }
      else {
        return true;
      }
    },
    revealBorderCells:function(originalClass) {
      console.log(originalClass)
      var directions = [[0, -1], [-1, 0], [0, 1], [1, 0], [-1, -1], [-1, 1], [1, -1], [1, 1]];
      for (var i = 0; i < directions.length; i++) {
        var cellClass = originalClass;
        console.log(directions[i])
        while ($(cellClass).is(':empty')) {
          var coordinate = [Number(cellClass.charAt(2)), Number(cellClass.charAt(4))];
          coordinate[0] += directions[i][0];
          coordinate[1] += directions[i][1];
          cellClass = '.h' + coordinate[0] + 'v' + coordinate[1];
          console.log(cellClass)
          grid.targetCell(cellClass)
        }
      }

    },
    targetCell:function(cellClass) {
      $(cellClass).css('background-color', '#e0e0e0')
      $(cellClass + ' > span').show();
    },
    clickCell:function() {
      // check the field with left-click
      $('.grid > div').on('click', function(e) {
        // console.log(e.target.className)
        var cellClass = ('.' + e.target.className);
        if ($(cellClass).is(':empty')) {
          grid.revealBorderCells(cellClass);
        }
        grid.targetCell(cellClass);
        if($('div *').not('.mine').css("background-color")=="rgb(244, 244, 244)") {
          gameOver("You win! Refresh the page to play again.");
        }
      })
    },
    toggleFlag:function() {
      availableFlags = $('.mine').length
      $('.flags-remaining').text("Flags remaining: " + availableFlags);
      // set flags using right-click
      $('.grid > div').on('contextmenu', function(e) {
        if ($(e.target).hasClass('flag')) {
          availableFlags++;
          $(e.target).toggleClass('flag')
        }
        else if (availableFlags > 0) {
          availableFlags--;
          $(e.target).toggleClass('flag')
        }
        $('.flags-remaining').text("Flags remaining: " + availableFlags);
      })
    }
  }
}());

// minefield module
var minefield = (function() {
  var mines = [];
  var safe = grid.cells;

  return {
    mines,
    safe,
    createMines:function() {
      for (var i = 0; i < 15; i++) {
        mine = [Math.floor(Math.random() * 9) + 1, Math.floor(Math.random() * 9) + 1];
        mines.push(mine);
        var index = grid.cells.indexOf(mine)
        safe.splice(index, 1);
      }
    },
    drawMines:function() {
      for (var i = 0; i < mines.length; i++) {
        $('.h' + mines[i][0] + 'v' + mines[i][1]).addClass('mine').html("<span>M</span>");
        //$('.h' + mines[i][0] + 'v' + mines[i][1] + ' > span').hide();
      }
    },
    clickMine:function() {
      var currentTime = $('div .timer').text();
      console.log($('.timer').text());
      console.log($('.timer').html());
      console.log($('.timer').innerHTML);
      console.log($('.timer').innerText);
      $('.mine').on('click', function(e) {
        $(e.target).css('background-color', 'red');
        grid.gameOver("You lose. Refresh page to play again.");
      })
    }
  }
}());

grid.createCells();
grid.drawCells();
minefield.createMines();
minefield.drawMines();
grid.addNumbersToCells();
minefield.clickMine();
grid.toggleFlag();
grid.clickCell();
grid.trackTime();
