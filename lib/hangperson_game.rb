class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  ROUNDS = 7

  # Get a word from remote "random word" service

  def initialize()
    @word = get_random_word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    raise(ArgumentError) if letter == nil || letter == '' || letter.match(/[^a-zA-Z]/)
    l = letter[0].downcase
    return false if guesses.count(l)>0 || wrong_guesses.count(l)>0
    if word.count(l)>0
      @guesses+=l
    else
      @wrong_guesses+=l
    end
  end
  
  def word_with_guesses
    result = ''
    @word.each_char do |c| 
      if @guesses.count(c) > 0 
        result += c
      else
        result += '-'
      end
    end
        
    return result
  end
  
  def check_win_or_lose
    return :win if word_with_guesses.count('-') == 0
    return :play if @wrong_guesses.length < ROUNDS
    return :lose
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
end

#game=HangpersonGame.new('banana')
#print game.word
#print game.guesses
#game.guess('b')
#puts game.guesses
#puts game.word_with_guesses
#puts game.check_win_or_lose
