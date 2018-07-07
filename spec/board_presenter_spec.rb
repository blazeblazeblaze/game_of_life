require 'spec_helper'

RSpec.describe BoardPresenter do
  let(:alive_cell) { instance_double(Cell, alive?: true) }
  let(:dead_cell) { instance_double(Cell, alive?: false) }
  let(:grid) { [[alive_cell], [dead_cell]] }

  subject { described_class.new(grid) }

  describe '#present' do
    it 'formats grid into #, ., and new lines' do
      expect { subject.present }.to output("#\n.\n").to_stdout
    end
  end
end
