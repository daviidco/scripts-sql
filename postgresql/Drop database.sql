-- DELETE ALL DATABASE
  
DO $$ 
DECLARE 
    r RECORD;
BEGIN
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = current_schema()) 
    LOOP
        EXECUTE 'DROP TABLE IF EXISTS ' || r.tablename || ' CASCADE';
    END LOOP;
END $$;


DO $$ 
DECLARE 
    typename text;
BEGIN
    
    -- Drop types
    FOR typename IN (SELECT typname FROM pg_type WHERE typnamespace = (SELECT oid FROM pg_namespace WHERE nspname = current_schema())) 
    LOOP
        BEGIN
            EXECUTE 'DROP TYPE IF EXISTS ' || typename || ' CASCADE';
        EXCEPTION
            WHEN OTHERS THEN
                RAISE NOTICE 'Error dropping type %: %', typename, SQLERRM;
        END;
       RAISE NOTICE 'Dropped type: %', typename;
    END LOOP;

END $$;
  
  
DO $$ 
DECLARE 
    typename text;
begin
    -- Drop types dynamically
    FOR typename IN (SELECT typname FROM pg_type WHERE typnamespace = (SELECT oid FROM pg_namespace WHERE nspname = current_schema())) 
    LOOP
        BEGIN
            EXECUTE 'DROP TYPE IF EXISTS ' || typename || ' CASCADE';
        EXCEPTION
            WHEN OTHERS THEN
                RAISE NOTICE 'Error dropping type %: %', typename, SQLERRM;
        END;
        RAISE NOTICE 'Dropped type: %', typename;
    END LOOP;

END $$;



DO $$ 
DECLARE 
    seqname text;
BEGIN
    FOR seqname IN (SELECT relname FROM pg_class WHERE relkind = 'S' AND relnamespace = (SELECT oid FROM pg_namespace WHERE nspname = current_schema())) 
    LOOP
        BEGIN
            EXECUTE 'DROP SEQUENCE IF EXISTS ' || seqname;
        EXCEPTION
            WHEN OTHERS THEN
                -- Maneja el error aquí, por ejemplo, puedes imprimir un mensaje
                RAISE NOTICE 'Error dropping sequence %: %', seqname, SQLERRM;
        END;
    END LOOP;
END $$;
