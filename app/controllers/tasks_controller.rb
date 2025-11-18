class TasksController < ApplicationController
  # 1. Utilise before_action pour définir @task une seule fois
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_completed]

  def index
    @tasks = Task.all
  end

  def show
    # @task est déjà défini par set_task
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task), notice: "Tâche créée avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @task est déjà défini par set_task
  end

  def update
    # @task est déjà défini par set_task
    if @task.update(task_params)
      redirect_to task_path(@task), notice: "Tâche mise à jour !"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "Tâche supprimée.", status: :see_other
  end

  def toggle_completed
    # @task est déjà défini par set_task
    @task.update(completed: !@task.completed)
    redirect_to tasks_path, notice: @task.completed ? "Tâche marquée comme terminée ✅" : "Tâche marquée comme non terminée 🔄", status: :see_other
  end

  private

  # 2. Méthode privée pour trouver la tâche (utilisée par before_action)
  def set_task
    @task = Task.find(params[:id])
  end

  # Strong Parameters, pas de changement nécessaire
  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end
end
