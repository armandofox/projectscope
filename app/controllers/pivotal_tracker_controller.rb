class PivotalTrackerController < ApplicationController
  before_action :set_pivotal_tracker, only: [:show, :edit, :update, :destroy]

  # GET /projects/:project_id/pivotal_tracker(.:format)
  def index
    @pivotal_trackers = PivotalTracker.find_by params[:project_id]
  end

  # GET /projects/:project_id/pivotal_trackers/:id(.:format)
  def show
  end

  # GET /projects/:project_id/pivotal_trackers/new(.:format)
  def new
    @pivotal_tracker = PivotalTracker.new
  end

  # GET /projects/:project_id/pivotal_trackers/:id/edit(.:format)
  def edit
  end

  # POST /projects/:project_id/pivotal_trackers(.:format)
  def create
    @pivotal_tracker = PivotalTracker.new(pivotal_tracker_params)

    respond_to do |format|
      if @pivotal_tracker.save
        format.html { redirect_to @pivotal_tracker, notice: 'Pull request was successfully created.' }
        format.json { render :show, status: :created, location: @pivotal_tracker }
      else
        format.html { render :new }
        format.json { render json: @pivotal_tracker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/:project_id/pivotal_trackers/:id(.:format)
  def update
    respond_to do |format|
      if @pivotal_tracker.update(pivotal_tracker_params)
        format.html { redirect_to @pivotal_tracker, notice: 'Pivotal Tracker was successfully updated.' }
        format.json { render :show, status: :ok, location: @pivotal_tracker }
      else
        format.html { render :edit }
        format.json { render json: @pivotal_tracker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/:project_id/pivotal_trackers/:id(.:format)
  def destroy
    @pivotal_tracker.destroy
    respond_to do |format|
      format.html { redirect_to pivotal_trackers_url, notice: 'Pivotal Tracker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pivotal_tracker
      @pivotal_tracker = PivotalTracker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pivotal_tracker_params
      params.require(:pivotal_tracker).permit(:done, :new, :old, :older, :project_id)
    end
end
