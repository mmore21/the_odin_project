// defines board object
var board = {
  cells: [1, 2, 3, 4, 5, 6, 7, 8, 9],
  winConditions: [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]
  ]
}

// checks if game board is full if there is no winner
function checkScratch() {
  for (var i = 0; i < board.cells.length; i++) {
    if ($('.cell-' + board.cells[i]).is(':empty')) {
      return false;
    }
  }
  return true;
}

function checkMatch(gridValues) {
  var x = [];
  var o = [];
  for (var key in gridValues) {
    if (gridValues[key] === "X") {
      x.push(Number(key));
    }
    else if (gridValues[key] === "O") {
      o.push(Number(key));
    }
  }
  for (var i = 0; i < board.winConditions.length; i++) {
    conditions = board.winConditions[i]
    if (x.includes(conditions[0]) && x.includes(conditions[1]) && x.includes(conditions[2])) {
      $('.notifier').html('<h1>Player 1 Wins</h1>')
      return true;
    }
    else if (o.includes(conditions[0]) && o.includes(conditions[1]) && o.includes(conditions[2])) {
      $('.notifier').html('<h1>Player 2 Wins</h1>')
      return true;
    }
  }
}

function checkWinConditions() {
  var gridValues = {};
  $('.grid > div').each(function() {
    gridValues[this.className.slice(-1)] = this.innerText;
  })
  if (checkMatch(gridValues) || checkScratch()) {
    $('.notifier').append('<a href=""><button>Play Again</button></a>')
    $('.grid > div').off('click');
  }
}

// creates HTML grid components
for(var i = 0; i < board.cells.length; i++) {
  $('.grid').append('<div class="cell-' + board.cells[i] + '"></div>')
}

// player constructor
function Player(name, symbol) {
  this.name = name;
  this.symbol = symbol;
}

// creates two global player instances
var player1 = new Player("Player 1", "X");
var player2 = new Player ("Player 2", "O");

// adds methods for the player instances
function setupPlayers() {
  currentUser = player1;
  changeUser = function() {
    currentUser = currentUser === player1 ? player2 : player1;
  }
}

setupPlayers();
$('.grid > div').click(function(e) {
  var target = $(e.target)
  if ($(target).is(':empty')) {
    target.text(currentUser.symbol);
    checkWinConditions();
    changeUser();
  }

})
