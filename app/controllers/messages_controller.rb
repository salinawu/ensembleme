class MessagesController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @user = current_user
    @message = @group.messages.create(message_params)
    @message.user_id = current_user.id
    if @message.save
      redirect_to @group
    else
      flash.now[:danger] = "error"
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @message = Message.find(params[:id])
    @message.destroy

    redirect_to group_path(@group)
  end

  def message_params
    params.require(:message).permit(:user_id, :group_id, :body)
  end
end
