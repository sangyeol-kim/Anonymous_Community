class MessagesController < ApplicationController
    before_action :users
    
    private
    
    def users
    @a = current_user.email
  end
end
