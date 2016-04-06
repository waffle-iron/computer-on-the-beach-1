class AdicionarBairroEmContatos < ActiveRecord::Migration
  def change
    add_column :contatos, :bairro, :string
  end
end
