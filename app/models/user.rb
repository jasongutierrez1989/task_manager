class User < ApplicationRecord
    has_secure_password
    
    has_many :tasks, dependent: :destroy
    has_many :locations, through: :tasks

    validates_presence_of :name
    validates :email, uniqueness: { message: "Email already in use, please try a different email or Login."}
end
