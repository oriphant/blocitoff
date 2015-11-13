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

  def make_to_open
      self.update_attributes(status: 'open')
      self.update_attributes(expiration: Time.now + 7.days)
  end

  def days_left
  # ~~~~~~~~~ Note ~~~~~~~~~~~~~~~
    # Expiration date and created_at date could be different depending on if the user renewed the action time which resets the expiration date.  So Option 1 & 2 flawed

  # ~~~~~~~~~ Option 1 ~~~~~~~~~~~~~~~
    # if (7 - (DateTime.now.to_date - created_at.to_date).to_i)>0 
    #   7 - (DateTime.now.to_date - created_at.to_date).to_i 
    # else
    #   0
    # end 
  
  # ~~~~~~~~~ Option 2 ~~~~~~~~~~~~~~~
    # (7 - (DateTime.now.to_date - created_at.to_date).to_i)>0 ? (7 - (DateTime.now.to_date - created_at.to_date).to_i) : 0
  
  # ~~~~~~~~~ Option 3 ~~~~~~~~~~~~~~~
   ((expiration.to_date - DateTime.now.to_date).to_i) > 0 ?  (expiration.to_date - DateTime.now.to_date).to_i : 0
  end

  def formatted_expiration
    expiration.since(7.days).to_date.to_formatted_s(:long_ordinal)
  end

  private
  def set_default_status
    self.status = 'open'
  end

  def set_expiration
    # self.expiration = Time.now + 7.days
    self.expiration = self.created_at + 7.days
  end

  default_scope {order('expiration asc')} # ~~~~~~~~ Sorts by date.  Default scope is not a special method or gem.  Built in. ~~~~~~~~~~~~

end
