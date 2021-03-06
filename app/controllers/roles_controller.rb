class RolesController < ApplicationController

  def index
    authorize! :list, Role
    params[:show] ||= "All"
    @roles = params[:show] == "All" ? Role.by_name : Role.by_name.find_all{|role| role.has_permission(params[:show])}
  end

  def show
    authorize! :list, Role
    @role = Role.get(params[:id])
  end

  def edit
    authorize! :edit, Role
    @role = Role.get(params[:id])
  end

  def update
    authorize! :update, Role
    @role = Role.get(params[:id])
    if @role.update_attributes(params[:role])
      flash[:notice] = "Role details are successfully updated."
      redirect_to(roles_path)
    else
      flash[:error] = "Error in updating the Role details."
      render :action => "edit"
    end
  end

  def new
    authorize! :create, Role
    @role = Role.new
  end

  def create
    authorize! :create, Role
    @role = Role.new(params[:role])
    return redirect_to roles_path if @role.save
    render :new
  end
end
