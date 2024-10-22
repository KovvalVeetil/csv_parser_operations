class Building < ApplicationRecord
    has_one_attached :csv_file
    validates :name, presence: true
    validates :height, numericality: { greater_than: 0 }
end
