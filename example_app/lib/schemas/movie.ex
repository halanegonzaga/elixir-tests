defmodule ExampleApp.Movie do
    use Ecto.Schema
  
    schema "movies" do
      field :title, :string
      field :tagline, :string
      has_many :characters, ExampleApp.Character
    end
  end