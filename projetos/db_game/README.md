<h1 align='center'>
  <img src="https://icongr.am/material/database.svg?size=30&color=127369">
  GAMES DATABASE
  <img src="https://icongr.am/material/database.svg?size=30&color=127369">
</h1>

</br>

# About

Backup for my database db_game.

This bk contains tables for console names and game names, an associative table to link each game with its consoles and some Stored Procedures for insertions

</br>

# Tables

### tb_console

| Columns | Details |
| --- | --- |
| id_console | Unique ID for each console |
| nome | The console's name |


### tb_jogo

| Columns | Details |
| --- | --- |
| id_jogo | Unique ID for each jogo |
| nome | The game's name |


### tb_jogo_console

| Columns | Details |
| --- | --- |
| id_jogo | Foreign Key for id_jogo |
| id_console | Foreign Key for id_console |

</br>

# Stored Procedures

| SP | Details |
| --- | --- |
| sp_insert_console | Use to make insert into tb_console |
| sp_insert_jogo | Use to make insert into tb_jogo |
| sp_insert_jogo_console | Use to make insert into tb_jogo_console |
