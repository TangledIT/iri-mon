# IRI monitor

IRI Monitor is a command line tool for monitoring IOTA's Initial Reference Implementation (IRI).
It allows you to identify if a node is synced and if your neighbors are active.

## Usage

```bash
./iri-mon

IRI Monitor - Status
----------------------------------------
Version: 1.6.1-RELEASE
Running: true
Synced: true [1028189 / 1028189]

ZeroMQ: enabled
Testnet: no
Debug: no

Tips: 429
Transactons to request: 57
```

```bash
./iri-mon neighbors

IRI Monitor - Neighbors
----------------------------------------
Configured neighbors: 5
Connected neighbors: 5

[udp] - 127.0.0.1:14600
State: active
Transactions: [all: 22018, new: 65, invalid: 0, stale: 12017, random requests: 184, send: 14792]
...
```

```bash
./iri-mon milestones

IRI Monitor - Milestones
----------------------------------------
Start Index: 1027365
Latest Index: 1028189
Latest Solid Subtangle Index: 1028189

Latest Milestone: WBGORFDDLTXBZP9YOACTZLKNPTUEZN9HRQLYRNQPRLYMZGPVCIBOLELOZFUYKUXZNTIGARLGDKHOZ9999
Latest Solid Subtangle Milestone: WBGORFDDLTXBZP9YOACTZLKNPTUEZN9HRQLYRNQPRLYMZGPVCIBOLELOZFUYKUXZNTIGARLGDKHOZ9999
```

```bash
./iri-mon ports

IRI Monitor - Ports
----------------------------------------
HTTP API Port: 14265
TCP Receiver Port: 15600
UDP Receiver Port: 14600
ZeroMQ Port: 5556
```

## Development

### Dependencies
- [Crystal language](https://crystal-lang.org/reference/installation/)

### Installation
1. Clone this repository `git clone git@github.com:TangledIT/iri-mon.git`

2. Run `shards build` to build executable

3. Find executable in `bin/` folder

## Contributing

1. Fork it (<https://github.com/tangledit/iri-mon/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [TangledIT](https://github.com/tangledit) - creator and maintainer
