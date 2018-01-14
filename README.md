# Docker - PowerDNS

## Introduction

I needed to create a simple a light image to container the powerdns software.

## Configuration

You can find the default postgresql configuration in the `conf` directory.

## Example

You can find a simple example for `my-company.eu`.
The example use postgresql as backend.

Use `docker-compose up --build` to start it.

And to check
```bash
dig imap.my-company.eu @127.0.0.1
````

