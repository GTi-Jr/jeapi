class MembersController < ApplicationController  
  before_filter :validate_token
  # GET /members
  # GET /members.json
  def index
    @members = Member.all

    render json: @members
  end

  # GET /members/1
  # GET /members/1.json
  def show
    @member = Member.find(params[:id])

    render json: @member
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)
    @member.photo = member_params["photo"]

    if @member.save
      render json: @member, status: :created, location: @member
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    @member = Member.find(params[:id])

    if @member.update(member_params)
      head :no_content
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    head :no_content
  end

  private
    
    def member_params
      params.permit(:name, :photo, :position, :junior_enterprise_id, :phone, :email)
    end
end
