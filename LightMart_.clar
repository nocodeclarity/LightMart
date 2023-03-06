;; LightMart
;; Cultivated by NoCodeClarity, Inc.
;; Dedicated to a Decentralized Future 

(define-script lightning-network-channel
  (verify-true (if (get-block-height) false true)) ; OP_IF
  (verify
    (multi-sig
      (list
        (require-check-sig (var-buyer-pubkey))
        (require-check-sig (var-seller-pubkey))
        (require-check-sig (var-multi-sig))
        (require-hash160 (var-channel-id))))
    (list
      (require-check-sig (var-seller-pubkey))
      (require-check-sig (var-buyer-pubkey))
      (require-check-sig (var-multi-sig))
      (require-hash160 (var-channel-id))))
  (verify
    (let ((order-lock-script
           (list
             (require-op-dup)
             (require-hash160 (hash160 (var-buyer-pubkey)))
             (require-check-sig)
             (list
               (int-to-byte-sequence 2)
               (require-check-sig (var-buyer-pubkey))
               (require-check-sig (var-seller-pubkey))
               (int-to-byte-sequence 2)
               (require-check-multisig))
             (var-order-details)
             (require-check-sig))))
      (order-release-script
        (list
          (require-op-dup)
          (require-hash160 (hash160 (var-seller-pubkey)))
          (require-check-sig)
          (list
            (int-to-byte-sequence 2)
            (require-check-sig (var-buyer-pubkey))
            (require-check-sig (var-seller-pubkey))
            (int-to-byte-sequence 2)
            (require-check-multisig)
            (require-op-verify))
          (var-order-details)
          (require-check-sig))))
      (list
        order-lock-script
        order-release-script))))
  (verify-true (if (get-block-height) true false)) ; OP_ENDIF
)
