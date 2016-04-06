class AddCidadeRefToContatos < ActiveRecord::Migration
  def change
    add_reference :contatos, :cidade, index: true, foreign_key: true
  end
end
