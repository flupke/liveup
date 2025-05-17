defmodule LiveupWeb.Plugs.SetLocale do
  import Plug.Conn
  @behaviour Plug

  @cldr_backend LiveupWeb.Cldr

  def init(opts), do: opts

  def call(conn, _opts) do
    default_locale_name = Cldr.default_locale(@cldr_backend)

    candidate_locale_name =
      conn
      |> get_req_header("accept-language")
      |> List.first()
      |> parse_primary_locale_tag()

    final_locale_name =
      if candidate_locale_name do
        case Cldr.validate_locale(candidate_locale_name, @cldr_backend) do
          {:ok, validated_name} -> validated_name
          {:error, _} -> default_locale_name
        end
      else
        default_locale_name
      end

    Cldr.put_locale(@cldr_backend, final_locale_name)
    conn
  end

  defp parse_primary_locale_tag(nil), do: nil

  defp parse_primary_locale_tag(header_value) do
    header_value
    |> String.split(",", trim: true)
    |> List.first()
    |> then(fn val ->
      if val do
        val
        |> String.split(~r"[-;]", parts: 2)
        |> List.first()
        |> String.downcase()
      else
        nil
      end
    end)
  end
end
