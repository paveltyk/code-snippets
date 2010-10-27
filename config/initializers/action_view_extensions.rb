# MonkeyPatch to add default classes to form inputs
module ActionView
  module Helpers
    class InstanceTag
      def tag_with_default_class(name, options)
        options = add_default_class(name, options)
        tag_without_default_class(name, options)
      end
      alias_method_chain :tag, :default_class
    end

    module TagHelper
      def tag_with_default_class(name, options = nil, open = false, escape = true)
        options = add_default_class(name, options || {})
        tag_without_default_class(name, options, open, escape)
      end
      alias_method_chain :tag, :default_class
    end
  end
end

private

def add_default_class(name, options)
  options.stringify_keys
  if name.to_s == 'input' && options.include?('type')
    options['class'] = [options['type'], options['class']].compact.join(' ')
  end
  options
end

ActionView::Base.default_form_builder = CustomFormBuilder
ActionView::Base.field_error_proc = Proc.new { |html_tag, instance| html_tag }
