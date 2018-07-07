class Board
  attr_accessor :grid
  attr_reader :rows_count, :cells_count

  def initialize(rows_count, cells_count)
    @rows_count = rows_count
    @cells_count = cells_count
    @grid = init_grid
  end

  def neighbours_of(row, cell)
    next_row = row + 1
    prev_row = row - 1
    next_cell = cell + 1
    prev_cell = cell - 1

    [
      cell_at(next_row, cell),
      cell_at(next_row, next_cell),
      cell_at(next_row, prev_cell),
      cell_at(prev_row, cell),
      cell_at(prev_row, next_cell),
      cell_at(prev_row, prev_cell),
      cell_at(row, next_cell),
      cell_at(row, prev_cell)
    ].compact
  end

  def alive?
    grid.flatten.any?(&:alive?)
  end

  def cell_at(row, cell)
    return unless row >= 0 && row < rows_count
    return unless cell >= 0 && cell < cells_count

    grid[row][cell]
  end

  def tick
    @grid = grid.map do |cells|
      cells.map { |cell| cell.next_state(self) }
    end
  end

  def present(presenter_klass)
    presenter_klass.present(grid)
  end

  private

  def init_grid
    Array.new(rows_count) do |row|
      Array.new(cells_count) do |cell|
        state = [true, false].sample
        Cell.new(row: row, cell: cell, initial_state: state)
      end
    end
  end
end
