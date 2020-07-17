// using jQuery Validation Plugin

$("#important-form").validate();


// custom validation from scratch
var customValidation = (function() {
  return {
    required:function(element) {
      $(".btn").click(function() {
        value = element.val();
        if ($(value).length > 0) {
          return true;
        }
        else {
          $(element).after("<p class='custom-error'>Field must be present.</p>");
          return false;
        }
      })
    },
    getRequired:function(arr) {
      for (var i = 0; i < arr.length; i++) {
        customValidation.required($(arr[i]));
      }
    }
  }
}());

// add required fields here (an example is below)
// customValidation.getRequired($(['#email', '#pw2']));
