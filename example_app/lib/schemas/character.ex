defmodule ExampleApp.Character do
    use Ecto.Schema
  
    schema "characters" do
      field :name, :string
      belongs_to :movie, ExampleApp.Movie
    end
  end