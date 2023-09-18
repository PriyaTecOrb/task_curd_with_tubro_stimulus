class TasksController < ApplicationController

	def index
    if params[:query].present?
      @tasks = Task.where("description LIKE ?", "%#{params[:query]}%").paginate(:page=>params[:page],:per_page=>3)
    else
      @tasks = Task.paginate(:page=>params[:page],:per_page=>3)
    end
	end

  def new
    @task = Task.new
  end

	def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        # render turbo_stream: turbo_stream.append("tasks", @task)
        format.html { redirect_to tasks_url, notice: "Task was successfully created" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
  
  def toggle
	  @task = Task.find(params[:id])
	  @task.update(completed: params[:completed])

	  render json: { message: "Success" }
	end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_url, notice: "Task was successfully updated" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    # respond_to do |format|
    #   format.turbo_stream { render turbo_stream: turbo_stream.remove(@task) }
    #   format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
    # end

    render json: {message: "Success"}
    # redirect_to tasks_url, notice: "Task was successfully deleted."
  end


  def search
    @tasks = Task.where("description LIKE ?", "%#{params[:query]}%").paginate(:page=>params[:page],:per_page=>10)
    render json: { message: "Success",tasks: @tasks }
  end


  private

  def task_params
    params.require(:task).permit(:description)
  end
end
