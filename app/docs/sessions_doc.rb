module SessionsDoc
  extend Apipie::DSL::Concern

  api :Post, 'sessions', 'Creates user and returns auth token'
  example '
  {
    "data": {
      "id": "5b79d04fe6fc8c1d58c339e7",
      "type": "users",
      "attributes": {
        "auth-token": "e567a7d3466fb271bd7765ed5a210266"
      }
    }
  }'
  def create; end
end
