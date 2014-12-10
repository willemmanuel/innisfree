# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean          default(FALSE)
#  volunteer_id           :integer
#  approved               :boolean
#  phone                  :string(255)
#  house_id               :integer
#  name                   :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :house
  has_many :cars
  has_many :appointments

  def self.send_reminders
   # email all the admins a full schedule for the day
   admins = User.where(admin: true).where(email_pref: true)
   admins.each do |admin|
      NotificationMailer.appointment_digest(admin).deliver
   end
   # email all volunteers a reminder
   todays_appointments = Appointment.where('date = ?', Date.today)
   todays_appointments.each do |appointment|
      if !appointment.user.nil? && appointment.user.email_pref
         NotificationMailer.appointment_reminder(appointment).deliver
      end
   end
  end

  attr_accessor :current_password

  def active_for_authentication? 
    super
  end 

  def inactive_message 
    super # Use whatever other message 
  end

  def name
    name = read_attribute(:name)
    if name.nil? or name.length == 0 
      return read_attribute(:email)
    else
      return read_attribute(:name)
    end
  end
   
end
