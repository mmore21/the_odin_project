// my_max function - returns highest number in array

function my_max(arr) {
  var max = arr[0];
  for (var i = 0; i < arr.length; i++) {
    if (arr[i] > max) {
      max = arr[i];
    }
  }
  return max
}

// vowel_count function - returns the amount of vowels in a string

function vowel_count(str) {
  var count = 0;
  var arr = str.split('');
  for (var i = 0; i < arr.length; i++) {
    if (["a", "e", "i", "o", "u"].includes(arr[i])) {
      count++;
    }
  }
  return count;
}

// reverse function - returns a reversed string

function reverse(str) {
  return str.split("").reverse().join("")
}
