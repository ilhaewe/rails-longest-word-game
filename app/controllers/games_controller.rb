
require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = Array.new(10) { alphabet.sample }
  end

  def score
    @letters = params[:letters].split(" ")
    @word = params[:word].upcase

    @included = @word.chars.all? { |letter| @letters.include?(letter) }

    if @included
      url = "https://dictionary.lewagon.com/#{@word}"
      begin
        response = URI.open(url).read
        json = JSON.parse(response)
        @english_word = json["found"]
      rescue
        @english_word = false
      end
    else
      @english_word = false
    end
  end
end
