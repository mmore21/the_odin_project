function myEach(array, callback) {
  for (var i = 0; i < array.length; i++) {
    callback(array[i])
  }
}

// test myEach function
myEach([1,2,3,4], function(item) {
  console.log(item);
});

function myMap(array, callback) {
  var newArray = [];
  myEach(array, function(item) {
    newArray.push(callback(item));
  });
  return newArray;
}

// test myMap function
myMap([1,2,3,4], function(item){
  return item * 2;
});

// Bianca Gandolfo's callback problems

function funcCaller(arg, func) {
  return func(arg);
}

function firstVal(obj, func) {
  return func(obj[Object.keys(arr)[0]], 0, obj);
}

function once(callback) {
  var called = false
  return function() {
    if (!called) {
      called = true;
      callback.apply(this, arguments);
    }
    else {
      console.log("Function has already been called.");
    }
  }
}
