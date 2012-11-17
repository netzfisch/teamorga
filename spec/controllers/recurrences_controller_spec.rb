require 'spec_helper'

describe RecurrencesController, "GET index" do

# not working, because:
# application_controller filter: "before_filter :require_login"
# recurrences_controller method: "@recurrences = Recurrence.find :all"

    before :each do
# better as helper method: sign_in user
user = User.create!(:email => "jdoe", :password => "secret", :name => "jdoe")
visit "/login"
fill_in "Email", :with => "jdoe"
fill_in "Password", :with => "secret"
click_button "Log in"
      @recurrence = mock_model(Recurrence)
      Recurrence.stub!(:find).with(:all).and_return([@recurrence])
      #Recurrence.stub!(:total_pages).and_return(0)
    end

    def do_get
      get :index
    end

    it "should be successfull" do
      do_get
      response.should be_success
    end

    it "should assign recurrences" do
      do_get
      assigns[:recurrences].should be_instance_of(Array)
    end

    it "should call the find method of the recurrence class" do
      Recurrence.should_receive(:find).with(:all).and_return(@recurrence)
      do_get
    end

    it "should render the index template" do
      do_get
      response.should render_template("index")
    end

end

