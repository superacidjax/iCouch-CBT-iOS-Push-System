class ActionsController < ApplicationController
  def reply
  end
  
  def settoken
    @user = User.find_by_id(params[:user_id])
    @user.device_token = params[:device_token]
    if @user.save
      render :json => {:status => :success, :id => @user.id, :token => true}
    else
      render :json => {:status => :error, :token => false}
    end
  end
  
  def read
    @message = Message.find_by_id(params[:id])
    @message.read = true
    @message.save
    render :json => {:status => :success}
  end
  
  def getmessage
    @user = User.find_by_id(params[:user_id])
    render :json => @user.messages.to_json
  end
  
  def register
    @user = User.new(:device_token => params[:device_token])
    if @user.save
      if params[:device_token] == "no"
        render :json => {:status => :success, :id => @user.id, :token => false}
      else
        render :json => {:status => :success, :id => @user.id, :token => true}
      end
    else
      render :json => {:status => :error}
    end
  end
  
  def sendnotis
    if params[:user_id] == "all"
      @users = User.all
      for @user in @users
        @message = Message.new(:user_id => @user.id, :title => params[:title], :content => params[:content], :read => 0)
        @message.save
        @messages = Message.where(:read => 0, :user_id => @user.id)
        APN.notify(@user.device_token, :alert => params[:title], :badge => @messages.length, :sound => true)
      end
      render :json => {:status => :success, :message => :notification_all_sent}
    else
      @message = Message.new(:user_id => params[:user_id], :title => params[:title], :content => params[:content], :read => 0)
      @user = User.find_by_id(params[:user_id])

      if @user.nil?
        render :json => {:status => :error, :message => :user_not_exist}
      else
        if @message.save
          @messages = Message.where(:read => 0, :user_id => params[:user_id])
          APN.notify(@user.device_token, :alert => params[:title], :badge => @messages.length, :sound => true)
          #APN::NotificationJob.perform(@user.device_token, :alert => params[:title], :badge => 1, :sound => true)
          render :json => {:status => :success, :message => :notification_sent}
        else
          render :json => {:status => :error}
        end
      end
    end
  end
  
  def sendmail
    Notifier.record_submit(params[:content]).deliver
    render :json => {:status => :success}
  end
end
