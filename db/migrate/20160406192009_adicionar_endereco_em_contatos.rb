class AdicionarEnderecoEmContatos < ActiveRecord::Migration
  def change
    add_column :contatos, :endereco, :string
  end
end
