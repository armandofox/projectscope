class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    sort = params[:sort]
    #@preprojects = Project.all
    #if sort == 'gpa'
    #  @projects = Project.CodeClimateMetric.order(:gpa)
    #elsif sort == 'coverage' 
    #  @projects = Project.order(:coverage)
    #elsif sort == 'prs'
    #  @projects = Project.order(:gpa)
    #elsif sort == 'slack'
    #  @projects = Project.SlackMetric.order()
    #elsif sort == 'ptr'
    #  @projects = Project.PivotalTracker.order()
    #else
    #  @projects = Project.all
    #end
     
    @projects = Project.all
    
    @projects.each do |project|
      # FIXME
      # Need to implement logic for fetching updates periodically
      if project.pull_request.red == nil
        project.pull_request.get_data
      end
      if project.slack_metric and project.slack_data_points.length == 0
        project.slack_metric.get_data
      end
      if project.code_climate_metric
        project.code_climate_metric.get_data
      end
      project.gpa = project.code_climate_metric.get_gpa[:stat]
      project.coverage = project.code_climate_metric.get_coverage[:stat]
      if project.pivotal_tracker.done == nil
        project.pivotal_tracker.get_data
      end
      project.get_scores
      
      #print project.gpa
      #print ' <----------> '
      #print project.code_climate_metric.gpa
    end
    #@projects = Project.all.order(:gpa)
    if sort == 'gpa'
      @projects = Project.order(:gpa)
    elsif sort == 'coverage' 
      @projects = Project.order(:coverage)
    elsif sort == 'prs' 
      @projects = Project.order(:prs)
    elsif sort == 'pts' 
      @projects = Project.order(:pts)
    elsif sort == 'name'
      @projects = Project.order(:name)
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name)
    end
end
