class Story < ApplicationRecord
  belongs_to :user
  has_one_attached :image, dependent: :destroy

  validates :image, presence: true
  validate :image_format
  scope :of_followed_users, ->(following_users) { where user_id: following_users }

  private

  def image_format
    return unless image.attached?

    errors.add(:image, 'must be a JPEG or PNG') unless image.content_type.in?(%w[image/jpeg image/png image/jpg])
  end
end
