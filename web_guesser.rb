require 'sinatra'
require 'sinatra/reloader'

class WebGuesser
  attr_reader :hidden_number

  def initialize
    @hidden_number = rand(100)
  end

end

wb = WebGuesser.new

get '/' do
  "The secret number is X, where the secret number is #{wb.hidden_number}."
end