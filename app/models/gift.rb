class Gift < ApplicationRecord
  validates :name, presence: true, length: {minimum: 1, maximum: 25}
  validates_uniqueness_of :name
end