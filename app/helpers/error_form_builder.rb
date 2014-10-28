class ErrorFormBuilder < ActionView::Helpers::FormBuilder
  def label(method, text = nil, options = {}, &block)
    errors = object.errors[method.to_sym]
    if not errors.empty?
      text += " <span class=\"errors\">#{errors.first}</span>"
    end
    super(method, text.html_safe, options, &block)
  end
end
