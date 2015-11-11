# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string
#  expiration :datetime
#

class Item < ActiveRecord::Base
  belongs_to :user
  before_create :set_default_status, :set_expiration

  def status_done
    self.update_attributes(status: 'done')
  end

  def make_to_to
      self.update_attributes(status: 'open')
      self.update_attributes(expiration: Time.now + 7.days)
  end

  private
  def set_default_status
    self.status = 'open'
  end
  def set_expiration
    # self.expiration = Time.now + 7.days
    self.expiration = self.created_at + 7.days
  end

end
