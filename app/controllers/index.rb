get '/' do
  # Look in app/views/index.erb
  erb :index

end

post '/urls' do
  # create a new Url
  url = Url.find_by_full(params[:full])

  if url
    @short = url.short
  else 
    if Url.create(params).valid?
      @short = Url.last.short
      erb :short_url
    else
      erb :invalid
    end
  end
end

# e.g., /q6bda
get '/:short_url' do
  url = Url.find_by_short(params[:short_url])
  url.click_count += 1
  url.save
  redirect to Url.find_by_short(params[:short_url]).full
end

