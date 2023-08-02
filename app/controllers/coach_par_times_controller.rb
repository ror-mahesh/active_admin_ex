class CoachParTimesController < InheritedResources::Base

  private

    def coach_par_time_params
      params.require(:coach_par_time).permit(:from, :to, :booked_slot, :sno, :coach_par_avail_id, :dates)
    end

end
