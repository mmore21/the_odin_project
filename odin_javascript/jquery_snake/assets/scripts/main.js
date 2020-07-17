// GLOBAL VARIABLES
//
// used to create the front-end cells
var cells = [];
// snake body which contains coordinates
var body = [];
// initial snake direction
var direction = "right"
// coordinate of current food
var currentFood;
// class name of current food
var currentFoodClass;
// gradually speeds up the speed of the interval
var snakeSpeed = 100 - body.length;

// adds two coordinates to the end of the body array then spawns food
function eatFood() {
  var endOfArray = body.slice(-2);
  // horizontal
  if (endOfArray[0][0] !== endOfArray[1][0]) {
    if (endOfArray[0][0] > endOfArray[1][0]) {
      body.push(endOfArray[1][0] - 1, endOfArray[1][1])
    }
    else {
      body.push(endOfArray[1][0] + 1, endOfArray[1][1])
    }
  }
  // vertical
  else if (endOfArray[0][1] !== endOfArray[1][1]) {
    if (endOfArray[0][1] > endOfArray[1][1]) {
      body.push(endOfArray[1][0], endOfArray[1][1] - 1)
    }
    else {
      body.push(endOfArray[1][0], endOfArray[1][1] - 1)
    }
  }
  spawnFood();
}

// creates currentFood and currentFoodClass (and paints food onto grid)
function spawnFood() {
  var randomX = Math.floor((Math.random() * 40) + 1);
  var randomY = Math.floor((Math.random() * 40) + 1);
  for(var i = 0; i < body.length; i++) {
    if (body[i][0] === randomX && body[i][1] === randomY) {
      spawnFood();
    }
  }
  currentFood = [randomX, randomY];
  currentFoodClass = "." + randomX + "h" + randomY + "v";
  $(currentFoodClass).css('background-color', 'red');
}

// checks if the snake hits the edges of the grid
function hitsBoundaries(current) {
  if (current[0] > 40 || current[1] > 40 || current[0] < 1 || current[1] < 1) {
    return true;
  }
}

// checks if the snake runs into itself
function eatsItself(current) {
  for(var i = 0; i < body.length; i++) {
    if (body[i][0] == current[0] && body[i][1] == current[1]) {
      return true;
    }
  }
}

// uses an interval to move the snake and keep track of score
function moveSnake() {
  var interval = setInterval(function() {
    var copy = jQuery.extend(true, [], body)
    var current = copy[0];
    if (direction === "right") {
      current[0]++;
    }
    else if (direction === "left") {
      current[0]--;
    }
    else if (direction === "up") {
      current[1]--;
    }
    else if (direction === "down") {
      current[1]++;
    }
    body.pop();
    if (hitsBoundaries(current) || eatsItself(current)) {
      alert("You lose. Score was " + (body.length + 1))
      clearInterval(interval);
      interval = false;
    }
    if (current[0] === currentFood[0] && current[1] === currentFood[1]) {
      eatFood();
    }
    body.unshift(current);
    $('.score').text("Score: " + body.length)
    if (interval !== false) {
      drawSnake();
    }
  }, snakeSpeed)
}

// draws the snake on the grid
function drawSnake() {
  $("div:not("+ currentFoodClass + ")").css('background-color', 'white');
  for(var i = 0; i < body.length; i++) {
    var class_name = "." + body[i][0] + "h" + body[i][1] + "v";
    $(class_name).css('background-color', 'black');
  }
}

// controls and creates the snake
function snake() {
  // initial snake body
  body.push([20,20], [19,20], [18,20], [17,20])
  drawSnake();
}

// cell object constructor
function cell(location) {
    this.location = location;
}

// creates the grid
function grid() {
  for(i = 1; i < 41; i++) {
    for (j = 1; j < 41; j++) {
      current = new cell([i, j]);
      cells.push(current);
      $('.grid').append('<div class="' + j + 'h' + i + 'v' + '"></div>')
    }
  }
}

// receives arrow input and changes the global direction variable accordingly
$(document).keydown(function(e) {
    if (e.keyCode == 37 && direction !== "right") {
      direction = "left";
    }
    else if (e.keyCode == 38 && direction !== "down") {
      direction = "up";
    }
    else if (e.keyCode == 39 && direction !== "left") {
      direction = "right";
    }
    else if (e.keyCode == 40 && direction !== "up") {
      direction = "down";
    }
});

$(document).ready(function () {
  grid();
  spawnFood();
  snake();
  moveSnake();
})
