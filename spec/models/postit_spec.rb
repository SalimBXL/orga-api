require 'rails_helper'

RSpec.describe Postit, type: :model do
  
  describe "Model validations" do
    it { should belong_to(:user) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:level) }
    it { should validate_numericality_of(:level) }
  end

end
