CREATE TABLE tfs (
tf VARCHAR (255) NULL,
target VARCHAR (255) NULL,
tissue VARCHAR (255) NULL,
cell_type VARCHAR (255) NULL,
cell_line VARCHAR (255) NULL);

INSERT INTO tfs(tf, target, tissue, cell_type, cell_line)
VALUES ('Y99t', 'NAT', 'kidney', 'blood', '783473');

INSERT INTO tfs(tf, target, tissue, cell_type, cell_line)
VALUES ('ERG', 'NAT', 'brain', 'cancer_cell', 's7321d');
