defmodule SFTPClient.Operations.WriteFileChunk do
  @moduledoc """
  A module that provides functions to write chunks of data to a file on an SFTP
  server.
  """

  import SFTPClient.OperationUtil

  alias SFTPClient.Handle

  @doc """
  Writes data to the file referenced by handle. The file is to be opened with
  write or append flag.
  """
  @spec write_file_chunk(Handle.t(), binary) ::
          :ok | {:error, SFTPClient.error()}
  def write_file_chunk(%Handle{} = handle, data) do
    case sftp_adapter().write(
           handle.conn.channel_pid,
           handle.id,
           data,
           handle.conn.config.operation_timeout
         ) do
      {:error, error} -> {:error, handle_error(error)}
      result -> result
    end
  end

  @doc """
  Writes data to the file referenced by handle. The file is to be opened with
  write or append flag. Raises when the operation fails.
  """
  @spec write_file_chunk!(Handle.t(), binary) :: :ok | no_return
  def write_file_chunk!(%Handle{} = handle, data) do
    handle |> write_file_chunk(data) |> may_bang!()
  end
end
