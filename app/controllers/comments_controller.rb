class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to project_ticket_path(@ticket.project, @ticket), notice: "Комментарий добавлен"
    else
      redirect_to project_ticket_path(@ticket.project, @ticket), alert: "Ошибка"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end