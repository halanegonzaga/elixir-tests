defmodule ExampleApp do
  
  alias ExampleApp.{User, Repo}

  def insertUser(name, mail, pass) do
    user = %{username: name, email: mail, password: pass}
    changeset = User.changeset(%User{}, user)

    case Repo.insert(changeset) do
      {:ok, record} -> record
      {:error, changeset} -> changeset
    end
  end

end
