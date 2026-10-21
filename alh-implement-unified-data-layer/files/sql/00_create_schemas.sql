WHENEVER SQLERROR EXIT SQL.SQLCODE
SET DEFINE ON
SET VERIFY OFF
SET ECHO OFF
SET FEEDBACK ON
SET SERVEROUTPUT ON

DEFINE workshop_user = '&1'
DEFINE workshop_password = '&2'

BEGIN
  FOR u IN (
    SELECT username
    FROM dba_users
    WHERE username IN ('SEER_BRONZE', 'SEER_SILVER', 'SEER_GOLD', UPPER('&workshop_user'))
  ) LOOP
    EXECUTE IMMEDIATE 'DROP USER ' || DBMS_ASSERT.ENQUOTE_NAME(u.username) || ' CASCADE';
  END LOOP;
END;
/

CREATE USER seer_bronze NO AUTHENTICATION;
CREATE USER seer_silver NO AUTHENTICATION;
CREATE USER seer_gold NO AUTHENTICATION;

ALTER USER seer_bronze QUOTA UNLIMITED ON data;
ALTER USER seer_silver QUOTA UNLIMITED ON data;
ALTER USER seer_gold QUOTA UNLIMITED ON data;

CREATE USER &workshop_user IDENTIFIED BY "&workshop_password"
  DEFAULT TABLESPACE data
  TEMPORARY TABLESPACE temp;

ALTER USER &workshop_user QUOTA UNLIMITED ON data;

GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE MINING MODEL TO &workshop_user;
GRANT DWROLE TO &workshop_user;
GRANT DATA_TRANSFORM_USER TO &workshop_user;
GRANT EXECUTE ON DBMS_CLOUD TO &workshop_user;
GRANT EXECUTE ON DBMS_VECTOR TO &workshop_user;
GRANT EXECUTE ON DBMS_VECTOR_CHAIN TO &workshop_user;

BEGIN
  ORDS_ADMIN.ENABLE_SCHEMA(
    p_enabled             => TRUE,
    p_schema              => UPPER('&workshop_user'),
    p_url_mapping_type    => 'BASE_PATH',
    p_url_mapping_pattern => LOWER('&workshop_user'),
    p_auto_rest_auth      => TRUE
  );
END;
/

BEGIN
  DBMS_CLOUD_ADMIN.ENABLE_RESOURCE_PRINCIPAL();
  DBMS_CLOUD_ADMIN.ENABLE_RESOURCE_PRINCIPAL(username => UPPER('&workshop_user'));
END;
/

PROMPT Workshop schemas, Database Actions user, and resource principal are enabled.
EXIT SUCCESS
