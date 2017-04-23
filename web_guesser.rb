require 'sinatra'
require 'sinatra/reloader'

class WebGuesser
  attr_reader :hidden_number

  def initialize
    @hidden_number = rand(100)
  end

  def check_guess(number)
    if number.nil?
      message = ""
    elsif number == hidden_number
      message = "Your guess is correct!"
    elsif number < hidden_number
      message = "Your guess is too low"
    elsif number > hidden_number
      message = "Your guess is too high"
    end
    message
  end

end

wb = WebGuesser.new

get '/' do
  message = ""
  erb :index, :locals => {
    :hidden_number => wb.hidden_number, :message => message
  }

  guessed_number = params["guess"]
  message = wb.check_guess(guessed_number.to_i)
  erb :index, :locals => {
    :hidden_number => wb.hidden_number, :message => message
  }
end