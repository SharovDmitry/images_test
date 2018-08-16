class Image
  include Mongoid::Document
  field :width, type: Integer
  field :height, type: Integer
  mount_base64_uploader :file, FileUploader

  belongs_to :user

  validates :width, :height, :file, presence: true
  validates :width, :height, numericality: { only_integer: true, greater_than: 0 }
end
