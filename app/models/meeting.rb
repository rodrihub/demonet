# == Schema Information
#
# Table name: meetings
#
#  id           :integer          not null, primary key
#  territory_id :integer
#  date         :datetime
#  summary      :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Meeting < ActiveRecord::Base

	belongs_to :territory

	has_many :user_meetings
	has_many :users, through: :user_meetings

end
