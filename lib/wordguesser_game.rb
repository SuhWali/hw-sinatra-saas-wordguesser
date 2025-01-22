class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  
  attr_accessor :word, :guesses, :wrong_guesses

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @searched_letters = ""
  end
  
  def guess(letter)

    if letter == nil || letter == "" || letter.match(/[^a-zA-Z]/)
      raise ArgumentError
    end
    
    if @searched_letters.include? letter.downcase
      return false
    end

    if @word.include? letter
      @guesses += letter
      @searched_letters += letter

      return true
    else
      @wrong_guesses += letter
      @searched_letters += letter
      return true
    end
  end

  def word_with_guesses
    @word.chars.map { |letter| @guesses.include?(letter) ? letter : '-' }.join
  end

  def check_win_or_lose
    if @word == word_with_guesses
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play

  end
end


  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, "").body
    end
  end
end
