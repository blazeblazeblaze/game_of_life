class BoardPresenter
  ALIVE_CELL = '#'.freeze
  DEAD_CELL = '.'.freeze

  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def self.present(grid)
    new(grid).present
  end

  def present
    grid.each do |cells|
      cells.each do |cell|
        print cell.alive? ? ALIVE_CELL : DEAD_CELL
      end
      puts "\n"
    end
  end
end
