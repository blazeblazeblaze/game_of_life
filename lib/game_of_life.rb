require 'pry'
require 'game_of_life/version'
require 'game_of_life/cell'
require 'game_of_life/board'
require 'game_of_life/board_presenter'

module GameOfLife
  TICK_PERIOD = 0.5
  ROWS_COUNT = 40
  COLUMN_COUNT = 80

  def self.start
    board = Board.new(ROWS_COUNT, COLUMN_COUNT)

    while board.alive?
      system 'clear'
      board.present(BoardPresenter)
      puts 'Press Ctrl-C to Exit!'
      sleep(TICK_PERIOD)
      board.tick
    end
  rescue Interrupt
    puts 'End of life.'
  end
end
