# Import the required files and modules
require "./crystal_cep/*"
require "http/client"
require "json"

# Method to validate if the provided CEP is in a valid format
def validar_cep?(cep : String) : Bool
  regex = /\A\d{8}\z/
  return !!(cep =~ regex)
end

# Module definition for CCEP
module CCEP
  extend self

  # Constant indicating the country
  COUNTRY = "Brasil"

  # Method to fetch information based on a given CEP
  def info_cep(cep : String) : Hash(String, String)
    # Validate if the CEP is in a valid format
    unless validar_cep?(cep)
      raise ArgumentError.new("O CEP '#{cep}' não está no formato válido. Deve conter exatamente 8 (#{cep.size}) dígitos numéricos.")
    end

    # Construct the URL for the ViaCEP API
    url = "https://viacep.com.br/ws/#{cep}/json/"

    # Make a GET request to the ViaCEP API
    response = HTTP::Client.get(url)

    # Check if the API request was successful
    if response.success?
      # Parse the JSON response
      json_body = JSON.parse(%(#{response.body}))

      # Check if the API response indicates an error
      raise ArgumentError.new("CEP não encontrado: #{cep}") if json_body["erro"]?

      # Return a Hash with relevant information
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
      # Raise an error if the API request was not successful
      raise ArgumentError.new("Não foi possível acessar as informações do CEP no momento. Por favor, relate esse problema aos contribuidores e tente novamente mais tarde.")
    end
  end
end
