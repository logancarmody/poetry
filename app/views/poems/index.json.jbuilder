json.array!(@poems) do |poem|
  json.extract! poem, :id, :lexicon, :poem, :search
  json.url poem_url(poem, format: :json)
end
