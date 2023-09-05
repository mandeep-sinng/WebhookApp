class ApiLink < ApplicationRecord
    validates :title, presence: true
    validates :url, presence: true
    validates :token, presence: true
end
