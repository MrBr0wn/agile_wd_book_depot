class ApplicationController < ActionController::Base
	before_action :set_i18n_locale_from_params
	before_action :authorize

	protected

		def set_i18n_locale_from_params
			if params[:locale]
				if I18n.available_locales.map(&:to_s).include?(params[:locale])
					I18n.locale = params[:locale]
				else
					flash.now[:notice] = "#{params[:locale]} translation not available"
					logger.error flash.now[:notice]
				end
			end
		end

		def authorize
			if request.format.symbol == :atom
				authenticate_or_request_with_http_basic('Administration') do |username, password|
					user = User.find_by(name: username)
			    ActiveSupport::SecurityUtils.secure_compare(username, user.name) &&
			    user.try(:authenticate, password)
			  end

			else
				unless User.find_by(id: session[:user_id])
					redirect_to login_url, notice: 'Please log in'
				end
			end
		end
end
