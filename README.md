# Yourgl

A fully restful API to get contents of a url

### Setting up:
1. clone project
2. rake create db
3. install bundles
4. run rspec
5. dive in

### Dependencies:
1. Postgresql for db
2. Ruby 2.3.1
3. Rails 5

### Endpoints:
1. `create`: post "/contents", params: {content: {page__url: "http://some_url"}}
2. `show`: get "/contents/:id"
3. `index`(list): get "/contents"
4. `destroy`: delete "/contents/:id"

### Other features:
##### Pagination:
An optional "paginate" param can be supplied to the `index`(list) endpoint, and if set to true, will activate the pagination feature on this API.

When activated, the "per__page"(number of resources per page) is gotten from configurations, while a "page_count" param can also be set in request, to request a specific page

Example request: `get "/contents?paginate=true&page_count=4"`

**Note:** "page_count" defaults to 0 => the first page

Also, when pagination is activated, the API response will have a boolean "next_page" attribute, to show if there are more resources after the requested page.

##### Error handling:
When the provided url is in-accessible for any reason, the `create` endpoint API response has a "unable to successfully parse page url" failure message.








