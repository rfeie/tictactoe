require_relative 'spec_helper'

describe Node do
	let(:node) {Node.new(1)}

	context 'attributes' do
		it "has a pos" do
			expect(node.pos).to eq(1)
		end

		it "has content" do
			node.content = "X"
			expect(node.content).to eq("X")
		end
		
		it "has an upper left direction" do
			node.directions[:upper_left] = "X"
			expect(node.directions[:upper_left]).to eq("X")
		end
		
		it "has an above direction" do
			node.directions[:above] = "X"
			expect(node.directions[:above]).to eq("X")
		end
		
		it "has an upper right direction" do
			node.directions[:upper_right] = "X"
			expect(node.directions[:upper_right]).to eq("X")
		end
		
		it "has an left direction" do
			node.directions[:left] = "X"
			expect(node.directions[:left]).to eq("X")
		end
		
		it "has an right direction" do
			node.directions[:right] = "X"
			expect(node.directions[:right]).to eq("X")
		end
		
		it "has an lower left direction" do
			node.directions[:lower_left] = "X"
			expect(node.directions[:lower_left]).to eq("X")
		end
		
		it "has an below direction" do
			node.directions[:below] = "X"
			expect(node.directions[:below]).to eq("X")
		end
		
		it "has an lower right direction" do
			node.directions[:lower_right] = "X"
			expect(node.directions[:lower_right]).to eq("X")
		end
	end
end