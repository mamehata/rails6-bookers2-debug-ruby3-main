class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags

  validates :title, presence: true
  validates :body, presence: true, length: {maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search,word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

  def save_tag(tags)
    #タグが存在していれば、タグの名前を配列として全て取得
    unless self.tags.nil?
      current_tags = self.tags.pluck(:tag_name)
    end
    old_tags = current_tags - tags
    new_tags = tags - current_tags
    #古いタグを削除
    old_tags.each do |old_tag|
      self.tags.delete(Tag.find_by(tag_name: old_tag))
    end
    #新しいタグを追加
    new_tags.each do |new_tag|
      add_tags = Tag.find_or_create_by(tag_name: new_tag)
      self.tags << add_tags
    end
  end
end
