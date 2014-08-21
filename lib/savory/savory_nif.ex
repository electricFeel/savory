defmodule Savory.SavoryNif do
  def load do
    nif_path = :filename.join([:code.priv_dir(:savory), :erlang.system_info(:system_architecture), "salt_nif"])
    :erlang.load_nif(nif_path, 0)
  end

  def start do
    :erlang.error(:salt_not_loaded)
  end

  def salt_box_keypair(_, _, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_box(_, _, _, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_box_open(_, _, _, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_box_beforenm(_, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_box_afternm(_, _, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_box_open_afternm(_, _, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_scalarmult(_, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_scalarmult_base(_) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_sign_keypair(_, _, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_sign(_, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_sign_open(_, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_secretbox(_, _, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_secretbox_open(_, _, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_stream(_, _, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_stream_xor(_, _, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_auth(_, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_auth_verify(_, _, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_onetimeauth(_, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_onetimeauth_verify(_, _, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_hash(_) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_verify_16(_, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_verify_32(_, _) do
    :erlang.error(:salt_not_loaded)
  end

  def salt_random_bytes(_, _, _, _) do
    :erlang.error(:salt_not_loaded)
  end
end