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
#  email_pref             :boolean          default(FALSE)
#  medical_coordinator    :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :house
  has_many :cars
  has_many :reservations
  has_many :appointments

  validates :name, presence: true
  validates :email, presence: true

  def self.send_reminders
   # email all the admins a full schedule for the day
   if !Appointment.where('date = ?', Date.today).empty?
    admins = User.where(admin: true).where(email_pref: true)
    admins.each do |admin|
      NotificationMailer.appointment_digest(admin).deliver
    end
   end
   # email all volunteers a reminder
   todays_appointments = Appointment.where('date = ?', Date.today)
   todays_appointments.each do |appointment|
      if !appointment.user.nil? && appointment.user.email_pref
         NotificationMailer.appointment_reminder(appointment).deliver
      end
   end
   todays_reminders = RecurringReminder.where('notification_date = ?', Date.today)
   todays_reminders.each do |recur|
     original_apt = Appointment.where('id = ?', recur.appointment_id)[0]
     user = User.where('id = ?', original_apt.user_id)[0]
     if !user.nil? && user.email_pref
       NotificationMailer.recurring_appointment_reminder(original_apt).deliver
     end 
   end
  end

  def self.send_weekly_digest
    if !Appointment.where('date >= ?', Date.tomorrow).where('date <= ?', Date.tomorrow+7).empty?
      coordinators = User.where(medical_coordinator: true).where(email_pref: true)
      coordinators.each do |coordinator|
        NotificationMailer.weekly_digest(coordinator).deliver
      end
    end
  end

  attr_accessor :current_password

  def name
    super || email
  end
   
end
