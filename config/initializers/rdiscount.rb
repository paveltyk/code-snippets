class String
  # More info at RDiscount#new
  #
  # :smart - Enable SmartyPants processing.
  # :filter_styles - Do not output <style> tags.
  # :filter_html - Do not output any raw HTML tags included in the source text.
  # :fold_lines - RedCloth compatible line folding (not used).
  # :generate_toc - Enable Table Of Contents generation
  # :no_image - Do not output any <img> tags.
  # :no_links - Do not output any <a> tags.
  # :no_tables - Do not output any tables.
  # :strict - Disable superscript and relaxed emphasis processing.
  # :autolink - Greedily urlify links.
  # :safelink - Do not make links for unknown URL types.
  # :no_pseudo_protocols - Do not process pseudo-protocols.
  def format_markdown(*options)
    options = [:filter_html, :safelink, :no_pseudo_protocols, :smart] if options.blank?
    RDiscount.new(self, *options).to_html
  end
end
