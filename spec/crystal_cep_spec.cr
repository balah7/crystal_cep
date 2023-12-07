require "./spec_helper"

describe CrystalCep do
  # TODO: Write tests

  describe "#validar_cep?" do
    it "retorna true para um CEP válido" do
      validar_cep?("12345678").should be_true
    end
  
    it "retorna false para um CEP inválido" do
      validar_cep?("1234567b").should be_false
    end
  end
end
