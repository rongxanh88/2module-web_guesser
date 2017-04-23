require 'sinatra'
require 'sinatra/reloader'
require 'pry'

class WebGuesser
  attr_reader :hidden_number, :number_x

  def initialize
    @hidden_number = rand(100)
    @number_x = "X"
  end

  def check_guess(number)
    if number == 0
      message = ""
    elsif number == hidden_number
      message = "You got it right!"
      @number_x = hidden_number
    elsif number <= (hidden_number - 5)
      message = "Way too low!"
    elsif number >= (hidden_number + 5)
      message = "Way too high!"
    elsif number < hidden_number
      message = "Too low!"
    elsif number > hidden_number
      message = "Too high!"
    end
    message
  end

end

wb = WebGuesser.new

get '/' do
  guessed_number = params["guess"]
  message = wb.check_guess(guessed_number.to_i)
  
  erb :index, :locals => {
    :hidden_number => wb.number_x, :message => message
  }
end