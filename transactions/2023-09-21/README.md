## Signing Key Rotation

As of this document, the HybridCustody contract account is currently managed by a single fully-weighted key. The purpose
of this set of transactions is to rotate the account into multi-sig account management.

### Process

To safely execute key rotation, the process will occur as follows at a pre-arranged time agreeable by all key holders:

> Execute first on Testnet with a pre-configured dummy account (`0x3027cc0f80bdf2ff`) to ensure accurate public key and
> resource ID information. Once success is confirmed via dry run transaction execution, rinse and repeat on Mainnet.
> NOTE: All key holders should clone this repo so everyone is working from the same [`flow.json`](../../flow.json)

1. Current custodian (@sisyphusSmiling) sends transaction [`0_add_keys.cdc`](./0_add_keys.cdc) with args found in
   [`add_keys_args.json`](./add_keys_args.json)

    ```sh
    # From project root:
    flow transactions send ./transactions/2023-09-21/0_add_keys.cdc \
        --args-json ./transactions/2023-09-21/add_keys_args.json \
        --signer <ACCOUNT> \
        --network <NETWORK>
    ```

1. Confirm that the transaction succeeds an keys have been added to the account signing account.

    - Testnet Flowview: (0x3027cc0f80bdf2ff)[https://testnet.flowview.app/account/0x3027cc0f80bdf2ff/key]
    - Mainnet Flowview: (0xd8a7e05a7ac670c0)[https://www.flowview.app/account/0xd8a7e05a7ac670c0/key]

1. Attempt dry run with first set of signers

    1. Go to [Flow Multisig Tool Page](https://flow-multisig-git-service-account-onflow.vercel.app/) and select
       appropriate network

    1. Select 'Service Account' tab and `hello.cdc` as the script from the dropdown

    1. Input the appropriate signing account for the network - `0x3027cc0f80bdf2ff` for Testnet and `d8a7e05a7ac670c0`
       for Mainnet

    1. Select the first set of signers from the available keys and click 'Generate Link', of course avoiding the
       fully-weighted key. Note, some may need to sign twice.

    1. Signers can choose to either sign via the OAuth URL or use Flow CLI to sign via remote url, either of which can
       be copied and shared with the signers.

        - The CLI comand will look like:
            ```sh
            flow transactions sign --from-remote-url <REMOTE_URL> --signer <ACCOUNT>
            ```
    
    1. Once all signers have signed, the transaction initiator can send the transaction an validate that it executed
       successfully

1. Assuming success, attempt dry run with final set of signers

1. If all keys have been validated as successfully added, revoke the fully-weighted key at index `0`. For ease, this can
   be executed by current custodian

    ```sh
    # From project root:
    flow transactions send ./transactions/2023-09-21/2_revoke_key.cdc \
        --args-json ./transactions/2023-09-21/revoke_zero_index_key_args.json \
        --signer <ACCOUNT> \
        --network <NETWORK>
    ```

1. If successful, rinse and repeat. Any corrections to key values, either by mistyping or incorrect assumptions about
   hash/signing algos, or resource IDs should be corrected in Testnet, and updated in `flow.json` to ensure smooth
   process when repeated against the mainnet account