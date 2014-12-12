class MessagesController < ApplicationController  
  before_filter :validate_token
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all

    render json: @messages
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])

    render json: @message
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    if @message.save
      UserNotifier.send_message(@message).deliver
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  def feedback
    @message = Message.new(message_params)

    if AdmNotifier.send_feedback(@message).deliver
      render nothing: true, status: :ok
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  def update
    @message = Message.find(params[:id])

    if @message.update(message_params)
      head :no_content
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  def read
    @message = JuniorEnterprise.find(params[:id]).messages

    @messages.where('read = ?', false).each do |me|
      me.read = true
      me.save
    end

    head :no_content
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    head :no_content
  end

  private
    
    def message_params
      params.permit(:text, :email, :phone, :name, :junior_enterprise_id, :read)
    end
end
