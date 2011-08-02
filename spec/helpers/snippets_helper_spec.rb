require 'spec_helper'

describe SnippetsHelper do
  describe "#render_tag_list" do
    it "should return string with generated links" do
      tag_list = TagList.new "Tag1, Tag2", :parse => true
      helper.render_tag_list(tag_list).scan(/<a /i).size.should eql(2)
    end
  end

  describe "#title_for_snippets_index" do
    context 'with snippets_controller' do
      before(:each) { params[:controller] = 'snippets' }

      it 'returns nil on the first index page' do
        helper.title_for_snippets_index.should be_nil
      end

      it 'returns "Page #" if page param present' do
        params[:page] = 2
        helper.title_for_snippets_index.should =~ /^Page 2$/i
      end
    end

    context 'with my/snippets_controller' do
      before(:each) { params[:controller] = 'my/snippets' }

      it 'returns "My Snippets" on the first index page' do
        helper.title_for_snippets_index.should =~ /^My Snippets$/i
      end

      it 'returns "My Snippets | Page #" if page param present' do
        params[:page] = 2
        helper.title_for_snippets_index.should =~ /^My Snippets \| Page 2$/i
      end
    end

    context 'with tags_controller' do
      before(:each) { params[:controller] = 'tags' }

      it 'returns "Tag: #{tag_name}" on the first index page' do
        params[:tag_name] = 'rails'
        helper.title_for_snippets_index.should =~ /^Tag: rails$/i
      end

      it 'returns "Tag: #{tag_name} | Page #" if page param present' do
        params[:page] = 2
        params[:tag_name] = 'rails'
        helper.title_for_snippets_index.should =~ /^Tag: rails \| Page 2$/i
      end
    end

    context 'with users_controller' do
      before(:each) do
        params[:controller] = 'users'
        helper.instance_variable_set :@user, User.make(:username => 'Pavel')
      end

      it 'returns username on the first show page' do
        helper.title_for_snippets_index.should =~ /^Pavel$/i
      end

      it 'returns "#{username} | Page #" if page param present' do
        params[:page] = 2
        helper.title_for_snippets_index.should =~ /^Pavel \| Page 2$/i
      end
    end
  end
end

