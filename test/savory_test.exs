defmodule SavoryTest do
  use ExUnit.Case

  test " stream" do
    sk = Savory.crypto_random_bytes(32)
    nc = Savory.crypto_random_bytes(24)
    pt = <<"Secret Message">>
    ct = Savory.crypto_stream_xor(pt, nc, sk)
    assert pt == Savory.crypto_stream_xor(ct, nc, sk)
  end

  test "sign" do
    {pk, sk} = Savory.crypto_sign_keypair()
    pm = <<"Plain text to be signed">>
    sm = Savory.crypto_sign(pm, sk)
    assert {:ok, pm} == Savory.crypto_sign_open(sm, pk)
  end

  test " secret box" do
    sk = Savory.crypto_random_bytes(32)
    nc = Savory.crypto_random_bytes(24)
    pt = <<"Secret Message">>
    ct = Savory.crypto_secretbox(pt, nc, sk)
    assert {:ok, pt} == Savory.crypto_secretbox_open(ct, nc, sk)
  end

  test " auth" do
    sk = Savory.crypto_random_bytes(32)
    pt = <<"Authentic message">>
    au = Savory.crypto_auth(pt, sk)
    assert :authenticated == Savory.crypto_auth_verify(au, pt, sk)
  end

  test "one time auth" do
    sk = Savory.crypto_random_bytes(32)
    pt = <<"Authentic message">>
    au = Savory.crypto_onetimeauth(pt, sk)
    assert :authenticated == Savory.crypto_onetimeauth_verify(au, pt, sk)
  end

end
