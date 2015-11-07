# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Item < ActiveRecord::Base
  belongs_to :user

  before_create :set_default_status, :set_expiration

  private
  def set_default_status
    self.status = 'open'
  end
  def set_expiration
    # self.expiration = Time.now + 7.days
    self.expiration = self.created_at + 7.days
  end
end