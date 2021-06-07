class MovieService

  def self.parse_data(query)
    data = JSON.parse(request(query).body, symbolize_names: true)
    data[:results]
  end

  def self.connection
    Faraday.new("https://api.themoviedb.org/3/search/") do |conn|
      conn.authorization :Bearer, ENV['MOVIEDB_TOKEN']
    end
  end

  def self.request(query)
    connection.get("movie?language=en-US&query=#{query}")
  end
end