$('button').click(function(e) {
  e.preventDefault();
  var info = ($('#search').serialize());
  info = info.slice(5);
  console.log(info)
  $.ajax({
      url: 'http://pokeapi.co/api/v2/pokemon-form/' + ($("#search > input").val()),
      method: 'GET',
      data: ($('#search')).serialize()
  }).done(function (response) {
    $('.error').hide();
    $('.results').show();
    $('.name').text(response.name);
    $('.id').text('Pokémon ID: ' + response.id);
    $('.generation').text('Generation: ' + response.version_group.name);
    $('.image').html("<img src='" + response.sprites.front_default + "' />");
  }).fail(function (response) {
    console.log("Error accessing API.")
    $('.results').hide();
    $('.error').show().text("Error (Pokémon name not found in database)");
  });

})
