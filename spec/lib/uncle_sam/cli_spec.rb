require './lib/uncle_sam/cli'

describe UncleSam::CLI do
  describe '.run' do
    it 'prints usage statement when no arguments are given' do
      expect(UncleSam::CLI).to receive(:print).with(:usage)
      UncleSam::CLI.run('')
    end
  end

  describe '.print(key)' do
    it 'prints the statement corresponding to the key' do
      expect(UncleSam::CLI).to receive(:puts)
      UncleSam::CLI.print(:example)
    end
  end

  describe '.message(key)' do
    it 'looks up a message from the messages.yml file' do
      message = UncleSam::CLI.message(:usage)
      expect(message).to be_a(String)
    end
  end
end
