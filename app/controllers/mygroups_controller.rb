class MygroupsController < ApplicationController
  before_action :set_mygroup, only: %i[ show edit update destroy ]

  # GET /mygroups or /mygroups.json
  def index
    #@mygroups = Mygroup.all
    #  @wfiles = Wfile.search(params).paginate(page: params[:page], per_page: 50)
    @mygroups = Mygroup.search(params).paginate(page: params[:page], per_page: 50)
  end

  # GET /mygroups/1 or /mygroups/1.json
  def show
    @group= Mygroup.find(params[:id])
    p   @group.dopmygroups.first.countuser unless @group.dopmygroups.first.nil?
    #p @group.dopmygroups.first.countuser

    #http://localhost:3001/mygroups/2102   # работает только с 1 связанной группой  !!! внимаение    has_one  не сработал, почему????


  end

  # GET /mygroups/new
  def new
    @mygroup = Mygroup.new
  end

  # GET /mygroups/1/edit@mygroup
  def edit
  end

  # POST /mygroups or /mygroups.json
  def create
    @mygroup = Mygroup.new(mygroup_params)

    respond_to do |format|
      if @mygroup.save
        format.html { redirect_to mygroup_url(@mygroup), notice: "Mygroup was successfully created." }
        format.json { render :show, status: :created, location: @mygroup }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mygroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mygroups/1 or /mygroups/1.json
  def update
    respond_to do |format|
      if @mygroup.update(mygroup_params)
        format.html { redirect_to mygroup_url(@mygroup), notice: "Mygroup was successfully updated." }
        format.json { render :show, status: :ok, location: @mygroup }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mygroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mygroups/1 or /mygroups/1.json
  def destroy
    @mygroup.destroy

    respond_to do |format|
      format.html { redirect_to mygroups_url, notice: "Mygroup was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mygroup
      @mygroup = Mygroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mygroup_params
      params.require(:mygroup).permit(:iid, :username, :title, :description, :countuser, :datein)
    end
end
