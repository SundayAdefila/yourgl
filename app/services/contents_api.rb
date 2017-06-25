class ContentsApi
  def initialize(opts={})
    @should_paginate = opts[:paginate]
    @per_page = Rails.configuration.contents_per_page
    @page_count = (opts[:page_count] || 0).to_i
  end

  def get_objs
    @results = {}
    @objs = Content.all

    paginate_objs if @should_paginate

    @results[:contents] = @objs
    @results
  end

  def paginate_objs
    @objs = @objs.limit(@per_page + 1).offset(@page_count * @per_page)
    if @objs.length > @per_page
      @objs = @objs.take(@per_page)
      @results[:next_page] = true
    else
      @results[:next_page] = false
    end
  end

end