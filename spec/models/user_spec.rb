require 'spec_helper'

describe Core::User do
  it_behaves_like 'roleable'
  it_behaves_like 'nameable'
  it_behaves_like 'has api keys'
end
