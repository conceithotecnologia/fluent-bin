# Fluent Infra

Projeto para desenvolvimento da infraestrutura base do Fluent ERP

Este projeto compõe as infraestrutura do sistema Fluent ERP sendo utilizado como componente de comunicação entre o Fluent ERP e o mundo externo.


## Estrutura de diretórios do Fluent

Recomendamos que a estrutura de diretórios do ambiente Fluent ERP seja organizado como segue:

| Diretórios | Descrição |
| ------ | ------ |
| Fluent | Raíz do projeto |
| Fluent/Application | Ambiente de produção |
| Fluent/Application/System/Lib32 | Bibliotecas 32bits |
| Fluent/Application/System/Lib64 | Bibliotecas 64bits |

## Lista de Bibliotecas

A seguir estão descritas as bibliotecas necessárias para execução do programa agrupadas por função

### Conexão com o banco de dados PostgreSQL

| Biblioteca | Versão | Path Relativo |
| ---- | --- | --- |
| libcrypto-1_1.dll | 1.1.1.3 | System\Lib32 |
| libiconv-2.dll | 1.14.0.0 | System\Lib32 |
| libintl-8.dll | 0.19.0.0 | System\Lib32 |
| libpq.dll | 10.0.10.19261 | System\Lib32 |
| libssl-1_1.dll | 1.1.1.3 | System\Lib32 |

### Criptografia SSL

| Biblioteca | Versão | Path Relativo |
| ---- | --- | --- |
| libeay32.dll | 1.0.2.19 | Win32 |
| ssleay32.dll | 1.0.2.19 | Win32 |
| libiconv.dll | 1.14.0.0 | Win32 |
| libiconv-2.dll | 1.14.0.0 | Win32 |
| libxml2.dll |  | Win32 |

### SAT Elgin Linker II / Smart SAT

| Biblioteca | Versão | Path Relativo |
| ---- | --- | --- |
| sat_elgin.dll | 5.0.2.0 | System\Lib32 |
| zlib.dll | 1.2.3.0 | System\Lib32 |

*Renomear aquivo dllsat.dll para sat_elgin.dll*

### SAT DIMEP D-SAT 2.0

| Biblioteca | Versão | Path Relativo |
| ---- | --- | --- |
| sat_dimep.dll | 4.6.1.0 | System\Lib32 |

*Renomear aquivo dllsat.dll para sat_dimep.dll*

### SAT Bematech

| Biblioteca | Versão | Path Relativo |
| ---- | --- | --- |
| sat_bematech.dll | 1.0.2.35 | System\Lib32 |

*Renomear aquivo dllsat.dll para sat_bematech.dll*
*Para que este SAT funcione é necessário copiar o arquivo bemasat.xml na pasta de sistema do Windows.*
-  *Windows 32 bits = C:\Windows\System32*
-  *Windows 64 bits = C:\Windows\SysWOW64*


