require 'rails_helper'

RSpec.describe RoomPolicy do
  subject { described_class.new(user, room) }

  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:room) { create(:room, event: event) }

  context "for an event moderator" do
    let!(:event_moderator) { create(:event_moderator_example, event: event, user: user) }

    it { is_expected.to forbid_action(:index)   }
    it { is_expected.to forbid_action(:show)    }
    it { is_expected.to permit_action(:create)  }
    it { is_expected.to permit_action(:update)  }
    it { is_expected.to permit_action(:destroy) }
    it { is_expected.to permit_action(:clear_display) }
    it { is_expected.to permit_action(:show_questions) }
    it { is_expected.to permit_action(:hide_questions) }
    it { is_expected.to forbid_action(:join) }
  end

  context "for an event attendee" do
    let!(:event_user) { create(:event_user_example, event: event, user: user) }

    it { is_expected.to permit_action(:index)   }
    it { is_expected.to forbid_action(:show)    }
    it { is_expected.to forbid_action(:create)  }
    it { is_expected.to forbid_action(:update)  }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to forbid_action(:clear_display) }
    it { is_expected.to forbid_action(:show_questions) }
    it { is_expected.to forbid_action(:hide_questions) }
    it { is_expected.to permit_action(:join) }
  end

  context "for a room attendee" do
    let!(:event_user) { create(:event_user_example, event: event, user: user) }
    let!(:event_user_room) { create(:event_user_room_example, room: room, event_user: event_user) }

    it { is_expected.to permit_action(:index)   }
    it { is_expected.to permit_action(:show)    }
    it { is_expected.to forbid_action(:create)  }
    it { is_expected.to forbid_action(:update)  }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to forbid_action(:clear_display) }
    it { is_expected.to forbid_action(:show_questions) }
    it { is_expected.to forbid_action(:hide_questions) }
    it { is_expected.to permit_action(:join) }
  end

  context "for a non-attendee && non-moderator" do
    it { is_expected.to forbid_action(:index)   }
    it { is_expected.to forbid_action(:show)    }
    it { is_expected.to forbid_action(:create)  }
    it { is_expected.to forbid_action(:update)  }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to forbid_action(:clear_display) }
    it { is_expected.to forbid_action(:show_questions) }
    it { is_expected.to forbid_action(:hide_questions) }
    it { is_expected.to forbid_action(:join) }
  end

end
