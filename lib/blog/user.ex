defmodule Blog.User do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias Blog.{Repo, User}

  @type t :: %__MODULE__{
          id: integer() | nil,
          username: String.t() | nil,
          email: String.t() | nil,
          inserted_at: NaiveDateTime.t() | nil,
          updated_at: NaiveDateTime.t() | nil
        }

  schema "users" do
    field(:username, :string)
    field(:password, :string)
    field(:email, :string)

    timestamps(type: :utc_datetime)
  end

  @doc false
  @spec changeset(t(), map()) :: Ecto.Changeset.t()
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :email])
    |> validate_required([:username, :password, :email])
  end

  @spec create_user(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_user(user_attrs) do
    %User{}
    |> User.changeset(user_attrs)
    |> Repo.insert()
  end

  @spec login(String.t(), String.t()) :: boolean()
  def login(username, password) do
    User
    |> where([u], u.username == ^username and u.password == ^password)
    |> Repo.exists?()
  end
end
