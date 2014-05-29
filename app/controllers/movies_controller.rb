class MoviesController < ApplicationController

  @@first_time = true
  def index
    @all_ratings = Movie.get_ratings
    if @@first_time
#    if @current_ratings.nil?
      @current_ratings = Hash[@all_ratings.map {|rating| [rating, "1"]}]
    elsif !params[:sort].nil?
    # catch the case where sort has been set
      @current_ratings = Hash[@all_ratings.map {|rating| [rating, "1"]}]
    else
      params[:ratings].nil? ? @current_ratings = 
        Hash[@all_ratings.map {|rating| [rating, "1"]}] :
        @current_ratings = params[:ratings]
    end
    @@first_time = false
    @movies = Movie.order(params[:sort]).where(rating: @current_ratings.keys)
    @header_to_hilite = params[:sort]
#    if !params[:sort].nil? 
#    if !session[:sort].nil? 
#    then redirect is set to true. 
#    order = session[:sort] 
#    session.delete(:sort) 
#    order
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
