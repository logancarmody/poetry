module PoemsHelper
  def generate_poem
    search = poem_params[:search]
    ss = poem_params[:second_search].present? 
    lex = ""
    lex += get_text(search)
    lex += get_text(poem_params[:second_search]) if ss
    lex = Sanitize.fragment(lex)
    poem = ""
    mark = MarkyMarkov::TemporaryDictionary.new
    mark.parse_string lex
    random_range(6, 15).times do 
      if rand % 2 
        poem += mark.generate_n_words random_range(3, 8)
      else 
        poem += mark.generate_1_sentence
      end
      poem += " || "
    end
    return {poem: poem, lexicon: lex, search: search, ss: ss, second_search: poem_params[:second_search]}
  end

  def get_text(query)
    return google_search(query) + wikipedia_search(query)
  end

  def google_search(query)
    t= ""    
    Google::Search::News.new(query: query).each_with_index do |q,i|
      t += q.content
    end
    return t
  end

  def wikipedia_search(query)
    return Wikipedia.find(query).summary.delete('\n')
  end

  def random_range(start, stop)
    return start + rand(stop-start)
  end

  def poem_title(poem)
    t = poem.search
    t += " & #{poem.second_search}" if poem.ss
    return t
  end
end
