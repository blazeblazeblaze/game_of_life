require 'spec_helper'

RSpec.describe Cell do
  let(:state) { true }
  let(:alive_neighbour) { instance_double(described_class, alive?: true) }
  let(:dead_neighbour) { instance_double(described_class, alive?: false) }

  subject do
    described_class.new(row: 0, cell: 0, initial_state: state)
  end

  describe '#alive?' do
    context 'cell is alive' do
      it 'returns true' do
        expect(subject.alive?).to eq true
      end
    end

    context 'cell is dead' do
      let(:state) { false }
      it 'returns false' do
        expect(subject.alive?).to eq false
      end
    end
  end

  describe '#next_state' do
    let(:neighbours) { [] }
    let(:board) { double }
    let(:next_state) { subject.next_state(board) }

    before do
      allow(board).to receive(:neighbours_of) { neighbours }
    end

    it 'returns new instance of Cell' do
      expect(next_state).not_to equal(subject)
      expect(next_state).to be_a(described_class)
    end

    context 'live cell has fewer than two live neighbours' do
      let(:neighbours) { [alive_neighbour] }

      it 'becomes dead' do
        expect(next_state.alive?).to eq(false)
      end
    end

    context 'live cell has two or three live neighbours' do
      let(:neighbours) { [alive_neighbour, alive_neighbour] }

      it 'becomes alive' do
        expect(next_state.alive?).to eq(true)
      end
    end

    context 'live cell has more than three live neighbours' do
      let(:neighbours) do
        [
          alive_neighbour,
          alive_neighbour,
          alive_neighbour,
          alive_neighbour
        ]
      end

      it 'becomes dead' do
        expect(next_state.alive?).to eq(false)
      end
    end

    context 'dead cell with exactly three live neighbours' do
      let(:state) { false }
      let(:neighbours) { [alive_neighbour, alive_neighbour, alive_neighbour] }

      it 'becomes alive' do
        expect(next_state.alive?).to eq(true)
      end
    end
  end
end
