require 'rails_helper'

RSpec.describe Postit, type: :model do
  
  describe "Model validations" do
    it { should belong_to(:user) }
    it { should validate_presence_of(:user) }
  end

end
