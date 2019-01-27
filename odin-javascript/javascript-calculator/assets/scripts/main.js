function add(num1, num2) {
  return num1 + num2;
}

function subtract(num1, num2) {
  return num1 - num2;
}

function multiply(num1, num2) {
  return num1 * num2;
}

function divide(num1, num2) {
  return num1 / num2;
}

function calculate(numbers, operator) {
  if (operator === '+') {
    return add(numbers[0], numbers[1])
  }
  else if (operator === '-') {
    return subtract(numbers[0], numbers[1])
  }
  else if (operator === '*') {
    return multiply(numbers[0], numbers[1])
  }
  else if (operator === '/') {
    return divide(numbers[0], numbers[1])
  }
}

$(document).ready(function() {
  var digits = [];
  var numbers = [];
  var operator;
  $(this).click(function() {
    var current = event.target.innerText;
    if (['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].includes(current)) {
      digits.push(current);
      $('.screen').text(digits.join(''));
    }
    else if (['+', '-', '*', '/'].includes(current)) {
      if (digits.length > 0) {
        numbers.push(Number(digits.join('')));
      }
      digits = [];
      if (numbers.length == 2) {
        var result = calculate(numbers, operator);
        $('.screen').text(result);
        numbers = [result];
      }
      operator = current;
    }
    else if (current === '=') {
      numbers.push(Number(digits.join('')))
      digits = [];
      if (numbers.length == 2) {
        var result = calculate(numbers, operator);
        $('.screen').text(result);
        numbers = [result];
      }
    }
    else if (current === "Clear") {
      $('.screen').text('');
      digits = [];
      numbers = [];
    }
  })
})
