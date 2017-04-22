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
  erb :index, :locals => {:hidden_number => wb.hidden_number}
end