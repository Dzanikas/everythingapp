class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def my_events
    @events_organized = current_user.events_organized
    @events_attended = current_user.events_attended
  end
  def new
    @event = Event.new
  end

  def create
    @organizer = current_user
    @event = @organizer.events_organized.build(event_params)
    if @event.save
      @event.invitations.create(attendee: @organizer)
      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def attend
    @event = Event.find(params[:id])
    @invitation = @event.invitations.create(attendee: current_user)

    respond_to do |format|
      format.html { redirect_to event_path(@event), notice: "You are now attending this event." }
      format.turbo_stream # Renders attend.turbo_stream.erb
    end
  end

  private

  def event_params
    params.expect(event: [ :name, :location, :time ])
  end
end
