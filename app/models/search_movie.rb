class SearchMovie < ApplicationRecord
  belongs_to :search
  belongs_to :movie
end
