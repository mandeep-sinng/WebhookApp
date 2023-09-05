class ApiLink < ApplicationRecord
    validates :title, presence: true
    validates :link, presence: true
    validates :token, presence: true
end
