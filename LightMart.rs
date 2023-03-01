OP_IF
    # Buyer deposits funds into the Lightning Network channel
    <buyer_pubkey> OP_CHECKSIGVERIFY
    <seller_pubkey> OP_CHECKSIGVERIFY
    <multi-sig> OP_CHECKSIGVERIFY
    OP_HASH160 <channel_id> OP_EQUALVERIFY

    # Seller deposits funds into the Lightning Network channel
    <seller_pubkey> OP_CHECKSIGVERIFY
    <buyer_pubkey> OP_CHECKSIGVERIFY
    <multi-sig> OP_CHECKSIGVERIFY
    OP_HASH160 <channel_id> OP_EQUALVERIFY

    # Buyer places order and locks funds in multisig
    OP_DUP OP_HASH160 <buyer_pubkey_hash> OP_EQUALVERIFY
    OP_CHECKSIGVERIFY
    OP_2 <buyer_pubkey> <seller_pubkey> OP_2 OP_CHECKMULTISIGVERIFY
    <order_details>
    OP_CHECKSIGVERIFY

    # Seller accepts order and releases funds
    OP_DUP OP_HASH160 <seller_pubkey_hash> OP_EQUALVERIFY
    OP_CHECKSIGVERIFY
    OP_2 <buyer_pubkey> <seller_pubkey> OP_2 OP_CHECKMULTISIGVERIFY
    OP_VERIFY
    <order_details>
    OP_CHECKSIGVERIFY
OP_ENDIF
