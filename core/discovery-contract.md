# Discovery contract

The core accepts an IDEA and a discovery provider. A provider returns an
object with `Project`, `Status`, and `DeliveryAllowed`. The core never knows
how discovery is performed: delivery is allowed only when `Status` is exactly
`READY`.

Providers expose `Invoke-Discovery -Idea <path>`.
