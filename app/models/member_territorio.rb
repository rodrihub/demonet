class MemberTerritorio < ActiveRecord::Base
	belongs_to :member, foreign_key: "user_id", class_name: "User"
	belongs_to :territorio
end