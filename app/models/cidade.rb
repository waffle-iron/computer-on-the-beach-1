class Cidade < ActiveRecord::Base
  has_many :contatos

  validates :nome,
    presence: true

  validates :uf,
    presence: true,
    length: { is: 2 }
end
