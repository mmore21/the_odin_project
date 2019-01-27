require 'sinatra'
require 'sinatra/reloader' if development?
require './lib/caesar_cipher'
require './lib/hangman.rb'
enable :sessions

# index
get '/' do
  erb :index, layout: :layout
end

# caesar cipher
get '/cipher' do
  string = params['string'].to_s
  shift_number = params['shift_number'].to_i
  answer = CaesarCipher.new(string, shift_number).cipher_message
  erb :cipher, :locals => { :answer => answer }
end

# hangman
helpers do
  def set_hangman
    session[:game] = Game.new
  end
end

get '/hangman' do
  set_hangman if session[:game].nil? || params[:new] == "true"

  guess = params[:guess]
  session[:game].turn(guess)
  turns = session[:game].turns
  hidden_array = session[:game].solution.hidden_array.join(' ')
  used_letters = session[:game].used_letters.join(' ')

  if session[:game].solution.word == session[:game].solution.hidden_array.join('')
    message = "You guessed the word correctly! Click 'New Game' to generate a new word."
  elsif session[:game].turns == 0
    message = "Out of turns. Click 'New Game' to generate a new word. The word was #{session[:game].solution.word}."
  end

  erb :hangman, :locals => { :message => message, :hidden_array => hidden_array, :used_letters => used_letters, :turns => turns }
end
