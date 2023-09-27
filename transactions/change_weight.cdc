transaction(second: String) {
    prepare(signer: AuthAccount) {
        let currentKey = signer.keys.get(keyIndex: 0)!.publicKey
        signer.keys.revoke(keyIndex: 0)
        signer.keys.add(publicKey: currentKey, hashAlgorithm: HashAlgorithm.SHA3_256, weight: 500.0)

        let newKey = PublicKey(
            publicKey: second.decodeHex(),
            signatureAlgorithm: SignatureAlgorithm.ECDSA_P256
        )

        signer.keys.add(
            publicKey: newKey,
            hashAlgorithm: HashAlgorithm.SHA3_256,
            weight: 500.0
        )
    }
}