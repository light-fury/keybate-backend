class RoomSerializer < ActiveModel::Serializer
  attributes :id, :number, :room_name, :created_at, :links,
             :display_panel_display_new, :display_panel_display_poll,
             :display_panel_display_poll_results, :display_panel_current_poll,
             :display_panel_display_poll_bar_chart, :display_panel_display_poll_pie_chart

  # embed :ids
  has_one :moderator

  def links
    {
      attendees: api_attendees_path(room_id: object.id),
      questions: api_questions_path(room_id: object.id),
      qcm_polls: api_qcm_polls_path(room_id: object.id)
    }
  end
end
