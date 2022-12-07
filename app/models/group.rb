class Group < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_one_attached :group_image

  def get_group_image
    (group_image.attached?) ? group_image : 'no_image.jpg'
  end
end
