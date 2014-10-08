require 'uncle_sam/commands/command'

describe UncleSam::Commands::Command do
  describe '#print(key)' do
    it 'prints the fetched message' do
      command = UncleSam::Commands::Command.new
      allow(command).to receive(:fetch_message).with(:example) { 'test' }
      expect(command).to receive(:puts).with('test')
      command.print(:example)
    end
  end

  describe '#fetch_message(key)'
end
