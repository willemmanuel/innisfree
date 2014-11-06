class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :volunteer

  def active_for_authentication? 
    super && self.approved
  end 

  def inactive_message 
    if !self.approved 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end
  
end
