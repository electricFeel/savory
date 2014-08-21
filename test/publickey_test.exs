defmodule PublicKeyTest do
  use ExUnit.Case

  setup_all do
  	:ok
  end

  test "opening box ourselves" do
    {a_pk, a_sk} = Savory.crypto_box_keypair()
    nc = Savory.crypto_random_bytes(24)
    pt = "Hello bob, message from Alice"
    ct = Savory.crypto_box(pt, nc, a_pk, a_sk)
    {:ok, d_pt} = Savory.crypto_box_open(ct, nc, a_pk, a_sk)
    assert pt == d_pt
    :ok
  end

  test "opening box by someone else" do
    {a_pk, a_sk} = Savory.crypto_box_keypair()
    {b_pk, b_sk} = Savory.crypto_box_keypair()
    nc = Savory.crypto_random_bytes(24)
    pt = "Hello bob, message from Alice"
    ct = Savory.crypto_box(pt, nc, b_pk, a_sk)
    {:ok, d_pt} = Savory.crypto_box_open(ct, nc, a_pk, b_sk)
    assert pt == d_pt
  end

  test "opening box in two steps" do
  	#apparently this is faster than the easier function above
  	{a_pk, a_sk} = Savory.crypto_box_keypair()
    {b_pk, b_sk} = Savory.crypto_box_keypair()
    nc = Savory.crypto_random_bytes(24)
    pt = "Hello bob, message from Alice"
  	
  	ac = Savory.crypto_box_beforenm(b_pk, a_sk)
  	bc = Savory.crypto_box_beforenm(a_pk, b_sk)
    ct = Savory.crypto_box_afternm(pt, nc, ac)

    assert {:ok, pt} == Savory.crypto_box_open_afternm(ct, nc, bc)
  end
end
