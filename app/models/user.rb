class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    
    has_secure_password
    
    validates :work,presence: true,numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 60}
    validates :short_break,presence: true,numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 60}
    validates :long_break,presence: true,numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 60}
    
    has_many :tasks
    has_many :memos
    has_many :posts
end
