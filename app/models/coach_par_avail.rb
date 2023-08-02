class CoachParAvail < ApplicationRecord
	belongs_to :account
	has_many :coach_par_times
	accepts_nested_attributes_for :coach_par_times, allow_destroy: true
end
