class Group < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_one_attached :group_image


end
