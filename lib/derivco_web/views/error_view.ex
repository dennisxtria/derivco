defmodule DerivcoWeb.ErrorView do
  @moduledoc false

  use DerivcoWeb, :view

  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
