class V1::PostitSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :level, :is_private
  belongs_to :user
end
