require 'uncle_sam/cli'

describe UncleSam::CLI do
  describe '.run' do
    it 'executes usage when no arguments are given' do
      expect_any_instance_of(UncleSam::Commands::Usage).to receive(:execute)
      UncleSam::CLI.run('')
    end
  end

  describe '#print(key)' do
    xit 'prints the statement corresponding to the key' do
      expect(UncleSam::CLI).to receive(:puts)
      UncleSam::CLI.print(:example)
    end
  end

  describe '#message(key)' do
    xit 'looks up a message from the messages.yml file' do
      message = UncleSam::CLI.message(:usage)
      expect(message).to be_a(String)
    end
  end
end
