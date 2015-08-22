require "spec_helper"

RSpec.describe Bot::BaseBot do
  let(:bot) { double(:bot) }
  let(:base_bot) { Bot::BaseBot.new(bot) }
  let(:command_asd) { "asd" }
  let(:command_qwe) { "qwe" }

  before do
    base_bot
  end

  describe '#register_command' do
    let(:expected_result) do
      { command_asd => {} }
    end

    before do
      base_bot.register_command(command_asd, {})
    end

    it 'should add command to list of commands' do
      expect(base_bot.instance_variable_get(:@commands)).to eq expected_result
    end
  end

  describe '#regex_commands' do
    let(:expected_result) { /\/asd|\/qwe/ }

    before do
      base_bot.register_command(command_asd, {})
      base_bot.register_command(command_qwe, {})
    end

    it 'should return a regexp containing both commands' do
      expect(base_bot.regex_commands).to eq expected_result
    end

    it 'should match /asd' do
      expect(base_bot.regex_commands.match("/asd")).to be
    end

    it 'should match /qwe' do
      expect(base_bot.regex_commands.match("/qwe")).to be
    end
  end
end
