class TicketPresenter
  
  def initialize(tickets)
    @tickets = tickets
  end
  
  def as_json(*args)
    if @tickets.is_a?(Ticket)
      ticket_as_json(@tickets)
    else
      @tickets.map(&method(:ticket_as_json))
    end
  end
  
  def ticket_as_json(ticket)
    { id: ticket.id,
      projectId: ticket.project.unfuddle_id,
      projectSlug: ticket.project.slug,
      projectColor: ticket.project.color,
      number: ticket.number,
      summary: ticket.summary,
      age: ticket.age }
  end
  
end
