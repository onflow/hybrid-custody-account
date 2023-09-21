/// Add all provided keys to the signing account at 250.0 weight each for 4/n multisig
///
transaction(publicKeys: [String]) {
	prepare(signer: AuthAccount) {
		for key in publicKeys {
			let newKey = PublicKey(
				publicKey: key.decodeHex(),
				signatureAlgorithm: SignatureAlgorithm.ECDSA_P256
			)

			signer.keys.add(
				publicKey: newKey,
				hashAlgorithm: HashAlgorithm.SHA2_256,
				weight: 250.0
			)
		}
	}
}