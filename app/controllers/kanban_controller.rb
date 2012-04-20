class KanbanController < ApplicationController
  before_filter :find_project, :except => [:index]
  
  
  def index
    @projects = Project.where("unfuddle_id IS NOT NULL")
  end
  
  
  def show
  end
  
  
  def queue
    render :json => TicketPresenter.new(@project.tickets_in_queue(params[:queue]))
  end
  
  def assign_ticket_to_queue
    ticket = @project.find_or_create_ticket_by_number(params[:ticket_number])
    if ticket
      ticket.set_queue! params[:queue]  
      render :json => TicketPresenter.new(ticket)
    else
      render :json => {errors: ["Ticket could not be found."]}, :status => :unprocessable_entity
    end
  end
  
  def remove_ticket_from_queue
    ticket = @project.find_or_create_ticket_by_number(params[:ticket_number])
    if ticket
      ticket.set_queue! nil
      head :ok
    else
      render :json => {errors: ["Ticket could not be found."]}, :status => :unprocessable_entity
    end
  end
  
  
private
  
  
  def find_project
    @project = Project.find_by_slug!(params[:slug])
  end
  
  
end
