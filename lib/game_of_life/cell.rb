class Cell
  attr_reader :cell, :row, :state

  def initialize(row:, cell:, initial_state:)
    @row = row
    @cell = cell
    @state = initial_state
  end

  def next_state(board)
    self.class.new(
      row: row,
      cell: cell,
      initial_state: new_state(board)
    )
  end

  def alive?
    state
  end

  private

  def new_state(board)
    neighbours_count = board.neighbours_of(row, cell).count(&:alive?)

    if alive? && (neighbours_count < 2 || neighbours_count > 3)
      false
    elsif alive? && (neighbours_count == 2 || neighbours_count == 3)
      true
    elsif !alive? && neighbours_count == 3
      true
    else
      alive?
    end
  end
end
