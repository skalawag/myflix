require 'spec_helper'

describe User do
  it { should have_secure_password }
  it { should validate_presence_of :email }
  it { should validate_presence_of :username }
  it { should have_many :reviews }
end
