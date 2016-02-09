class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    word.downcase!
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def word
    @word
  end

  def word=(new_word)
    @word = new_word
  end
  
  def guesses
    @guesses
  end
  
  def wrong_guesses
    @wrong_guesses
  end

  def guess(letter)
    raise ArgumentError.new("Guess was nil") if letter.nil?
    letter.downcase!
    raise ArgumentError.new("Guess was empty") if letter.length==0
    raise ArgumentError.new("Guess was not a letter") unless ('a'..'z').include?(letter)
    if @wrong_guesses.include? letter
      return false
    elsif @guesses.include? letter
      return false
    else
      if @word.include? letter
        @guesses << letter
      else 
        @wrong_guesses << letter
      return true
      end
    end
  end
  
  def word_with_guesses
    guessed_word = ""
    word_array = @word.split('')
    word_array.each do |l|
      if @guesses.include? l
        guessed_word << l
      else
        guessed_word << '-'
      end
    end
    guessed_word
  end
  
  def check_win_or_lose
    # total_guesses = @guesses.length + @wrong_guesses.length
    if @wrong_guesses.length >= 7
      return :lose
    else
      if self.word_with_guesses.eql? @word
        return :win
      else
        return :play
      end
    end
  end
  
    
  

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
