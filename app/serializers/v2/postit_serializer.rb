class V2::PostitSerializer < V1::PostitSerializer
  attributes :id, :title, :body, :level
  belongs_to :user
end
