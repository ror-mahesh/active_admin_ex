class CoachParAvailsController < InheritedResources::Base

  private

    def coach_par_avail_params
      params.require(:coach_par_avail).permit(:start_date, :end_date, :account_id)
    end

end
