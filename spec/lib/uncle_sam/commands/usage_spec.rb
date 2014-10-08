require 'uncle_sam/commands'

describe UncleSam::Commands::Usage do
  describe '#execute' do
    it 'prints :usage' do
      command = UncleSam::Commands::Usage.new
      expect(command).to receive(:print).with(:usage)
      command.execute
    end
  end
end
