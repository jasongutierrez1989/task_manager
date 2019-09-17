class Task < ApplicationRecord
    belongs_to :user
    belongs_to :location, optional: true

    validates_presence_of :name
end
