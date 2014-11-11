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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
   test "user_trivial_true" do
     assert true
   end

   test "user_trivial_true2" do
     assert true
   end
end
