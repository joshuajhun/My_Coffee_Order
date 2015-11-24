class Item < ActiveRecord::Base
  belongs_to :category
  validates :title, :description, :price , :image, presence: true
  validates :title, uniqueness: true
  has_many :order_items
  has_many :orders, through: :order_items
  before_save :set_slug

  def to_param
    slug
  end

  def set_slug
    self.slug = title.parameterize
  end
end
