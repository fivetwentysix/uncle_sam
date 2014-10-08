require 'uncle_sam/cli'

describe UncleSam::CLI do
  describe '.run' do
    it 'executes usage when no arguments are given' do
      expect_any_instance_of(UncleSam::Commands::Usage).to receive(:execute)
      UncleSam::CLI.run('')
    end
  end
end
