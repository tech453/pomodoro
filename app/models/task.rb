class Task < ApplicationRecord
    validates :content,presence: true,length: {minimum: 1,maximum: 20}
    belongs_to :user
end
