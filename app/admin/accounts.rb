# frozen_string_literal: true

ActiveAdmin.register Account do
  menu priority: 5
  # include BuilderJsonWebToken::JsonWebTokenValidation
  # before_action :validate_json_web_token
  DATE = '%d/%m/%Y'
  permit_params :name, :email, :password, :password_confirmation,
                coach_par_avails_attributes: [:start_date, :end_date, { coach_par_times_attributes: %i[from to booked_slot sno _destroy] }]

  controller do
    # def scoped_collection
    #   @accounts = Account.where(role_id: BxBlockRolesPermissions::Role.find_by_name(BxBlockRolesPermissions::Role.names[:coach]).id)
    # end

    def create_availability(object)
      (Date.today..6.months.from_now)&.each do |date|
        # BxBlockAppointmentManagement::Availability.create!(start_time: '06:00', end_time: '23:00',
                                                           # availability_date: date.strftime(DATE), service_provider_id: object.id)
      rescue StandardError
        next
      end
    end

    # def check_activation(object)
    #   return if object.activated

    #   BxBlockAppointmentManagement::BookedSlot.where(service_provider_id: params[:id]).destroy_all
    #   slots = nil
    #   begin
    #     ActiveRecord::Base.connection.execute('SET datestyle = dmy;')
    #     slots = BxBlockAppointmentManagement::Availability.where(
    #       'service_provider_id = ? and Date(availability_date) >=?', object.id, Date.today
    #     )
    #   rescue StandardError
    #     slots = nil
    #   end
    #   timeslots = [{ 'to' => '06:59 AM', 'sno' => '1', 'from' => '06:00 AM', 'booked_status' => false },
    #                { 'to' => '07:59 AM', 'sno' => '2', 'from' => '07:00 AM', 'booked_status' => false },
    #                { 'to' => '08:59 AM', 'sno' => '3', 'from' => '08:00 AM', 'booked_status' => false },
    #                { 'to' => '09:59 AM', 'sno' => '4', 'from' => '09:00 AM', 'booked_status' => false },
    #                { 'to' => '10:59 AM', 'sno' => '5', 'from' => '10:00 AM', 'booked_status' => false },
    #                { 'to' => '11:59 AM', 'sno' => '6', 'from' => '11:00 AM', 'booked_status' => false },
    #                { 'to' => '12:59 PM', 'sno' => '7', 'from' => '12:00 PM', 'booked_status' => false },
    #                { 'to' => '01:59 PM', 'sno' => '8', 'from' => '01:00 PM', 'booked_status' => false },
    #                { 'to' => '02:59 PM', 'sno' => '9', 'from' => '02:00 PM', 'booked_status' => false },
    #                { 'to' => '03:59 PM', 'sno' => '10', 'from' => '03:00 PM', 'booked_status' => false },
    #                { 'to' => '04:59 PM', 'sno' => '11', 'from' => '04:00 PM', 'booked_status' => false },
    #                { 'to' => '05:59 PM', 'sno' => '12', 'from' => '05:00 PM', 'booked_status' => false },
    #                { 'to' => '06:59 PM', 'sno' => '13', 'from' => '06:00 PM', 'booked_status' => false },
    #                { 'to' => '07:59 PM', 'sno' => '14', 'from' => '07:00 PM', 'booked_status' => false },
    #                { 'to' => '08:59 PM', 'sno' => '15', 'from' => '08:00 PM', 'booked_status' => false },
    #                { 'to' => '09:59 PM', 'sno' => '16', 'from' => '09:00 PM', 'booked_status' => false },
    #                { 'to' => '10:59 PM', 'sno' => '17', 'from' => '10:00 PM', 'booked_status' => false },
    #                { 'to' => '11:59 PM', 'sno' => '18', 'from' => '11:00 PM', 'booked_status' => false }]
    #   slots&.update_all(timeslots: timeslots)
    #   ActiveRecord::Base.connection.execute('SET datestyle = ymd;')
    # end

    # def destroy
    #   AccountBlock::Account.find(params[:id]).destroy
    #   BxBlockAppointmentManagement::Availability.where(service_provider_id: params[:id]).destroy_all
    #   BxBlockAppointmentManagement::BookedSlot.where(service_provider_id: params[:id]).destroy_all
    #   redirect_to admin_coaches_path
    # end

    def create
      # return unless params[:account][:type] == 'email_account'

      account = Account.where('LOWER(email) = ?', params[:account]['email'].downcase).first
      if account.present?
        return render json: { errors: [{ account: 'Email already taken' }] },
                      status: :unprocessable_entity
      end

      # password_validator = AccountBlock::PasswordValidation.new(params[:account]['password_confirmation'])
      # password_valid = password_validator.valid?
      # unless password_valid
      #   rule = 'Password is invalid.Password should be a minimum of 8 characters long,contain both uppercase and lowercase characters,at least one digit,and one special character.'
      #   return render json: { errors: [{ Password: rule.to_s }] }, status: :unprocessable_entity
      # end
      # unless Phonelib.valid?(params[:account]['full_phone_number'])
      #   return render json: { errors: [{ full_phone_number: 'Invalid or Unrecognized Phone Number' }] },
      #                 status: :unprocessable_entity
      # end

      @account = Account.new(name: params[:account][:name],email: params[:account][:email], password: params[:account][:password], password_confirmation: params[:account][:password_confirmation])
      if @account.password == @account.password_confirmation
        # @account.role_id = BxBlockRolesPermissions::Role.find_by_name(:coach).id
        if @account.save(validate: false)
          @account.update(activated: true)
          create_availability(@account)
          # CoachAvailabilityWorker.perform_in(Time.now+30.seconds, @account.id)
          redirect_to admin_coaches_path
        else
          render json: { errors: [{ full_phone_number: 'already exists' }] }, status: :unprocessable_entity
        end
      else
        render json: { errors: [{ Password: 'Password and Confirm Password Not Matched' }] },
               status: :unprocessable_entity
      end
    end

    # def update
    #   role_id = BxBlockRolesPermissions::Role.find_by_name(:coach).id
    #   account = AccountBlock::Account.find_by(email: params['account']['email'], role_id: role_id)
    #   unless params['account']['coach_par_avails_attributes']['0']['start_date'].nil?
    #     params['account']['coach_par_avails_attributes'].each do |avl|
    #       avail = BxBlockAppointmentManagement::CoachParAvail.new(
    #         start_date: params['account']['coach_par_avails_attributes'][avl.first]['start_date'], account_id: account.id
    #       )
    #       avail.save!
    #       params['account']['coach_par_avails_attributes'][avl.first]['coach_par_times_attributes']&.each do |_sub|
    #         avail_time = BxBlockAppointmentManagement::CoachParTime.new(
    #           from: params['account']['coach_par_avails_attributes']['0']['start_date'], to: params['account']['coach_par_avails_attributes']['0']['start_date'], coach_par_avail_id: avail.id
    #         )
    #         avail_time.save!
    #       end
    #     end
    #   end
    #   account.save!
    #   redirect_to(admin_coaches_url) and return
    # end
  end
  index title: 'Account' do
    selectable_column
    id_column
    column :name
    column :email
    # column :full_phone_number
    # column :activated
    # column :created_at
    # column :updated_at
    actions
  end

  show do
    attributes_table title: 'Account Details' do
      row :name
      row :email
      # row :full_phone_number
      # row :created_at
      # row :updated_at
    end
  end
  form title: 'Add New Coach' do |f|
    f.inputs do
      if f.object.new_record? && false
        f.input :type, input_html: { value: 'email_account' }, as: :hidden
        f.input :name
        f.input :email
        # f.input :full_phone_number
        f.input :password
        f.input :password_confirmation
        # f.input :expertise, as: :check_boxes, collection: CoachSpecialization.all.pluck(:expertise)
      else
        f.input :name
        f.input :email
        # f.input :full_phone_number
        f.input :password
        # f.input :activated
        # f.input :education
        # f.input :city
        # f.has_many :user_languages, allow_destroy: true do |t|
        #   t.input :language
        # end
        # f.has_many :coach_leaves, allow_destroy: true do |t|
        #   t.input :coach_off, as: :datepicker, datepicker_options: { dateFormat: DATE }
        # end
        f.has_many :coach_par_avails,
                   for: [:coach_par_avails, f.object.coach_par_avails || CoachParAvail.new], allow_destroy: true do |t|
          # payal = Account.new.number_of_weeks_month(Date.parse('2023-08-01'), 0, Date.parse('2023-08-31'))
          weeks = (Date.today.beginning_of_month..Date.today.end_of_month).to_a.group_by{|d| d.strftime("%V")}
          # payal.times do |aman|
            weeks.each do |week_count, values|
              aman = week_count.to_i - Date.today.beginning_of_month.strftime("%V").to_i
          # byebug
              d = values.map{|a| a.strftime("%A")}
              # values.each do |date|
              # byebug
              # week = date.strftime("%A")
                t.input :start_date, label: "Week #{aman + 1}", class: "checkbox_#{aman}", as: :check_boxes,
                                     collection: d
                t.has_many :coach_par_times,  class: "checkbox_#{aman}",
                           for: [:coach_par_times,
                                 t.object.coach_par_times || CoachParTime.new] do |c_p|
                  c_p.input :from, as: :select, include_blank: false, collection: ['06:00 AM',
                                                                                   '07:00 AM',
                                                                                   '08:00 AM',
                                                                                   '09:00 AM',
                                                                                   '10:00 AM',
                                                                                   '11:00 AM',
                                                                                   '12:00 PM',
                                                                                   '01:00 PM',
                                                                                   '02:00 PM',
                                                                                   '03:00 PM',
                                                                                   '04:00 PM',
                                                                                   '05:00 PM',
                                                                                   '06:00 PM',
                                                                                   '07:00 PM',
                                                                                   '08:00 PM',
                                                                                   '09:00 PM',
                                                                                   '10:00 PM',
                                                                                   '11:00 PM']
                  c_p.input :to, as: :select, include_blank: false, collection: ['06:59 AM',
                                                                                 '07:59 AM',
                                                                                 '08:59 AM',
                                                                                 '09:59 AM',
                                                                                 '10:59 AM',
                                                                                 '11:59 AM',
                                                                                 '12:59 PM',
                                                                                 '01:59 PM',
                                                                                 '02:59 PM',
                                                                                 '03:59 PM',
                                                                                 '04:59 PM',
                                                                                 '05:59 PM',
                                                                                 '06:59 PM',
                                                                                 '07:59 PM',
                                                                                 '08:59 PM',
                                                                                 '09:59 PM',
                                                                                 '10:59 PM',
                                                                                 '11:59 PM']
                end
              end
          # end
        end
        # f.input :expertise, as: :check_boxes, collection: CoachSpecialization.all.pluck(:expertise),
        #                     default: f.object.expertise
      end
    end
    f.actions do
      f.submit 'Submit'
    end
  end
end
