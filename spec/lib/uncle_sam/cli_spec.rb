require 'uncle_sam/cli'

describe UncleSam::CLI do
  describe '.run' do
    it 'executes usage when no arguments are given' do
      expect_any_instance_of(UncleSam::Commands::Usage).to receive(:execute)
      UncleSam::CLI.run('')
    end

    it 'calculates when given a net_income' do
      command = double(UncleSam::Commands::Calculate)
      expect(UncleSam::Commands::Calculate).to receive(:new).with(120000.0, :single) { command }
      expect(command).to receive(:execute)
      UncleSam::CLI.run('120000')
    end
  end
end
