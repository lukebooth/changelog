class ReleasesController < ApplicationController
  include UrlHelper
  before_filter :get_project_and_environment
  
  # GET /releases
  # GET /releases.json
  def index
    @releases = @environment.releases.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @releases }
    end
  end

  # GET /releases/1
  # GET /releases/1.json
  def show
    @release = @environment.releases.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @release }
    end
  end

  # GET /releases/new
  # GET /releases/new.json
  def new
    @release = @environment.releases.new(params.pick(:commit0, :commit1))
    @release.build_changes_from_commits if @release.can_read_commits?
    @release.changes.build if @release.changes.none?

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @release }
    end
  end

  # GET /releases/1/edit
  def edit
    @release = @environment.releases.find(params[:id])
    @release.changes.build if @release.changes.none?
  end

  # POST /releases
  # POST /releases.json
  def create
    @release = @environment.releases.new(params[:release])

    respond_to do |format|
      if @release.save
        format.html { redirect_to @release, notice: 'Release was successfully created.' }
        format.json { render json: @release, status: :created, location: @release }
      else
        format.html { render action: "new" }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /releases/1
  # PUT /releases/1.json
  def update
    @release = @environment.releases.find(params[:id])

    respond_to do |format|
      if @release.update_attributes(params[:release])
        format.html { redirect_to @release, notice: 'Release was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /releases/1
  # DELETE /releases/1.json
  def destroy
    @release = @environment.releases.find(params[:id])
    @release.destroy

    respond_to do |format|
      format.html { redirect_to releases_url }
      format.json { head :no_content }
    end
  end
  
private
  
  def get_project_and_environment
    @project = Project.find_by_slug!(params[:project_id])
    @environment = @project.environments.find_by_slug!(params[:environment_id])
  end
  
end