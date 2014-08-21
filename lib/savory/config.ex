defmodule Savory.Config do
  
  def crypto_box_publickeybytes, do: 32
  def crypto_box_secretkeybytes, do: 32
  def crypto_box_beforenmbytes, do: 32
  def crypto_box_noncebytes, do: 24
  def crypto_box_zerobytes, do: 32
  def crypto_box_boxzerobytes, do: 16
  def crypto_box_primitive, do: :curve25519xsalsa20poly1305

  def crypto_scalarmult_bytes, do: 32
  def crypto_scalarmult_scalarbytes, do: 32

  def crypto_sign_bytes, do: 64
  def crypto_sign_publickeybytes, do: 32
  def crypto_sign_secretkeybytes, do: 64
  def crypto_sign_primitive, do: :ed25519

  def crypto_secretbox_keybytes, do: 32
  def crypto_secretbox_noncebytes, do: 24
  def crypto_secretbox_zerobytes, do: 32
  def crypto_secretbox_boxzerobytes, do: 16
  def crypto_secretbox_primitive, do: :xsalsa20poly1305

  def crypto_stream_keybytes, do: 32
  def crypto_stream_noncebytes, do: 24
  def crypto_stream_primitive, do: :xsalsa20

  def crypto_auth_bytes, do: 32
  def crypto_auth_keybytes, do: 32
  def crypto_auth_primitive, do: :hmacsha512256

  def crypto_onetimeauth_bytes, do: 16
  def crypto_onetimeauth_keybytes, do: 32
  def crypto_onetimeauth_primitive, do: :poly1305

  def crpyto_hash_bytes, do: 64
  def crypto_hash_primitive, do: :sha512

end