require 'rails_helper'

RSpec.describe PollPolicy do
  subject { described_class.new(user, poll) }

  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:room) { create(:room, event: event) }
  let(:poll) { create(:poll, room: room, event: event) }

  context "for an event moderator" do
    let!(:event_moderator) { create(:event_moderator_example, event: event, user: user) }

    it { is_expected.to permit_action(:index)   }
    it { is_expected.to permit_action(:show)    }
    it { is_expected.to permit_action(:create)  }
    it { is_expected.to permit_action(:update)  }
    it { is_expected.to permit_action(:destroy) }
    it { is_expected.to permit_action(:reorder) }
    it { is_expected.to permit_action(:publish) }
    it { is_expected.to permit_action(:open) }
    it { is_expected.to permit_action(:display_results) }
  end

  context "for a room attendee" do
    let!(:event_user) { create(:event_user_example, event: event, user: user) }
    let!(:event_user_room) { create(:event_user_room_example, room: room, event_user: event_user) }

    it { is_expected.to permit_action(:index)   }
    it { is_expected.to permit_action(:show)    }
    it { is_expected.to forbid_action(:create)  }
    it { is_expected.to forbid_action(:update)  }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to forbid_action(:reorder) }
    it { is_expected.to forbid_action(:publish) }
    it { is_expected.to forbid_action(:open) }
    it { is_expected.to forbid_action(:display_results) }
  end

  context "for a non-attendee && non-moderator" do
    it { is_expected.to forbid_action(:index)   }
    it { is_expected.to forbid_action(:show)    }
    it { is_expected.to forbid_action(:create)  }
    it { is_expected.to forbid_action(:update)  }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to forbid_action(:reorder) }
    it { is_expected.to forbid_action(:publish) }
    it { is_expected.to forbid_action(:open) }
    it { is_expected.to forbid_action(:display_results) }
  end
end
