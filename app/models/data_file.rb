class DataFile
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  mount_uploader :file, FileUploader

  scope :lifo, -> { order("created_at DESC")}

  validates :file, presence: true
end
