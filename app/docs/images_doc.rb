module ImagesDoc
  extend Apipie::DSL::Concern

  api :GET, 'api/v1/images', 'Returns all user previously resized images'
  error code: 401, desc: 'Unauthorized'
  header 'Auth-token', 'User auth token', required: true
  example '
  {
    "data": [
      {
        "id": "5b75b55be6fc8c1784328405",
        "type": "images",
        "attributes": {
          "file-url": "/uploads/image/file/5b75b55be6fc8c1784328405/resized_file.gif",
          "width": 100,
          "height": 200
        }
      },
      {
        "id": "5b75ba68e6fc8c1784328406",
        "type": "images",
        "attributes": {
          "file-url": "/uploads/image/file/5b75ba68e6fc8c1784328406/resized_file.gif",
          "width": 444,
          "height": 555
        }
      }
    ]
  }'
  def index; end

  api :POST, 'api/v1/images', 'Resizing image, returns resized image url, width and height'
  formats ['json']
  error code: 400, desc: 'Bad request'
  error code: 401, desc: 'Unauthorized'
  error code: 422, desc: 'Unprocessable entity'
  header 'Auth-token', 'User auth token', required: true
  param :image, Hash, required: true do
    param :width, Integer, desc: 'Image new width', required: true
    param :height, Integer, desc: 'Image new height', required: true
    param :file, ['Base64'], desc: 'File to resize', required: true
  end
  example '
  {
    "data": {
      "id": "5b79d731e6fc8c1a609e5ad6",
      "type": "images",
      "attributes": {
        "file-url": "/uploads/image/file/5b79d731e6fc8c1a609e5ad6/resized_file.gif",
        "width": 100,
        "height": 200
      }
    }
  }'
  def create; end

  api :PUT, 'api/v1/images/:id', 'Resizing image one more time, returns resized image url, width and height'
  formats ['json']
  error code: 400, desc: 'Bad request'
  error code: 401, desc: 'Unauthorized'
  error code: 404, desc: 'Not found'
  error code: 422, desc: 'Unprocessable entity'
  header 'Auth-token', 'User auth token', required: true
  param :image, Hash, required: true do
    param :width, Integer, desc: 'Image new width', required: true
    param :height, Integer, desc: 'Image new height', required: true
  end
  example '
  {
    "data": {
      "id": "5b79d731e6fc8c1a609e5ad6",
      "type": "images",
      "attributes": {
        "file-url": "/uploads/image/file/5b79d731e6fc8c1a609e5ad6/resized_file.gif",
        "width": 500,
        "height": 600
      }
    }
  }'
  def update; end
end
