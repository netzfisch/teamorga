require 'spec_helper'

describe EventsController do

  describe 'generate recurrences from event data' do
    before :each do
      @fake_results = [mock('recurrence1'), mock('recurrence2')]
    end

    it 'should call the model method that generates recurrence dates ' do
      Event.should_receive(:dates_between).with(base_date, end_date).
        and_return(@fake_results)
      post :dates_between, {:dates_between => (base_date, end_date)}
    end

    describe 'after valid recurrence generation' do
      before :each do
        Recurrence.stub(:dates_between).and_return(@fake_results)
        post :dates_between, {:dates_between => (base_date, end_date)}
      end
      it 'should select the event results template for rendering' do
        response.should render_template('index')
      end
      it 'should make the created results available to that template' do
        assigns(:recurrences).should == @fake_results
      end

    end
  end
end

