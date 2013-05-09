require 'spec_helper'

describe Georgia::Page do

  specify {FactoryGirl.build(:kennedy_post).should be_valid}

end