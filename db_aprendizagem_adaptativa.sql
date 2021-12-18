-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.6.4-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para db_aprendizagem_adaptativa
CREATE DATABASE IF NOT EXISTS `db_aprendizagem_adaptativa` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `db_aprendizagem_adaptativa`;

-- Copiando estrutura para tabela db_aprendizagem_adaptativa.alternativas
CREATE TABLE IF NOT EXISTS `alternativas` (
  `cd_alternativa` int(11) NOT NULL AUTO_INCREMENT,
  `de_alternativa` char(30) NOT NULL,
  `cd_quest` int(11) NOT NULL,
  `correto_alternativa` int(11) NOT NULL,
  PRIMARY KEY (`cd_alternativa`),
  KEY `fk_cd_quest` (`cd_quest`),
  CONSTRAINT `fk_cd_quest` FOREIGN KEY (`cd_quest`) REFERENCES `questoes` (`cd_quest`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela db_aprendizagem_adaptativa.alternativas: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `alternativas` DISABLE KEYS */;
/*!40000 ALTER TABLE `alternativas` ENABLE KEYS */;

-- Copiando estrutura para tabela db_aprendizagem_adaptativa.anexos
CREATE TABLE IF NOT EXISTS `anexos` (
  `cd_anexo` int(11) NOT NULL AUTO_INCREMENT,
  `cd_quest` int(11) NOT NULL,
  `seq_anexo` char(80) DEFAULT NULL,
  `tp_anexo` char(20) DEFAULT NULL,
  `cont_anexo` text DEFAULT NULL,
  PRIMARY KEY (`cd_anexo`),
  KEY `fk_cd_quest_anexo` (`cd_quest`),
  CONSTRAINT `fk_cd_quest_anexo` FOREIGN KEY (`cd_quest`) REFERENCES `questoes` (`cd_quest`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela db_aprendizagem_adaptativa.anexos: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `anexos` DISABLE KEYS */;
/*!40000 ALTER TABLE `anexos` ENABLE KEYS */;

-- Copiando estrutura para tabela db_aprendizagem_adaptativa.conteudo
CREATE TABLE IF NOT EXISTS `conteudo` (
  `cd_conteudo` int(11) NOT NULL AUTO_INCREMENT,
  `de_conteudo` char(30) NOT NULL,
  `cd_disciplina` int(11) NOT NULL,
  PRIMARY KEY (`cd_conteudo`),
  KEY `fk_cd_disciplina` (`cd_disciplina`),
  CONSTRAINT `fk_cd_disciplina` FOREIGN KEY (`cd_disciplina`) REFERENCES `disciplinas` (`cd_disciplina`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela db_aprendizagem_adaptativa.conteudo: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `conteudo` DISABLE KEYS */;
INSERT INTO `conteudo` (`cd_conteudo`, `de_conteudo`, `cd_disciplina`) VALUES
	(1, 'Algebra', 1),
	(2, 'Historia da linguagem', 2),
	(3, '2 guerra mundial', 3);
/*!40000 ALTER TABLE `conteudo` ENABLE KEYS */;

-- Copiando estrutura para tabela db_aprendizagem_adaptativa.disciplinas
CREATE TABLE IF NOT EXISTS `disciplinas` (
  `cd_disciplina` int(11) NOT NULL AUTO_INCREMENT,
  `de_disciplina` char(50) NOT NULL,
  PRIMARY KEY (`cd_disciplina`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela db_aprendizagem_adaptativa.disciplinas: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `disciplinas` DISABLE KEYS */;
INSERT INTO `disciplinas` (`cd_disciplina`, `de_disciplina`) VALUES
	(1, 'matematica'),
	(2, 'portugues'),
	(3, 'historia'),
	(4, 'geologia'),
	(5, 'racionais');
/*!40000 ALTER TABLE `disciplinas` ENABLE KEYS */;

-- Copiando estrutura para tabela db_aprendizagem_adaptativa.questoes
CREATE TABLE IF NOT EXISTS `questoes` (
  `cd_quest` int(11) NOT NULL AUTO_INCREMENT,
  `des_quest` text NOT NULL,
  `cd_conteudo` int(11) NOT NULL,
  `tp_questao` char(30) NOT NULL,
  `nivel_questao_prof` int(11) NOT NULL,
  `nivel_questao_calc` int(11) NOT NULL,
  PRIMARY KEY (`cd_quest`),
  KEY `fk_cd_conteudo` (`cd_conteudo`),
  CONSTRAINT `fk_cd_conteudo` FOREIGN KEY (`cd_conteudo`) REFERENCES `conteudo` (`cd_conteudo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela db_aprendizagem_adaptativa.questoes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `questoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `questoes` ENABLE KEYS */;

-- Copiando estrutura para tabela db_aprendizagem_adaptativa.respostas_questoes
CREATE TABLE IF NOT EXISTS `respostas_questoes` (
  `cd_quest` int(11) NOT NULL,
  `cd_alternativa` int(11) NOT NULL,
  `cd_usuario` int(11) NOT NULL,
  `cd_resultado` int(11) NOT NULL,
  `dt_data` datetime DEFAULT NULL,
  `cd_teste` int(11) NOT NULL,
  KEY `fk_cd_quest_resposta` (`cd_quest`),
  KEY `fk_cd_alternativa_resposta` (`cd_alternativa`),
  KEY `fk_cd_usuario_resposta` (`cd_usuario`),
  KEY `fk_cd_teste_resposta` (`cd_teste`),
  CONSTRAINT `fk_cd_alternativa_resposta` FOREIGN KEY (`cd_alternativa`) REFERENCES `alternativas` (`cd_alternativa`),
  CONSTRAINT `fk_cd_quest_resposta` FOREIGN KEY (`cd_quest`) REFERENCES `questoes` (`cd_quest`),
  CONSTRAINT `fk_cd_teste_resposta` FOREIGN KEY (`cd_teste`) REFERENCES `teste` (`cd_teste`),
  CONSTRAINT `fk_cd_usuario_resposta` FOREIGN KEY (`cd_usuario`) REFERENCES `usuarios` (`cd_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela db_aprendizagem_adaptativa.respostas_questoes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `respostas_questoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `respostas_questoes` ENABLE KEYS */;

-- Copiando estrutura para tabela db_aprendizagem_adaptativa.teste
CREATE TABLE IF NOT EXISTS `teste` (
  `cd_teste` int(11) NOT NULL AUTO_INCREMENT,
  `dt_data` datetime DEFAULT NULL,
  `cd_usuario` int(11) NOT NULL,
  `cd_disciplina` int(11) NOT NULL,
  PRIMARY KEY (`cd_teste`),
  KEY `fk_cd_usuario_test` (`cd_usuario`),
  KEY `fk_cd_disciplina_test` (`cd_disciplina`),
  CONSTRAINT `fk_cd_disciplina_test` FOREIGN KEY (`cd_disciplina`) REFERENCES `disciplinas` (`cd_disciplina`),
  CONSTRAINT `fk_cd_usuario_test` FOREIGN KEY (`cd_usuario`) REFERENCES `usuarios` (`cd_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela db_aprendizagem_adaptativa.teste: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `teste` DISABLE KEYS */;
/*!40000 ALTER TABLE `teste` ENABLE KEYS */;

-- Copiando estrutura para tabela db_aprendizagem_adaptativa.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `cd_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `no_usuario` char(60) NOT NULL,
  `de_usu_login` char(15) NOT NULL,
  `nr_senha` char(20) NOT NULL,
  `cd_tipo_usu` int(1) NOT NULL,
  PRIMARY KEY (`cd_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela db_aprendizagem_adaptativa.usuarios: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`cd_usuario`, `no_usuario`, `de_usu_login`, `nr_senha`, `cd_tipo_usu`) VALUES
	(1, 'xunda', 'xunda123', '123', 1),
	(2, 'joao', 'joao123', '123', 1),
	(3, 'carol', 'carol123', '123', 1),
	(4, 'prof', 'prof123', '123', 2),
	(5, 'xuxu', 'xuxu124', '123', 1),
	(6, 'assis', 'assis123', '123', 1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;

-- Copiando estrutura para tabela db_aprendizagem_adaptativa.usuario_disciplina
CREATE TABLE IF NOT EXISTS `usuario_disciplina` (
  `cd_usuario` int(11) NOT NULL,
  `cd_disciplina` int(11) NOT NULL,
  KEY `fk_cd_usuario` (`cd_usuario`),
  KEY `fk_cd_disciplina_usu` (`cd_disciplina`),
  CONSTRAINT `fk_cd_disciplina_usu` FOREIGN KEY (`cd_disciplina`) REFERENCES `disciplinas` (`cd_disciplina`),
  CONSTRAINT `fk_cd_usuario` FOREIGN KEY (`cd_usuario`) REFERENCES `usuarios` (`cd_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela db_aprendizagem_adaptativa.usuario_disciplina: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `usuario_disciplina` DISABLE KEYS */;
INSERT INTO `usuario_disciplina` (`cd_usuario`, `cd_disciplina`) VALUES
	(1, 2),
	(2, 2),
	(3, 3);
/*!40000 ALTER TABLE `usuario_disciplina` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
