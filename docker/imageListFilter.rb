class ImageListFilter
  attr_accessor :dangling, :before, :since, :label, :reference

  def to_s
    "#{resolve_dangling} #{resolve_label} #{resolve_reference} #{resolve_since} #{resolve_before}"
  end

  private def resolve_dangling
    unless @dangling.nil?
      "--filter dangling=#{@dangling}"
    end
  end

  private def resolve_label
    unless @label.nil?
      "--filter label=#{@label}"
    end
  end

  private def resolve_reference
    unless @reference.nil?
      "--filter reference=#{@reference}"
    end
  end

  private def resolve_since
    unless @since.nil?
      "--filter since=#{@since}"
    end
  end

  private def resolve_before
    unless @before.nil?
      "--filter before=#{@before}"
    end
  end
end

class ImageListFilterBuilder
  def initialize
    @image_list_filter = ImageListFilter.new
  end

  def get
    @image_list_filter
  end

  def with_dangling(value)
    @image_list_filter.dangling = value
    self
  end

  def with_label(value)
    @image_list_filter.label = value
    self
  end

  def with_reference(value)
    @image_list_filter.reference = value
    self
  end

  def with_since(value)
    @image_list_filter.since = value
    self
  end

  def with_before(value)
    @image_list_filter.before = value
    self
  end

end