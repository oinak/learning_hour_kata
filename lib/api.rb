class Faraday
  class Error < StandardError; end
end

class Api
  def get(path_str)
    path, id = path_str.split('/').reject(&:empty?)
    puts "Api#get #{{ path:, id:, path_str: }}"
    puts " /contacts/ =~ path #{/contacts/ =~ path}"
    if /contacts/ =~ path
      contacts(id)
    elsif /addresses/ =~ path
      addresses(id)
    else
      raise "Unknown path #{{ path:, id:, path_str: }}"
    end
  end

  def contacts(id)
    case id
    when '0' then Response.new({ 'contact' => { 'postcode' => '00000' } }.to_json)
    when '1' then Response.new({ 'contact' => { 'postcode' => '12345' } }.to_json)
    when '2' then Response.new('}}')
    else
      raise ::Faraday::Error
    end
  end

  def addresses(postcode)
    case postcode
    when '12345' then Response.new({ 'addresses' => [1, 2, 3] }.to_json)
    when '00000' then Response.new('}}')
    when 2 then raise Faraday::Error
    end
  end

  class Response
    attr_reader :body

    def initialize(body) = @body = body
  end
end
