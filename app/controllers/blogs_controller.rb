class BlogsController < ApplicationController
  layout "blog"
  before_action :set_blog, only: [:show, :index]

  # GET /blogs
  # GET /blogs.json
  def index
    @posts = @user.descriptions.all
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end


    # GET /blogs/new
  def new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @user = User.find_by_domain(request.host)
      unless @user
        redirect_to root_path
      end
    end
end
