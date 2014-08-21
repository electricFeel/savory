Savory
======

A pure Elixir/Nif port of [Freza's Erlang Salt]( https://github.com/freza/salt/) application.  

Salt is an Erlang wrapper for the libsodium library which, in turn, is an interface to the NaCl cryptographic primitives library. NaCl (which is also pronounced salt) is covered in detail here: 

###Motivation
While the Erlang standard library does have a crpyto package, there are numerous reasons you'd want to use a well-vetted, widely used low-level encryption package. More importantly, NaCl (and libsodium by extension) addresses a number of failings in other cryptographic libraries. That topic is covered in some detail in  [The security impact
of a new cryptographic library](http://cr.yp.to/highspeed/coolnacl-20120725.pdf).  

Libsodium itself has bindings in a number of different languages almost 2 dozen languages with more or less the same API being exposed. 

##Examples
###Public key:
	{a_pk, a_sk} = Savory.crypto_box_keypair()
    nc = Savory.crypto_random_bytes(24)
    pt = "Hello bob, message from Alice"
    ct = Savory.crypto_box(pt, nc, a_pk, a_sk)
    {:ok, d_pt} = Savory.crypto_box_open(ct, nc, a_pk, a_sk)

###Secret Key:
	sk = Savory.crypto_random_bytes(32)
    nc = Savory.crypto_random_bytes(24)
    pt = <<"Secret Message">>
    ct = Savory.crypto_secretbox(pt, nc, sk)
    assert {:ok, pt} == Savory.crypto_secretbox_open(ct, nc, sk)


##Dependencies

Libsodium needs to be installed:

	git clone https://github.com/jedisct1/libsodium.git
	cd libsodium
	./autogen.sh
	./configure && make check
	sudo make install

##TODO:
  - Improve documentation
    - Add more use cases
    - Write module docs 
  - Bench mark the use of gen_server and the corresponding nif support (it may be unnecessary). Any changes shouldn't affect the API