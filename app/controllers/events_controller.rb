class EventsController < ApplicationController

  before_action :logged_in_user, only: [:new, :create, :destroy, :index, :show]

  def new
  end

  def index
    @upcoming_events = Event.future
    @past_events = Event.past
  end

  def show
    @event = Event.find(params[:id])
    @eventAttendees = @event.attendees
  end

  def create
    @event = current_user.events.build(event_params)
    if (@event.save)
      flash[:success] = "Event created!"
      redirect_to current_user
    else
      flash[:danger] = "Invalid event paramters."
      render 'new'
    end
  end

  def destroy
  end

  def event_params
    params.require(:event).permit(:name, :description, :date, :location)
  end

end
