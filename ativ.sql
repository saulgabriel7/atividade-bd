/*1 Funções de String:*/

CREATE TABLE nomes (
    nome VARCHAR(50)
);
INSERT INTO nomes (nome) VALUES
    ('Roberta'),
    ('Roberto'),
    ('Maria Clara'),
    ('João');

SELECT UPPER(nome) FROM nomes;

SELECT LENGTH(nome) FROM nomes;

SELECT
    CASE
        WHEN nome LIKE '%a' THEN CONCAT('Sra. ', nome)
        ELSE CONCAT('Sr. ', nome)
    END AS nome_com_tratamento
FROM nomes;

/*2. Funções Numéricas:*/

CREATE TABLE produtos (
    produto VARCHAR(50),
    preco DECIMAL(10, 2),
    quantidade INT
);

INSERT INTO produtos (produto, preco, quantidade) VALUES
    ('Produto A', 10.50, 5),
    ('Produto B', 20.75, 0),
    ('Produto C', 15.25, 10);

SELECT produto, ROUND(preco, 2) AS preco_arredondado FROM produtos;

SELECT produto, ABS(quantidade) AS quantidade_absoluta FROM produtos;

SELECT AVG(preco) AS media_precos FROM produtos;

/*3. Funções de Data:*/

CREATE TABLE eventos (
    data_evento DATE
);

INSERT INTO eventos (data_evento) VALUES
    ('2023-10-16'),
    ('2023-10-17'),
    ('2023-10-18');

INSERT INTO eventos (data_evento) VALUES (NOW());

SELECT DATEDIFF('2023-10-18', '2023-10-16') AS dias_entre_datas;

SELECT data_evento, DAYNAME(data_evento) AS dia_semana FROM eventos;

/*4. Funções de Controle de Fluxo:*/

SELECT produto, 
IF(quantidade > 0, 'Em estoque', 'Fora de estoque') AS status_estoque FROM produtos;

SELECT
    produto,
    CASE
        WHEN preco < 15 THEN 'Barato'
        WHEN preco BETWEEN 15 AND 25 THEN 'Médio'
        ELSE 'Caro'
    END AS categoria_preco
FROM produtos;


/*5. Função Personalizada:*/

DELIMITER //
CREATE FUNCTION TOTAL_VALOR(preco DECIMAL(10, 2), quantidade INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    RETURN preco * quantidade;
END;
//
DELIMITER ;

SELECT produto, TOTAL_VALOR(preco, quantidade) AS valor_total FROM produtos;

/*6. Funções de Agregação:*/

SELECT COUNT(*) AS numero_produtos FROM produtos;

SELECT produto FROM produtos 
WHERE preco = (SELECT MAX(preco) FROM produtos);

SELECT produto FROM produtos 
WHERE preco = (SELECT MIN(preco) FROM produtos);

SELECT SUM(IF(quantidade > 0, preco, 0)) AS soma_produtos_em_estoque FROM produtos;

/*7. Criando funções*/

DELIMITER //
CREATE FUNCTION FATORIAL(n INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE result INT DEFAULT 1;
    WHILE n > 1 DO
        SET result = result * n;
        SET n = n - 1;
    END WHILE;
    RETURN result;
END;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION f_exponencial(base DECIMAL(10, 2), expoente INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE result DECIMAL(10, 2) DEFAULT 1;
    WHILE expoente > 0 DO
        SET result = result * base;
        SET expoente = expoente - 1;
    END WHILE;
    RETURN result;
END;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION e_palindromo(palavra VARCHAR(255))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE reverso VARCHAR(255);
    SET reverso = REVERSE(palavra);
    IF reverso = palavra THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END;
//
DELIMITER ;




