require "./spec_helper"

describe CCEP do
  # TODO: Write tests
  it "constante deve retornar o nome do pais" do
    CCEP::COUNTRY.should eq "Brasil"
  end

  describe "#validar_cep?" do
    it "retorna true para um CEP válido" do
      validar_cep?("12345678").should be_true
    end

    it "retorna false para um CEP inválido" do
      validar_cep?("1234567b").should be_false
    end
  end

  describe "#info_get" do
    it "levanta ArgumentError para cep não encontrado" do
      expect_raises(ArgumentError) do
        CCEP.info_cep("00000001")
      end
    end

    it "retorna um hash de strings caso encontre alguma informação sobre o CEP" do
      CCEP.info_cep("74765340").should be_a(Hash(String, String))
    end
  end
end
