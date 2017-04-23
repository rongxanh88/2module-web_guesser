require 'sinatra'
require 'sinatra/reloader'

class WebGuesser
  attr_reader :hidden_number
  attr_accessor :number_x, :background

  def initialize
    @hidden_number = rand(100)
    @number_x = "X"
    @background = "#F0F8FF"
  end

  def check_guess(number)
    if number == 0
      message = ""
    elsif number == hidden_number
      message = "You got it right!"
      number_x = hidden_number
      @background = "#008000"
    elsif number <= (hidden_number - 5)
      message = "Way too low!"
      @background = "#FF0000"
    elsif number >= (hidden_number + 5)
      message = "Way too high!"
      @background = "#FF0000"
    elsif number < hidden_number
      message = "Too low!"
      @background = "#FF6347"
    elsif number > hidden_number
      message = "Too high!"
      @background = "#FF6347"
    end
    message
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