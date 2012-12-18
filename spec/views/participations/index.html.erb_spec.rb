require 'spec_helper'

describe "participations/index" do

view.stub(:will_paginate)

  it "should render successfully" do
    render
    rendered.should match /^Zusagen (.*) Absagen (.*) Keine Rueckmeldung$/
  end

end

