require 'uncle_sam/commands/command'

describe UncleSam::Commands::Command do
  let(:command) { UncleSam::Commands::Command.new }

  describe '#print(key)' do
    it 'prints the fetched message' do
      allow(command).to receive(:fetch_message).with(:example) { 'test' }
      expect(command).to receive(:puts).with('test')
      command.print(:example)
    end
  end

  describe '#fetch_message(key)' do
    it 'retrieves the message corresponding from the messages.yml file' do
      result = command.fetch_message(:usage)
      expect(result).to be_a(String)
    end
  end
end
