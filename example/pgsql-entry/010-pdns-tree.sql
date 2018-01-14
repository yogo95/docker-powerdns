--
-- ---------------------------------
--

-- DROP SCHEMA "pdns";
CREATE SCHEMA "pdns";

--
-- ---------------------------------
--

CREATE TABLE pdns.domains (
  id                    SERIAL PRIMARY KEY,
  name                  VARCHAR(255) NOT NULL,
  master                VARCHAR(128) DEFAULT NULL,
  last_check            INT DEFAULT NULL,
  type                  VARCHAR(6) NOT NULL,
  notified_serial       INT DEFAULT NULL,
  account               VARCHAR(40) DEFAULT NULL,
  CONSTRAINT c_lowercase_name CHECK (((name)::TEXT = LOWER((name)::TEXT)))
);

CREATE UNIQUE INDEX name_index ON pdns.domains(name);


CREATE TABLE pdns.records (
  id                    BIGSERIAL PRIMARY KEY,
  domain_id             INT DEFAULT NULL,
  name                  VARCHAR(255) DEFAULT NULL,
  type                  VARCHAR(10) DEFAULT NULL,
  content               VARCHAR(65535) DEFAULT NULL,
  ttl                   INT DEFAULT NULL,
  prio                  INT DEFAULT NULL,
  change_date           INT DEFAULT NULL,
  disabled              BOOL DEFAULT 'f',
  ordername             VARCHAR(255),
  auth                  BOOL DEFAULT 't',
  CONSTRAINT domain_exists
  FOREIGN KEY(domain_id) REFERENCES pdns.domains(id)
  ON DELETE CASCADE,
  CONSTRAINT c_lowercase_name CHECK (((name)::TEXT = LOWER((name)::TEXT)))
);

CREATE INDEX rec_name_index ON pdns.records(name);
CREATE INDEX nametype_index ON pdns.records(name,type);
CREATE INDEX domain_id ON pdns.records(domain_id);
CREATE INDEX recordorder ON pdns.records (domain_id, ordername text_pattern_ops);


CREATE TABLE pdns.supermasters (
  ip                    INET NOT NULL,
  nameserver            VARCHAR(255) NOT NULL,
  account               VARCHAR(40) NOT NULL,
  PRIMARY KEY(ip, nameserver)
);


CREATE TABLE pdns.comments (
  id                    SERIAL PRIMARY KEY,
  domain_id             INT NOT NULL,
  name                  VARCHAR(255) NOT NULL,
  type                  VARCHAR(10) NOT NULL,
  modified_at           INT NOT NULL,
  account               VARCHAR(40) DEFAULT NULL,
  comment               VARCHAR(65535) NOT NULL,
  CONSTRAINT domain_exists
  FOREIGN KEY(domain_id) REFERENCES pdns.domains(id)
  ON DELETE CASCADE,
  CONSTRAINT c_lowercase_name CHECK (((name)::TEXT = LOWER((name)::TEXT)))
);

CREATE INDEX comments_domain_id_idx ON pdns.comments (domain_id);
CREATE INDEX comments_name_type_idx ON pdns.comments (name, type);
CREATE INDEX comments_order_idx ON pdns.comments (domain_id, modified_at);


CREATE TABLE pdns.domainmetadata (
  id                    SERIAL PRIMARY KEY,
  domain_id             INT REFERENCES pdns.domains(id) ON DELETE CASCADE,
  kind                  VARCHAR(32),
  content               TEXT
);

CREATE INDEX domainidmetaindex ON pdns.domainmetadata(domain_id);


CREATE TABLE pdns.cryptokeys (
  id                    SERIAL PRIMARY KEY,
  domain_id             INT REFERENCES pdns.domains(id) ON DELETE CASCADE,
  flags                 INT NOT NULL,
  active                BOOL,
  content               TEXT
);

CREATE INDEX domainidindex ON pdns.cryptokeys(domain_id);


CREATE TABLE pdns.tsigkeys (
  id                    SERIAL PRIMARY KEY,
  name                  VARCHAR(255),
  algorithm             VARCHAR(50),
  secret                VARCHAR(255),
  CONSTRAINT c_lowercase_name CHECK (((name)::TEXT = LOWER((name)::TEXT)))
);

CREATE UNIQUE INDEX namealgoindex ON pdns.tsigkeys(name, algorithm);
