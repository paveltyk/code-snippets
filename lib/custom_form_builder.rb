class CustomFormBuilder < ActionView::Helpers::FormBuilder
  def error_messages(options={})
    super options.reverse_merge(:header_message => nil, :message => nil, :class => 'error-explanation', :id => nil)
  end
end
