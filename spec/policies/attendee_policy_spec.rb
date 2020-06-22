require 'rails_helper'

RSpec.describe AttendeePolicy do
  let(:user) { create(:user) }
  let(:non_attendee) { create(:user) }
  let(:event) { create(:event) }
  let(:room) { create(:room, event: event) }

  context "for an event moderator" do
    subject { described_class.new(non_attendee, event_user_room) }
    let!(:event_moderator) { create(:event_moderator_example, event: event, user: non_attendee) }
    let!(:event_user) { create(:event_user_example, event: event, user: user) }
    let!(:event_user_room) { create(:event_user_room_example, room: room, event_user: event_user) }

    it { is_expected.to permit_action(:index)    }
  end

  context "for a room attendee" do
    subject { described_class.new(user, event_user_room) }
    let!(:event_user) { create(:event_user_example, event: event, user: user) }
    let!(:event_user_room) { create(:event_user_room_example, room: room, event_user: event_user) }

    it { is_expected.to permit_action(:index)    }
  end

  context "for a non-attendee && non-moderator" do
    subject { described_class.new(non_attendee, event_user_room) }
    let!(:event_user) { create(:event_user_example, event: event, user: user) }
    let!(:event_user_room) { create(:event_user_room_example, room: room, event_user: event_user) }

    it { is_expected.to forbid_action(:index)    }
  end
end
