# Módulo Azure SQL

Este módulo cria um servidor SQL e um banco de dados no Azure.

## Variáveis

- `sql_server_name`: Nome do servidor SQL.
- `sql_database_name`: Nome do banco de dados SQL.
- `resource_group_name`: Nome do grupo de recursos.
- `location`: Localização do recurso.
- `admin_username`: Nome de usuário administrador do servidor SQL.
- `admin_password`: Senha do administrador do servidor SQL.
- `sku_name`: SKU do banco de dados SQL (exemplo: S0, S1, P1).
- `tags`: Tags para os recursos.

## Saídas

- `sql_server_id`: ID do servidor SQL.
- `sql_database_id`: ID do banco de dados SQL.
- `sql_server_fqdn`: FQDN do servidor SQL.

## Exemplo de Uso

```terraform
module "azure_sql" {
  source              = "./modules/azure_sql"
  sql_server_name     = "my-sql-server"
  sql_database_name   = "my-database"
  resource_group_name = "my-resource-group"
  location            = "eastus"
  admin_username      = "adminuser"
  admin_password      = "P@ssw0rd1234"
  sku_name            = "S0"
  tags = {
    Environment = "Dev"
    Project     = "MyProject"
  }
}
```
