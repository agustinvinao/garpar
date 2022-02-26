CREATE DATABASE IF NOT EXISTS vento;
CREATE USER IF NOT EXISTS 'garpar'@localhost IDENTIFIED BY 'garpar';
GRANT ALL PRIVILEGES ON 'users'.* TO 'garpar'@localhost; 
