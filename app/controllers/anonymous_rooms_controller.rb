require 'nokogiri'
require 'open-uri'
class AnonymousRoomsController < ApplicationController
  def index
    @anonymous_rooms = AnonymousRoom.page params[:page]
    url = "http://news.nate.com/rank/interest?sc=sisa"
    doc = Nokogiri::HTML(open(url))
    currency = doc.css('div.postRankSubjectList.f_clear > div.mduSubjectList.f_clear')
    @new_currency = currency.map { |cur| cur.text }
  end

  def new
    @anonymous_room = AnonymousRoom.new
  end

  def create
    @anonymous_room = current_user.anonymous_rooms.build(anonymous_room_params)
    if @anonymous_room.save
      flash[:success] = 'Chat room added!'
      redirect_to anonymous_room_path(@anonymous_room)
    else
      render 'new'
    end
  end
  
  def show
    @anonymous_room = AnonymousRoom.includes(:messages).find_by(id: params[:id])
    @message = Message.new
    @a=current_user.id
  end
  
  def upvote 
    @vote = AnonymousRoom.find(params[:id])
    @vote.upvote_by current_user
    redirect_back(fallback_location: root_path)
  end  
  
  def downvote
    @vote = AnonymousRoom.find(params[:id])
    @vote.downvote_by current_user
    redirect_back(fallback_location: root_path)
  end

  private

  def anonymous_room_params
    params.require(:anonymous_room).permit(:title, :user_id)
  end
end