class TicketsController < ApplicationController
  before_action :set_project, only: [:index, :new, :create]
  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update(ticket_params)
      redirect_to project_tickets_path, notice: "Задача обновлена"
    else
      render :edit
    end
  end
  def kanban
    @project = Project.find(params[:project_id])
    @statuses = %w[To\ Do In\ Progress Done]
  end

  def edit
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.find(params[:id])
  end

  def index
    @tickets = @project.tickets
  end

  def show
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.find(params[:id])
  end
  def new
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.build
  end

  def create
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.build(ticket_params)
    @ticket.user = current_user

    if @ticket.save
      redirect_to project_path(@project), notice: "Задача создана"
    else
      render :new
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:project_id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description, :status)
  end
end
