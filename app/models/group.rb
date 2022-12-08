class Group < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_one_attached :image

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
end
