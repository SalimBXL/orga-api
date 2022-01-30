class Postit < ApplicationRecord

    belongs_to :user

    validates_presence_of :user, :title, :level, :body
    validates_numericality_of :level
end
