require 'spec_helper'

describe Invitation do
  it { should belong_to :user }
  it { should validate_presence_of :new_user_email }
  it { should validate_presence_of :token }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :new_user_name }
end
