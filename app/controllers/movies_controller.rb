class MoviesController < ApplicationController


  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index

	if params[:ratings].nil?
		values = Hash[Movie.ratings.map {|x| [x, '1']}]
		  ratings = values
	 	 params[:ratings]= ratings 
   end


#) Hash[x.map {|x| [x, '1']}]


	sort = params[:order] 
	checks = params[:ratings]

	@checks = checks

	@movies = Movie.order(sort).find(:all, :conditions => {:rating=>[checks.keys]})
	
	@color_re = 'hilite' if sort == 'release_date'
	@color_sort = 'hilite'if sort == 'title'

	@all_ratings = Movie.ratings
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
