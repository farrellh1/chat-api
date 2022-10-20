require 'rails_helper'

RSpec.describe Conversation, type: :model do
  # it { should belong_to(:user).class_name('User').with_foreign_key('sender_id') }
  it { should belong_to(:user).class_name('User').with_foreign_key('recipient_id') }
  it { should have_many(:messages) } 
end
