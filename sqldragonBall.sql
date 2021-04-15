USE DesafioBDZ

CREATE TABLE Classe(
Id_classe INTEGER PRIMARY KEY IDENTITY(1, 1) NOT NULL,
Descricao VARCHAR (600) NOT NULL
)

CREATE TABLE Raca(
Id_raca INTEGER PRIMARY KEY IDENTITY (1,1) NOT NULL,
Nome VARCHAR (100) NOT NULL
)

CREATE TABLE InfoRaca(
Id_infoRaca INTEGER PRIMARY KEY IDENTITY (1,1) NOT NULL,
Id_raca INTEGER NOT  NULL,
Descricao VARCHAR (500),
CONSTRAINT Fk_IdRaca FOREIGN KEY (Id_raca)
REFERENCES Raca (Id_raca)
)

CREATE TABLE Personagem(
Id_Personagem INTEGER PRIMARY KEY IDENTITY (1,1) NOT NULL,
Id_raca INTEGER NOT NULL,
Id_classe INTEGER NOT NULL,
Nome VARCHAR (100) NOT NULL,
PowerLevel FLOAT NOT NULL,
CONSTRAINT Fk_Id_Raca FOREIGN KEY (Id_raca)
REFERENCES Raca (Id_raca),
CONSTRAINT Fk_IdClasse FOREIGN KEY (Id_classe)
REFERENCES Classe (Id_classe)
)
select*from Raca
INSERT INTO Raca(Nome)
VALUES
('Androide'),
('Animal'),
('Terráqueo'),
('Shin-jin'),
('Majin'),
('Namekuseijin'),
('Ogro'),
('Raça do Freeza'),
('Saiyajin'),
('Tsufurujin');

INSERT INTO InfoRaca(Id_raca, Descricao)
VALUES
(1,'"Humanos Artificiais" são Terráqueos cyborgs/robóticos, a maioria criados pelo cientista Dr. Gero. É dito que maioria dos androides têm energia ilimitada e vida eterna. Devido à sua natureza inorgânica, eles também não tem aura (ao contrário de Saiyajins, Terráqueos, e outros), então eles não podem ser rastreados usando rastreadores ou Ki Sense.'),
(2,'Na série Dragon Ball, 17% dos Terráqueos são do tipo animal. É comum ver animais antropomórficos vivendo entre os humanos como residentes das cidades; os dois animais mais recorrentes são Pual e Oolong.'),
(4,'Eles compartilham o planeta com outras formas de vida inteligentes, incluindo animais antropomórficos. Inclusive, o Rei da Terra é um cachorro antropomórfico. 1% dos terráqueos são híbridos com outra raça, 7% são tipo monstro, 17% são tipo animal, e o 75% restante são tipo humanos normais.'),
(5,'"Povo do Núcleo" são uma raça de seres do Planeta Kaishin. Os Shinjins são a verdadeira raça da qual todos os Kaioh e Kaiohshin fazem parte antes de serem promovidos. O seu planeta tem uma população de mais ou menos 80 Shin-jins de cada vez.'),
(6,'É uma raça na franquia Dragon Ball. Eles estream com Majin Boo no capítulo 460 do manga Dragon Ball, que lançou em 4 de Março, 1994.'),
(7,'Eles estão entre as raças mais importantes da série, pois eles são os criadores das Esferas do Dragão. Namekuseijins são humanoides com características de plantas e lesmas, incluindo pele verde e antenas.'),
(8,'São uma raça que cuidam do Outro Mundo em Dragon Ball Z. Enma Daioh é o chefe de todos os Ogros, e ele também decide quais almas vão para o Inferno e quais vão para o Paraíso.'),
(9,'É a misteriosa raça sem nome que Freeza, Rei Cold, Coola, Kuriza, e Chilled pertencem. A raça é introduzida na série na saga Namekusei de Dragon Ball Z.'),
(10,'São uma raça guerreira que foi quase toda extinta por Freeza antes do começo da série Dragon Ball. Eles têm um papel central em Dragon Ball Z, Dragon Ball GT, e Dragon Ball Super após ser revelado que o protagonista Goku é na verdade um Saiyajin que foi mandado para destruir a Terra.'),
(11,'Foram uma raça altamente avançada em tecnologia nativos do Planeta Planta. Porém, o planeta foi dominado pelos Saiyajin, deixando os Tsufurujin extintos.')

INSERT INTO Classe(Descricao)
VALUES('Alta'),
('Baixa')

INSERT INTO Personagem(Id_raca, Id_classe, Nome, PowerLevel)
VALUES 
(10, 1, 'Goku', 10000),
(10, 1, 'Vegeta', 9000),
(6, 2, 'Majin Boo', 1000),
(9, 1, 'Freeza', 8000),
(8, 2, 'Enma Daioh', 1000),
(5, 2, 'Velho Kaiohshin', 2000),
(5, 2, 'Grande Kaiohshin', 1000),
(5, 1, 'Chronoa', 5000),
(5, 2, 'Fuwa', 800),
(5, 2, 'Gowasu', 600),
(5, 2, 'Anato', 800),
(5, 2, 'Peru', 500),
(5, 2, 'Ea', 200),
(5, 2, 'Kuru', 100),
(5, 2, 'Oguma', 900),
(11, 1, 'Zarbuto', 5000),
(11, 1, 'Dr. Raichi', 6000),
(2, 2, 'Mestre Karin', 200),
(2, 2, 'Oolong', 100),
(7, 2, 'Kami-Sama', 4000),
(1, 1, 'Android 17', 9000),
(1, 1, 'Android 18', 9500)

SELECT  P.Nome, 
		P.PowerLevel 
	From Personagem AS P --exercício 1
		INNER JOIN Raca AS R
			ON R.Id_raca = P.Id_raca
	WHERE PowerLevel < 1000 AND R.Nome = 'Shin-jin'



SELECT TOP 5 R.Nome, 
			 P.PowerLevel 
	FROM Personagem AS P--exercício 2
		INNER JOIN Raca AS R
			ON P.Id_raca = R.Id_raca
	WHERE PowerLevel >= 3000 AND PowerLevel<= 5000 
	ORDER BY PowerLevel DESC



SELECT  P.Nome AS 'Nome do Personagem', 
		R.Nome As 'Nome da raça', 
		I.Descricao, 
		P.PowerLevel, --exercicio 3
		CASE 
			WHEN PowerLevel >= 8000 THEN 'É mais de 8 MIL'
			ELSE 'É 37 ANOS, CARAL&¨%' END AS Mensagem
	FROM Personagem AS P
		INNER JOIN Raca AS R
			ON R.Id_raca = P.Id_raca
		INNER JOIN InfoRaca AS I
			ON I.Id_raca = R.Id_raca


SELECT  LOWER(P.Nome) AS Nome, 
		C.Descricao AS 'Nome da classe' 
	FROM Personagem AS P--exercício 4
		INNER JOIN Classe AS C
			ON C.Id_classe = P.Id_classe
		INNER JOIN Raca AS R
			ON P.Id_raca = R.Id_raca
	WHERE  LOWER(R.Nome) = LOWER('Androide')

GO

CREATE PROCEDURE p_inserirClasse (
	@Descricao VARCHAR (600)
)
AS 
	BEGIN
		INSERT INTO Classe(Descricao)
		VALUES (@Descricao)
	END

GO


EXEC p_inserirClasse 'teste20'

GO

CREATE PROCEDURE p_inserirRaca(
	@Nome VARCHAR (100)
)

AS
	BEGIN
		INSERT INTO Raca(Nome)
		VALUES(@Nome)
	END

GO

EXEC p_inserirRaca 'teste'

GO 

CREATE PROCEDURE p_inserirInfoRaca(
	@Id_raca INT,
	@Descricao VARCHAR (500)
)
AS
	BEGIN
		INSERT INTO InfoRaca(Id_raca, Descricao)
		VALUES(@Id_raca, @Descricao)
	END

GO

EXEC p_inserirInfoRaca 2, 'teste5'

GO

CREATE PROCEDURE p_inserirPersonagem(
	@Id_raca INT,
	@Id_classe INT,
	@Nome VARCHAR (100),
	@PoweLevel FLOAT
)
AS
	BEGIN
		INSERT INTO Personagem(Id_raca, Id_classe, Nome, PowerLevel)
		VALUES(@Id_raca, @Id_classe, @Nome, @PoweLevel)
	END
GO

EXEC p_inserirPersonagem 1, 1, 'Teste', 10000

GO

-------------------------------

CREATE PROCEDURE p_apagaRaca
	@Id_raca INT
AS
	BEGIN
		DELETE Raca WHERE Id_raca= @Id_raca
	END
EXEC p_apagaRaca 12

GO 

CREATE PROCEDURE p_apagaClasse
	@Id_classe INT
AS 
	BEGIN
		DELETE Classe WHERE Id_classe = @Id_classe
	END
GO

EXEC p_apagaClasse 3

GO

CREATE PROCEDURE p_apagaInfoRaca(
	@Id_infoRaca INT
)
AS
	BEGIN
		DELETE InfoRaca WHERE Id_infoRaca = @Id_infoRaca
	END

EXEC p_apagaInfoRaca 1

GO
--sp_rename 'p_Personagem', 'p_inserirPersonagem'

CREATE PROCEDURE p_apagaPersonagem(
	@Id_personagem INT
)
AS
	BEGIN
		DELETE Personagem WHERE Id_Personagem = @Id_personagem
	END

GO

EXEC p_apagaPersonagem 3

GO

CREATE PROCEDURE p_buscaPersonagem(
	@Id_Personagem INT = NULL 
)
AS
	BEGIN
			SELECT  P.Nome AS 'Nome do Personagem', 
					R.Nome As 'Nome da raça', 
					I.Descricao, 
					P.PowerLevel, 
					CASE WHEN PowerLevel >= 8000 THEN 'É mais de 8 MIL'
					ELSE 'É 37 ANOS, CARAL&¨%' END AS Mensagem
				FROM Personagem AS P
					INNER JOIN Raca AS R
						ON R.Id_raca = P.Id_raca
					INNER JOIN InfoRaca AS I
						ON I.Id_raca = R.Id_raca 
				WHERE @Id_Personagem IS NULL OR P.Id_Personagem = @Id_Personagem 
	END

GO
EXEC p_buscaPersonagem 5





--drop procedure p_buscaPersonagem






