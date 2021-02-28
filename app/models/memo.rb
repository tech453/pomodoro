class Memo < ApplicationRecord
    validates :content,presence: true,length: {minimum: 1,maximum: 500}
    belongs_to :user
end
