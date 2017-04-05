class ConversationsController < ApplicationController
  # Mailboxer actions
  before_action :get_mailbox
  before_action :get_conversation, except: [:index]

  def index
    if current_user == nil
      redirect_to root_path, flash: {error: "You need to be logged in to do that!"}
    else
      @conversations = @mailbox.inbox.paginate(page: params[:page], per_page: 10)
    end
  end

  def show
  end

  def reply
    current_user.reply_to_conversation(@conversation, params[:body])
    flash[:success] = 'Reply sent'
    redirect_to conversation_path(@conversation)
  end

  private

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end

  def get_conversation
    @conversation ||= @mailbox.conversations.find(params[:id])
  end
end
