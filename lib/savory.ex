defmodule Savory do
  alias Savory.SavoryNif, as: Nif
  alias Savory.Server, as: Server
  alias Savory.Config, as: C

  #public key authenticated encryption
  def crypto_box_keypair(), do: Server.make_box_keypair()

  def crypto_box(plain_text, nonce, pk, sk) do
    Nif.salt_box([crypto_box_zerobytes() | plain_text], nonce, pk, sk)
  end

  def crypto_box_open(cipher_text, nonce, pk, sk) do
    Nif.salt_box_open([crypto_secretbox_boxzerobytes() | cipher_text], nonce, pk, sk)
  end

  def crypto_box_beforenm(pk, sk), do: Nif.salt_box_beforenm(pk, sk)

  def crypto_box_afternm(pt, nonce, ctx) do
    Nif.salt_box_afternm([crypto_box_zerobytes() | pt], nonce, ctx)
  end

  def crypto_box_open_afternm(cipher_text, nonce, context) do
    Nif.salt_box_open_afternm([crypto_box_boxzerobytes() | cipher_text], nonce, context)
  end

  #scalar multiplication
  def crypto_scalarmult(integer, group_p), do: Nif.salt_scalarmul(integer, group_p)
  def crypto_scalarmult_base(integer), do: Nif.salt_scalarmult(integer)

  #signitures
  def crypto_sign_keypair(), do: Server.make_sign_keypair()
  def crypto_sign(message, sk), do: Nif.salt_sign(message, sk)
  def crypto_sign_open(signed_msg, pk), do: Nif.salt_sign_open(signed_msg, pk)
  def crypto_sign_detached(msg, sk), do: Nif.salt_sign_detached(msg, sk)
  def crypto_sign_verify_detached(sig, msg, pk), do: Nif.salt_sign_verify_detached(sig, msg, pk)

  @doc """
  Converts an Ed25519 public key `pk` to a Curve25519 public key.
  """
  def crypto_sign_ed25519_pk_to_curve25519(pk), do: Nif.salt_sign_ed25519_pk_to_curve25519(pk)

  @doc """
  Converts an Ed25519 secret key `pk` to a Curve25519 secret key.
  """
  def crypto_sign_ed25519_sk_to_curve25519(sk), do: Nif.salt_sign_ed25519_sk_to_curve25519(sk)

  ###Secret-key
  #Authenticated encrpytion
  def crypto_secretbox(plain_text, nonce, sk) do
    Nif.salt_secretbox([crypto_secretbox_zerobytes() | plain_text], nonce, sk)
  end

  def crypto_secretbox_open(cipher_text, nonce, sk) do
    Nif.salt_secretbox_open([crypto_secretbox_boxzerobytes() | cipher_text], nonce, sk)
  end

  #Encryption
  def crypto_stream(byte_cnt, nonce, sk), do: Nif.salt_stream(byte_cnt, nonce, sk);
  def crypto_stream_xor(plain_text, nonce, sk), do: Nif.salt_stream_xor(plain_text, nonce, sk)

  #message authentication
  def crypto_auth(message, sk), do: Nif.salt_auth(message, sk)
  def crypto_auth_verify(authenticator, message, sk), do: Nif.salt_auth_verify(authenticator, message, sk)

  #single message authentication
  def crypto_onetimeauth(message, sk), do: Nif.salt_onetimeauth(message, sk)
  def crypto_onetimeauth_verify(authenticator, message, sk) do
    Nif.salt_onetimeauth_verify(authenticator, message, sk)
  end

  #low level functions
  def crypto_hash(message), do: Nif.salt_hash(message)

  #string compare
  def crypto_verify_16(bin_x, bin_y), do: Nif.salt_verify_16(bin_x, bin_y)
  def crypto_verify_32(bin_x, bin_y), do: Nif.salt_verify_32(bin_x, bin_y)

  #random
  def crypto_random_bytes(n), do: Server.make_random_bytes(n)

  #zero bytes

  defp crypto_secretbox_zerobytes(), do: zero_bytes(C.crypto_secretbox_zerobytes())
  defp crypto_secretbox_boxzerobytes(), do: zero_bytes(C.crypto_secretbox_boxzerobytes())
  defp crypto_box_zerobytes(), do: zero_bytes(C.crypto_box_zerobytes())
  defp crypto_box_boxzerobytes(), do: zero_bytes(C.crypto_box_boxzerobytes())

  #helpers
  defp zero_bytes(len) do
    len = len * 8
    << 0 :: size(len)>>
  end

end
