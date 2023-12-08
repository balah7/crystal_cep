# crystal_cep

<img src="https://img.shields.io/badge/shards-v0.1.0-purple" alt="Shard Version">

A Biblioteca Crystal CEP é uma ferramenta poderosa e fácil de usar para desenvolvedores que trabalham com a linguagem de programação Crystal, permitindo a recuperação fácil e sem emendas de informações de endereço com base nos códigos postais brasileiros (CEP - Código de Endereçamento Postal). Esta biblioteca que usa a api [ViaCEP](https://viacep.com.br/), simplifica o processo de integração da funcionalidade de consulta de CEP em suas aplicações Crystal, fornecendo detalhes precisos e atualizados para um determinado CEP.

## Instalação

1. Adicione a dependência ao seu `shard.yml`:

   ```yaml
   dependencies:
     crystal_cep:
       github: balah7/crystal_cep
   ```

2. Execute `shards install`

## Uso

Requerimento:

```crystal
require "crystal_cep"
```

Pequeno exemplo: (CCEP)

```crystal
require "crystal_cep"

# --- Função info_get(cep : String) : Hash(String, String) -> Função onde irá passar como argumento o CEP (String) apenas número e 8 caracteres e irá retornar um Hash de String com as informações sobre o cep.
data = CCEP.info_cep("01001000")
puts data
# => {"cep" => "01001000", "street" => "Praça da Sé", "complement" => "", "hood" => "Sé", "city" => "São Paulo", "uf" => "SP", "ddd" => "11", "ibge" => "3550308"}

data["cep"]
# => 01001000

data["street"]
# => "Praça de Sé"

data["complement"]
# => ""

data = CCEP.info_cep("01001-000")
# => Error

...
```

## Contribuição

1. Fork o repositório (<https://github.com/balah7/crystal_cep/fork>)
2. Crie uma branch para sua nova feature (`git checkout -b my-new-feature`)
3. Faça suas alterações (`git commit -am 'Add some feature'`)
4. Envie suas alterações para a sua branch (`git push origin my-new-feature`)
5. Crie um novo Pull Request

## Contribuidores

- [balah7](https://github.com/balah7) - criador e mantenedor
