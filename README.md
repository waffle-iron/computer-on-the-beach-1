# Computer on the beach

Equipe Asseinfo

<img src="https://octodex.github.com/images/baracktocat.jpg" width="181">

### 1. Iniciando

- Execute os seguintes comandos no terminal:

        $ git clone git@github.com:asseinfo/computer-on-the-beach.git
        $ git checkout passo-1

### 2. Criando uma aplicação Rails

Com todo o setup de ambiente pronto e o Rails instalado, realize os seguintes passos:

- Gerando um novo aplicativo Rails:

        $ rails new computer-on-the-beach --skip-spring

Com isso ele vai gerar uma pasta com o código fonte inicial do seu aplicativo.

- Entre no diretório do aplicativo:

        $ cd computer-on-the-beach

- Rode o servidor da aplicação:

        $ bin/rails server

- No navegador, acesse `localhost:3000`

        # Opcional
        $ git clean -fd
        $ git checkout passo-2
        $ bundle

### 3. Instalando o Bootstrap

O Rails não vem com bootstrap por padrão, então vamos instalá-lo.

- Adicione as seguintes linhas no arquivo `Gemfile`:

        gem 'bootstrap-sass', '~> 3.3.6'
        gem 'bootstrap-generators', '~> 3.3.4'

- Execute o Bundler:

        $ bundle

Após isso, o `Bundler` vai baixar todos os arquivos necessários para instalar o `Bootstrap`.

- Agora você precisa dizer para o Rails que você irá utilizar Sass:

        $ mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss
        $ rails generate bootstrap:install --force

- Isso irá fazer com que o Rails use templates do bootstrap, inclusive para as páginas que você irá criar no futuro. O parâmetro `force` é preciso para que seja instalado o menu no estilo bootstrap.

        # Opcional
        $ git clean -fd
        $ git checkout passo-3
        $ bundle   

### 4. Scaffold

- Gerando o cadastro de contatos:

        $ bundle exec rails generate scaffold Contato nome:string telefone:string

Após esse comando você observará que foram criados todos os arquivos que contemplam um CRUD completo no Rails.
Um dos arquivos gerados pelo scaffold é o arquivo de migração, ele diz para o Rails como seu banco deve ficar para suportar o nosso novo CRUD.

- Execute o seguinte comando para rodar as migrações:

        $ bundle exec rake db:migrate

- Pronto, agora você pode verificar como ficou o nosso novo CRUD. Inicie o servidor:

        $ bin/rails server

- No navegador, acesse `localhost:3000/contatos`

        # Opcional
        $ git clean -fd
        $ git checkout passo-4
        $ bundle

### 5. Adicionando o campo endereço em contatos

- Gere o arquivo de Migration:

        $ bundle exec rails generate migration AdicionarEnderecoEmContatos

- Edite a Migration

```ruby    
  def change
    add_column :contatos, :endereco, :string
  end
```

- Execute a Migration:

        $ bundle exec rake db:migrate

Ajuste os seguintes arquivos:

- No arquivo `_form.html` adicione:

```ruby
  <div class="form-group">
    <%= f.label :endereço, class: "col-sm-2 control-label" %>
    <div class="col-sm-10">
      <%= f.text_field :endereco, class: "form-control" %>
    </div>
  </div>
```

- No arquivo `index.html` adicione os campos abaixo:

```ruby
  <th>Endereço</th>
  ...
  <td><%= contato.endereco %></td>
```

- No arquivo `show.html.erb` adicione:

```ruby
  <dt>Endereço:</dt>
  <dd><%= @contato.endereco %></dd>
```

- No arquivo `contatos_controller.rb` altere o método `contato_params` para:

```ruby
  def contato_params
    params.require(:contato).permit(:nome, :telefone, :endereco)
  end
```

- Inicie a aplicação:

        $ bin/rails server

- No navegador, acesse `localhost:3000/contatos`

        # Opcional
        $ git clean -fd
        $ git checkout passo-5
        $ bundle

### 6. A força está com você!

<img src="https://octodex.github.com/images/octobiwan.jpg" width="181">

- A) Adicione um novo campo chamado `Bairro` no cadastro de `contatos`.

- B) Crie o cadastro de cidades

- Gerando o cadastro de cidades:

        $ bundle exec rails generate scaffold Cidade nome:string uf:string
        $ bundle exec rake db:migrate
        $ bin/rails server

- No navegador, acesse `localhost:3000/cidades`

        # Opcional
        $ git clean -fd
        $ git checkout passo-6
        $ bundle

### 7. Adicionando o campo `cidade` em contatos com chave estrangeira

- Gere o campo e a chave estrangeira:

        $ bundle exec rails generate migration AddCidadeRefToContatos cidade:references

- Execute a migração:

        $ bundle exec rake db:migrate

- Ajuste o modelo de `Contato`:

```ruby
  belongs_to :cidade
```

- Ajuste modelo de `Cidade`:

```ruby
  has_many :contatos
```

- Ajuste o `contatos_controller.rb` para:

```ruby
  def contato_params
    params.require(:contato).permit(:nome, :telefone, :endereco, :bairro, :cidade_id)
  end
```

- No arquivo `views/contatos/show.html.erb` adicione:

```ruby
  <% if @contato.cidade.present? %>
    <dt>Cidade:</dt>
    <dd><%= @contato.cidade.nome %></dd>
  <% end %>
```

- No arquivo `views/contatos/_form.html.erb` adicione:

```ruby
  <div class="form-group">
    <%= f.label :cidade, class: "col-sm-2 control-label" %>
    <div class="col-sm-10">
      <%= f.collection_select :cidade_id, Cidade.all, :id, :nome,
        class: "form-control", include_blank: true %>
    </div>
  </div>
```

- Inicie o servidor:

        $ bin/rails server

- No navegador, acesse `localhost:3000/contatos`

        # Opcional
        $ git clean -fd
        $ git checkout passo-7
        $ bundle

### 8. Adicionando uma validação de dados no cadastro de cidades

- No arquivo `app/models/cidade.rb`, adicione:

```ruby
  validates :nome,
    presence: true

  validates :uf,
    presence: true,
    length: { is: 2 }
```

- Inicie o servidor:

        $ bin/rails server

- No navegador, acesse `localhost:3000/cidades`

        # Opcional
        $ git clean -fd
        $ git checkout passo-8
        $ bundle

### 9. Traduzindo o aplicativo

- Descomente a linha abaixo no arquivo `config/application.rb` e ajuste o locale para pt-BR:

```ruby
  config.i18n.default_locale = "pt-BR"
```

- Crie o arquivo config/locales/pt-BR.yml com o conteúdo do link abaixo:

  https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/pt-BR.yml

- Opcional: Traduzir os HTML's

- Inicie o servidor:

        $ bin/rails server

- No navegador, acesse `localhost:3000/cidades`

        # Opcional
        $ git clean -fd
        $ git checkout passo-9
        $ bundle

### 10. Organizando layout

- No arquivo `app/views/layouts/application.html.erb` altere o menu superior:

```ruby
  ...
    <%= link_to "Meus Contatos", root_path, class: "navbar-brand" %>
  </div>
  <div id="navbar" class="collapse navbar-collapse">
    <ul class="nav navbar-nav">
      <li>
        <%= link_to "Cidades", cidades_path %>
      </li>
    </ul>
  </div>
  ...
```

- No arquivo de rotas `config/routes.rb` altere o index da aplicação:

```ruby
  Rails.application.routes.draw do
    root 'contatos#index'
```

        # Opcional
        $ git clean -fd
        $ git checkout passo-10
        $ bundle

### 11. Deploy

* Pré-requisito: Ter uma conta no heroku.

- Acesse o painel de controle do heroku e crie um novo app.

- Selecione o método de deploy "Heroku Git" e então copie o comando na seção
  "Existing Git repository" e execute-o na linha de comando na pasta do seu
  projeto.
  Depois, execute: $ git remote show heroku. Assim, você confere que o repositório
  remoto do heroku foi adicionado no seu projeto.

- Substitua no arquivo Gemfile a linha `gem sqlite3` para `gem 'mysql2', '0.3.18'`

- Ajuste o arquivo `database.yml`

  ```ruby
  default: &default
    adapter: mysql2
    pool: 5
    timeout: 5000
    encoding: utf8
    username: root
    password: root
    host: localhost

  development:
    <<: *default
    database: development.mysql

  test:
    <<: *default
    database: test.mysql

  production:
    <<: *default
    database: production.mysql
  ```

- Agora é só criar o banco de dados em mysql localmente e rodar as migrações

        $ bundle exec rake db:create
        $ bundle exec rake db:migrate
        $ bin/rails server

- Crie um arquivo chamado `Procfile`na raiz do projeto com o seguinte conteúdo:

  ```ruby
    web: bundle exec rails server -p $PORT
  ```

- Antes de enviar o app para o heroku você pode rodar local da seguinte maneira:

        $ heroku local web

- No heroku, adicione o add-on `ClearDB MySQL`

- Configure as credenciais do mysql do heroku no arquivo `database.yml`.
  Esses dados estão na aba `Settings` clicando no botão `Reveal Config Vars`.

- Copie o conteúdo da variável de ambiente `CLEARDB_DATABASE_URL`.

        Exemplo: mysql://bcbb4199cf0fac:c7b67ce5@us-cdbr-iron-east-03.cleardb.net/heroku_11766f89a7c601b?reconnect=true

- Dados extraidos da linha acima que você deve colocar no `database.yml` na seção `production`:

        username: bcbb4199cf0fac
        password: c7b67ce5
        host: us-cdbr-iron-east-03.cleardb.net
        database: heroku_11766f89a7c601b

- Agora precisamos rodar as migrações do banco de dados lá no heroku

        $ heroku run rake db:migrate

- Se tudo aconteceu normalmente no passo anterior, então publique a aplicação no heroku assim:

        $ git push heroku master


## THANKS
<img src="https://octodex.github.com/images/heisencat.png" width="300">
