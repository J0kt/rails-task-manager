# Defines the TasksController class, which inherits from ApplicationController.
class TasksController < ApplicationController
  # This 'before_action' callback ensures that the 'set_task' method is called
  # before the specified actions (:show, :edit, :update, :destroy, :toggle_completed).
  # It's used to find a task by its ID and make it available to these actions.
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_completed]

  # This action is responsible for displaying a list of all tasks.
  def index
    # Retrieves all records from the Task model and assigns them to the @tasks instance variable,
    # making them available to the view.
    @tasks = Task.all
  end

  # This action is responsible for displaying a single task.
  # The @task instance variable is already set by the `set_task` before_action.
  def show
  end

  # This action prepares a new, unsaved task object for the form.
  def new
    # Creates a new instance of the Task model, which will be used to build the form.
    @task = Task.new
  end

  # This action handles the submission of the new task form.
  def create
    # Creates a new Task object with the parameters submitted from the form.
    # The `task_params` method ensures only permitted attributes are used (strong parameters).
    @task = Task.new(task_params)
    # Attempts to save the new task to the database.
    if @task.save
      # If the task is successfully saved, redirects the user to the show page for that task,
      # and sets a success notice.
      redirect_to task_path(@task), notice: "Tâche créée avec succès !"
    else
      # If the task fails to save (e.g., due to validation errors),
      # re-renders the 'new' template, preserving user input,
      # and sets an HTTP status code indicating an unprocessable entity.
      render :new, status: :unprocessable_entity
    end
  end

  # This action prepares an existing task object for the edit form.
  # The @task instance variable is already set by the `set_task` before_action.
  def edit
  end

  # This action handles the submission of the edit task form.
  def update
    # The @task instance variable is already set by the `set_task` before_action.
    # Attempts to update the existing task with the parameters submitted from the form.
    if @task.update(task_params)
      # If the task is successfully updated, redirects the user to the show page for that task,
      # and sets a success notice.
      redirect_to task_path(@task), notice: "Tâche mise à jour !"
    else
      # If the task fails to update (e.g., due to validation errors),
      # re-renders the 'edit' template, preserving user input,
      # and sets an HTTP status code indicating an unprocessable entity.
      render :edit, status: :unprocessable_entity
    end
  end

  # This action handles the deletion of a task.
  def destroy
    # Deletes the task from the database.
    @task.destroy
    # Redirects the user to the tasks index page after deletion,
    # sets a success notice, and specifies an HTTP status code for 'See Other'.
    redirect_to tasks_path, notice: "Tâche supprimée.", status: :see_other
  end

  # This action toggles the 'completed' status of a task.
  def toggle_completed
    # The @task instance variable is already set by the `set_task` before_action.
    # Updates the 'completed' attribute of the task to its opposite boolean value.
    @task.update(completed: !@task.completed)
    # Redirects the user to the tasks index page after updating the status.
    # Sets a dynamic notice message based on the new 'completed' status,
    # and specifies an HTTP status code for 'See Other'.
    redirect_to tasks_path, notice: @task.completed ? "Tâche marquée comme terminée ✅" : "Tâche marquée comme non terminée 🔄", status: :see_other
  end

  # Private methods are defined below this keyword.
  # They can only be called from within this controller.
  private

  # Private method to find a task by its ID.
  # This method is called by the `before_action` for specific controller actions.
  def set_task
    # Finds a task in the database using the 'id' parameter from the URL,
    # and assigns it to the @task instance variable.
    # If the task is not found, it will automatically raise a RecordNotFound error,
    # which Rails handles by default with a 404 page.
    @task = Task.find(params[:id])
  end

  # Private method to define strong parameters for tasks.
  # This prevents malicious users from injecting unwanted data into the database.
  def task_params
    # Requires that the 'params' hash contains a ':task' key.
    # Permits only the 'title', 'details', and 'completed' attributes to be mass-assigned.
    params.require(:task).permit(:title, :details, :completed)
  end
end
