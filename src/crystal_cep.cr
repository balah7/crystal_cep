require "./crystal_cep/*"
require "http/client"
require "json"

def validar_cep?(cep : String) : Bool
  regex = /\A\d{8}\z/
  return !!(cep =~ regex)
end

module CCEP
  extend self

  COUNTRY = "Brasil"

  def info_cep(cep : String) : Hash(String, String)
    unless validar_cep?(cep)
      raise ArgumentError.new("O CEP '#{cep}' não está no formato válido. Deve conter exatamente 8 (#{cep.size}) dígitos numéricos.")
    end

    url = "https://viacep.com.br/ws/#{cep}/json/"
    response = HTTP::Client.get(url)

    if response.success?
      json_body = JSON.parse(%(#{response.body}))

      raise ArgumentError.new("CEP não encontrado: #{cep}") if json_body["erro"]?

      return {
        "cep"        => json_body["cep"].to_s,
        "street"     => json_body["logradouro"].to_s,
        "complement" => json_body["complemento"].to_s,
        "hood"       => json_body["bairro"].to_s,
        "city"       => json_body["localidade"].to_s,
        "uf"         => json_body["uf"].to_s,
        "ddd"        => json_body["ddd"].to_s,
        "ibge"       => json_body["ibge"].to_s,
      }
    else
      raise ArgumentError.new("Não foi possível acessar as informações do CEP no momento. Por favor, relate esse problema aos contribuidores e tente novamente mais tarde.")
    end
  end
end

include CCEP

# puts CCEP.info_cep("74765340")
# puts "---------------------"
# puts CCEP.info_cep("00000099")
