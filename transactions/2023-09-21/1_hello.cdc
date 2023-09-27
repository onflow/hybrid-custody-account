/// Dry run transaction
///
transaction {
    prepare(signer: AuthAccount) {
        log("Hello, World!")
    }
}
