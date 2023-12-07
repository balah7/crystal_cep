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

   def info_cep(cep : String)

    unless validar_cep?(cep)
      raise ArgumentError.new("O CEP '#{cep}' não está no formato válido. Deve conter exatamente 8 (#{cep.size}) dígitos numéricos.")
    end

    url = "https://viacep.com.br/ws/#{cep}/json/"
    response = HTTP::Client.get(url)

    if response.success?
      body = response.body
      json_body = JSON.parse(%(#{body}))
      puts json_body
    else
      puts "Erro na solicitação"
    end
  end
end

include CCEP

CCEP.info_cep("49082050")
p "---------------------"
CCEP.info_cep("00000099")
