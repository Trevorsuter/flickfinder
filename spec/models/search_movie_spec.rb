require 'rails_helper'

RSpec.describe SearchMovie, type: :model do
  describe 'relationships' do
    it { should belong_to :search }
    it { should belong_to :movie }
  end
end
