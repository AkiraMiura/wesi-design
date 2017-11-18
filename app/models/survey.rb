class Survey < ApplicationRecord
    has_many :data, dependent: :destroy
    belongs_to :user
    
    attr_accessor :file
    
    validates :name, presence: true, length: { maximum: 50 }
    
end
