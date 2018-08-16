class ImageSerializer < ActiveModel::Serializer
  attributes :file_url, :width, :height

  def file_url
    object.file.resized.url
  end
end
