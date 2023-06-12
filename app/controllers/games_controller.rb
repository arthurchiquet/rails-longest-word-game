require 'open-uri'
require 'json'


class GamesController < ApplicationController
  def new
    session[:score] ||= 0
    @letters = Array.new(10) { ("a".."z").to_a.sample.upcase }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    response_json = JSON.parse(URI.open(url).read)

    if !response_json["found"]
      @result = "not an english word"
    elsif !check_word(params[:word], params[:letters])
      @result = "not in the grid"
    else
      session[:score] += params[:word].length**2
      @result = "well done! You're score is #{session[:score]}"
    end
  end

  private

  def check_word(attempt, grid)
    new_attemp = attempt.chars
    selected_grid = []
    grid.split.each { |x| selected_grid << x.downcase if new_attemp.include?(x.downcase) }
    return true if new_attemp.all? { |x| selected_grid.include?(x) } && new_attemp.size <= selected_grid.size

    return false
  end

end
