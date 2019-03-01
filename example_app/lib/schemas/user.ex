defmodule ExampleApp.User do
    use Ecto.Schema
    import Ecto.Changeset

    schema "users" do
        field(:username, :string)
        field(:password, :string)
        field(:email, :string)
        field(:confirmed, :boolean, default: false)
        #field(:pass, :string, virtual: true)
        #field(:confirmation, :string, virtual: true)
        timestamps()
    end

    @required_fields [:username, :email, :password] # Constantes
    @optional_fields [] # Constantes

    def changeset(user, params \\ :empty) do
        user
        |> cast(params, @required_fields ++ @optional_fields)
        |> validate_required(@required_fields)
        |> unique_constraint(:username)
    end
end