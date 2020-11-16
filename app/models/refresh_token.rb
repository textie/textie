class RefreshToken < ApplicationRecord
  LIFETIME = 1.month

  belongs_to :user

  def expired?
    created_at < LIFETIME.ago
  end
end
