class Api::V1::Admin::PollsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_poll, only: [:show, :update, :destroy, :publish, :open, :display_results, :destroy_option]
  respond_to :json

  def index
    @polls = current_room.polls
    authorize @polls.first if @polls.first
  end

  def create
    @poll = current_room.polls.new(poll_params)
    authorize @poll

    if @poll.published != true
      if current_room.polls.count >= 1
        max_list_order = current_room.polls.where.not(list_order: nil).order("list_order DESC").first.try(:list_order) || -1
        @poll.list_order = max_list_order + 1
      else
        @poll.list_order = 0
      end
    end

    if @poll.save!
      if @poll.published
        ActionCable.server.broadcast "polls_#{@poll.room.id}",
          action: 'publish_to_public',
          id: @poll.id,
          event_id: @poll.event_id,
          room_id: @poll.room_id,
          title: @poll.title,
          options_count: @poll.options_count,
          display_results: @poll.display_results,
          published: @poll.published,
          list_order: @poll.list_order,
          open: @poll.open,
          options: poll_options
        head :ok
      else
        ActionCable.server.broadcast "polls_#{@poll.room.id}",
          action: 'create',
          id: @poll.id,
          event_id: @poll.event_id,
          room_id: @poll.room_id,
          title: @poll.title,
          options_count: @poll.options_count,
          display_results: @poll.display_results,
          published: @poll.published,
          list_order: @poll.list_order,
          open: @poll.open,
          options: poll_options
        head :ok
      end
    end
  end

  def show
    authorize @poll
  end

  def update
    authorize @poll
    if @poll.update!(poll_params)
      if params[:published] == true
        @poll.room.users.each do |user|
          Notification.create!(
            title: 'New poll',
            poll_id: @poll.id,
            event_id: @poll.event_id,
            room_id: @poll.room_id,
            description: "A new poll was sent to the room #{current_room.name}.",
            user: user
          )
        end

        ActionCable.server.broadcast "polls_#{@poll.room.id}",
          action: 'publish_to_public',
          id: @poll.id,
          event_id: @poll.event_id,
          room_id: @poll.room_id,
          title: @poll.title,
          options_count: @poll.options_count,
          answers_count: @poll.answers_count,
          display_results: @poll.display_results,
          published: @poll.published,
          list_order: @poll.list_order,
          open: @poll.open,
          options: poll_options
        head :ok
      else
        ActionCable.server.broadcast "polls_#{@poll.room.id}",
          action: 'update',
          id: @poll.id,
          event_id: @poll.event_id,
          room_id: @poll.room_id,
          title: @poll.title,
          options_count: @poll.options_count,
          answers_count: @poll.answers_count,
          display_results: @poll.display_results,
          published: @poll.published,
          list_order: @poll.list_order,
          open: @poll.open,
          options: poll_options
        head :ok
      end
    end
  end

  def destroy
    authorize @poll
    @poll.destroy!
  end

  def reorder
    authorize current_room.polls.first
    params[:polls].each do |poll_attributes|
      poll = Poll.find(poll_attributes[:id])
      poll.update_attribute(:list_order, poll_attributes[:list_order])

      ActionCable.server.broadcast "polls_#{current_room.id}",
        action: 'reorder',
        id: poll.id,
        list_order: poll.list_order
      head :ok
    end
  end

  def publish
    authorize @poll
    previous_list_order = @poll.list_order

    if @poll.update!(published: true, list_order: nil)
      @poll.reorder_after_publish(current_room, previous_list_order)

      @poll.room.users.each do |user|
        Notification.create!(
          title: 'New poll',
          poll_id: @poll.id,
          event_id: @poll.event_id,
          room_id: @poll.room_id,
          description: "A new poll was sent to the room #{current_room.name}.",
          user: user
        )
      end

      ActionCable.server.broadcast "polls_#{@poll.room.id}",
        action: 'publish_to_public',
        id: @poll.id,
        event_id: @poll.event_id,
        room_id: @poll.room_id,
        title: @poll.title,
        options_count: @poll.options_count,
        answers_count: @poll.answers_count,
        display_results: @poll.display_results,
        published: @poll.published,
        list_order: @poll.list_order,
        open: @poll.open,
        options: poll_options
      head :ok
    end
  end

  def open
    authorize @poll
    if @poll.update!(open: true)
      ActionCable.server.broadcast "polls_#{@poll.room.id}",
        action: 'open',
        id: @poll.id,
        published: @poll.published,
        open: @poll.open
      head :ok
    end
  end

  def display_results
    authorize @poll
    @poll.update!(display_results: true)
  end

  def destroy_option
    authorize @poll
    @poll.options.find(params[:option_id]).destroy!
  end

  private

  def poll_params
    params.permit(:title, :room_id, :event_id, :published, :open, :display_results, options_attributes: [:id, :description])
  end

  def current_room
    Room.includes(:polls).find(params[:room_id])
  end

  def set_poll
    @poll = current_room.polls.includes(:answers, :options).find(params[:id])
  end

  # options.answers.count should be implemented with a counter cache.
  def poll_options
    @poll.options.map do |option|
      { id: option.id, description: option.description, count: option.answers.count }
    end
  end
end
