module Api
  module V1
    class ProfilesController < ApplicationController
      def show
        respond_with current_user
      end
    end
  end
end
