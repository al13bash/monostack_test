class Authorization < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  scope :facebook, -> { find_by(provider: 'facebook') }
  # after_create :fetch_details

  def fetch_details
    send("fetch_details_from_#{provider.downcase}")
  end

  def fetch_details_from_facebook
    graph = Koala::Facebook::API.new(token)
    profile = graph.get_object('me')
    user = self.user
    user.update_attributes(first_name: profile['first_name'], last_name: profile['last_name'],
                           address: profile['location']['name'])
    user.save
  end
end
