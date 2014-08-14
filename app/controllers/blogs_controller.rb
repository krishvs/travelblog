class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :index]

  # GET /blogs
  # GET /blogs.json
  def index
    @posts = @user.descriptions.all
    render :layout => "blog_index"
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @blog = find_description
    @template = Liquid::Template.parse(@user.template.template)  # Parses and compiles the template
    @final_template = @template.render( 'title' => @blog.title, 'username' => @user.username, 'description' => @blog.description, 'created_at' => @blog.created_at )  
    if @blog
      render :layout => "blog_article"
    else
      redirect_to blogs_path
    end
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
      Rails.logger.info "I am in the set_blog"
      @user = User.find_by_domain(request.host)
      Rails.logger.info "The value of the user is #{@user.inspect}"
      unless @user
        redirect_to root_path
      end
    end

    def find_description
      @user.descriptions.find_by_title(params[:id])
    end

end
