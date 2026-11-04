# VETERINARIO_BANCO# 🐾 VetCare Pro — Sistema de Gestão de Clínica Veterinária

![MySQL](https://img.shields.io/badge/MySQL-8.0-00758F?style=for-the-badge&logo=mysql&logoColor=white)
![Status](https://img.shields.io/badge/Status-Conclu%C3%ADdo-brightgreen?style=for-the-badge)
![Atividade](https://img.shields.io/badge/SEDUC-DEST2%20%7C%20Atividade%20III-blue?style=for-the-badge)

Repositório destinado à **Atividade III (SEDUC DEST2)** de planejamento, modelagem lógica, normalização (1FN à 4FN), implementação SQL e dump de um Banco de Dados Relacional.

📁 **Arquivo de Dump / Script no repositório:** [`mysql.vet.sql`](./mysql.vet.sql)

---

## 📌 1. Domínio do Banco de Dados
* **Domínio:** Sistema de Gestão de Clínica Veterinária e Pet Shop (**VetCare Pro**).
* **SGBD Utilizado:** MySQL 8.0 (MySQL Workbench).
* **Escopo:** Controle de tutores, pacientes (pets), espécies, raças, corpo clínico (veterinários, especialidades e turnos de plantão), agendamento/prontuário de consultas e faturamento de serviços/insumos (vacinas, exames e medicamentos).

---

## 🏢 2. Contextualização (Cenário sem SGBD Relacional)

A **VetCare Pro** é uma clínica veterinária de médio porte que realizava todo o controle operacional por meio de planilhas eletrônicas descentralizadas (Excel) e fichas em papel na recepção.

### Problemas enfrentados sem um SGBD relacional:
1. **Redundância e Inconsistência de Dados:** Os dados dos tutores (CPF, telefone, endereço) eram digitados repetidamente a cada nova consulta. Quando um cliente mudava de telefone, a atualização ocorria em uma aba, mas permanecia antiga nas demais.
2. **Anomalias de Exclusão e Atualização:** Ao remover a linha de um atendimento cancelado na planilha, perdiam-se acidentalmente os dados cadastrais do pet ou do tutor caso aquele fosse seu único registro.
3. **Conflito de Agendamentos (Falta de Concorrência):** Recepcionistas agendavam pacientes diferentes para o mesmo veterinário no mesmo horário, pois as planilhas não possuíam controle transacional (ACID) nem travas de integridade.
4. **Lentidão e Erros em Relatórios:** Calcular o faturamento mensal por médico veterinário ou levantar o consumo de vacinas e exames exigia horas de filtros manuais, gerando erros financeiros.
5. **Ausência de Integridade Referencial:** Existiam registros de consultas vinculados a nomes de veterinários ou serviços digitados incorretamente ou já inativos.

---

## 🚀 3. Proposta de Melhoria (Solução com SGBD Relacional)

A implantação do banco de dados relacional **`vetcare_db`** no **MySQL** soluciona os problemas operacionais através de:

* **Unicidade e Centralização:** Entidades isoladas em tabelas próprias identificadas por chaves primárias (`PRIMARY KEY`) e restrições de unicidade (`UNIQUE` para CPF, CRMV, e-mail).
* **Integridade Referencial (`FOREIGN KEY`):** Garantia de que nenhuma consulta seja cadastrada sem um pet e um veterinário válidos e previamente registrados.
* **Normalização Completa (1FN à 4FN):** Eliminação de grupos repetitivos, dependências parciais, transitivas e multivaloradas, garantindo manutenção limpa e segura.
* **Consultas Analíticas Rápidas (DQL):** Extração imediata de indicadores financeiros, histórico clínico e produtividade médica usando `INNER JOIN`, `LEFT JOIN`, `GROUP BY` e funções de agregação.

---

## 🗂️ 4. Modelagem Lógica do Banco de Dados

### 4.1. Dicionário de Tabelas, Campos e Tipos

| Tabela | Campo | Tipo | Restrições / Papel |
| :--- | :--- | :--- | :--- |
| **`especie`** | `id_especie` | `INT` | `PK`, `AUTO_INCREMENT` |
| | `nome_especie` | `VARCHAR(50)` | `NOT NULL`, `UNIQUE` (Ex: Canina, Felina) |
| **`raca`** | `id_raca` | `INT` | `PK`, `AUTO_INCREMENT` |
| | `nome_raca` | `VARCHAR(80)` | `NOT NULL` |
| | `id_especie` | `INT` | `FK` $\rightarrow$ `especie(id_especie)` |
| **`tutor`** | `id_tutor` | `INT` | `PK`, `AUTO_INCREMENT` |
| | `nome` | `VARCHAR(100)` | `NOT NULL` |
| | `cpf` | `CHAR(11)` | `NOT NULL`, `UNIQUE` |
| | `email` | `VARCHAR(100)` | `UNIQUE` |
| | `logradouro` | `VARCHAR(150)` | `NOT NULL` |
| | `bairro` | `VARCHAR(80)` | `NOT NULL` |
| | `cidade` | `VARCHAR(80)` | `NOT NULL` |
| **`tutor_telefone`**| `id_telefone` | `INT` | `PK`, `AUTO_INCREMENT` |
| | `id_tutor` | `INT` | `FK` $\rightarrow$ `tutor(id_tutor)` |
| | `numero_telefone`| `VARCHAR(15)` | `NOT NULL` |
| | `tipo` | `VARCHAR(20)` | `NOT NULL` (WhatsApp, Celular, Fixo) |
| **`pet`** | `id_pet` | `INT` | `PK`, `AUTO_INCREMENT` |
| | `nome_pet` | `VARCHAR(80)` | `NOT NULL` |
| | `data_nascimento`| `DATE` | `NOT NULL` |
| | `peso_kg` | `DECIMAL(5,2)` | `NOT NULL` |
| | `sexo` | `CHAR(1)` | `NOT NULL`, `CHECK ('M', 'F')` |
| | `id_tutor` | `INT` | `FK` $\rightarrow$ `tutor(id_tutor)` |
| | `id_raca` | `INT` | `FK` $\rightarrow$ `raca(id_raca)` |
| **`veterinario`** | `id_veterinario` |
