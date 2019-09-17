class Location < ApplicationRecord
    has_many :tasks, dependent: :destroy
    has_many :users, through: :tasks

    validates_presence_of :name

end
