class Key < ActiveRecord::Base
  before_create { generate_token(:password) }

  /Método para Gerar Senha Randomica/
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64(20,false)
    end while Key.exists?(column => self[column])    
  end

end
