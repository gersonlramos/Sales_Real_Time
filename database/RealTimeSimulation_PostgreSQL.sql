DO $$
DECLARE
    v_id INTEGER := 0;
    v_data TIMESTAMP;
    v_produto INTEGER := 0;
    v_vendedor INTEGER := 0;
    v_tipo_pgto INTEGER := 0;
    v_quantidade INTEGER := 0;
    v_valor NUMERIC(10,2);
    v_i INTEGER := 1;
BEGIN
    FOR v_i IN 1..10 LOOP
        v_id := ABS(floor(random() * 999999)::integer);
        v_data := CURRENT_TIMESTAMP;
        v_produto := floor(random() * 9 + 1)::integer;
        v_vendedor := floor(random() * 9 + 1)::integer;
        v_tipo_pgto := floor(random() * 3 + 1)::integer;
        v_quantidade := floor(random() * 6 + 1)::integer;
        
        -- Get the valor_unit from produtos and calculate total valor
        SELECT (p.valor_unit * v_quantidade) INTO v_valor
        FROM produtos p 
        WHERE p.id = v_produto;
        
        INSERT INTO vendas (id, data, produto, vendedor, tipo_pgto, quantidade, valor)
        VALUES (v_id, v_data, v_produto, v_vendedor, v_tipo_pgto, v_quantidade, v_valor);
        
        COMMIT;
        
        RAISE NOTICE 'Inserted row %: ID=%, Valor=%', v_i, v_id, v_valor;
        
        PERFORM pg_sleep(5);
    END LOOP;
END $$;