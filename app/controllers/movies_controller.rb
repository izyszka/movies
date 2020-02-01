class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :next, :prev]
  before_action :set_movies, only: [:index, :next, :prev]
  before_action :authorize, except: [:index, :show, :search, :next, :prev]
  # GET /movies
  # GET /movies.json
  def index
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    if user_signed_in? && current_user.review
      @review = current_user.review
    else
      @review = Review.new
    end
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
    @movie = Movie.find(params[:id])
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def search
    if params[:search].present?
      @movies = Movie.search(params[:search])
    else
      @movies = Movie.all
    end
  end

  def next
    if @movie == @movies.last
      redirect_to @movies.first
    else
      redirect_to @movies.where("id > ?", params[:id]).first
    end
  end

  def prev
    if @movie == @movies.first
      redirect_to @movies.last
    else
      redirect_to @movies.where("id < ?", params[:id]).last
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def set_movies
      @movies = Movie.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :director, :description, :length, :quote, :quote_author, :poster, :photo)
    end

    def authorize
      unless current_user && current_user.is_admin?
        redirect_back(fallback_location: root_path, alert: 'You are not allowed to perform this action.')
      end
    end
end
