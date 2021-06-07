require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'relationships' do
    it { should have_many :search_movies }
    it { should have_many(:searches).through(:search_movies) }
  end
end
