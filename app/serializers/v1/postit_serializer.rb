class V1::PostitSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :level
  belongs_to :user
end
