class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, except: [:index]
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @tickets = Ticket.all.includes(:project, :assignee)
  end

  def show
  end

  def new
    @ticket = @project.tickets.build
  end

  def edit
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    @ticket.assignee = current_user

    if @ticket.save
      redirect_to project_path(@project), notice: 'Ticket was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to project_ticket_path(@project, @ticket), notice: 'Ticket was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ticket.destroy
    redirect_to project_tickets_url(@project), notice: 'Ticket was successfully destroyed.'
  end

  def kanban
    @statuses = ['to_do', 'in_progress', 'done']
    @tickets = @project.tickets.includes(:assignee)
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_ticket
    @ticket = @project.tickets.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description, :status, :priority)
  end
end
