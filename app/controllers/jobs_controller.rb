class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
      if params[:screen_id]
          @screen = Screen.find(params[:screen_id])
          @jobs = @screen.jobs.order('target')
      else
        @jobs = Job.order('target')
      end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
      if params[:screen_id]
          @screen = Screen.find(params[:screen_id])
      end
  end

  # GET /jobs/new
  def new
      if params[:screen_id]
          @screen = Screen.find(params[:screen_id])
      end
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
      if params[:screen_id]
          @screen = Screen.find(params[:screen_id])
      end
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @screen = Screen.find(params[:screen_id])
    @job = Job.new(job_params)
    @job.user = current_user
    @job.screen = @screen

    respond_to do |format|
      if @job.save
        format.html { redirect_to screen_jobs_path(@screen, @job), notice: 'Job was successfully created.' }
        format.json { render action: 'show', status: :created, location: @job }
      else
        format.html { render action: 'new' }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to screen_jobs_path(@job.screen,@job), notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
      if params[:screen_id]
          @screen = Screen.find(params[:screen_id])
      end
    @job.destroy
    respond_to do |format|
      format.html { redirect_to @screen || jobs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:screen_id, :command_id, :arguments, :target_string)
    end
end
