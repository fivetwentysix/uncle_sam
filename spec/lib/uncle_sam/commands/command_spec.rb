require 'uncle_sam/commands/command'

describe UncleSam::Commands::Command do
  let(:command) { UncleSam::Commands::Command.new }

  describe '#print(key, *args)' do
    it 'prints the fetched message' do
      allow(command).to receive(:fetch_message).with(:example) { 'test' }
      expect(command).to receive(:puts).with('test')
      command.print(:example)
    end

    it 'print and substring fetched messages with args' do
      allow(command).to receive(:fetch_message).with(:example) { '%s %s' }
      expect(command).to receive(:puts).with('hello world')
      command.print(:example, 'hello', 'world')
    end
  end

  describe '#fetch_message(key)' do
    it 'retrieves the message corresponding from the messages.yml file' do
      result = command.fetch_message(:usage)
      expect(result).to be_a(String)
    end
  end
end
