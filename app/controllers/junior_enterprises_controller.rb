class JuniorEnterprisesController < ApplicationController  
  before_filter :validate_token
  # GET /junior_enterprises
  # GET /junior_enterprises.json
  def index
    @junior_enterprises = JuniorEnterprise.all

    render :json => @junior_enterprises.to_json(:include => [:messages, :members] )
  end

  def find_messages
    @junior_enterprise = JuniorEnterprise.find params[:id]

    render :json => @junior_enterprise.to_json(:include => :messages)
  end

  def find_members
    @junior_enterprise = JuniorEnterprise.find params[:id]

    render :json => @junior_enterprise.to_json(:include => :members)
  end

  # GET /junior_enterprises/1
  # GET /junior_enterprises/1.json
  def show
    @junior_enterprise = JuniorEnterprise.find(params[:id])

    if request.headers["access"] != "1"
      @junior_enterprise.update(access: @junior_enterprise.access + 1)
    end

    render :json => @junior_enterprise.to_json(:include => [:messages, :members])
  end

  # POST /junior_enterprises
  # POST /junior_enterprises.json
  def create
    @junior_enterprise = JuniorEnterprise.new(junior_enterprise_params)
    @junior_enterprise.logo = junior_enterprise_params["logo"]

    if @junior_enterprise.save
      user = User.find(junior_enterprise_params["user_id"])
      user.junior_enterprise = @junior_enterprise
      user.save

      render json: @junior_enterprise, status: :created, location: @junior_enterprise
    else
      render json: @junior_enterprise.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /junior_enterprises/1
  # PATCH/PUT /junior_enterprises/1.json
  def update
    @junior_enterprise = JuniorEnterprise.find(params[:id])

    if @junior_enterprise.update(junior_enterprise_params)
      head :no_content
    else
      render json: @junior_enterprise.errors, status: :unprocessable_entity
    end
  end

  # DELETE /junior_enterprises/1
  # DELETE /junior_enterprises/1.json
  def destroy
    @junior_enterprise = JuniorEnterprise.find(params[:id])
    @junior_enterprise.destroy

    head :no_content
  end

  def search
    @je = JuniorEnterprise.all

    if params[:name]
      unless params[:name].blank?
        @je = @je.where("lower(name) like ?", "%#{params[:name].downcase}%")
      end
    end

    if params[:state]
      unless params[:state].blank?
        @je = @je.where(["state = :state",{ state: params[:state]}])
      end
    end

    if params[:area]
      unless params[:area].blank?
        @je = @je.where("lower(area) like ?", "%#{params[:area].downcase}%")
      end
    end

    if params[:consultor]
      if params[:consultor] == 'true'
        @je = @je.where(["consultor = :consultor",{ consultor: true}])
      end
    end

    if params[:training]
      if params[:training] == 'true'
        @je = @je.where(["training = :training",{ training: true}])
      end
    end

    if params[:product]
      if params[:product] == 'true'
        @je = @je.where(["product = :product",{ product: true}])
      end
    end

    if params[:project]
      if params[:project] == 'true'
        @je = @je.where(["project = :project",{ project: true}])
      end
    end

    render json: @je
  end

  def seal
    junior_enterprise = JuniorEnterprise.find(params[:id])
    if junior_enterprise.seal
      junior_enterprise.update_attributes( :seal => false ) ? (head :no_content) : (head :unprocessable_entity)
    else
      junior_enterprise.update_attributes( :seal => true ) ? (head :no_content) : (head :unprocessable_entity)
    end
  end

  private
    
    def junior_enterprise_params
      params.permit(:user_id,:name, :logo, :description, :phrase, :site, :phone, :city, :state, :youtube, :facebook, :course, :area, :address, :consultor, :product, :access, :project, :training, :seal)
    end
end
