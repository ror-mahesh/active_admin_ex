class AccountsController < InheritedResources::Base

  private

    def account_params
      params.require(:account).permit(:name, :email, :password)
    end

end
