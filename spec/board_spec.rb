require 'spec_helper'

RSpec.describe Board do
  let(:heigth) { 5 }
  let(:width) { 5 }
  subject { described_class.new(heigth, width) }

  it 'initializes random grid' do
    expect(subject.grid).not_to be_nil
  end

  describe '#neighbours_of' do
    context 'given cell location is on the corner the board' do
      it 'returns 3 neighbours' do
        neighbours = subject.neighbours_of(0, 0)
        expect(neighbours.count).to eq(3)
      end
    end

    context 'given cell location is on the edge of the board' do
      it 'returns 5 neighbours' do
        neighbours = subject.neighbours_of(1, 0)
        expect(neighbours.count).to eq(5)
      end
    end

    context 'given cell location is surrounded by other cells' do
      it 'returns all 8 neighbours' do
        neighbours = subject.neighbours_of(1, 1)
        expect(neighbours.count).to eq(8)
      end
    end
  end

  describe '#alive?' do
    context 'when no alive cells remain' do
      let(:dead_grid) { [instance_double(Cell, alive?: false)] }
      before { allow(subject).to receive(:grid) { dead_grid } }

      it 'returns false' do
        expect(subject.alive?).to eq(false)
      end
    end

    context 'when alive cells remain' do
      let(:alive_grid) { [instance_double(Cell, alive?: true)] }
      before { allow(subject).to receive(:grid) { alive_grid } }

      it 'returns true' do
        expect(subject.alive?).to eq(true)
      end
    end
  end

  describe '#cell_at' do
    context 'given cell location is within boundaries' do
      it 'returns cell' do
        expect(subject.cell_at(0, 0)).to be_a(Cell)
      end
    end

    context 'given cell location is outside boundaries' do
      it 'returns nil' do
        expect(subject.cell_at(heigth + 1, width)).to be_nil
      end
    end
  end

  describe '#tick' do
    let(:cell) { instance_double(Cell) }

    it 'sets new grid state' do
      expect { subject.tick }.to change { subject.grid }
    end

    context 'new state generation' do
      before do
        allow(subject).to receive(:grid) { [[cell]] }
        allow(cell).to receive(:next_state)
        subject.tick
      end

      it 'delegates state generation to each cell' do
        expect(cell).to have_received(:next_state)
      end
    end
  end

  describe '#present' do
    let(:presenter) { double }

    before do
      allow(presenter).to receive(:present)
      subject.present(presenter)
    end

    it 'delegates presentation to its presenter' do
      expect(presenter).to have_received(:present).with(subject.grid)
    end
  end
end
