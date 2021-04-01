# frozen_string_literal: true

require_relative "trace_spec_helper"

RSpec.describe RpnUIA::Traceable, ".define_trace" do
  context "with :state" do
    subject { Dummy.new }

    it "creates @state" do
      expect(subject).to have_attributes state: nil
    end

    it "creates the empty trace for @state" do
      expect(subject).to have_attributes state_traces: []
    end

    it "creates :state=" do
      expect(subject).to respond_to :state=
    end

    it "creates :state" do
      expect(subject).to respond_to :state
    end

    it "creates :state_traces" do
      expect(subject).to respond_to :state_traces
    end

    it "creates :clear_state" do
      expect(subject).to respond_to :clear_state
    end

    it "creates :save_state" do
      expect(subject).to respond_to :save_state
    end

    it "creates :restore_previous_state" do
      expect(subject).to respond_to :restore_previous_state
    end

    it "creates :any_previous_state?" do
      expect(subject).to respond_to :any_previous_state?
    end
  end

  context "with :state and :feeling" do
    subject(:cat) { Cat.new }

    it "creates both @state & @feeling" do
      expect(subject).to have_attributes(state: nil, feeling: nil)
    end

    it "creates empty traces for @state_traces & @feeling_traces" do
      expect(subject).to have_attributes(state_traces: [], feeling_traces: [])
    end

    it "creates :state= & :feeling=" do
      expect(subject).to respond_to :state=
      expect(subject).to respond_to :feeling=
    end

    it "creates :state & :feeling" do
      expect(subject).to respond_to :state
      expect(subject).to respond_to :feeling
    end

    it "creates :state_traces & :feeling_trace" do
      expect(subject).to respond_to :state_traces
      expect(subject).to respond_to :feeling_traces
    end

    it "creates :clear_state & :clear_feeling" do
      expect(subject).to respond_to :clear_state
      expect(subject).to respond_to :clear_feeling
    end

    it "creates :save_state & save_feeling" do
      expect(subject).to respond_to :save_state
      expect(subject).to respond_to :save_feeling
    end

    it "creates :restore_previous_state & :restore_previous_feeling" do
      expect(subject).to respond_to :restore_previous_state
      expect(subject).to respond_to :restore_previous_feeling
    end

    it "creates :any_previous_state? & :any_previous_feeling?" do
      expect(subject).to respond_to :any_previous_state?
      expect(subject).to respond_to :any_previous_feeling?
    end
  end
end
