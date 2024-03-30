-- Script para povoar a dimensão tempo
USE PROJETO_LAGARTO
	
CREATE OR ALTER PROCEDURE SP_DIM_TEMPO (@DT_INICIAL DATETIME, @DT_FINAL DATETIME)
AS
BEGIN
		SET NOCOUNT ON
		SET LANGUAGE BRAZILIAN

		DECLARE @DIA INT,
				@MES INT,
				@ANO INT,
				@TRIMESTRE INT,
				@NOME_TRIMESTRE VARCHAR(100),
				@SEMESTRE INT,
				@NOME_SEMESTRE VARCHAR (100),
				@FINALSEMANA CHAR(3),
				@DATA DATE,
				@NOMEDIA VARCHAR(7),
				@DIASEMANA INT,
				@NOME_DIA VARCHAR (7),
				@NOME_MES VARCHAR(10),
				@DATA_NIVEL DATETIME,
				@ULTIMO_DIA_MES INT

		SET @DATA = @DT_INICIAL

		WHILE @DATA <= @DT_FINAL
		BEGIN
			SET @DIA = DAY(@DATA)
			SET @MES = MONTH(@DATA)
			SET @ANO = YEAR (@DATA)
			SET @DIASEMANA = DATEPART(WEEKDAY, @DATA)
			SET @TRIMESTRE = DATEPART(QUARTER, @DATA)
			SET @NOME_DIA = DATENAME(dw, @DATA)
			SET @NOME_MES = DATENAME(mm,@DATA)
			SET @DATA_NIVEL =(SELECT DATEADD(DD, - DAY (DATEADD(M, 1, @DATA)),DATEADD(M, 1, @DATA)))
			SET @ULTIMO_DIA_MES = DATEPART(DAY,@DATA_NIVEL)

			IF @MES < 6
				SET @SEMESTRE = 1
			ELSE
				SET @SEMESTRE = 2

			IF @DIASEMANA = 7 OR @DIASEMANA = 1
				SET @FINALSEMANA = 'SIM'
			ELSE
				SET @FINALSEMANA = 'NAO'

				SET @NOME_SEMESTRE = STR(@SEMESTRE) + '° Semestre' + '/' + STR(@ANO)
				SET @NOME_TRIMESTRE = STR(@TRIMESTRE) + '° Trimestre' + '/' + STR(@ANO)
	
			IF (@DIA = 1 AND @MES = 1)
			BEGIN
				INSERT INTO DIM_TEMPO(NIVEL,DATA, ANO)
				VALUES('ANO',@DATA, @ANO)
			END

			IF (@DIA = 1)
			BEGIN
				INSERT INTO DIM_TEMPO(NIVEL,DATA, NOME_MES, MES, TRIMESTRE,NOME_TRIMESTRE, SEMESTRE,NOME_SEMESTRE, ANO)
				VALUES('MES',@DATA, @NOME_MES, @MES, @TRIMESTRE, @NOME_TRIMESTRE, @SEMESTRE, @NOME_SEMESTRE , @ANO)
			END

			INSERT INTO DIM_TEMPO(NIVEL, DATA, DIA, DIA_SEMANA,NOME_MES,FIM_SEMANA,FERIADO,FL_FERIADO, MES, TRIMESTRE,NOME_TRIMESTRE, SEMESTRE, NOME_SEMESTRE, ANO)
			VALUES('DIA',@DATA, @DIA, @NOME_DIA,@NOME_MES, @FINALSEMANA,'Sem Feriado','NAO',@MES,@TRIMESTRE, @NOME_TRIMESTRE, @SEMESTRE, @NOME_SEMESTRE, @ANO)

			SET @DATA = DATEADD(DAY, 1, @DATA)
	END
END

EXEC SP_DIM_TEMPO '20090101', '20240101'

SELECT * FROM DIM_TEMPO

-- Script para povoar a dimensão feriados no ano de 2023
--Dados retirados do site a baixo
--https://www.anbima.com.br/feriados/fer_nacionais/2023.asp
INSERT INTO DIM_FERIADOS(DATA,DESCRICAO,TIPO)
VALUES	('2013-01-01','Confraternização Universal','NACIONAL'),
		('2013-11-02','Carnaval','NACIONAL'),
		('2013-12-02','Carnaval','NACIONAL'),
		('2013-29-03','Paixão de Cristo','NACIONAL'),
		('2013-21-04','Tiradentes','NACIONAL'),
		('2013-01-05','Dia do Trabalho','NACIONAL'),
		('2013-30-05','Corpus Christi','NACIONAL'),
		('2013-07-09','Independência do Brasil','NACIONAL'),
		('2013-12-10','Nossa Sr. Aparecida - Padroeira do Brasil','NACIONAL'),
		('2013-02-11','Finados','NACIONAL'),
		('2013-15-11','Proclamação da República','NACIONAL'),
		('2013-25-12','Natal','NACIONAL'),
		
		('2014-01-01','Confraternização Universal','NACIONAL'),
		('2014-03-03','Carnaval','NACIONAL'),
		('2014-04-03','Carnaval','NACIONAL'),
		('2014-16-04','Paixão de Cristo','NACIONAL'),
		('2014-21-04','Tiradentes','NACIONAL'),
		('2014-01-05','Dia do Trabalho','NACIONAL'),
		('2014-19-06','Corpus Christi','NACIONAL'),
		('2014-07-09','Independência do Brasil','NACIONAL'),
		('2014-12-10','Nossa Sr. Aparecida - Padroeira do Brasil','NACIONAL'),
		('2014-02-11','Finados','NACIONAL'),
		('2014-15-11','Proclamação da República','NACIONAL'),
		('2014-25-12','Natal','NACIONAL'),

		('2015-01-01','Confraternização Universal','NACIONAL'),
		('2015-16-02','Carnaval','NACIONAL'),
		('2015-17-02','Carnaval','NACIONAL'),
		('2015-03-04','Paixão de Cristo','NACIONAL'),
		('2015-21-04','Tiradentes','NACIONAL'),
		('2015-01-05','Dia do Trabalho','NACIONAL'),
		('2015-04-06','Corpus Christi','NACIONAL'),
		('2015-07-09','Independência do Brasil','NACIONAL'),
		('2015-12-10','Nossa Sr. Aparecida - Padroeira do Brasil','NACIONAL'),
		('2015-02-11','Finados','NACIONAL'),
		('2015-15-11','Proclamação da República','NACIONAL'),
		('2015-25-12','Natal','NACIONAL'),
		
		('2016-01-01','Confraternização Universal','NACIONAL'),
		('2016-08-02','Carnaval','NACIONAL'),
		('2016-09-02','Carnaval','NACIONAL'),
		('2016-25-03','Paixão de Cristo','NACIONAL'),
		('2016-21-04','Tiradentes','NACIONAL'),
		('2016-01-05','Dia do Trabalho','NACIONAL'),
		('2016-26-05','Corpus Christi','NACIONAL'),
		('2016-07-09','Independência do Brasil','NACIONAL'),
		('2016-12-10','Nossa Sr. Aparecida - Padroeira do Brasil','NACIONAL'),
		('2016-02-11','Finados','NACIONAL'),
		('2016-15-11','Proclamação da República','NACIONAL'),
		('2016-25-12','Natal','NACIONAL'),
		
		('2017-01-01','Confraternização Universal','NACIONAL'),
		('2017-27-02','Carnaval','NACIONAL'),
		('2017-28-02','Carnaval','NACIONAL'),
		('2017-14-04','Paixão de Cristo','NACIONAL'),
		('2017-21-04','Tiradentes','NACIONAL'),
		('2017-01-05','Dia do Trabalho','NACIONAL'),
		('2017-15-06','Corpus Christi','NACIONAL'),
		('2017-07-09','Independência do Brasil','NACIONAL'),
		('2017-12-10','Nossa Sr. Aparecida - Padroeira do Brasil','NACIONAL'),
		('2017-02-11','Finados','NACIONAL'),
		('2017-15-11','Proclamação da República','NACIONAL'),
		('2017-25-12','Natal','NACIONAL'),
		
		('2018-01-01','Confraternização Universal','NACIONAL'),
		('2018-12-02','Carnaval','NACIONAL'),
		('2018-13-02','Carnaval','NACIONAL'),
		('2018-30-04','Paixão de Cristo','NACIONAL'),
		('2018-21-04','Tiradentes','NACIONAL'),
		('2018-01-05','Dia do Trabalho','NACIONAL'),
		('2018-31-05','Corpus Christi','NACIONAL'),
		('2018-07-09','Independência do Brasil','NACIONAL'),
		('2018-12-10','Nossa Sr. Aparecida - Padroeira do Brasil','NACIONAL'),
		('2018-02-11','Finados','NACIONAL'),
		('2018-15-11','Proclamação da República','NACIONAL'),
		('2018-25-12','Natal','NACIONAL'),
		
		('2019-01-01','Confraternização Universal','NACIONAL'),
		('2019-04-03','Carnaval','NACIONAL'),
		('2019-05-03','Carnaval','NACIONAL'),
		('2019-19-04','Paixão de Cristo','NACIONAL'),
		('2019-21-04','Tiradentes','NACIONAL'),
		('2019-01-05','Dia do Trabalho','NACIONAL'),
		('2019-19-06','Corpus Christi','NACIONAL'),
		('2019-07-09','Independência do Brasil','NACIONAL'),
		('2019-12-10','Nossa Sr. Aparecida - Padroeira do Brasil','NACIONAL'),
		('2019-02-11','Finados','NACIONAL'),
		('2019-15-11','Proclamação da República','NACIONAL'),
		('2019-25-12','Natal','NACIONAL'),
		
		('2020-01-01','Confraternização Universal','NACIONAL'),
		('2020-24-02','Carnaval','NACIONAL'),
		('2020-25-02','Carnaval','NACIONAL'),
		('2020-19-04','Paixão de Cristo','NACIONAL'),
		('2020-21-04','Tiradentes','NACIONAL'),
		('2020-01-05','Dia do Trabalho','NACIONAL'),
		('2020-11-06','Corpus Christi','NACIONAL'),
		('2020-07-09','Independência do Brasil','NACIONAL'),
		('2020-12-10','Nossa Sr. Aparecida - Padroeira do Brasil','NACIONAL'),
		('2020-02-11','Finados','NACIONAL'),
		('2020-15-11','Proclamação da República','NACIONAL'),
		('2020-25-12','Natal','NACIONAL'),

		('2021-01-01','Confraternização Universal','NACIONAL'),
		('2021-15-02','Carnaval','NACIONAL'),
		('2021-16-02','Carnaval','NACIONAL'),
		('2021-02-04','Paixão de Cristo','NACIONAL'),
		('2021-21-04','Tiradentes','NACIONAL'),
		('2021-01-05','Dia do Trabalho','NACIONAL'),
		('2021-03-06','Corpus Christi','NACIONAL'),
		('2021-07-09','Independência do Brasil','NACIONAL'),
		('2021-12-10','Nossa Sr. Aparecida - Padroeira do Brasil','NACIONAL'),
		('2021-02-11','Finados','NACIONAL'),
		('2021-15-11','Proclamação da República','NACIONAL'),
		('2021-25-12','Natal','NACIONAL'),
		
		('2022-01-01','Confraternização Universal','NACIONAL'),
		('2022-28-02','Carnaval','NACIONAL'),
		('2022-01-02','Carnaval','NACIONAL'),
		('2022-15-04','Paixão de Cristo','NACIONAL'),
		('2022-21-04','Tiradentes','NACIONAL'),
		('2022-01-05','Dia do Trabalho','NACIONAL'),
		('2022-16-06','Corpus Christi','NACIONAL'),
		('2022-07-09','Independência do Brasil','NACIONAL'),
		('2022-12-10','Nossa Sr. Aparecida - Padroeira do Brasil','NACIONAL'),
		('2022-02-11','Finados','NACIONAL'),
		('2022-15-11','Proclamação da República','NACIONAL'),
		('2022-25-12','Natal','NACIONAL'),
		
		('2023-01-01','Confraternização Universal','NACIONAL'),
		('2023-20-02','Carnaval','NACIONAL'),
		('2023-21-02','Carnaval','NACIONAL'),
		('2023-07-04','Paixão de Cristo','NACIONAL'),
		('2023-21-04','Tiradentes','NACIONAL'),
		('2023-01-05','Dia do Trabalho','NACIONAL'),
		('2023-08-06','Corpus Christi','NACIONAL'),
		('2023-07-09','Independência do Brasil','NACIONAL'),
		('2023-12-10','Nossa Sr. Aparecida - Padroeira do Brasil','NACIONAL'),
		('2023-02-11','Finados','NACIONAL'),
		('2023-15-11','Proclamação da República','NACIONAL'),
		('2023-25-12','Natal','NACIONAL'),
		
		('2024-01-01','Confraternização Universal','NACIONAL'),
		('2024-12-02','Carnaval','NACIONAL'),
		('2024-13-02','Carnaval','NACIONAL'),
		('2024-29-03','Paixão de Cristo','NACIONAL'),
		('2024-21-04','Tiradentes','NACIONAL'),
		('2024-01-05','Dia do Trabalho','NACIONAL'),
		('2024-30-05','Corpus Christi','NACIONAL'),
		('2024-07-09','Independência do Brasil','NACIONAL'),
		('2024-12-10','Nossa Sr. Aparecida - Padroeira do Brasil','NACIONAL'),
		('2024-02-11','Finados','NACIONAL'),
		('2024-15-11','Proclamação da República','NACIONAL'),
		('2024-20-11','Dia Nacional de Zumbi e da Consciência Negra','NACIONAL'),
		('2024-25-12','Natal','NACIONAL')

SELECT * FROM DIM_FERIADOS


-- Script para atualizar a dimensão tempo com os feriados cadastrados na dimensão feriados

CREATE OR ALTER PROCEDURE SP_ATUALIZA_FERIADO(@ANO INT)
AS
BEGIN
	
	UPDATE DIM_TEMPO 
	SET FL_FERIADO = 'SIM', FERIADO = F.DESCRICAO
	FROM DIM_TEMPO T
	INNER JOIN DIM_FERIADOS F ON T.DATA = F.DATA
	WHERE T.ANO = @ANO

END

EXEC SP_ATUALIZA_FERIADO '2024'
