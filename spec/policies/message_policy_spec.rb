require 'rails_helper'

RSpec.describe MessagePolicy do
  subject { described_class.new(user, message) }

  let(:user) { create(:user) }
  let(:user_two) { create(:user) }
  let(:event) { create(:event) }

  context "for a contact" do
    let(:contact) { create(:contact_example, event: event, from_user: user, to_user: user_two) }
    let(:message) { create(:message, contact: contact) }

    it { is_expected.to permit_action(:index)    }
    it { is_expected.to permit_action(:show)    }
    it { is_expected.to permit_action(:create)  }
    it { is_expected.to permit_action(:update)  }
    it { is_expected.to permit_action(:destroy) }
  end

  context "for a non-contact" do
    # Someone who doesn't have a contact role (created contact without creating role).
    let(:fake_contact) { create(:contact, event: event, from_user: user, to_user: user_two) }
    let(:message) { create(:message, contact: fake_contact) }

    it { is_expected.to forbid_action(:index)    }
    it { is_expected.to forbid_action(:show)    }
    it { is_expected.to forbid_action(:create)  }
    it { is_expected.to forbid_action(:update)  }
    it { is_expected.to forbid_action(:destroy) }
  end
end
