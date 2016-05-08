require_relative 'spec_helper'

describe Player do
	let (:player) {Player.new("Test Player", "D")}

	it 'initializes with player name' do
		expect(player.name).to eq("Test Player")
	end

	it 'initializes with player mark' do
		expect(player.mark).to eq("D")
	end

	it 'initializes with a UserInterface' do
		expect(player.ui.class).to eq(UserInterface)
	end
end