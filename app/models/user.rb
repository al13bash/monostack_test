class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  extend Enumerize

  before_create :set_role_to_user

  enumerize :role, in: [:guest, :user, :admin], default: :guest

  private

  def set_role_to_user
    self.role = :user
  end
end
