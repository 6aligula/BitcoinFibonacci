-- Función 1: Sin parámetros
CREATE OR REPLACE FUNCTION mostra_privilegis()
RETURNS TABLE(role_name text, schema_name text, table_name text, privilege_type text) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    grantee AS role_name, 
    table_schema AS schema_name, 
    table_name, 
    privilege_type
  FROM information_schema.role_table_grants
  WHERE grantee NOT IN ('postgres', 'PUBLIC')
    AND table_schema NOT LIKE 'pg_%';
END;
$$ LANGUAGE plpgsql;

-- Función 2: Con esquema y rol administrativo como parámetros
CREATE OR REPLACE FUNCTION mostra_privilegis(schema_name text, role_name text)
RETURNS TABLE(role_name text, schema_name text, table_name text, privilege_type text) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    grantee, 
    table_schema, 
    table_name, 
    privilege_type
  FROM information_schema.role_table_grants
  WHERE table_schema = schema_name
    AND grantee = role_name;
END;
$$ LANGUAGE plpgsql;

-- Función 3: Con esquema, rol administrativo y tabla como parámetros
CREATE OR REPLACE FUNCTION mostra_privilegis(schema_name text, role_name text, table_name text)
RETURNS TABLE(role_name text, schema_name text, table_name text, privilege_type text) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    grantee, 
    table_schema, 
    table_name, 
    privilege_type
  FROM information_schema.role_table_grants
  WHERE table_schema = schema_name
    AND grantee = COALESCE(NULLIF(role_name, ''), current_role)
    AND table_name = table_name;
END;
$$ LANGUAGE plpgsql;




buena:
-- Función 1: Sin parámetros
CREATE OR REPLACE FUNCTION mostra_privilegis()
RETURNS TABLE(role_name text, schema_name text, table_name text, privilege_type text) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    r.grantee::text AS role_name, 
    r.table_schema::text AS schema_name, 
    r.table_name::text AS table_name, 
    r.privilege_type::text AS privilege_type
  FROM information_schema.role_table_grants r
  WHERE r.grantee NOT IN ('postgres', 'PUBLIC')
    AND r.table_schema NOT LIKE 'pg_%';
END;
$$ LANGUAGE plpgsql;

SELECT * FROM mostra_privilegis();
SELECT * FROM mostra_privilegis('tu_esquema', 'tu_rol_administrativo');
SELECT * FROM mostra_privilegis('tu_esquema', 'tu_rol_administrativo', 'tu_tabla');
