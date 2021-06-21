
class Player
    attr_accessor :name, :mark, :score
  
    def initialize
      @name = nil
      @mark = nil
      @score = 0
    end
  
    def set_name
      puts "What is your name?"
      self.name = gets.chomp
    end

    def set_mark(mark)
      self.mark = mark
    end

    def update_score
      self.score += 1
    end
  end