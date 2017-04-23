require 'sinatra'
require 'sinatra/reloader'

class WebGuesser
  attr_reader :hidden_number
  attr_accessor :number_x, :background, :guesses_remaining

  def initialize
    @hidden_number = rand(100)
    @number_x = "X"
    @background = "#F0F8FF"
    @guesses_remaining = 6
  end

  def check_guess(number)
    if number == 0
      message = ""
    elsif number == hidden_number
      message = "You got it right! Game reset, a new number has been generated."
      number_x = hidden_number
      set_background("green")
      reset_game
    elsif number <= (hidden_number - 5)
      message = "Way too low!"
      set_background("red")
    elsif number >= (hidden_number + 5)
      message = "Way too high!"
      set_background("red")
    elsif number < hidden_number
      message = "Too low!"
      set_background("light red")
    elsif number > hidden_number
      message = "Too high!"
      set_background("light red")
    end

    deduct_guesses_remaining
    guesses_remaining == 0 ? reset_game : message
  end

  def set_background(color)
    case color
    when "red"
      @background = "#FF0000"
    when "light red"
      @background = "#FF6347"
    when "green"
      @background = "#008000"
    end
  end

  def reset_guesses
    @guesses_remaining = 6
  end

  def deduct_guesses_remaining
    @guesses_remaining -= 1
  end

  def reset_game
    reset_guesses
    @hidden_number = rand(100)
    "Game has reset"
  end

end

wb = WebGuesser.new

get '/' do
  guessed_number = params["guess"]
  message = wb.check_guess(guessed_number.to_i)
  
  erb :index, :locals => {
    :hidden_number => wb.number_x, :message => message,
    :background_color => wb.background
  }
end