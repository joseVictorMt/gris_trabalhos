-- =========================================================
-- Author: José Victor Medeiros Thomé da Silva
-- Create Date: 24/02/2020
-- Description: Script do Banco de Dados da Tag da aula
-- de Banco de Dados 1 do processo seletivo do GRIS 2020.1.
-- =========================================================

CREATE DATABASE ps_gris;
USE ps_gris;

-- Instructors: representa os instrutores
-- do treinamento técnico.
CREATE TABLE Instructors (
	id INT UNSIGNED NOT NULL,
	name VARCHAR(255),
	email VARCHAR(255),
    telegram_profile VARCHAR(50),
    CONSTRAINT PK_Instructor PRIMARY KEY (id));

-- Subjects: representa as matérias/assuntos
-- abordados nas aulas do treinamento técnico.
CREATE TABLE Subjects (
	id INT UNSIGNED NOT NULL,
    name VARCHAR(255),
    program LONGTEXT,
    CONSTRAINT PK_Subject PRIMARY KEY (id));

-- Classes: representa as aulas passadas pelos
-- instrutores durante o treinamento técnico.
CREATE TABLE Classes (
	id INT UNSIGNED NOT NULL,
    class_day DATE,
    start_time TIME,
    end_time TIME,
    instructor_id INT UNSIGNED NOT NULL,
    subject_id INT UNSIGNED NOT NULL,
    CONSTRAINT PK_Class PRIMARY KEY (id),
    CONSTRAINT FK_InstructorClass FOREIGN KEY (instructor_id)
    REFERENCES Instructors(id),
    CONSTRAINT FK_SubjectClass FOREIGN KEY (subject_id)
    REFERENCES Subjects(id),
	UNIQUE(instructor_id, subject_id));

-- Tags: representa as tags passadas após as
-- aulas do treinamento técnico.
CREATE TABLE Tags (
	id INT UNSIGNED NOT NULL,
    title VARCHAR(255),
    description LONGTEXT,
    date_limit DATE,
    class_id INT UNSIGNED NOT NULL,
    CONSTRAINT PK_Tag PRIMARY KEY (id),
    CONSTRAINT FK_ClassTag FOREIGN KEY (class_id)
    REFERENCES Classes(id));

-- Students: representa os estudantes/participantes
-- do treinamento técnico.
CREATE TABLE Students (
	id INT UNSIGNED NOT NULL,
    name VARCHAR(255),
    email VARCHAR(255),
    telephone VARCHAR(19),
    CONSTRAINT PK_Student PRIMARY KEY (id));

-- Deliveries: uma relação de Students e Tags
-- que registra a entrega dos exercícios feitos
-- e as notas de avaliação (após serem corrigidos).
CREATE TABLE Deliveries (
    tag_id INT UNSIGNED NOT NULL,
    student_id INT UNSIGNED NOT NULL,
    delivery_date DATE,
    grade FLOAT,
    CONSTRAINT PK_Delivery PRIMARY KEY(tag_id, student_id),
	CONSTRAINT FK_TagDelivery FOREIGN KEY(tag_id)
    REFERENCES Tags(id),
	CONSTRAINT FK_StudentDelivery FOREIGN KEY(student_id)
	REFERENCES Students(id),
    UNIQUE (tag_id, student_id));

INSERT INTO Instructors
VALUES
	('1', 'Breno', 'breno_css@poli.ufrj.br', '@brenocss'),
    ('2', 'Daniel La Rubia Rolim', NULL, '@dlarubia'),
    ('3', 'José Luiz', NULL, '@esoj_1'),
    ('4', 'Franklin', 'franklinmartins@dcc.ufrj.br', '@Frankitin'),
    ('5', 'Leonardo Ventura', 'leo-ventura@dcc.ufrj.br', '@leoventura98'),
    ('6', 'Arthur Castro', 'arthurcastro@dcc.ufrj.br', '@artoscastro');

INSERT INTO Subjects
VALUES
	('1', 'WebHacking', 'Mussum Ipsum, cacilds vidis litro abertis. Copo furadis é disculpa de bebadis, arcu quam euismod magna. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. Aenean aliquam molestie leo, vitae iaculis nisl.'),
    ('2', 'Malware', 'Mussum Ipsum, cacilds vidis litro abertis. Copo furadis é disculpa de bebadis, arcu quam euismod magna. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. Aenean aliquam molestie leo, vitae iaculis nisl.'),
    ('3', 'Segurança Ofensiva I', 'Mussum Ipsum, cacilds vidis litro abertis. Copo furadis é disculpa de bebadis, arcu quam euismod magna. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. Aenean aliquam molestie leo, vitae iaculis nisl.'),
    ('4', 'Segurança Ofensiva II', 'Mussum Ipsum, cacilds vidis litro abertis. Copo furadis é disculpa de bebadis, arcu quam euismod magna. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. Aenean aliquam molestie leo, vitae iaculis nisl.'),
    ('5', 'Engenharia Social', 'Mussum Ipsum, cacilds vidis litro abertis. Copo furadis é disculpa de bebadis, arcu quam euismod magna. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. Aenean aliquam molestie leo, vitae iaculis nisl.' ),
    ('6', 'Forense', 'Mussum Ipsum, cacilds vidis litro abertis. Copo furadis é disculpa de bebadis, arcu quam euismod magna. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. Aenean aliquam molestie leo, vitae iaculis nisl.' ),
    ('7', 'Banco de Dados I', 'Mussum Ipsum, cacilds vidis litro abertis. Copo furadis é disculpa de bebadis, arcu quam euismod magna. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. Aenean aliquam molestie leo, vitae iaculis nisl.' ),
    ('8', 'Banco de Dados II', 'Mussum Ipsum, cacilds vidis litro abertis. Copo furadis é disculpa de bebadis, arcu quam euismod magna. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. Aenean aliquam molestie leo, vitae iaculis nisl.' );

INSERT INTO Classes
VALUES
	('1', '2020-02-03', '15:00', '17:00', '5', '2'),
	('2', '2020-02-05', '10:00', '15:00', '1', '1'),
	('3', '2020-02-05', '15:00', '17:00', '6', '7'),
	('4', '2020-02-06', '10:00', '12:00', '3', '3'),
	('5', '2020-02-06', '15:00', '17:00', '4', '5'),
	('6', '2020-02-10', '10:00', '15:00', '3', '4'),
	('7', '2020-02-12', '10:00', '12:00', '2', '6'),
	('8', '2020-02-14', '10:00', '12:00', '6', '8');

INSERT INTO Students
VALUES
	('1', 'Beatriz Santos', 'beatrizsantos@exemplo.com', '+55 (21) 98888-3333'),
    ('2', 'Cristina Antunes', 'cristina_antunes@exemplo.com', '+55 (21) 99999-8888'),
    ('3', 'José Victor', 'josevictor@exemplo.com', '+55 (21) 98844-0099'),
    ('4', 'Jefferson Maxx', 'jeffersonmaxx@exemplo.com', '+55 (21) 96666-3333'),
    ('5', 'Thomaz Veloso', 'thomazveloso@exemplo.com', '+55 (21) 99998-3344'),
    ('6', 'Felipe de Jesus', 'felipejesus@exemplo.com', '+55 (21) 97777-2222');

INSERT INTO Tags
VALUES
	('1',
	'Fazer um relatório de PenTest envolvendo Engenharia Social.',
	'Mussum Ipsum, cacilds vidis litro abertis. Copo furadis é disculpa de bebadis, arcu quam euismod magna. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. Aenean aliquam molestie leo, vitae iaculis nisl.',
	'2020-02-16',
	'5'),
    ('2',
	'Fazer a lista de WebHacking.',
	'Mussum Ipsum, cacilds vidis litro abertis. Copo furadis é disculpa de bebadis, arcu quam euismod magna. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. Aenean aliquam molestie leo, vitae iaculis nisl.',
	'2020-02-18',
	'2'),
    ('3',
    'Fazer o Banco de Dados do PS do GRIS.',
    'Mussum Ipsum, cacilds vidis litro abertis. Copo furadis é disculpa de bebadis, arcu quam euismod magna. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. Aenean aliquam molestie leo, vitae iaculis nisl.',
    '2020-02-29',
    '3'),
    ('4',
    'Criar um Malware.',
    'Mussum Ipsum, cacilds vidis litro abertis. Copo furadis é disculpa de bebadis, arcu quam euismod magna. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. Aenean aliquam molestie leo, vitae iaculis nisl.',
    '2020-03-07',
    '4');

INSERT INTO Deliveries
VALUES
	('1', '2', '2020-02-18', '10.0'),
    ('4', '6', '2020-02-28', '8.0'),
    ('1', '5', '2020-02-16', '7.0'),
    ('2', '4', '2020-03-05', '9.0'),
    ('3', '4', '2020-03-07', '6.0'),
    ('1', '3', '2020-02-18', '9.5'),
    ('3', '1', '2020-02-29', '7.8'),
    ('1', '1', '2020-02-16', '6.4'),
    ('4', '2', '2020-03-07', '8.3'),
    ('2', '5', '2020-02-18', '9.2');

-- Comandos para deletar tabelas (caso sejam necessários).
-- DROP TABLE Instructors;
-- DROP TABLE Subjects;
-- DROP TABLE Classes;
-- DROP TABLE Tags;
-- DROP TABLE Students;
-- DROP TABLE Deliveries;
