/// Revokes the key at the given index
///
transaction(keyIndex: Int) {
    prepare(signer: AuthAccount) {
        signer.keys.revoke(keyIndex: keyIndex)
    }
}