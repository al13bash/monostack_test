class Post < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories

  accepts_nested_attributes_for :categories

  extend Enumerize

  enumerize :status, in: [:moderation, :approved, :rejected], default: :moderation

  def as_json(options = {})
    super(options.merge(include: [:user, :categories]))
  end
end
