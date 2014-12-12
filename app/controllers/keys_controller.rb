class KeysController < ApplicationController

  def create
    @key = Key.new(key_params)

    if @key.save
      render json: @key, status: :created
    else
      render json: @key.errors, status: :unprocessable_entity
    end
  end
  private
    
    def key_params
      params.permit(:password)
    end
end
