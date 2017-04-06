class ConversationsController < ApplicationController
  # Mailboxer actions
  before_action :get_mailbox, except: [:index_json]
  before_action :get_conversation, except: [:index, :index_json]
  # CSRF controls (may the gods have mercy on my soul)
  skip_before_action :verify_authenticity_token, only: [:index_json]

  def index
    if current_user == nil
      redirect_to root_path, flash: {error: "You need to be logged in to do that!"}
    else
      @conversations = @mailbox.inbox.paginate(page: params[:page], per_page: 10)
    end
  end

  def index_json
    userid = params[:id]
    user = User.where(:uid => userid)[0]
    @conversations = user.mailbox.conversations(user)
    puts @conversations[0].messages[0].inspect
  end

  def show
    current_user.mark_as_read(@conversation)
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
