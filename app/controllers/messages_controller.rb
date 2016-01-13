class MessagesController < ApplicationController

  def index
    if params[:search].present?
      @messages = Message.near(params[:search], 30)
    else
      @messages = Message.all
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    # @group = Group.find_by(id: group_id)
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    # @message.group_id = @group
    flash[:danger] = @message.group_id
    if @message.save
      Group.find_by(id: @message.group_id).messages << @message
      redirect_to group_path(@group)
    else
      # flash[:danger] = "hi"
      render 'new'
    end
  end

  def update
    @message = Message.find(params[:id])

    if @message.update(message_params)
      redirect_to @message
    else
      render 'edit'
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    redirect_to messages_path
  end

  private
    def message_params
      params.require(:message).permit(:location, :expertise, :commitment, :ensemble)
    end
end
