class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  extend Enumerize

  before_create :set_role_to_user

  enumerize :role, in: [:guest, :user, :admin], default: :guest

  def self.from_auth(params, current_user)
    params = params.smash.with_indifferent_access
    authorization = Authorization.find_or_initialize_by(provider: params[:provider], uid: params[:uid])
    if authorization.persisted?
      if current_user
        if current_user.id == authorization.user.id
          user = current_user
        else
          return false
        end
      else
        user = authorization.user
      end
    else
      if current_user
        user = current_user
      elsif params[:email].present?
        user = User.find_or_initialize_by(email: params[:email])
      else
        user = User.new
      end
    end
    authorization.secret = params[:secret]
    authorization.token  = params[:token]
    fallback_name        = params[:name].split(" ") if params[:name]
    fallback_first_name  = fallback_name.try(:first)
    fallback_last_name   = fallback_name.try(:last)
    # user.first_name    ||= (params[:first_name] || fallback_first_name)
    # user.last_name     ||= (params[:last_name]  || fallback_last_name)

    # if user.image_url.blank?
    #   user.image = Image.new(name: user.full_name, remote_file_url: params[:image_url])
    # end

    user.password = Devise.friendly_token[0,10] if user.encrypted_password.blank?

    if user.email.blank?
      user.save(validate: false)
    else
      user.save
    end
    authorization.user_id ||= user.id
    authorization.save
    user
  end

  private

  def set_role_to_user
    self.role = :user
  end
end
