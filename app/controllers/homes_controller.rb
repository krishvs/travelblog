class HomesController < ApplicationController
  before_action :set_blog, only: [:index]

  def index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @user = User.find_by_domain(request.host)
      if @user
      	redirect_to blogs_path
      end
    end

end
