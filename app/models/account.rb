class Account < ApplicationRecord
	has_many :coach_par_avails
  accepts_nested_attributes_for :coach_par_avails, allow_destroy: true

  def self.ransackable_attributes(auth_object = nil)
    ['full_name_cont', 'full_name_eq', 'full_name_start', 'full_name_end', 'email_cont', 'email_eq', 'email_start', 'email_end']
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def number_of_weeks_month(start_of_month, count, end_of_month)
     if start_of_month > end_of_month
      return count
     else
      number_of_weeks_month(start_of_month.end_of_week + 1, count + 1, end_of_month)
     end
    end
end
