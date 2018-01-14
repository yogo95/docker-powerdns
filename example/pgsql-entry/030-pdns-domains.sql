-- Initialize the database with the current domains
-- Help in https://doc.powerdns.com/md/authoritative/howtos/

INSERT INTO pdns.domains (name, type) VALUES ('my-company.eu', 'NATIVE');
INSERT INTO pdns.records (domain_id, name, content, type, ttl, prio)
    VALUES (
        (SELECT id FROM pdns.domains WHERE name = 'my-company.eu'),
        'my-company.eu', 'my-company.eu dns.my-company.eu 100 300 300 3600 300', 'SOA', 300, NULL
    );
-- NS
INSERT INTO pdns.records (domain_id, name, content, type, ttl, prio)
    VALUES (
        (SELECT id FROM pdns.domains WHERE name = 'my-company.eu'),
        'my-company.eu', '192-168-0-10.my-company.eu', 'NS', 300, NULL
    );
INSERT INTO pdns.records (domain_id, name, content, type, ttl, prio)
    VALUES (
        (SELECT id FROM pdns.domains WHERE name = 'my-company.eu'),
        'my-company.eu', '192-168-0-11.my-company.eu', 'NS', 300, NULL
    );
-- MX
INSERT INTO pdns.records (domain_id, name, content, type, ttl, prio)
    VALUES (
        (SELECT id FROM pdns.domains WHERE name = 'my-company.eu'),
        'my-company.eu', 'mx10.my-company.eu', 'MX', 300, 10
    );
-- Ips
INSERT INTO pdns.records (domain_id, name, content, type, ttl, prio)
    VALUES (
        (SELECT id FROM pdns.domains WHERE name = 'my-company.eu'),
        '192-168-0-10.my-company.eu', '192.168.0.10', 'A', 300, NULL
    );
INSERT INTO pdns.records (domain_id, name, content, type, ttl, prio)
    VALUES (
        (SELECT id FROM pdns.domains WHERE name = 'my-company.eu'),
        '192-168-0-11.my-company.eu', '192.168.0.11', 'A', 300, NULL
    );
-- Mails
INSERT INTO pdns.records (domain_id, name, content, type, ttl, prio)
    VALUES (
        (SELECT id FROM pdns.domains WHERE name = 'my-company.eu'),
        'mx10.my-company.eu', '192-168-0-10', 'A', 300, NULL
    );
INSERT INTO pdns.records (domain_id, name, content, type, ttl, prio)
    VALUES (
        (SELECT id FROM pdns.domains WHERE name = 'my-company.eu'),
        'smtp.my-company.eu', '192-168-0-10.my-company.eu', 'CNAME', 300, NULL
    );
INSERT INTO pdns.records (domain_id, name, content, type, ttl, prio)
    VALUES (
        (SELECT id FROM pdns.domains WHERE name = 'my-company.eu'),
        'imap.my-company.eu', '192-168-0-10.my-company.eu', 'CNAME', 300, NULL
    );
-- Virtual servers
INSERT INTO pdns.records (domain_id, name, content, type, ttl, prio)
    VALUES (
        (SELECT id FROM pdns.domains WHERE name = 'my-company.eu'),
        'websrv-010.my-company.eu', '192.168.0.120', 'A', 300, NULL
    );
-- Web Servers
INSERT INTO pdns.records (domain_id, name, content, type, ttl, prio)
    VALUES (
        (SELECT id FROM pdns.domains WHERE name = 'my-company.eu'),
        'www.my-company.eu', 'websrv-010.my-company.eu', 'CNAME', 300, NULL
    );
