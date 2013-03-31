atom_feed do |feed|
  feed.title('ET Routes')
  feed.updated(@routes.first.created_at) if @routes.any?

  @routes.each do |route|
    feed.entry(route, :url => route.url) do |entry|
      entry.title('New Route')
      entry.content(RoutePresenter.new(route).to_tweet)
    end
  end
end