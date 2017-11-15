class Survey < ApplicationRecord
    has_many :data, dependent: :destroy
    belongs_to :user
end
