$(document).ready(function() {
  $('.container').append('<h1 class="text-center">Restaurant</h1>',
  '<img src="https://i.pinimg.com/736x/03/96/a1/0396a1451e93a14f935a0c0f0a62f3d0--restaurant-interior-design-restaurant-interiors.jpg" alt="Modern restaurant" />',
  '<hr />',
  '<p class="content">Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p>'
  );

  $('li').eq(0).on('click', function() {
    $('.content').html('<p class="content">Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p>');
  })

  $('li').eq(1).on('click', function() {
    $('.content').html('<ul><li>Python - $14.99</li><li>Ruby - $29.99</li><li>C - $9.99</li><li>Java - $4.99</li></ul>');
  })

  $('li').eq(2).on('click', function() {
    $('.content').html('<p class="content">You can find our restaurant at Port 12345 on The World Wide Web.</p>');
  })
})
