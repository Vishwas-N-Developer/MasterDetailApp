class Person < ApplicationRecord
    has_one :detail, dependent: :destroy

    validates :name, presence: true

    accepts_nested_attributes_for :detail
end
