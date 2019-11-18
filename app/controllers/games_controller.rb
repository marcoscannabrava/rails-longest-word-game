require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (("A".."Z").to_a * 4).sample(10)
  end

  def score
    # TODO: runs the game and return detailed hash of result
    url = "https://wagon-dictionary.herokuapp.com/#{params[:attempt]}"
    dictionary_call = JSON.parse(open(url).read)
    @time = Time.new() - Time.parse(params[:start_time])
    @score = 0
    # check if letters are in grid
    if params[:attempt].upcase.chars.all? { |letter| params[:attempt].upcase.chars.count(letter) <= params[:grid].count(letter) }
      # letters in grid?
      if dictionary_call["found"] == false
        @message = "Sorry, the given word is not an english word..."
      else
        @message = "Well done! That was a good answer."
        @score = dictionary_call["length"] + (1 / @time)
      end
    else
      @message = "Sorry, some letters are not in the grid."
    end
  end
end
