defmodule JaResource.Create do
  use Behaviour
  import Plug.Conn
  import Phoenix.Controller, only: [controller_module: 1]

  @moduledoc """
  Provides default `create/2` action implementation, `handle_create/2` callback.

  This behaviour is used by JaResource unless excluded by via only/except option.

  It relies on (and uses):

    * JaResource.Model
    * JaResource.Attributes

  When used JaResource.Create defines the `create/2` action suitable for
  handling json-api requests.

  To customize the behaviour of the create action the following callbacks can
  be implemented:

    * handle_create/2
    * JaResource.Attributes.permitted_attributes/3

  """

  @doc """
  Returns an unpersisted changeset or persisted model of the newly created object.

  Default implementation returns the results of calling
  `Model.changeset(%Model{}, attrs)` where Model is the model defined by the
  `JaResource.Model.model/0` callback.

  The attributes argument is the result of the `permitted_attributes` function.

  `handle_create/2` can return an %Ecto.Changeset, an Ecto.Schema struct,
  a list of errors (`{:error, [email: "is not valid"]}` or a conn with
  any response/body.


  Example custom implementation:

      def handle_create(_conn, attributes) do
        Post.changeset(%Post{}, attributes, :create_and_publish)
      end

  """
  @callback handle_create(Plug.Conn.t, JaResource.attributes) :: Plug.Conn.t | Ecto.Changeset.t | JaResource.record | {:ok, JaResource.record} | {:error, JaResource.validation_errors}

  defmacro __using__(_) do
    quote do
      @behaviour JaResource.Create
      use JaResource.Attributes

      def handle_create(_conn, attributes) do
        __MODULE__.model.changeset(__MODULE__.model.__struct__, attributes)
      end

      defoverridable [handle_create: 2]
    end
  end

  def call(conn) do
    controller = controller_module(conn)
    merged = JaResource.Attributes.from_params(conn.params)
    attributes = controller.permitted_attributes(conn, merged, :create)
    conn
    |> controller.handle_create(attributes)
    |> JaResource.Create.insert(controller)
    |> JaResource.Create.respond(conn)
  end

  @doc false
  def insert(%Ecto.Changeset{} = changeset, controller) do
    controller.repo.insert(changeset)
  end
  if Code.ensure_loaded?(Ecto.Multi) do
    def insert(%Ecto.Multi{} = multi, controller) do
      controller.repo.transaction(multi)
    end
  end
  def insert(other, _controller), do: other

  @doc false
  def respond(%Plug.Conn{} = conn, _old_conn), do: conn
  def respond({:error, errors}, conn), do: invalid(conn, errors)
  def respond({:ok, model}, conn), do: created(conn, model)
  def respond(model, conn), do: created(conn, model)

  defp created(conn, model) do
    conn
    |> put_status(:created)
    |> Phoenix.Controller.render(:show, data: model)
  end

  defp invalid(conn, errors) do
    conn
    |> put_status(:unprocessable_entity)
    |> Phoenix.Controller.render(:errors, data: errors)
  end
end
