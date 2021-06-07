require 'rails_helper'

RSpec.describe Search, type: :model do
  describe 'validations' do
    it { should validate_presence_of :query }
  end

  describe 'relationships' do
    it { should have_many :search_movies }
    it { should have_many(:movies).through(:search_movies) }
  end
end
