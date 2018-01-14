

-- REVOKE ALL ON DATABASE "pdns" FROM "pdns-read";
-- REVOKE ALL ON SCHEMA "pdns" FROM "pdns-read";
-- REVOKE ALL ON TABLE     
--     pdns.domains,
--     pdns.records,
--     pdns.supermasters,
--     pdns.comments,
--     pdns.domainmetadata,
--     pdns.cryptokeys,
--     pdns.tsigkeys
--   FROM "pdns-read";


-- DROP ROLE IF EXISTS "pdns-read";


CREATE ROLE "pdns-read";
CREATE ROLE "pdns-min-write";

GRANT CONNECT ON DATABASE "pdns" TO "pdns-read";
GRANT USAGE ON SCHEMA "pdns" TO "pdns-read";
GRANT SELECT ON TABLE 
    pdns.domains,
    pdns.records,
    pdns.supermasters,
    pdns.comments,
    pdns.domainmetadata,
    pdns.cryptokeys,
    pdns.tsigkeys
  TO "pdns-read";

GRANT UPDATE (ordername, auth)
  ON TABLE pdns.records TO "pdns-min-write";
GRANT UPDATE (last_check, notified_serial)
  ON TABLE pdns.domains TO "pdns-min-write";

