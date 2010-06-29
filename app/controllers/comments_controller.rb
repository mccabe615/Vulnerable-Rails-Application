class CommentsController < ApplicationController
  
  before_filter :find_rider
  
  def new
    @comment = Comment.new
  end
  
  def edit
    @comment = @rider.comments.find(params[:id])
  end
  
  def create
    @comment = Comment.new(params[:comment])
    if (@rider.comments << @comment)
      redirect_to rider_url(@rider)
    else
      render :action => :new
    end
  end
  
  def destroy
    comment = @rider.comments.find(params[:id])
    @rider.comments.delete(comment)
    redirect_to rider_url(@rider)
  end
    
  private
  
  def find_rider
    @rider_id = params[:rider_id]
    return(redirect_to(riders_url)) unless @rider_id
    @rider = Rider.find(@rider_id)
  end
end
