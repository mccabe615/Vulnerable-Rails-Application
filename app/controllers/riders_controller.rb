class RidersController < ApplicationController
  
  def index
    @rider = Rider.new(params[:rider])
    @riders = Rider.find(:all)
  end

  def create
    params[:rider]
    @rider = Rider.new(params[:rider])
    if @rider.save
      flash[:notice] = "#{@rider.name}, you're ready to ride!"
    else
      render :action => 'index'
    end
  end
  
  def show
    redirect_to(riders_url)
  end
  
  def download 
    send_file ('/Volumes/data/Users/tate/' + params[:filename])
  end
  
  def edit
    @rider = Rider.find(params[:id])
  end
  
  def update
    @rider = Rider.find(params[:id])
    
    if @rider.update_attributes(params[:rider])
      flash[:notice] = "#{@rider.name}"
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @rider = Rider.find(params[:id])
    @rider.destroy
    redirect_to(riders_url)
  end
  
end
